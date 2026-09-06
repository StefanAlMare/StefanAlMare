//
// OCLPMetalCompat.kext — D97DO one-shot CAVE-only functional propagation probe
//
// Purpose:
// Preserve the runtime-proven D97DL delivery path while allowing exactly one
// inert CAVE write for propagation testing. SITE functional mutation is absent.
//
// Safety:
// - Apple's original _cs_validate_page is always called first.
// - -ocmcdiag is still required to install the route.
// - The only functional boot arg accepted is -ocmcd97bvcave.
// - Full -ocmcd97bv is treated as a blocked/invalid request and performs no writes.
// - SITE replacement bytes and SITE write path are not compiled into this build.
// - CAVE may be written at most once globally, after exact 25G82/Haswell/path/page/
//   Apple-validation/preimage gates; later CAVE callbacks are observation-only.
// - No Root Patch, no on-disk shared-cache/system mutation, no reboot logic.
//

#include <Headers/plugin_start.hpp>
#include <Headers/kern_api.hpp>
#include <Headers/kern_user.hpp>
#include <Headers/kern_devinfo.hpp>
#include <Headers/kern_util.hpp>

#include <sys/param.h>
#include <sys/vnode.h>
#include <sys/proc.h>

#include <kern/thread_call.h>
#include <kern/clock.h>
#include <stdatomic.h>

extern "C" char osversion[];

#define MODULE_SHORT "ocmc"

static mach_vm_address_t orgCsValidatePage {};

static constexpr const char *TargetBuild = "25G82";
static constexpr const char *TargetCacheSuffix = "/dyld_shared_cache_x86_64h";

static constexpr memory_object_offset_t SitePageOffset = 0x0F5E1000ULL;
static constexpr size_t SiteInPage = 0x719;
static constexpr memory_object_offset_t CavePageOffset = 0x0F47E000ULL;
static constexpr size_t CaveInPage = 0x560;
static constexpr size_t CaveLength = 208;
static constexpr size_t CaveFunctionalWindowLength = 18;

static constexpr uint8_t SitePreimage[] {
    0x3D, 0x18, 0x7D, 0x00, 0x00,
    0xB9, 0x17, 0x7D, 0x00, 0x00,
    0x0F, 0x4C, 0xC1
};

static constexpr uint8_t CaveReplacement[] {
    0x3D, 0x18, 0x7D, 0x00, 0x00,
    0xB9, 0x17, 0x7D, 0x00, 0x00,
    0x0F, 0x4C, 0xC1,
    0xE9, 0xB4, 0x31, 0x16, 0x00
};

static constexpr uint32_t AppleValidatedAll = 0xF;

static_assert(sizeof(CaveReplacement) == CaveFunctionalWindowLength,
              "D97DO cave replacement must exactly fill the 18-byte functional window");
static_assert(SiteInPage + sizeof(SitePreimage) <= PAGE_SIZE,
              "D97DO observed site window must fit inside one validation page");
static_assert(CaveInPage + CaveLength <= PAGE_SIZE,
              "D97DO cave must fit inside one validation page");

// Persistent state. Status encoding: 0=unknown/pending, 1=PASS, 2=NEGATIVE/FAIL.
static _Atomic(uint32_t) bootArgGate = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) kernelGate = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) buildGate = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) cpuGate = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) routeState = ATOMIC_VAR_INIT(0);

static _Atomic(uint32_t) siteSeenCount = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) sitePreimageState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) siteValidated = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) siteTainted = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) siteNx = ATOMIC_VAR_INIT(0);

static _Atomic(uint32_t) caveSeenCount = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) caveWindow18State = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) caveFull208State = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) caveValidated = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) caveTainted = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) caveNx = ATOMIC_VAR_INIT(0);

static _Atomic(uint32_t) publisherTicks = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97ddCallbackSeenCount = ATOMIC_VAR_INIT(0);

static _Atomic(uint32_t) d97diSiteSafetyState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diSiteMutationState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diSitePostimageState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diSiteWriteCount = ATOMIC_VAR_INIT(0);

static _Atomic(uint32_t) d97diCaveSafetyState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diCaveMutationState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diCavePostimageState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diCaveTailZeroState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diCaveWriteCount = ATOMIC_VAR_INIT(0);

static _Atomic(uint32_t) d97doCaveOnlyRequested = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97doFullFunctionalArgPresent = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97doSiteWriteBlockedState = ATOMIC_VAR_INIT(1);
static _Atomic(uint32_t) d97doCaveWritePhase = ATOMIC_VAR_INIT(0);
// phase: 0=UNCLAIMED, 1=WRITING, 2=WRITE_PASS, 3=WRITE_FAIL
static _Atomic(uint32_t) d97doCavePropagationState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97doCavePostimageSeenAfterWrite = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97doCaveZeroSeenAfterWrite = ATOMIC_VAR_INIT(0);
static _Atomic(int32_t) d97doCaveWritePid = ATOMIC_VAR_INIT(0);
static _Atomic(int32_t) d97doCavePropagationPid = ATOMIC_VAR_INIT(0);

static thread_call_t publisherCall {};

static const char *statusString(uint32_t value) {
    switch (value) {
        case 1: return "PASS";
        case 2: return "NEGATIVE";
        case 3: return "WAITING_CAVE";
        case 4: return "BLOCKED_CAVE_ONLY";
        default: return "PENDING";
    }
}

static bool targetBuildMatches() {
    return osversion[0] != '\0' && !strcmp(osversion, TargetBuild);
}

static bool targetMainCachePath(const char *path) {
    if (!path || !UserPatcher::matchSharedCachePath(path))
        return false;

    const size_t pathLen = strlen(path);
    const size_t suffixLen = strlen(TargetCacheSuffix);
    if (pathLen < suffixLen)
        return false;

    return !strncmp(path + pathLen - suffixLen, TargetCacheSuffix, suffixLen);
}

static bool allZero(const uint8_t *ptr, size_t size) {
    if (!ptr)
        return false;

    for (size_t i = 0; i < size; i++) {
        if (ptr[i] != 0)
            return false;
    }
    return true;
}

static bool appleValidationSafe(
    const int *validatedP,
    const int *taintedP,
    const int *nxP
) {
    return validatedP && taintedP && nxP &&
           static_cast<uint32_t>(*validatedP) == AppleValidatedAll &&
           static_cast<uint32_t>(*taintedP) == 0 &&
           static_cast<uint32_t>(*nxP) == 0;
}

static void writeExact(uint8_t *dst, const uint8_t *src, size_t size) {
    for (size_t i = 0; i < size; i++)
        dst[i] = src[i];
}

static void recordPassOrFirstNegative(_Atomic(uint32_t) *state, bool pass) {
    if (pass) {
        atomic_store_explicit(state, 1U, memory_order_release);
    } else if (atomic_load_explicit(state, memory_order_relaxed) == 0) {
        atomic_store_explicit(state, 2U, memory_order_release);
    }
}

static void publishState(thread_call_param_t, thread_call_param_t) {
    const uint32_t ticks =
        atomic_fetch_add_explicit(&publisherTicks, 1, memory_order_relaxed) + 1;

    auto service = ADDPR(selfInstance);
    if (service) {
        service->setProperty("D97CTChannel", "IORegistry-AtomicAsync-v1");
        service->setProperty("D97DDRouteBuildGateMethod", "cs-validate-page-callback-osversion-v1");
        service->setProperty("D97DDObservedBuild", osversion);
        service->setProperty("D97DDCallbackSeenCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97ddCallbackSeenCount, memory_order_relaxed)), 32);

        const uint32_t caveOnlyRequested =
            atomic_load_explicit(&d97doCaveOnlyRequested, memory_order_relaxed);
        const uint32_t fullArgPresent =
            atomic_load_explicit(&d97doFullFunctionalArgPresent, memory_order_relaxed);

        service->setProperty("D97DIFunctionalBootArg", "-ocmcd97bv");
        service->setProperty("D97DIFunctionalMode", "LATENT");
        service->setProperty("D97DIFunctionalRequested",
                             static_cast<unsigned long long>(0), 32);

        service->setProperty("D97DOCaveOnlyBootArg", "-ocmcd97bvcave");
        service->setProperty("D97DOFullFunctionalBootArg", "-ocmcd97bv");
        service->setProperty("D97DOCaveOnlyRequested",
                             static_cast<unsigned long long>(caveOnlyRequested), 32);
        service->setProperty("D97DOFullFunctionalArgPresent",
                             static_cast<unsigned long long>(fullArgPresent), 32);
        service->setProperty("D97DOFunctionalMode",
                             fullArgPresent ? "BLOCKED_FULL_ARG" :
                             (caveOnlyRequested ? "CAVE_ONLY" : "LATENT"));
        service->setProperty("D97DOSiteWriteBlocked", "PASS");
        service->setProperty("D97DOCaveWritePhase",
                             static_cast<unsigned long long>(
                                 atomic_load_explicit(&d97doCaveWritePhase, memory_order_relaxed)
                             ), 32);
        service->setProperty("D97DOCavePropagation",
                             statusString(
                                 atomic_load_explicit(&d97doCavePropagationState, memory_order_relaxed)
                             ));
        service->setProperty("D97DOCavePostimageSeenAfterWrite",
                             static_cast<unsigned long long>(