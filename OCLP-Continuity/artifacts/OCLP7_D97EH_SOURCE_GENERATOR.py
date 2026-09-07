#!/usr/bin/env python3
from pathlib import Path
import sys

if len(sys.argv) != 3:
    raise SystemExit("usage: generator.py <D97DL.cpp> <D97EH.cpp>")

src = Path(sys.argv[1]).read_text()

def once(old, new, label):
    global src
    n = src.count(old)
    if n != 1:
        raise SystemExit(f"D97EH_GENERATOR_FAIL:{label}:anchor_count={n}")
    src = src.replace(old, new, 1)

once(
'''static mach_vm_address_t orgCsValidatePage {};

static constexpr const char *TargetBuild = "25G82";
''',
'''static mach_vm_address_t orgCsValidatePage {};

// D97EH observer-only target. Tahoe may KC-back this bundle even if the
// standalone executable is absent from the filesystem.
static const char *pathIOAcceleratorFamily2 =
    "/System/Library/Extensions/IOAcceleratorFamily2.kext/Contents/MacOS/IOAcceleratorFamily2";
static KernelPatcher::KextInfo kextIOAcceleratorFamily2 {
    "com.apple.iokit.IOAcceleratorFamily2",
    &pathIOAcceleratorFamily2,
    1,
    {true},
    {},
    KernelPatcher::KextInfo::Unloaded
};
static mach_vm_address_t orgSetIdMode {};
static _Atomic(uint32_t) d97ehSetIdModeCallCount = ATOMIC_VAR_INIT(0);

static constexpr const char *TargetBuild = "25G82";
''',
"globals")

once(
'''static void publishState(thread_call_param_t, thread_call_param_t) {
''',
'''static IOReturn patchedSetIdMode(void *that, uint32_t id, uint32_t mode) {
    // D97EH invariant: Apple receives the exact original id and mode.
    const IOReturn ret =
        FunctionCast(patchedSetIdMode, orgSetIdMode)(that, id, mode);

    const uint32_t call =
        atomic_fetch_add_explicit(&d97ehSetIdModeCallCount, 1U, memory_order_relaxed) + 1U;

    if (call <= 32U) {
        const uint32_t badBits = mode & 0xFF8073C0U;
        const uint32_t goodBits = mode & 0x007F8C3FU;
        SYSLOG(
            "ocmc",
            "D97EH_SET_ID_MODE call=%u id=0x%08x mode=0x%08x badBits=0x%08x goodBits=0x%08x ret=0x%08x",
            call, id, mode, badBits, goodBits, static_cast<uint32_t>(ret)
        );
    }

    return ret;
}

static void processD97EHKext(
    KernelPatcher &patcher,
    size_t index,
    mach_vm_address_t address,
    size_t size
) {
    if (index != kextIOAcceleratorFamily2.loadIndex)
        return;

    KernelPatcher::RouteRequest route(
        "__ZN14IOAccelSurface11set_id_modeEjj",
        patchedSetIdMode,
        orgSetIdMode
    );

    const bool routed =
        patcher.routeMultipleLong(index, &route, 1, address, size);

    SYSLOG(
        "ocmc",
        "D97EH_ROUTE bundle=com.apple.iokit.IOAcceleratorFamily2 version=487.4.3 status=%s",
        routed ? "PASS" : "NEGATIVE"
    );

    if (!routed)
        patcher.clearError();
}

static void publishState(thread_call_param_t, thread_call_param_t) {
''',
"observer_functions")

once(
'''    if (!cpuOk)
        return;

    lilu.onPatcherLoadForce([](void *user, KernelPatcher &patcher) {
''',
'''    if (!cpuOk)
        return;

    if (checkKernelArgument("-ocmcd97eh")) {
        lilu.onKextLoadForce(&kextIOAcceleratorFamily2);
        lilu.onKextLoadForce(
            nullptr,
            0,
            [](void *user, KernelPatcher &patcher, size_t index, mach_vm_address_t address, size_t size) {
                processD97EHKext(patcher, index, address, size);
            },
            nullptr
        );
    }

    lilu.onPatcherLoadForce([](void *user, KernelPatcher &patcher) {
''',
"registration")

for token in ("patchedMode", "~0xff8073c0", "~0xFF8073C0", "mode &=", "return kIOReturnSuccess"):
    if token in src:
        raise SystemExit(f"D97EH_GENERATOR_FAIL:forbidden_token:{token}")

required = (
    '__ZN14IOAccelSurface11set_id_modeEjj',
    'FunctionCast(patchedSetIdMode, orgSetIdMode)(that, id, mode)',
    'return ret;',
    'mode & 0xFF8073C0U',
    'mode & 0x007F8C3FU',
    'checkKernelArgument("-ocmcd97eh")',
    'D97EH_SET_ID_MODE',
    'SiteReplacement',
    'CaveReplacement',
)
for token in required:
    if token not in src:
        raise SystemExit(f"D97EH_GENERATOR_FAIL:required_missing:{token}")

Path(sys.argv[2]).write_text(src)
print("D97EH_GENERATOR_STATUS=PASS")
