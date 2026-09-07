# OCLP7 D97FG — D97EZ 0.0.12 LATENT VESA runtime PASS / one ACTIVE accelerated experiment authorized

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, MacBookAir6,2

## Input authority
- D97FD independently audited D97EZ 0.0.12 build and binary semantics PASS.
- D97FF proved exact active-EFI D97EZ identity before runtime boot.
- D97EY remains the decisive semantic proof for observed set_id_mode classes: accepted 0x24 versus rejected 0x224 carrying exact additional bit 0x200.
- D97EW/D97EX persistent collector remains the settled accelerated-evidence transport mechanism.

## Exact current VESA runtime evidence
System:
- ProductVersion `26.6.2`;
- BuildVersion `25G82`.

Saved boot args:
`-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 -igfxvesa -ocmcdiag #-ocmcd97bvcave -ocmcd97bv -ocmcd97eh`

Therefore:
- `-igfxvesa` active;
- `-ocmcd97ez` absent;
- observer and settled D97BV args preserved;
- no new T2/Haswell variable introduced.

Loaded identity:
- `com.oclpmetalcompat.OCLPMetalCompat (0.0.12)`;
- UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`;
- x86_64 load shown by kmutil.

IORegistry runtime state:
- `D97EZFunctionalBootArg="-ocmcd97ez"`;
- `D97EZFunctionalRequested=0`;
- `D97EZFunctionalMode="LATENT"`;
- `D97EZExact224SeenCount=0`;
- `D97EZExact224AdaptedCount=0`;
- `D97EZOtherModeSeenCount=0`;
- `D97EZAdaptSuccessCount=0`;
- `D97EZAdaptFailureCount=0`;
- `D97EZPassthroughSuccessCount=0`;
- `D97EZPassthroughFailureCount=0`;
- `D97ELObserverRequested=1`;
- `D97ELCallbackSeenCount=17`;
- `D97ELTargetCallbackSeenCount=1`;
- `D97ELRouteStatus="PASS"`;
- `D97ELSetIdModeCallCount=0`;
- `D97ESCapturedCount=0`;
- all `D97ES01Valid`..`D97ES08Valid=0`;
- `D97CTRouteStatus="PASS"`;
- `D97CTPublisherTicks=300`.

## Interpretation
This is a clean VESA/LATENT runtime PASS:
- exact audited D97EZ loads;
- the existing observer target route remains healthy;
- the new functional gate is definitively inactive when its bootarg is absent;
- no adaptation counter increments;
- no tuple capture occurs because VESA produces zero set_id_mode calls;
- publisher reaches its expected bounded 300 ticks.

Classification is deliberately bounded. This VESA boot proves LATENT gating/route/publisher/zero-call behavior. It does NOT by itself prove exact passthrough semantics under real accelerated set_id_mode traffic, because there are no such calls in VESA.

## Classification
- `D97FG_D97EZ_RUNTIME_IDENTITY=PASS`
- `D97FG_D97EZ_LATENT_GATE=PASS`
- `D97FG_D97EL_ROUTE=PASS`
- `D97FG_D97ES_EMPTY_TUPLE_STATE=PASS`
- `D97FG_D97EZ_ZERO_ADAPTATION=PASS`
- `D97FG_D97EZ_PUBLISHER_BOUNDED_LIVENESS=PASS`
- `D97FG_ACCELERATED_ACTIVE_EXPERIMENT_AUTHORIZED=YES_ONE_BOOT`
- `D97FG_GLOBAL_MASK_AUTHORIZED=NO`
- `D97FG_ROOT_PATCH_AUTHORIZED=NO`
- `D97FG_NEW_T2_HASWELL_BOOTARGS_AUTHORIZED=NO`

## One authorized ACTIVE experiment
Perform exactly one accelerated diagnostic boot with only these intentional boot-arg state changes relative to the proven LATENT VESA state:
1. make `-igfxvesa` inert using established `#-igfxvesa` convention;
2. add active `-ocmcd97ez`.

Preserve unchanged:
- `-ocmcdiag`;
- `-ocmcd97bv`;
- `-ocmcd97eh`;
- inert `#-ocmcd97bvcave`;
- `ipc_control_port_options=0`;
- `-amfipassbeta`;
- D97DX Root Patch;
- D97EZ 0.0.12 exact identity;
- D97EW persistent collector;
- normal 3/3/3 framebuffer baseline;
- every other settled EFI/system state.

Do not add `igfxmetal=1`, `-disablegfxfirmware`, `watchdog=0`, or any other new T2/Haswell variable. Do not Root Patch again. Do not alter framebuffer counts.

## Required evidence
The accelerated run must be evaluated through D97EW persisted evidence, not the later recovery VESA IORegistry.

Key D97EZ invariants to prove:
- `D97EZFunctionalRequested=1` / `FunctionalMode=ACTIVE`;
- `Exact224SeenCount + OtherModeSeenCount == D97ELSetIdModeCallCount`;
- `Exact224AdaptedCount == Exact224SeenCount`;
- for captured `originalMode=0x224`, `PassedMode=0x24`;
- Apple return for adapted exact-224 calls;
- non-224 captured calls preserve `PassedMode == originalMode`;
- no evidence of global bit clearing or return coercion.

If image is lost, keep the accelerated system running for at least 30 seconds before hard power so D97ES/D97EZ publication and D97EW disk sync can complete. Then recover VESA by restoring active `-igfxvesa` and making `-ocmcd97ez` absent/inert.

## CURRENT ACTION
Exactly one ACTIVE accelerated D97EZ boot is authorized under the above constraints. After return to VESA, do not inspect current VESA IORegistry as accelerated evidence; inspect the D97EW run corresponding to the immediately preceding accelerated boot by saved boot args.
