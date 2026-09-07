# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`

Current authoritative runtime checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EP_D97EL_VESA_ROUTE_PASS_ACCEL_MEASUREMENT_GATE.md`

Current observer build audit checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EN_D97EL_0010_INDEPENDENT_BUILD_AUDIT_PASS.md`

Current Root Patch execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`

Current build design:
`OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`

Current observer build helper:
`OCLP-Continuity/artifacts/OCLP7_D97EL_IMAC_BUILD.sh`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch remains installed;
- active EFI kext is audited D97EL `OCLPMetalCompat.kext` 0.0.10;
- executable SHA256 `7aa86d2484c6f252f7a77704117cebb6e14afa96bf2d98bb2523644fd86926ac`;
- UUID `1A19441E-9937-3FBF-995D-9CC282E89089` x86_64;
- current session is VESA with `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh` active;
- `#-ocmcd97bvcave` inert;
- normal pre-D97ED 3/3/3 framebuffer baseline required;
- D97BV `_cs_validate_page` route PASS, functional mode ACTIVE;
- D97EL exact `IOAccelSurface::set_id_mode(uint32_t,uint32_t)` route PASS in VESA;
- `D97ELSetIdModeCallCount=0` in VESA as expected;
- one accelerated observer measurement boot is now authorized, with no additional causal changes.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo;
- no true-five reapplication;
- no functional masking of set_id_mode before measurement.

## Settled runtime/build facts

### D97BV / D97DT
Selective-3802 runtime delivery is CLOSED PASS under VESA exact 25G82 using D97DL 0.0.7. CAVE/SITE exact runtime delivery, validation safety and cross-process visibility were proven. Do not retest absent contradiction.

D97DL source authority SHA256:
`f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`.

### D97DX Root Patch
Native-Metal-safe Root Patch execution PASS:
- bounded legacy `MTLCompilerService.xpc` only under native Metal.framework;
- private compiler lanes, CoreImage/RenderBox compatibility;
- exact 25G82 metallib handling;
- Monterey GVA/OpenCL;
- Haswell graphics drivers;
- no legacy main Metal shadow;
- no MetalOld;
- no true-five replay.

### D97EB / D97EE accelerated failures
Normal 3/3/3 accelerated boot and later 1/1/1 experiment both reached the same core failure class:
- `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits`;
- display forced/offlined;
- WindowServer SIGSEGV;
- no kernel panic;
- no `_MTL4*` superclass regression.

1/1/1 applied successfully but did not solve the failure. Framebuffer-count tuning is CLOSED NEGATIVE.

### D97EG exact symbol
ASUS2 read-only audit proves AppleIntelHD5000Graphics dynamically imports:
`__ZN14IOAccelSurface11set_id_modeEjj`
= `IOAccelSurface::set_id_mode(uint32_t id, uint32_t mode)`.

IOAcceleratorFamily2 identity:
- bundle id `com.apple.iokit.IOAcceleratorFamily2`;
- version `487.4.3`.

### D97EH 0.0.9 observer
D97EH independent audit PASS:
- exact symbol observer;
- original `that/id/mode` passed unchanged;
- original IOReturn returned unchanged;
- first 32 calls logged with candidate masks only after original return;
- no mode mutation, no return coercion, no framebuffer mutation.

D97EH source SHA256:
`2d93b4bc09cd4259e027808547ea003820139f2c2d48b7591c8ea5ccfe038a2d`.

### D97EL 0.0.10
Independent build audit PASS:
- artifact `OCLP7_D97EL_IMAC_BUILD_20260907_123115.zip`;
- ZIP SHA256 `b0d8c265a239f8051a4b505a4ce5649f874c95e8e26671bd586b62dd11705181`;
- generated source SHA256 `3a103b84ae8c18c7259c672dff9dd5c0f11d04d88554c8da8e60c5c0c04b9003`;
- version `0.0.10`, x86_64;
- UUID `1A19441E-9937-3FBF-995D-9CC282E89089`;
- executable SHA256 `7aa86d2484c6f252f7a77704117cebb6e14afa96bf2d98bb2523644fd86926ac`;
- exact D97EH observer semantics preserved;
- registration behavior preserved;
- telemetry only added.

## D97EP — decisive VESA observer-route PASS
D97EL IORegistry after VESA reboot:
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

Interpretation:
- observer bootarg recognized;
- global Lilu kext callback path works;
- exact IOAcceleratorFamily2 callback matched;
- exact set_id_mode symbol route installed successfully;
- no set_id_mode call in VESA, preserving clean accelerated measurement frontier;
- D97BV remains healthy.

D97EP checkpoint commit:
`9790e6d320ecba9b1642a648142c41bac56dfa7d`.

## OCLP T2 / Haswell audit integration policy at this gate
Do not add new EFI/boot-arg variables before the first D97EL accelerated measurement.
Existing `ipc_control_port_options=0` and `-amfipassbeta` may remain.
Do NOT add `igfxmetal=1`, `-disablegfxfirmware`, `watchdog=0`, or other new variables until after the exact set_id_mode measurement; such tests must be later isolated A/B experiments.

## Current causal frontier
`Tahoe/CoreDisplay producer semantics -> IOAccelSurface::set_id_mode(id, mode) -> legacy Haswell IOAccelerator acceptance`.

Need exact accelerated runtime:
- `id`;
- `mode`;
- `mode & 0xFF8073C0`;
- `mode & 0x007F8C3F`;
- original IOReturn.

No functional correction is authorized before measurement.

## CURRENT ACTION — ONE ACCELERATED D97EL MEASUREMENT BOOT AUTHORIZED
Only change for next diagnostic boot:
- disable/remove/comment `-igfxvesa`.

Keep unchanged:
- `-ocmcdiag`;
- `-ocmcd97bv`;
- `-ocmcd97eh`;
- current Root Patch state;
- current D97EL 0.0.10 kext;
- normal pre-D97ED 3/3/3 framebuffer baseline;
- all other settled EFI state.

Do NOT:
- add `igfxmetal=1` yet;
- add `-disablegfxfirmware` or `watchdog=0`;
- clear or mask any set_id_mode bits;
- coerce return values;
- Root Patch again;
- retune framebuffer counts;
- shadow native Tahoe Metal;
- replay true-five;
- mutate Golden.

Expected observer log, up to first 32 calls:
`D97EH_SET_ID_MODE call=<n> id=0x... mode=0x... badBits=0x... goodBits=0x... ret=0x...`

If image is lost and VESA recovery is required, analyze the immediately preceding accelerated diagnostic boot under the permanent VESA recovery rule. Never mix later VESA recovery logs into the accelerated evidence.
