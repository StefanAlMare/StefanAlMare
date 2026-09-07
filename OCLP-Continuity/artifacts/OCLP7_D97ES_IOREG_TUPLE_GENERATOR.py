#!/usr/bin/env python3
from pathlib import Path
import sys

if len(sys.argv) != 3:
    raise SystemExit('usage: generator.py <D97EL.cpp> <D97ES.cpp>')

src = Path(sys.argv[1]).read_text()

def once(old, new, label):
    global src
    n = src.count(old)
    if n != 1:
        raise SystemExit(f'D97ES_GENERATOR_FAIL:{label}:anchor_count={n}')
    src = src.replace(old, new, 1)

once(
'''static _Atomic(uint32_t) d97elRouteState = ATOMIC_VAR_INIT(0);

static constexpr const char *TargetBuild = "25G82";
''',
'''static _Atomic(uint32_t) d97elRouteState = ATOMIC_VAR_INIT(0);

// D97ES live-readable tuple telemetry. Observer semantics remain passthrough-only.
static constexpr uint32_t D97ESCaptureSlots = 8U;
static _Atomic(uint32_t) d97esValid[D97ESCaptureSlots] {};
static _Atomic(uint32_t) d97esId[D97ESCaptureSlots] {};
static _Atomic(uint32_t) d97esMode[D97ESCaptureSlots] {};
static _Atomic(uint32_t) d97esBadBits[D97ESCaptureSlots] {};
static _Atomic(uint32_t) d97esGoodBits[D97ESCaptureSlots] {};
static _Atomic(uint32_t) d97esRet[D97ESCaptureSlots] {};

static const char *d97esValidKeys[D97ESCaptureSlots] {
    "D97ES01Valid", "D97ES02Valid", "D97ES03Valid", "D97ES04Valid",
    "D97ES05Valid", "D97ES06Valid", "D97ES07Valid", "D97ES08Valid"
};
static const char *d97esIdKeys[D97ESCaptureSlots] {
    "D97ES01Id", "D97ES02Id", "D97ES03Id", "D97ES04Id",
    "D97ES05Id", "D97ES06Id", "D97ES07Id", "D97ES08Id"
};
static const char *d97esModeKeys[D97ESCaptureSlots] {
    "D97ES01Mode", "D97ES02Mode", "D97ES03Mode", "D97ES04Mode",
    "D97ES05Mode", "D97ES06Mode", "D97ES07Mode", "D97ES08Mode"
};
static const char *d97esBadBitsKeys[D97ESCaptureSlots] {
    "D97ES01BadBits", "D97ES02BadBits", "D97ES03BadBits", "D97ES04BadBits",
    "D97ES05BadBits", "D97ES06BadBits", "D97ES07BadBits", "D97ES08BadBits"
};
static const char *d97esGoodBitsKeys[D97ESCaptureSlots] {
    "D97ES01GoodBits", "D97ES02GoodBits", "D97ES03GoodBits", "D97ES04GoodBits",
    "D97ES05GoodBits", "D97ES06GoodBits", "D97ES07GoodBits", "D97ES08GoodBits"
};
static const char *d97esRetKeys[D97ESCaptureSlots] {
    "D97ES01Ret", "D97ES02Ret", "D97ES03Ret", "D97ES04Ret",
    "D97ES05Ret", "D97ES06Ret", "D97ES07Ret", "D97ES08Ret"
};

static constexpr const char *TargetBuild = "25G82";
''',
'globals')

once(
'''    if (call <= 32U) {
        const uint32_t badBits = mode & 0xFF8073C0U;
        const uint32_t goodBits = mode & 0x007F8C3FU;
        SYSLOG(
            "ocmc",
            "D97EH_SET_ID_MODE call=%u id=0x%08x mode=0x%08x badBits=0x%08x goodBits=0x%08x ret=0x%08x",
            call, id, mode, badBits, goodBits, static_cast<uint32_t>(ret)
        );
    }

    return ret;
''',
'''    const uint32_t badBits = mode & 0xFF8073C0U;
    const uint32_t goodBits = mode & 0x007F8C3FU;

    // D97ES records only after Apple returns. No argument or return mutation.
    if (call <= D97ESCaptureSlots) {
        const uint32_t slot = call - 1U;
        atomic_store_explicit(&d97esId[slot], id, memory_order_relaxed);
        atomic_store_explicit(&d97esMode[slot], mode, memory_order_relaxed);
        atomic_store_explicit(&d97esBadBits[slot], badBits, memory_order_relaxed);
        atomic_store_explicit(&d97esGoodBits[slot], goodBits, memory_order_relaxed);
        atomic_store_explicit(&d97esRet[slot], static_cast<uint32_t>(ret), memory_order_relaxed);
        atomic_store_explicit(&d97esValid[slot], 1U, memory_order_release);
    }

    if (call <= 32U) {
        SYSLOG(
            "ocmc",
            "D97EH_SET_ID_MODE call=%u id=0x%08x mode=0x%08x badBits=0x%08x goodBits=0x%08x ret=0x%08x",
            call, id, mode, badBits, goodBits, static_cast<uint32_t>(ret)
        );
    }

    return ret;
''',
'capture_after_original')

once(
'''        service->setProperty("D97ELSetIdModeCallCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97ehSetIdModeCallCount, memory_order_relaxed)), 32);

        const uint32_t functionalRequested =
''',
'''        const uint32_t d97esCallCount =
            atomic_load_explicit(&d97ehSetIdModeCallCount, memory_order_relaxed);
        service->setProperty("D97ELSetIdModeCallCount",
                             static_cast<unsigned long long>(d97esCallCount), 32);
        service->setProperty("D97ESCaptureSlots",
                             static_cast<unsigned long long>(D97ESCaptureSlots), 32);
        service->setProperty("D97ESCapturedCount",
                             static_cast<unsigned long long>(d97esCallCount < D97ESCaptureSlots ? d97esCallCount : D97ESCaptureSlots), 32);

        for (uint32_t slot = 0; slot < D97ESCaptureSlots; slot++) {
            const uint32_t valid =
                atomic_load_explicit(&d97esValid[slot], memory_order_acquire);
            service->setProperty(d97esValidKeys[slot],
                                 static_cast<unsigned long long>(valid), 32);
            if (!valid)
                continue;

            service->setProperty(d97esIdKeys[slot],
                                 static_cast<unsigned long long>(atomic_load_explicit(&d97esId[slot], memory_order_relaxed)), 32);
            service->setProperty(d97esModeKeys[slot],
                                 static_cast<unsigned long long>(atomic_load_explicit(&d97esMode[slot], memory_order_relaxed)), 32);
            service->setProperty(d97esBadBitsKeys[slot],
                                 static_cast<unsigned long long>(atomic_load_explicit(&d97esBadBits[slot], memory_order_relaxed)), 32);
            service->setProperty(d97esGoodBitsKeys[slot],
                                 static_cast<unsigned long long>(atomic_load_explicit(&d97esGoodBits[slot], memory_order_relaxed)), 32);
            service->setProperty(d97esRetKeys[slot],
                                 static_cast<unsigned long long>(atomic_load_explicit(&d97esRet[slot], memory_order_relaxed)), 32);
        }

        const uint32_t functionalRequested =
''',
'publisher_tuple_properties')

once(
'''    const bool complete =
        observedComplete && (!functionalRequested || functionalResolved);

    // Bounded 5-minute early-boot publication window.
''',
'''    const bool observerRequested =
        atomic_load_explicit(&d97elObserverRequested, memory_order_relaxed) != 0;
    const bool observerTupleCaptured =
        atomic_load_explicit(&d97ehSetIdModeCallCount, memory_order_acquire) != 0;
    const bool complete =
        observedComplete && (!functionalRequested || functionalResolved) &&
        (!observerRequested || observerTupleCaptured);

    // D97ES keeps the existing bounded publisher alive until the first observer tuple.
    // Still capped at the original 5-minute early-boot window.
''',
'publisher_liveness')

for token in ('patchedMode', '~0xff8073c0', '~0xFF8073C0', 'mode &=', 'return kIOReturnSuccess'):
    if token in src:
        raise SystemExit(f'D97ES_GENERATOR_FAIL:forbidden_token:{token}')

required = (
    '__ZN14IOAccelSurface11set_id_modeEjj',
    'FunctionCast(patchedSetIdMode, orgSetIdMode)(that, id, mode)',
    'return ret;',
    'const uint32_t badBits = mode & 0xFF8073C0U;',
    'const uint32_t goodBits = mode & 0x007F8C3FU;',
    'D97ESCaptureSlots',
    'D97ESCapturedCount',
    'D97ES01Id',
    'D97ES01Mode',
    'D97ES01BadBits',
    'D97ES01GoodBits',
    'D97ES01Ret',
    'atomic_store_explicit(&d97esValid[slot], 1U, memory_order_release)',
    '(!observerRequested || observerTupleCaptured)',
    'lilu.onKextLoadForce(&kextIOAcceleratorFamily2);',
)
for token in required:
    if token not in src:
        raise SystemExit(f'D97ES_GENERATOR_FAIL:required_missing:{token}')

Path(sys.argv[2]).write_text(src)
print('D97ES_GENERATOR_STATUS=PASS')
