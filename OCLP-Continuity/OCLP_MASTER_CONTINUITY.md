# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`

Current authoritative runtime checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EK_D97EH_VESA_LOAD_PASS_ROUTE_UNPROVEN.md`

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
- current session remains VESA from the D97EH 0.0.9 deployment boot;
- active EFI kext is still D97EH `OCLPMetalCompat.kext` 0.0.9 until D97EL deployment is performed;
- active D97EH executable SHA256 `23bbc4a30a0c445a20a2821530a427256662e4e4832eaa6c82b1219540460fcf`;
- active D97EH UUID `E3BE3246-7F7A-36B8-822D-7D1AEB35D721`;
- active recovery args: `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`;
- `#-ocmcd97bvcave` inert;
- normal pre-D97ED 3/3/3 framebuffer baseline required;
- D97BV `_cs_validate_page` route remains PASS and functional mode ACTIVE;
- `IOAcceleratorFamily2` 487.4.3 loads even in VESA together with AppleIntelFramebufferAzul 18.0.8 and AppleIntelHD5000Graphics 18.0.8;
- D97EH set_id_mode route remains UNPROVEN because unified log produced neither PASS nor NEGATIVE nor callback evidence;
- accelerated boot is NOT authorized yet.

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

D97EH VESA deployment boot proved kext/load safety and D97BV health, but observer route status remained UNPROVEN because the unified log had no D97EH route marker despite IOAcceleratorFamily2 loading.

## D97EL 0.0.10 — independent build audit PASS
Purpose: preserve D97EH observer semantics and registration behavior exactly while adding IORegistry telemetry around registration/callback/route state.

User-returned build artifact:
- `OCLP7_D97EL_IMAC_BUILD_20260907_123115.zip`;
- bytes `61617`;
- ZIP SHA256 `b0d8c265a239f8051a4b505a4ce5649f874c95e8e26671bd586b62dd11705181`;
- ZIP CRC PASS.

Generated source:
- bytes `26688`;
- SHA256 `3a103b84ae8c18c7259c672dff9dd5c0f11d04d88554c8da8e60c5c0c04b9003`.

D97EL kext executable:
- version `0.0.10`;
- arch `x86_64`;
- UUID `1A19441E-9937-3FBF-995D-9CC282E89089`;
- executable SHA256 `7aa86d2484c6f252f7a77704117cebb6e14afa96bf2d98bb2523644fd86926ac`;
- Info.plist SHA256 `f6e31e96d1bc83e8dcb0bfa1ee1657bb04201e15a9c7ab33a0419ed397131d70`.

Manifest: every listed payload hash validates exactly; previous self-hash tooling bug is absent.

D97EL telemetry properties:
- `D97ELObserverRequested`;
- `D97ELCallbackSeenCount`;
- `D97ELTargetCallbackSeenCount`;
- `D97ELLastCallbackIndex`;
- `D97ELKextLoadIndex`;
- `D97ELRouteStatus`;
- `D97ELSetIdModeCallCount`.

Independent source delta versus D97EH is telemetry only. Registration anchor remains exactly:
`lilu.onKextLoadForce(&kextIOAcceleratorFamily2);`.

Independent binary disassembly proves:
- generic callback counter/index/loadIndex telemetry occurs before target match;
- target callback counter increments only on exact loadIndex match;
- exact set_id_mode route is attempted with routeMultipleLong;
- route state stores PASS=1 or NEGATIVE=2;
- `patchedSetIdMode` still restores saved `that/id/mode` into `rdi/esi/edx` before Apple original call;
- candidate masks execute only after original return;
- original return value is returned unchanged.

Independent lineage proof:
- reverse D97EL telemetry substitutions -> exact D97EH SHA256 `2d93b4bc09cd4259e027808547ea003820139f2c2d48b7591c8ea5ccfe038a2d`;
- reverse D97EH observer substitutions -> exact D97DL SHA256 `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`.

Classification:
- `D97EN_BUILD_AUDIT=PASS`;
- `D97EN_VESA_DEPLOYMENT_AUTHORIZED=YES`;
- `D97EN_ACCELERATED_BOOT_AUTHORIZED=NO`.

D97EN checkpoint commit:
`f68ee3ec504527f8ee05ac9c7633a7071c824256`.

## Current causal frontier
`Tahoe/CoreDisplay producer semantics -> IOAccelSurface::set_id_mode(id, mode) -> legacy Haswell IOAccelerator acceptance`.

Need exact runtime:
- observer registration state;
- callback state;
- route PASS/NEGATIVE;
then, only after route PASS, accelerated `id`, `mode`, candidate rejected bits, and original IOReturn.

External NootedGreen masks remain orientation only. Clearing any mode bits is NOT authorized until ASUS2 measurement.

## CURRENT ACTION — D97EL VESA-FIRST DEPLOYMENT AUTHORIZED
On ASUS2, while currently in VESA:
1. keep backup of active D97EH 0.0.9;
2. replace only active EFI `EFI/OC/Kexts/OCLPMetalCompat.kext` with audited D97EL 0.0.10;
3. do not change `Kernel -> Add -> BundlePath`;
4. keep boot args exactly `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh` with `#-ocmcd97bvcave` inert;
5. do not Root Patch;
6. do not reboot until active EFI identity is verified.

Required pre-reboot EFI identity:
- version `0.0.10`;
- executable SHA256 `7aa86d2484c6f252f7a77704117cebb6e14afa96bf2d98bb2523644fd86926ac`;
- UUID `1A19441E-9937-3FBF-995D-9CC282E89089`.

After identity PASS, exactly one VESA reboot may be authorized.
After VESA returns, inspect D97EL IORegistry telemetry. Accelerated boot remains forbidden until `D97ELRouteStatus=PASS` is explicitly proven.

Still forbidden:
- accelerated boot now;
- clearing `0xff8073c0` or any mode bits;
- return coercion;
- retaining 1/1/1 as production configuration;
- another Root Patch;
- CoreDisplay donor/downgrade without independent ABI audit;
- legacy main Metal shadow;
- global forced-3802;
- true-five reapplication;
- Golden mutation.
