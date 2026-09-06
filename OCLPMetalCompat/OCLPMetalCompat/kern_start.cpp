//
// OCLPMetalCompat.kext — D97CO observe-only prototype
//
// Purpose: prove that Tahoe 25G82 validates the two native Metal shared-cache
// pages required by the D97BV selective-3802 adapter before any functional
// byte mutation is introduced.
//
// D97CO MUST NOT modify page contents. Functional D97BV delivery is a later,
// separately-authorized phase after runtime timing/provenance is established.
//

#include <Headers/plugin_start.hpp>
#include <Headers/kern_api.hpp>
#include <Headers/kern_user.hpp>
#include <Headers/kern_devinfo.hpp>
#include <Headers/kern_util.hpp>

#include <sys/param.h>
#include <sys/sysctl.h>
#include <sys/vnode.h>

#define MODULE_SHORT "ocmc"

static mach_vm_address_t orgCsValidatePage {};

static constexpr const char *TargetBuild = "25G82";
static constexpr const char *TargetCacheSuffix = "/dyld_shared_cache_x86_64h";

// D97CN runtime/static topology for Tahoe 26.6.2 / 25G82 x86_64h main cache.
static constexpr memory_object_offset_t SitePageOffset = 0x0F5E1000ULL;
static constexpr size_t SiteInPage = 0x719;
static constexpr memory_object_offset_t CavePageOffset = 0x0F47E000ULL;
static constexpr size_t CaveInPage = 0x560;
static constexpr size_t CaveLength = 208;

static constexpr uint8_t SitePreimage[] {
    0x3D, 0x18, 0x7D, 0x00, 0x00,
    0xB9, 0x17, 0x7D, 0x00, 0x00,
    0x0F, 0x4C, 0xC1
};

// D97BV would later place 18 bytes at CaveInPage. D97CO only proves the
// complete 208-byte cave remains zero when the cache page is validated.
static constexpr size_t CaveFunctionalWindowLength = 18;

static_assert(SiteInPage + sizeof(SitePreimage) <= PAGE_SIZE,
              "D97CO site preimage must fit inside one 4K validation page");
static_assert(CaveInPage + CaveLength <= PAGE_SIZE,
              "D97CO cave must fit inside one 4K validation page");

static bool targetBuildMatches() {
    char build[32] {};
    size_t size = sizeof(build);
    if (sysctlbyname("kern.osversion", build, &size, nullptr, 0) != 0) {
        SYSLOG(MODULE_SHORT, "D97CO_BUILD_QUERY_FAIL");
        return false;
    }

    const bool match = !strcmp(build, TargetBuild);
    SYSLOG(MODULE_SHORT, "D97CO_BUILD build=%s expected=%s match=%d", build, TargetBuild, match);
    return match;
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

static void patchedCsValidatePage(
    vnode_t vp,
    memory_object_t pager,
    memory_object_offset_t pageOffset,
    const void *data,
    int *validatedP,
    int *taintedP,
    int *nxP
) {
    // Preserve Apple's validation first, exactly following the established
    // FeatureUnlock/Lilu shared-cache patching substrate. D97CO then observes
    // the already-validated page but never writes to it.
    FunctionCast(patchedCsValidatePage, orgCsValidatePage)(
        vp, pager, pageOffset, data, validatedP, taintedP, nxP
    );

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
    const int validated = validatedP ? *validatedP : -1;
    const int tainted = taintedP ? *taintedP : -1;
    const int nx = nxP ? *nxP : -1;

    if (pageOffset == SitePageOffset) {
        const bool preimageMatch = !memcmp(
            page + SiteInPage, SitePreimage, sizeof(SitePreimage)
        );

        SYSLOG(
            MODULE_SHORT,
            "D97CO_SITE_SEEN page=0x%llX inpage=0x%lX preimage=%s validated=%d tainted=%d nx=%d path=%s",
            static_cast<unsigned long long>(pageOffset),
            static_cast<unsigned long>(SiteInPage),
            preimageMatch ? "PASS" : "NEGATIVE",
            validated,
            tainted,
            nx,
            path
        );
        return;
    }

    if (pageOffset == CavePageOffset) {
        const bool fullCaveZero = allZero(page + CaveInPage, CaveLength);
        const bool functionalWindowZero = allZero(
            page + CaveInPage, CaveFunctionalWindowLength
        );

        SYSLOG(
            MODULE_SHORT,
            "D97CO_CAVE_SEEN page=0x%llX inpage=0x%lX window18=%s full208=%s validated=%d tainted=%d nx=%d path=%s",
            static_cast<unsigned long long>(pageOffset),
            static_cast<unsigned long>(CaveInPage),
            functionalWindowZero ? "PASS" : "NEGATIVE",
            fullCaveZero ? "PASS" : "NEGATIVE",
            validated,
            tainted,
            nx,
            path
        );
    }
}

static void pluginStart() {
    DBGLOG(MODULE_SHORT, "D97CO_START");

    // Explicit opt-in for the experimental diagnostic build. Merely placing
    // the kext in an EFI is insufficient to activate the hook.
    if (!checkKernelArgument("-ocmcdiag")) {
        SYSLOG(MODULE_SHORT, "D97CO_INACTIVE missing=-ocmcdiag");
        return;
    }

    if (getKernelVersion() != KernelVersion::Tahoe) {
        SYSLOG(MODULE_SHORT, "D97CO_INACTIVE kernel_not_Tahoe");
        return;
    }

    if (!targetBuildMatches()) {
        SYSLOG(MODULE_SHORT, "D97CO_INACTIVE build_gate");
        return;
    }

    if (BaseDeviceInfo::get().cpuGeneration != CPUInfo::CpuGeneration::Haswell) {
        SYSLOG(MODULE_SHORT, "D97CO_INACTIVE cpu_not_Haswell");
        return;
    }

    lilu.onPatcherLoadForce([](void *user, KernelPatcher &patcher) {
        KernelPatcher::RouteRequest route(
            "_cs_validate_page",
            patchedCsValidatePage,
            orgCsValidatePage
        );

        if (!patcher.routeMultipleLong(KernelPatcher::KernelID, &route, 1)) {
            SYSLOG(MODULE_SHORT, "D97CO_ROUTE_CS_VALIDATE_PAGE=FAIL");
            return;
        }

        SYSLOG(MODULE_SHORT, "D97CO_ROUTE_CS_VALIDATE_PAGE=PASS");
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
