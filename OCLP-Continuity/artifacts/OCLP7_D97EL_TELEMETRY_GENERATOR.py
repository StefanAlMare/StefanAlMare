#!/usr/bin/env python3
from pathlib import Path
import sys

if len(sys.argv) != 3:
    raise SystemExit('usage: generator.py <D97EH.cpp> <D97EL.cpp>')

src = Path(sys.argv[1]).read_text()

def once(old, new, label):
    global src
    n = src.count(old)
    if n != 1:
        raise SystemExit(f'D97EL_GENERATOR_FAIL:{label}:anchor_count={n}')
    src = src.replace(old, new, 1)

once(
'''static mach_vm_address_t orgSetIdMode {};
static _Atomic(uint32_t) d97ehSetIdModeCallCount = ATOMIC_VAR_INIT(0);
''',
'''static mach_vm_address_t orgSetIdMode {};
static _Atomic(uint32_t) d97ehSetIdModeCallCount = ATOMIC_VAR_INIT(0);

// D97EL telemetry-only state. No observer semantics are changed.
static _Atomic(uint32_t) d97elObserverRequested = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97elCallbackSeenCount = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97elTargetCallbackSeenCount = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97elLastCallbackIndex = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97elKextLoadIndex = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97elRouteState = ATOMIC_VAR_INIT(0);
''',
'globals')

once(
'''static void processD97EHKext(
    KernelPatcher &patcher,
    size_t index,
    mach_vm_address_t address,
    size_t size
) {
    if (index != kextIOAcceleratorFamily2.loadIndex)
        return;
''',
'''static void processD97EHKext(
    KernelPatcher &patcher,
    size_t index,
    mach_vm_address_t address,
    size_t size
) {
    atomic_fetch_add_explicit(&d97elCallbackSeenCount, 1U, memory_order_relaxed);
    atomic_store_explicit(&d97elLastCallbackIndex, static_cast<uint32_t>(index), memory_order_relaxed);
    atomic_store_explicit(
        &d97elKextLoadIndex,
        static_cast<uint32_t>(kextIOAcceleratorFamily2.loadIndex),
        memory_order_relaxed
    );

    if (index != kextIOAcceleratorFamily2.loadIndex)
        return;

    atomic_fetch_add_explicit(&d97elTargetCallbackSeenCount, 1U, memory_order_relaxed);
''',
'target_callback_telemetry')

once(
'''    const bool routed =
        patcher.routeMultipleLong(index, &route, 1, address, size);

    SYSLOG(
''',
'''    const bool routed =
        patcher.routeMultipleLong(index, &route, 1, address, size);

    atomic_store_explicit(&d97elRouteState, routed ? 1U : 2U, memory_order_release);

    SYSLOG(
''',
'route_state')

once(
'''        service->setProperty("D97DDCallbackSeenCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97ddCallbackSeenCount, memory_order_relaxed)), 32);

        const uint32_t functionalRequested =
''',
'''        service->setProperty("D97DDCallbackSeenCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97ddCallbackSeenCount, memory_order_relaxed)), 32);

        service->setProperty("D97ELObserverBootArg", "-ocmcd97eh");
        service->setProperty("D97ELObserverRequested",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97elObserverRequested, memory_order_relaxed)), 32);
        service->setProperty("D97ELCallbackSeenCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97elCallbackSeenCount, memory_order_relaxed)), 32);
        service->setProperty("D97ELTargetCallbackSeenCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97elTargetCallbackSeenCount, memory_order_relaxed)), 32);
        service->setProperty("D97ELLastCallbackIndex",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97elLastCallbackIndex, memory_order_relaxed)), 32);
        service->setProperty("D97ELKextLoadIndex",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97elKextLoadIndex, memory_order_relaxed)), 32);
        service->setProperty("D97ELRouteStatus",
                             statusString(atomic_load_explicit(&d97elRouteState, memory_order_acquire)));
        service->setProperty("D97ELSetIdModeCallCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97ehSetIdModeCallCount, memory_order_relaxed)), 32);

        const uint32_t functionalRequested =
''',
'publisher_properties')

once(
'''    if (checkKernelArgument("-ocmcd97eh")) {
        lilu.onKextLoadForce(&kextIOAcceleratorFamily2);
''',
'''    const bool d97elObserverRequestedNow = checkKernelArgument("-ocmcd97eh");
    atomic_store_explicit(
        &d97elObserverRequested,
        d97elObserverRequestedNow ? 1U : 0U,
        memory_order_relaxed
    );

    if (d97elObserverRequestedNow) {
        lilu.onKextLoadForce(&kextIOAcceleratorFamily2);
''',
'observer_requested')

for token in ('patchedMode', '~0xff8073c0', '~0xFF8073C0', 'mode &=', 'return kIOReturnSuccess'):
    if token in src:
        raise SystemExit(f'D97EL_GENERATOR_FAIL:forbidden_token:{token}')

required = (
    '__ZN14IOAccelSurface11set_id_modeEjj',
    'FunctionCast(patchedSetIdMode, orgSetIdMode)(that, id, mode)',
    'return ret;',
    'mode & 0xFF8073C0U',
    'mode & 0x007F8C3FU',
    'D97ELObserverRequested',
    'D97ELCallbackSeenCount',
    'D97ELTargetCallbackSeenCount',
    'D97ELKextLoadIndex',
    'D97ELRouteStatus',
    'D97ELSetIdModeCallCount',
    'atomic_store_explicit(&d97elRouteState, routed ? 1U : 2U, memory_order_release)',
)
for token in required:
    if token not in src:
        raise SystemExit(f'D97EL_GENERATOR_FAIL:required_missing:{token}')

Path(sys.argv[2]).write_text(src)
print('D97EL_GENERATOR_STATUS=PASS')
