# OCLP7 CHECKPOINT — D97EP — D97EL VESA ROUTE PASS / ACCELERATED MEASUREMENT GATE

Date: 2026-09-07 EEST
Target: ASUS2 — Tahoe 26.6.2 / 25G82 — Haswell 8086:0412 — MacBookAir6,2

## Active EFI / plugin
Audited D97EL `OCLPMetalCompat.kext` 0.0.10 is active in EFI.

Exact identity:
- version `0.0.10`;
- arch `x86_64`;
- UUID `1A19441E-9937-3FBF-995D-9CC282E89089`;
- executable SHA256 `7aa86d2484c6f252f7a77704117cebb6e14afa96bf2d98bb2523644fd86926ac`.

VESA boot args at this gate:
- `-igfxvesa` ACTIVE;
- `-ocmcdiag` ACTIVE;
- `-ocmcd97bv` ACTIVE;
- `-ocmcd97eh` ACTIVE;
- `#-ocmcd97bvcave` inert.

Normal pre-D97ED 3/3/3 framebuffer baseline remains required.

## D97EL VESA telemetry — decisive PASS
User returned IORegistry telemetry after rebooting D97EL 0.0.10 in VESA:

- `D97ELObserverRequested = 1`;
- `D97ELCallbackSeenCount = 17`;
- `D97ELTargetCallbackSeenCount = 1`;
- `D97ELLastCallbackIndex = 20`;
- `D97ELKextLoadIndex = 9`;
- `D97ELRouteStatus = PASS`;
- `D97ELSetIdModeCallCount = 0`;
- `D97CTRouteStatus = PASS`;
- `D97DIFunctionalRequested = 1`;
- `D97DIFunctionalMode = ACTIVE`.

Loaded identity confirms OCLPMetalCompat 0.0.10 UUID `1A19441E-9937-3FBF-995D-9CC282E89089`.

Interpretation:
1. D97EL observer bootarg was recognized.
2. Lilu global kext callback mechanism is active.
3. Exact IOAcceleratorFamily2 target callback was observed once.
4. Exact route for `__ZN14IOAccelSurface11set_id_modeEjj` installed successfully.
5. No set_id_mode call occurred in VESA, which is expected and cleanly preserves the accelerated measurement frontier.
6. D97BV remains healthy and active.

Classifications:
- `D97EP_D97EL_EFI_IDENTITY=PASS`;
- `D97EP_OBSERVER_REQUESTED=YES`;
- `D97EP_GLOBAL_CALLBACK_PATH=PASS`;
- `D97EP_TARGET_CALLBACK=PASS`;
- `D97EP_SET_ID_MODE_ROUTE=PASS`;
- `D97EP_SET_ID_MODE_CALLS_VESA=0_EXPECTED`;
- `D97EP_D97BV_ROUTE=PASS`;
- `D97EP_D97BV_FUNCTIONAL_MODE=ACTIVE`.

## OCLP T2 / Haswell audit integration decision
Do not add any new EFI/boot-arg variable before the first D97EL accelerated measurement.

Reason: the exact set_id_mode route is now proven. Introducing `igfxmetal=1`, `-disablegfxfirmware`, `watchdog=0`, or other new variables at this point would contaminate the causal experiment. Existing `ipc_control_port_options=0` and `-amfipassbeta` may remain as already present. Any T2/Haswell-derived bootarg experiment must be a later separate A/B after exact mode/return measurement.

## NEXT ACTION — one accelerated diagnostic measurement boot is authorized
Only change for the next diagnostic boot:
- disable/remove/comment `-igfxvesa`.

Keep:
- `-ocmcdiag`;
- `-ocmcd97bv`;
- `-ocmcd97eh`;
- all other currently settled EFI/Root Patch state unchanged;
- normal 3/3/3 framebuffer baseline unchanged.

Do NOT:
- add `igfxmetal=1` yet;
- add `-disablegfxfirmware` or `watchdog=0`;
- mutate any set_id_mode bits;
- coerce return codes;
- Root Patch again;
- change framebuffer counts;
- shadow native Tahoe Metal;
- replay true-five;
- alter Golden.

Expected measurement from accelerated boot:
`D97EH_SET_ID_MODE call=<n> id=<...> mode=<...> badBits=<...> goodBits=<...> ret=<...>`
for up to the first 32 calls, while Apple's original receives exact unmodified `that/id/mode` and returns exact original IOReturn.

If accelerated boot loses image and the machine is recovered to VESA, permanent VESA recovery rule applies: analyze the immediately preceding accelerated boot, never the later recovery boot.
