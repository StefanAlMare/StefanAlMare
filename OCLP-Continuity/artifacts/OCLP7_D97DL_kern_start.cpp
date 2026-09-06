//
// OCLPMetalCompat.kext — D97DL cave-first hardened functional D97BV prototype
//
// Purpose:
// Preserve the runtime-proven D97DI delivery path and harden the cross-page D97BV
// trampoline by requiring CAVE mutation PASS before SITE can ever be written.
//
// Safety:
// - Apple's original _cs_validate_page is always called first.
// - -ocmcdiag is still required to install the route.
// - Functional writes additionally require explicit -ocmcd97bv.
// - SITE writes additionally require CAVE mutation PASS observed with acquire/release ordering.
// - Exact 25G82, Haswell, main x86_64h cache, page offsets, preimages,
//   Apple's validated-all result, tainted=0 and NX=0 are all required.
// - Without -ocmcd97bv the build is observe-only/latent.
// - No Root Patch, no on-disk shared-cache/system mutation, no reboot logic.
//

#include <Headers/plugin_start.hpp>
#include <Headers/kern_api.hpp>
#include <Headers/kern_user.hpp>
#include <Headers/kern_devinfo.hpp>
#include <Headers/kern_util.hpp>

#include <sys/param.h>
#include <sys/vnode.h>

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

static constexpr uint8_t SiteReplacement[] {
    0x3D, 0xDA, 0x0E, 0x00, 0x00,
    0x74, 0x06,
    0xE9, 0x3B, 0xCE, 0xE9, 0xFF,
    0x90
};

static constexpr uint8_t CaveReplacement[] {
    0x3D, 0x18, 0x7D, 0x00, 0x00,
    0xB9, 0x17, 0x7D, 0x00, 0x00,
    0x0F, 0x4C, 0xC1,
    0xE9, 0xB4, 0x31, 0x16, 0x00
};

static constexpr uint32_t AppleValidatedAll = 0xF;

static_assert(sizeof(SiteReplacement) == sizeof(SitePreimage),
              "D97DI site replacement must preserve the 13-byte window");
static_assert(sizeof(CaveReplacement) == CaveFunctionalWindowLength,
              "D97DI cave replacement must exactly fill the 18-byte functional window");
static_assert(SiteInPage + sizeof(SitePreimage) <= PAGE_SIZE,
              "D97DI site window must fit inside one validation page");
static_assert(CaveInPage + CaveLength <= PAGE_SIZE,
              "D97DI cave must fit inside one validation page");

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

static _Atomic(uint32_t) d97diFunctionalRequested = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diSiteSafetyState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diSiteMutationState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diSitePostimageState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diSiteWriteCount = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97dlSiteCavePrereqState = ATOMIC_VAR_INIT(0);

static _Atomic(uint32_t) d97diCaveSafetyState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diCaveMutationState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diCavePostimageState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diCaveTailZeroState = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97diCaveWriteCount = ATOMIC_VAR_INIT(0);

static thread_call_t publisherCall {};

static const char *statusString(uint32_t value) {
    switch (value) {
        case 1: return "PASS";
        case 2: return "NEGATIVE";
        case 3: return "WAITING_CAVE";
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

        const uint32_t functionalRequested =
            atomic_load_explicit(&d97diFunctionalRequested, memory_order_relaxed);
        service->setProperty("D97DIFunctionalBootArg", "-ocmcd97bv");
        service->setProperty("D97DIFunctionalMode",
                             functionalRequested ? "ACTIVE" : "LATENT");
        service->setProperty("D97DIFunctionalRequested",
                             static_cast<unsigned long long>(functionalRequested), 32);

        service->setProperty("D97DISiteSafety",
                             statusString(atomic_load_explicit(&d97diSiteSafetyState, memory_order_relaxed)));
        service->setProperty("D97DISiteMutation",
                             statusString(atomic_load_explicit(&d97diSiteMutationState, memory_order_relaxed)));
        service->setProperty("D97DISitePostimage",
                             statusString(atomic_load_explicit(&d97diSitePostimageState, memory_order_relaxed)));
        service->setProperty("D97DISiteWriteCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97diSiteWriteCount, memory_order_relaxed)), 32);

        service->setProperty("D97DLSiteCavePrereq",
                             statusString(atomic_load_explicit(&d97dlSiteCavePrereqState, memory_order_relaxed)));

        service->setProperty("D97DICaveSafety",
                             statusString(atomic_load_explicit(&d97diCaveSafetyState, memory_order_relaxed)));
        service->setProperty("D97DICaveMutation",
                             statusString(atomic_load_explicit(&d97diCaveMutationState, memory_order_relaxed)));
        service->setProperty("D97DICavePostimage",
                             statusString(atomic_load_explicit(&d97diCavePostimageState, memory_order_relaxed)));
        service->setProperty("D97DICaveTailZeroAfter",
                             statusString(atomic_load_explicit(&d97diCaveTailZeroState, memory_order_relaxed)));
        service->setProperty("D97DICaveWriteCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97diCaveWriteCount, memory_order_relaxed)), 32);

        service->setProperty("D97CTBootArgGate",
                             static_cast<unsigned long long>(atomic_load_explicit(&bootArgGate, memory_order_relaxed)), 32);
        service->setProperty("D97CTKernelGate",
                             static_cast<unsigned long long>(atomic_load_explicit(&kernelGate, memory_order_relaxed)), 32);
        service->setProperty("D97CTBuildGate",
                             static_cast<unsigned long long>(atomic_load_explicit(&buildGate, memory_order_relaxed)), 32);
        service->setProperty("D97CTCpuGate",
                             static_cast<unsigned long long>(atomic_load_explicit(&cpuGate, memory_order_relaxed)), 32);

        const uint32_t route = atomic_load_explicit(&routeState, memory_order_relaxed);
        service->setProperty("D97CTRouteStatus", statusString(route));

        const uint32_t siteCount = atomic_load_explicit(&siteSeenCount, memory_order_relaxed);
        service->setProperty("D97CTSiteSeenCount",
                             static_cast<unsigned long long>(siteCount), 32);
        if (siteCount > 0) {
            service->setProperty("D97CTSitePreimage",
                                 statusString(atomic_load_explicit(&sitePreimageState, memory_order_relaxed)));
            service->setProperty("D97CTSiteValidated",
                                 static_cast<unsigned long long>(atomic_load_explicit(&siteValidated, memory_order_relaxed)), 32);
            service->setProperty("D97CTSiteTainted",
                                 static_cast<unsigned long long>(atomic_load_explicit(&siteTainted, memory_order_relaxed)), 32);
            service->setProperty("D97CTSiteNX",
                                 static_cast<unsigned long long>(atomic_load_explicit(&siteNx, memory_order_relaxed)), 32);
        }

        const uint32_t caveCount = atomic_load_explicit(&caveSeenCount, memory_order_relaxed);
        service->setProperty("D97CTCaveSeenCount",
                             static_cast<unsigned long long>(caveCount), 32);
        if (caveCount > 0) {
            service->setProperty("D97CTCaveWindow18",
                                 statusString(atomic_load_explicit(&caveWindow18State, memory_order_relaxed)));
            service->setProperty("D97CTCaveFull208",
                                 statusString(atomic_load_explicit(&caveFull208State, memory_order_relaxed)));
            service->setProperty("D97CTCaveValidated",
                                 static_cast<unsigned long long>(atomic_load_explicit(&caveValidated, memory_order_relaxed)), 32);
            service->setProperty("D97CTCaveTainted",
                                 static_cast<unsigned long long>(atomic_load_explicit(&caveTainted, memory_order_relaxed)), 32);
            service->setProperty("D97CTCaveNX",
                                 static_cast<unsigned long long>(atomic_load_explicit(&caveNx, memory_order_relaxed)), 32);
        }

        service->setProperty("D97CTPublisherTicks",
                             static_cast<unsigned long long>(ticks), 32);
    }

    const bool observedComplete =
        atomic_load_explicit(&siteSeenCount, memory_order_relaxed) > 0 &&
        atomic_load_explicit(&caveSeenCount, memory_order_relaxed) > 0;
    const bool functionalRequested =
        atomic_load_explicit(&d97diFunctionalRequested, memory_order_relaxed) != 0;
    const bool functionalResolved =
        atomic_load_explicit(&d97diSiteMutationState, memory_order_relaxed) != 0 &&
        atomic_load_explicit(&d97diCaveMutationState, memory_order_relaxed) != 0;
    const bool complete =
        observedComplete && (!functionalRequested || functionalResolved);

    // Bounded 5-minute early-boot publication window.
    if (!complete && ticks < 300 && publisherCall) {
        uint64_t intervalAbs = 0;
        nanoseconds_to_absolutetime(1000000000ULL, &intervalAbs);
        thread_call_enter_delayed(publisherCall, mach_absolute_time() + intervalAbs);
    }
}

static void startPublisher() {
    publisherCall = thread_call_allocate(publishState, nullptr);
    if (!publisherCall)
        return;

    uint64_t intervalAbs = 0;
    nanoseconds_to_absolutetime(1000000000ULL, &intervalAbs);
    thread_call_enter_delayed(publisherCall, mach_absolute_time() + intervalAbs);
}

static void patchedCsValidatePage(
    vnode_t vp,
    memory_object_t pager,
    memory_object_offset_t pageOffset,
    const void *data,
    int *validatedP,
    int *taintedP,
    int *nxP
) {
    FunctionCast(patchedCsValidatePage, orgCsValidatePage)(
        vp, pager, pageOffset, data, validatedP, taintedP, nxP
    );

    atomic_fetch_add_explicit(&d97ddCallbackSeenCount, 1, memory_order_relaxed);

    const bool buildOk = targetBuildMatches();
    atomic_store_explicit(&buildGate, buildOk ? 1U : 2U, memory_order_relaxed);
    if (!buildOk)
        return;

    if (pageOffset != SitePageOffset && pageOffset != CavePageOffset)
        return;

    if (!data)
        return;

    char path[PATH_MAX] {};
    int pathLen = PATH_MAX;
    if (vn_getpath(vp, path, &pathLen) != 0)
        return;

    if (!targetMainCachePath(path))
        return;

    const auto page = static_cast<const uint8_t *>(data);
    auto mutablePage = const_cast<uint8_t *>(page);

    const uint32_t validated = validatedP ? static_cast<uint32_t>(*validatedP) : 0;
    const uint32_t tainted = taintedP ? static_cast<uint32_t>(*taintedP) : 0;
    const uint32_t nx = nxP ? static_cast<uint32_t>(*nxP) : 0;
    const bool validationSafe = appleValidationSafe(validatedP, taintedP, nxP);
    const bool functionalRequested =
        atomic_load_explicit(&d97diFunctionalRequested, memory_order_relaxed) != 0;

    if (pageOffset == SitePageOffset) {
        const bool preimageMatch =
            !memcmp(page + SiteInPage, SitePreimage, sizeof(SitePreimage));
        const bool alreadyPatched =
            !memcmp(page + SiteInPage, SiteReplacement, sizeof(SiteReplacement));

        const uint32_t priorSeen =
            atomic_fetch_add_explicit(&siteSeenCount, 1, memory_order_relaxed);
        if (priorSeen == 0) {
            atomic_store_explicit(&sitePreimageState, preimageMatch ? 1U : 2U, memory_order_relaxed);
            atomic_store_explicit(&siteValidated, validated, memory_order_relaxed);
            atomic_store_explicit(&siteTainted, tainted, memory_order_relaxed);
            atomic_store_explicit(&siteNx, nx, memory_order_relaxed);
        }

        recordPassOrFirstNegative(&d97diSiteSafetyState, validationSafe);

        if (!functionalRequested)
            return;

        // D97DL cross-page safety: never make SITE branch to CAVE until CAVE
        // has been proven safely mutated. The release store after CAVE mutation
        // synchronizes with this acquire load.
        const uint32_t caveMutationReady =
            atomic_load_explicit(&d97diCaveMutationState, memory_order_acquire);
        if (caveMutationReady != 1U) {
            atomic_store_explicit(
                &d97dlSiteCavePrereqState,
                3U,
                memory_order_relaxed
            );
            return;
        }
        atomic_store_explicit(
            &d97dlSiteCavePrereqState,
            1U,
            memory_order_relaxed
        );

        if (alreadyPatched) {
            atomic_store_explicit(&d97diSitePostimageState, 1U, memory_order_relaxed);
            recordPassOrFirstNegative(&d97diSiteMutationState, validationSafe);
            return;
        }

        if (!preimageMatch || !validationSafe) {
            recordPassOrFirstNegative(&d97diSiteMutationState, false);
            return;
        }

        writeExact(
            mutablePage + SiteInPage,
            SiteReplacement,
            sizeof(SiteReplacement)
        );

        const bool postimageMatch =
            !memcmp(page + SiteInPage, SiteReplacement, sizeof(SiteReplacement));
        atomic_store_explicit(&d97diSitePostimageState, postimageMatch ? 1U : 2U, memory_order_relaxed);
        atomic_store_explicit(&d97diSiteMutationState, postimageMatch ? 1U : 2U, memory_order_relaxed);
        if (postimageMatch)
            atomic_fetch_add_explicit(&d97diSiteWriteCount, 1, memory_order_relaxed);
        return;
    }

    const bool fullCaveZero = allZero(page + CaveInPage, CaveLength);
    const bool functionalWindowZero =
        allZero(page + CaveInPage, CaveFunctionalWindowLength);
    const bool cavePostimageAlready =
        !memcmp(page + CaveInPage, CaveReplacement, sizeof(CaveReplacement));
    const bool caveTailZero =
        allZero(
            page + CaveInPage + sizeof(CaveReplacement),
            CaveLength - sizeof(CaveReplacement)
        );

    const uint32_t priorSeen =
        atomic_fetch_add_explicit(&caveSeenCount, 1, memory_order_relaxed);
    if (priorSeen == 0) {
        atomic_store_explicit(&caveWindow18State, functionalWindowZero ? 1U : 2U, memory_order_relaxed);
        atomic_store_explicit(&caveFull208State, fullCaveZero ? 1U : 2U, memory_order_relaxed);
        atomic_store_explicit(&caveValidated, validated, memory_order_relaxed);
        atomic_store_explicit(&caveTainted, tainted, memory_order_relaxed);
        atomic_store_explicit(&caveNx, nx, memory_order_relaxed);
    }

    recordPassOrFirstNegative(&d97diCaveSafetyState, validationSafe);

    if (!functionalRequested)
        return;

    if (cavePostimageAlready && caveTailZero) {
        atomic_store_explicit(&d97diCavePostimageState, 1U, memory_order_relaxed);
        atomic_store_explicit(&d97diCaveTailZeroState, 1U, memory_order_relaxed);
        recordPassOrFirstNegative(&d97diCaveMutationState, validationSafe);
        return;
    }

    if (!fullCaveZero || !functionalWindowZero || !validationSafe) {
        recordPassOrFirstNegative(&d97diCaveMutationState, false);
        return;
    }

    writeExact(
        mutablePage + CaveInPage,
        CaveReplacement,
        sizeof(CaveReplacement)
    );

    const bool cavePostimageMatch =
        !memcmp(page + CaveInPage, CaveReplacement, sizeof(CaveReplacement));
    const bool caveTailZeroAfter =
        allZero(
            page + CaveInPage + sizeof(CaveReplacement),
            CaveLength - sizeof(CaveReplacement)
        );

    atomic_store_explicit(&d97diCavePostimageState, cavePostimageMatch ? 1U : 2U, memory_order_relaxed);
    atomic_store_explicit(&d97diCaveTailZeroState, caveTailZeroAfter ? 1U : 2U, memory_order_relaxed);
    atomic_store_explicit(
        &d97diCaveMutationState,
        (cavePostimageMatch && caveTailZeroAfter) ? 1U : 2U,
        memory_order_release
    );
    if (cavePostimageMatch && caveTailZeroAfter)
        atomic_fetch_add_explicit(&d97diCaveWriteCount, 1, memory_order_relaxed);
}

static void pluginStart() {
    startPublisher();

    const bool argOk = checkKernelArgument("-ocmcdiag");
    atomic_store_explicit(&bootArgGate, argOk ? 1U : 2U, memory_order_relaxed);
    if (!argOk)
        return;

    const bool functionalRequested = checkKernelArgument("-ocmcd97bv");
    atomic_store_explicit(
        &d97diFunctionalRequested,
        functionalRequested ? 1U : 0U,
        memory_order_relaxed
    );

    const bool kernelOk = getKernelVersion() == KernelVersion::Tahoe;
    atomic_store_explicit(&kernelGate, kernelOk ? 1U : 2U, memory_order_relaxed);
    if (!kernelOk)
        return;

    const bool cpuOk =
        BaseDeviceInfo::get().cpuGeneration == CPUInfo::CpuGeneration::Haswell;
    atomic_store_explicit(&cpuGate, cpuOk ? 1U : 2U, memory_order_relaxed);
    if (!cpuOk)
        return;

    lilu.onPatcherLoadForce([](void *user, KernelPatcher &patcher) {
        KernelPatcher::RouteRequest route(
            "_cs_validate_page",
            patchedCsValidatePage,
            orgCsValidatePage
        );

        const bool routed =
            patcher.routeMultipleLong(KernelPatcher::KernelID, &route, 1);

        atomic_store_explicit(&routeState, routed ? 1U : 2U, memory_order_relaxed);
    });
}

static const char *bootargOff[] {
    "-ocmcoff"
};

static const char *bootargDebug[] {
    "-ocmcdbg"
};

static const char *bootargBeta[] {
    "-ocmcbeta"
};

PluginConfiguration ADDPR(config) {
    xStringify(PRODUCT_NAME),
    parseModuleVersion(xStringify(MODULE_VERSION)),
    LiluAPI::AllowNormal,
    bootargOff,
    arrsize(bootargOff),
    bootargDebug,
    arrsize(bootargDebug),
    bootargBeta,
    arrsize(bootargBeta),
    KernelVersion::Tahoe,
    KernelVersion::Tahoe,
    pluginStart
};
