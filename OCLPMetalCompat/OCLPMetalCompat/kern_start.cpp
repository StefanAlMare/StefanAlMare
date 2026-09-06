//
// OCLPMetalCompat.kext — D97CS observe-only sysctl telemetry prototype
//
// Purpose: preserve the exact D97CO _cs_validate_page observation logic while
// replacing unreliable early-boot log observation with durable, read-only
// sysctl telemetry visible after boot.
//
// D97CS MUST NOT modify dyld shared-cache page contents. Functional D97BV
// delivery remains a later, separately-authorized phase.
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

static constexpr size_t CaveFunctionalWindowLength = 18;

static_assert(SiteInPage + sizeof(SitePreimage) <= PAGE_SIZE,
              "D97CS site preimage must fit inside one 4K validation page");
static_assert(CaveInPage + CaveLength <= PAGE_SIZE,
              "D97CS cave must fit inside one 4K validation page");

// Durable post-boot telemetry.
// 0 = not reached / false, 1 = reached / true, -1 = explicit negative/failure.
// Apple cs_validate_page outputs use -99 until observed.
static int telemetryStart = 0;
static int telemetryArg = 0;
static int telemetryKernel = 0;
static int telemetryBuild = 0;
static int telemetryCpu = 0;
static int telemetryGate = 0;
static int telemetryRoute = 0;

static int telemetrySiteOffset = 0;
static int telemetrySitePath = 0;
static int telemetrySitePreimage = 0;
static int telemetrySiteValidated = -99;
static int telemetrySiteTainted = -99;
static int telemetrySiteNx = -99;

static int telemetryCaveOffset = 0;
static int telemetryCavePath = 0;
static int telemetryCaveWindow18 = 0;
static int telemetryCaveFull208 = 0;
static int telemetryCaveValidated = -99;
static int telemetryCaveTainted = -99;
static int telemetryCaveNx = -99;

SYSCTL_DECL(_kern);

SYSCTL_INT(_kern, OID_AUTO, ocmc_start,          CTLFLAG_RD, &telemetryStart,          0, "D97CS pluginStart reached");
SYSCTL_INT(_kern, OID_AUTO, ocmc_arg,            CTLFLAG_RD, &telemetryArg,            0, "D97CS -ocmcdiag gate");
SYSCTL_INT(_kern, OID_AUTO, ocmc_kernel,         CTLFLAG_RD, &telemetryKernel,         0, "D97CS Tahoe kernel gate");
SYSCTL_INT(_kern, OID_AUTO, ocmc_build,          CTLFLAG_RD, &telemetryBuild,          0, "D97CS exact 25G82 build gate");
SYSCTL_INT(_kern, OID_AUTO, ocmc_cpu,            CTLFLAG_RD, &telemetryCpu,            0, "D97CS Haswell CPU gate");
SYSCTL_INT(_kern, OID_AUTO, ocmc_gate,           CTLFLAG_RD, &telemetryGate,           0, "D97CS all activation gates");
SYSCTL_INT(_kern, OID_AUTO, ocmc_route,          CTLFLAG_RD, &telemetryRoute,          0, "D97CS cs_validate_page route status");

SYSCTL_INT(_kern, OID_AUTO, ocmc_site_offset,    CTLFLAG_RD, &telemetrySiteOffset,     0, "D97CS site page offset observed");
SYSCTL_INT(_kern, OID_AUTO, ocmc_site_path,      CTLFLAG_RD, &telemetrySitePath,       0, "D97CS site exact x86_64h cache path");
SYSCTL_INT(_kern, OID_AUTO, ocmc_site_preimage,  CTLFLAG_RD, &telemetrySitePreimage,   0, "D97CS site preimage status");
SYSCTL_INT(_kern, OID_AUTO, ocmc_site_validated, CTLFLAG_RD, &telemetrySiteValidated,  0, "D97CS site Apple validated");
SYSCTL_INT(_kern, OID_AUTO, ocmc_site_tainted,   CTLFLAG_RD, &telemetrySiteTainted,    0, "D97CS site Apple tainted");
SYSCTL_INT(_kern, OID_AUTO, ocmc_site_nx,        CTLFLAG_RD, &telemetrySiteNx,         0, "D97CS site Apple nx");

SYSCTL_INT(_kern, OID_AUTO, ocmc_cave_offset,    CTLFLAG_RD, &telemetryCaveOffset,     0, "D97CS cave page offset observed");
SYSCTL_INT(_kern, OID_AUTO, ocmc_cave_path,      CTLFLAG_RD, &telemetryCavePath,       0, "D97CS cave exact x86_64h cache path");
SYSCTL_INT(_kern, OID_AUTO, ocmc_cave_window18,  CTLFLAG_RD, &telemetryCaveWindow18,   0, "D97CS cave first 18 bytes zero");
SYSCTL_INT(_kern, OID_AUTO, ocmc_cave_full208,   CTLFLAG_RD, &telemetryCaveFull208,    0, "D97CS cave full 208 bytes zero");
SYSCTL_INT(_kern, OID_AUTO, ocmc_cave_validated, CTLFLAG_RD, &telemetryCaveValidated,  0, "D97CS cave Apple validated");
SYSCTL_INT(_kern, OID_AUTO, ocmc_cave_tainted,   CTLFLAG_RD, &telemetryCaveTainted,    0, "D97CS cave Apple tainted");
SYSCTL_INT(_kern, OID_AUTO, ocmc_cave_nx,        CTLFLAG_RD, &telemetryCaveNx,         0, "D97CS cave Apple nx");

static bool telemetryRegistered = false;

static void registerTelemetry() {
    if (telemetryRegistered)
        return;

    sysctl_register_oid(&sysctl__kern_ocmc_start);
    sysctl_register_oid(&sysctl__kern_ocmc_arg);
    sysctl_register_oid(&sysctl__kern_ocmc_kernel);
    sysctl_register_oid(&sysctl__kern_ocmc_build);
    sysctl_register_oid(&sysctl__kern_ocmc_cpu);
    sysctl_register_oid(&sysctl__kern_ocmc_gate);
    sysctl_register_oid(&sysctl__kern_ocmc_route);

    sysctl_register_oid(&sysctl__kern_ocmc_site_offset);
    sysctl_register_oid(&sysctl__kern_ocmc_site_path);
    sysctl_register_oid(&sysctl__kern_ocmc_site_preimage);
    sysctl_register_oid(&sysctl__kern_ocmc_site_validated);
    sysctl_register_oid(&sysctl__kern_ocmc_site_tainted);
    sysctl_register_oid(&sysctl__kern_ocmc_site_nx);

    sysctl_register_oid(&sysctl__kern_ocmc_cave_offset);
    sysctl_register_oid(&sysctl__kern_ocmc_cave_path);
    sysctl_register_oid(&sysctl__kern_ocmc_cave_window18);
    sysctl_register_oid(&sysctl__kern_ocmc_cave_full208);
    sysctl_register_oid(&sysctl__kern_ocmc_cave_validated);
    sysctl_register_oid(&sysctl__kern_ocmc_cave_tainted);
    sysctl_register_oid(&sysctl__kern_ocmc_cave_nx);

    telemetryRegistered = true;
}

static bool targetBuildMatches() {
    char build[32] {};
    size_t size = sizeof(build);
    if (sysctlbyname("kern.osversion", build, &size, nullptr, 0) != 0) {
        telemetryBuild = -1;
        SYSLOG(MODULE_SHORT, "D97CS_BUILD_QUERY_FAIL");
        return false;
    }

    const bool match = !strcmp(build, TargetBuild);
    telemetryBuild = match ? 1 : -1;
    SYSLOG(MODULE_SHORT, "D97CS_BUILD build=%s expected=%s match=%d", build, TargetBuild, match);
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
    FunctionCast(patchedCsValidatePage, orgCsValidatePage)(
        vp, pager, pageOffset, data, validatedP, taintedP, nxP
    );

    const bool siteOffset = pageOffset == SitePageOffset;
    const bool caveOffset = pageOffset == CavePageOffset;

    if (!siteOffset && !caveOffset)
        return;

    if (siteOffset)
        telemetrySiteOffset = 1;
    if (caveOffset)
        telemetryCaveOffset = 1;

    if (!data)
        return;

    char path[PATH_MAX] {};
    int pathLen = PATH_MAX;
    if (vn_getpath(vp, path, &pathLen) != 0)
        return;

    if (!targetMainCachePath(path))
        return;

    if (siteOffset)
        telemetrySitePath = 1;
    if (caveOffset)
        telemetryCavePath = 1;

    const auto page = static_cast<const uint8_t *>(data);
    const int validated = validatedP ? *validatedP : -1;
    const int tainted = taintedP ? *taintedP : -1;
    const int nx = nxP ? *nxP : -1;

    if (siteOffset) {
        const bool preimageMatch = !memcmp(
            page + SiteInPage, SitePreimage, sizeof(SitePreimage)
        );

        telemetrySitePreimage = preimageMatch ? 1 : -1;
        telemetrySiteValidated = validated;
        telemetrySiteTainted = tainted;
        telemetrySiteNx = nx;

        SYSLOG(
            MODULE_SHORT,
            "D97CS_SITE_SEEN page=0x%llX inpage=0x%lX preimage=%s validated=%d tainted=%d nx=%d path=%s",
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

    if (caveOffset) {
        const bool fullCaveZero = allZero(page + CaveInPage, CaveLength);
        const bool functionalWindowZero = allZero(
            page + CaveInPage, CaveFunctionalWindowLength
        );

        telemetryCaveWindow18 = functionalWindowZero ? 1 : -1;
        telemetryCaveFull208 = fullCaveZero ? 1 : -1;
        telemetryCaveValidated = validated;
        telemetryCaveTainted = tainted;
        telemetryCaveNx = nx;

        SYSLOG(
            MODULE_SHORT,
            "D97CS_CAVE_SEEN page=0x%llX inpage=0x%lX window18=%s full208=%s validated=%d tainted=%d nx=%d path=%s",
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
    registerTelemetry();
    telemetryStart = 1;
    DBGLOG(MODULE_SHORT, "D97CS_START");

    telemetryArg = checkKernelArgument("-ocmcdiag") ? 1 : -1;
    if (telemetryArg != 1) {
        SYSLOG(MODULE_SHORT, "D97CS_INACTIVE missing=-ocmcdiag");
        return;
    }

    telemetryKernel = getKernelVersion() == KernelVersion::Tahoe ? 1 : -1;
    if (telemetryKernel != 1) {
        SYSLOG(MODULE_SHORT, "D97CS_INACTIVE kernel_not_Tahoe");
        return;
    }

    if (!targetBuildMatches()) {
        SYSLOG(MODULE_SHORT, "D97CS_INACTIVE build_gate");
        return;
    }

    telemetryCpu =
        BaseDeviceInfo::get().cpuGeneration == CPUInfo::CpuGeneration::Haswell ? 1 : -1;
    if (telemetryCpu != 1) {
        SYSLOG(MODULE_SHORT, "D97CS_INACTIVE cpu_not_Haswell");
        return;
    }

    telemetryGate = 1;

    lilu.onPatcherLoadForce([](void *user, KernelPatcher &patcher) {
        KernelPatcher::RouteRequest route(
            "_cs_validate_page",
            patchedCsValidatePage,
            orgCsValidatePage
        );

        if (!patcher.routeMultipleLong(KernelPatcher::KernelID, &route, 1)) {
            telemetryRoute = -1;
            SYSLOG(MODULE_SHORT, "D97CS_ROUTE_CS_VALIDATE_PAGE=FAIL");
            return;
        }

        telemetryRoute = 1;
        SYSLOG(MODULE_SHORT, "D97CS_ROUTE_CS_VALIDATE_PAGE=PASS");
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
