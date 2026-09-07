#!/usr/bin/env python3
from pathlib import Path
import hashlib
import sys

if len(sys.argv) != 3:
    raise SystemExit('usage: generator.py <D97ES.cpp> <D97EZ.cpp>')

inp = Path(sys.argv[1])
out = Path(sys.argv[2])
src = inp.read_text()

EXPECTED_D97ES_SHA256 = '8184610aca1f2e651e6526e45c05d00a96055711c985571bc34c703ba7f6a8d0'
actual_input_sha = hashlib.sha256(src.encode()).hexdigest()
if actual_input_sha != EXPECTED_D97ES_SHA256:
    raise SystemExit(f'D97EZ_GENERATOR_FAIL:input_sha:{actual_input_sha}')

def once(old, new, label):
    global src
    n = src.count(old)
    if n != 1:
        raise SystemExit(f'D97EZ_GENERATOR_FAIL:{label}:anchor_count={n}')
    src = src.replace(old, new, 1)

once(
'''static _Atomic(uint32_t) d97esRet[D97ESCaptureSlots] {};

static const char *d97esValidKeys[D97ESCaptureSlots] {
''',
'''static _Atomic(uint32_t) d97esRet[D97ESCaptureSlots] {};

// D97EZ exact-match compatibility experiment. LATENT unless -ocmcd97ez is present.
static _Atomic(uint32_t) d97ezFunctionalRequested = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97ezExact224SeenCount = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97ezExact224AdaptedCount = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97ezOtherModeSeenCount = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97ezAdaptSuccessCount = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97ezAdaptFailureCount = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97ezPassthroughSuccessCount = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97ezPassthroughFailureCount = ATOMIC_VAR_INIT(0);
static _Atomic(uint32_t) d97ezPassedMode[D97ESCaptureSlots] {};

static const char *d97esValidKeys[D97ESCaptureSlots] {
''',
'globals')

once(
'''static const char *d97esRetKeys[D97ESCaptureSlots] {
    "D97ES01Ret", "D97ES02Ret", "D97ES03Ret", "D97ES04Ret",
    "D97ES05Ret", "D97ES06Ret", "D97ES07Ret", "D97ES08Ret"
};

static constexpr const char *TargetBuild = "25G82";
''',
'''static const char *d97esRetKeys[D97ESCaptureSlots] {
    "D97ES01Ret", "D97ES02Ret", "D97ES03Ret", "D97ES04Ret",
    "D97ES05Ret", "D97ES06Ret", "D97ES07Ret", "D97ES08Ret"
};
static const char *d97ezPassedModeKeys[D97ESCaptureSlots] {
    "D97EZ01PassedMode", "D97EZ02PassedMode", "D97EZ03PassedMode", "D97EZ04PassedMode",
    "D97EZ05PassedMode", "D97EZ06PassedMode", "D97EZ07PassedMode", "D97EZ08PassedMode"
};

static constexpr const char *TargetBuild = "25G82";
''',
'passed_mode_keys')

once(
'''static IOReturn patchedSetIdMode(void *that, uint32_t id, uint32_t mode) {
    // D97EH invariant: Apple receives the exact original id and mode.
    const IOReturn ret =
        FunctionCast(patchedSetIdMode, orgSetIdMode)(that, id, mode);

    const uint32_t call =
        atomic_fetch_add_explicit(&d97ehSetIdModeCallCount, 1U, memory_order_relaxed) + 1U;
''',
'''static IOReturn patchedSetIdMode(void *that, uint32_t id, uint32_t mode) {
    const uint32_t originalMode = mode;
    const bool exact224 = originalMode == 0x00000224U;
    const bool functionalActive =
        atomic_load_explicit(&d97ezFunctionalRequested, memory_order_relaxed) != 0;

    if (exact224)
        atomic_fetch_add_explicit(&d97ezExact224SeenCount, 1U, memory_order_relaxed);
    else
        atomic_fetch_add_explicit(&d97ezOtherModeSeenCount, 1U, memory_order_relaxed);

    // Exact-match adapter only. There is deliberately no broad bit mask.
    const uint32_t passedMode =
        (functionalActive && exact224) ? 0x00000024U : originalMode;

    if (functionalActive && exact224)
        atomic_fetch_add_explicit(&d97ezExact224AdaptedCount, 1U, memory_order_relaxed);

    // Apple original is called exactly once. `that` and `id` remain unchanged.
    const IOReturn ret =
        FunctionCast(patchedSetIdMode, orgSetIdMode)(that, id, passedMode);

    if (functionalActive && exact224) {
        if (ret == kIOReturnSuccess)
            atomic_fetch_add_explicit(&d97ezAdaptSuccessCount, 1U, memory_order_relaxed);
        else
            atomic_fetch_add_explicit(&d97ezAdaptFailureCount, 1U, memory_order_relaxed);
    } else {
        if (ret == kIOReturnSuccess)
            atomic_fetch_add_explicit(&d97ezPassthroughSuccessCount, 1U, memory_order_relaxed);
        else
            atomic_fetch_add_explicit(&d97ezPassthroughFailureCount, 1U, memory_order_relaxed);
    }

    const uint32_t call =
        atomic_fetch_add_explicit(&d97ehSetIdModeCallCount, 1U, memory_order_relaxed) + 1U;
''',
'exact_adapter_call')

once(
'''        atomic_store_explicit(&d97esMode[slot], mode, memory_order_relaxed);
        atomic_store_explicit(&d97esBadBits[slot], badBits, memory_order_relaxed);
''',
'''        atomic_store_explicit(&d97esMode[slot], originalMode, memory_order_relaxed);
        atomic_store_explicit(&d97ezPassedMode[slot], passedMode, memory_order_relaxed);
        atomic_store_explicit(&d97esBadBits[slot], badBits, memory_order_relaxed);
''',
'tuple_original_and_passed_mode')

once(
'''        service->setProperty("D97ESCapturedCount",
                             static_cast<unsigned long long>(d97esCallCount < D97ESCaptureSlots ? d97esCallCount : D97ESCaptureSlots), 32);

        for (uint32_t slot = 0; slot < D97ESCaptureSlots; slot++) {
''',
'''        service->setProperty("D97ESCapturedCount",
                             static_cast<unsigned long long>(d97esCallCount < D97ESCaptureSlots ? d97esCallCount : D97ESCaptureSlots), 32);
        const uint32_t d97ezFunctional =
            atomic_load_explicit(&d97ezFunctionalRequested, memory_order_relaxed);
        service->setProperty("D97EZFunctionalBootArg", "-ocmcd97ez");
        service->setProperty("D97EZFunctionalRequested",
                             static_cast<unsigned long long>(d97ezFunctional), 32);
        service->setProperty("D97EZFunctionalMode", d97ezFunctional ? "ACTIVE" : "LATENT");
        service->setProperty("D97EZExact224SeenCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97ezExact224SeenCount, memory_order_relaxed)), 32);
        service->setProperty("D97EZExact224AdaptedCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97ezExact224AdaptedCount, memory_order_relaxed)), 32);
        service->setProperty("D97EZOtherModeSeenCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97ezOtherModeSeenCount, memory_order_relaxed)), 32);
        service->setProperty("D97EZAdaptSuccessCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97ezAdaptSuccessCount, memory_order_relaxed)), 32);
        service->setProperty("D97EZAdaptFailureCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97ezAdaptFailureCount, memory_order_relaxed)), 32);
        service->setProperty("D97EZPassthroughSuccessCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97ezPassthroughSuccessCount, memory_order_relaxed)), 32);
        service->setProperty("D97EZPassthroughFailureCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97ezPassthroughFailureCount, memory_order_relaxed)), 32);

        for (uint32_t slot = 0; slot < D97ESCaptureSlots; slot++) {
''',
'publisher_counters')

once(
'''            service->setProperty(d97esModeKeys[slot],
                                 static_cast<unsigned long long>(atomic_load_explicit(&d97esMode[slot], memory_order_relaxed)), 32);
            service->setProperty(d97esBadBitsKeys[slot],
''',
'''            service->setProperty(d97esModeKeys[slot],
                                 static_cast<unsigned long long>(atomic_load_explicit(&d97esMode[slot], memory_order_relaxed)), 32);
            service->setProperty(d97ezPassedModeKeys[slot],
                                 static_cast<unsigned long long>(atomic_load_explicit(&d97ezPassedMode[slot], memory_order_relaxed)), 32);
            service->setProperty(d97esBadBitsKeys[slot],
''',
'publisher_passed_mode')

once(
'''    const bool d97elObserverRequestedNow = checkKernelArgument("-ocmcd97eh");
    atomic_store_explicit(
        &d97elObserverRequested,
        d97elObserverRequestedNow ? 1U : 0U,
        memory_order_relaxed
    );

    if (d97elObserverRequestedNow) {
''',
'''    const bool d97elObserverRequestedNow = checkKernelArgument("-ocmcd97eh");
    atomic_store_explicit(
        &d97elObserverRequested,
        d97elObserverRequestedNow ? 1U : 0U,
        memory_order_relaxed
    );
    const bool d97ezFunctionalRequestedNow = checkKernelArgument("-ocmcd97ez");
    atomic_store_explicit(
        &d97ezFunctionalRequested,
        d97ezFunctionalRequestedNow ? 1U : 0U,
        memory_order_relaxed
    );

    if (d97elObserverRequestedNow) {
''',
'functional_bootarg')

# Exact-match safety: broad masking and return coercion remain forbidden.
for token in (
    'mode &=', '~0x00000200', '~0x200', 'mode & 0x007F8C3F',
    'return kIOReturnSuccess', 'id =', 'id &=', 'that ='
):
    if token in src:
        raise SystemExit(f'D97EZ_GENERATOR_FAIL:forbidden_token:{token}')

required = (
    'originalMode == 0x00000224U',
    '(functionalActive && exact224) ? 0x00000024U : originalMode',
    'FunctionCast(patchedSetIdMode, orgSetIdMode)(that, id, passedMode)',
    'return ret;',
    'checkKernelArgument("-ocmcd97ez")',
    'D97EZFunctionalMode',
    'D97EZExact224SeenCount',
    'D97EZExact224AdaptedCount',
    'D97EZOtherModeSeenCount',
    'D97EZAdaptSuccessCount',
    'D97EZAdaptFailureCount',
    'D97EZPassthroughSuccessCount',
    'D97EZPassthroughFailureCount',
    'D97EZ01PassedMode',
    'atomic_store_explicit(&d97esMode[slot], originalMode, memory_order_relaxed)',
    'atomic_store_explicit(&d97ezPassedMode[slot], passedMode, memory_order_relaxed)',
    'lilu.onKextLoadForce(&kextIOAcceleratorFamily2);',
)
for token in required:
    if token not in src:
        raise SystemExit(f'D97EZ_GENERATOR_FAIL:required_missing:{token}')

# There must be exactly one exact translation constant pair in executable source logic.
if src.count('0x00000224U') != 1:
    raise SystemExit(f'D97EZ_GENERATOR_FAIL:exact224_count={src.count("0x00000224U")}')
if src.count('0x00000024U') != 1:
    raise SystemExit(f'D97EZ_GENERATOR_FAIL:exact24_count={src.count("0x00000024U")}')

out.write_text(src)
print(f'D97EZ_INPUT_SHA256={actual_input_sha}')
print(f'D97EZ_OUTPUT_SHA256={hashlib.sha256(src.encode()).hexdigest()}')
print('D97EZ_GENERATOR_STATUS=PASS')