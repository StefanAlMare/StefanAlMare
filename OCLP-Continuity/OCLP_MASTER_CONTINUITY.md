# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative runtime checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EK_D97EH_VESA_LOAD_PASS_ROUTE_UNPROVEN.md`
Current Root Patch execution checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`
Current build design: `OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`
Current observer build helper: `OCLP-Continuity/artifacts/OCLP7_D97EL_IMAC_BUILD.sh`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch remains installed;
- current session is VESA boot from 2026-09-07 11:52 EEST;
- active EFI compatibility kext is audited D97EH `OCLPMetalCompat.kext` 0.0.9;
- active executable identity: SHA256 `23bbc4a30a0c445a20a2821530a427256662e4e4832eaa6c82b1219540460fcf`, UUID `E3BE3246-7F7A-36B8-822D-7D1AEB35D721` x86_64;
- active recovery args: `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`; `#-ocmcd97bvcave` inert;
- D97BV `_cs_validate_page` route remains PASS and functional mode ACTIVE;
- `IOAcceleratorFamily2` 487.4.3 DOES load in this VESA boot, together with AppleIntelFramebufferAzul 18.0.8 and AppleIntelHD5000Graphics 18.0.8;
- D97EH set_id_mode route is not proven: no PASS/NEGATIVE route marker, no set_id_mode observations, no UUID mismatch evidence;
- accelerated boot is NOT authorized.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo;
- no true-five reapplication.

## D97BV / D97DT runtime closure
D97DT remains FULL VESA PAIR PASS on exact Tahoe 25G82:
- exact D97DL 0.0.7 loaded;
- functional mode ACTIVE;
- route/build 25G82 PASS;
- CAVE and SITE exact D97BV runtime delivery proven with write count 1 each and Apple validation safe;
- D97DR separately proved cross-process CAVE visibility.

Selective-3802 adapter delivery is CLOSED PASS under VESA.

## D97DX native-Metal-safe Root Patch — PASS
Exact source baseline b9df76; exact tracked delta four files only.
Tahoe policy:
- bounded legacy `MTLCompilerService.xpc` under native Metal.framework plus private compiler lanes;
- CoreImage/RenderBox/private compiler compatibility only; NO whole legacy Metal.framework donor;
- exact 25G82 metallib map, 182 entries;
- no MetalOld;
- no true-five.

Manual Root Patch execution PASS:
- exact 25G82 MetallibSupportPkg;
- Metal 3802 Common/Extended/metallibs;
- Monterey GVA/OpenCL;
- Intel Haswell patchset;
- Auxiliary Kernel Collection rebuilt;
- final `Patching complete`.

## D97DZ VESA post-patch validation — PASS
Proved:
- Root Patch metadata present;
- legacy main on-disk Metal absent;
- MetalOld absent;
- legacy MTLCompilerService exact SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- Lilu 1.7.3, OCLPMetalCompat 0.0.7, WhateverGreen 1.7.1 loaded;
- patched Haswell graphics kexts loaded;
- D97BV ACTIVE;
- shared-cache SITE/CAVE integrity retained.

## D97EB normal 3/3/3 accelerated failure
Accelerated WindowServer reached CoreDisplay/Haswell IOAccelerator:
- internal FB obtained 1366x768;
- external FB2/FB3 had mode-info/no-device errors;
- `GPU: FB: 3 of 3 opened`;
- four `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits`;
- main/offline display condition;
- WindowServer SIGSEGV; respawn repeated.

Critical negatives:
- no kernel panic;
- no `_MTL4*` unresolved-superclass regression;
- no MTLCompilerService failure before first WS crash.

## D97EC topology baseline
Project EFI baseline uses:
- `AAPL,ig-platform-id = 0600260A` = 0x0A260006;
- device-id 0x0412;
- native WEG Azul topology 3 pipes / 3 ports / 3 framebuffer memories, LVDS + DP + DP;
- con2 overridden to HDMI in project baseline.

Thus 3-framebuffer enumeration was native platform topology, not accidental overexposure.

## D97ED / D97EE 1/1/1 experiment — CLOSED NEGATIVE
D97EE proved 1/1/1 took effect (`GPU: FB: 1 of 1 opened`) yet four `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` events and WindowServer SIGSEGV persisted.

Classifications:
- `D97EE_1FB_APPLIED=YES`;
- `D97EE_EXTERNAL_FB2_FB3_NECESSARY_FOR_CORE_CRASH=NO`;
- `D97EE_IOACCEL_SURFACE_BAD_BITS=PERSISTS`;
- `D97EE_WINDOWSERVER_SIGSEGV=PERSISTS`;
- `D97EE_SINGLE_FB_VECTOR_SOLUTION=NEGATIVE`;
- `D97EE_FRAMEBUFFER_COUNT_TUNING_FRONTIER=CLOSED_NEGATIVE`.

## D97EG — exact set_id_mode symbol resolved
ASUS2 read-only audit proved `AppleIntelHD5000Graphics.kext` dynamically imports:
`__ZN14IOAccelSurface11set_id_modeEjj`.

Therefore exact failing interface imported by legacy Haswell driver is:
`IOAccelSurface::set_id_mode(uint32_t id, uint32_t mode)`.

IOAcceleratorFamily2 identity:
- bundle id `com.apple.iokit.IOAcceleratorFamily2`;
- version `487.4.3`.

Earlier VESA observation that it was not loaded is superseded by D97EK, which proves it does load in the 11:52 VESA session.

## D97EH / D97EI — observer build and independent audit PASS
D97EH is OCLPMetalCompat 0.0.9, observer-only, built locally on authorized Intel iMac.

Artifact:
- ZIP `OCLP7_D97EH_IMAC_BUILD_20260907_113417.zip`;
- bytes `59310`;
- ZIP SHA256 `f04d5392861381982c47705f7a987cb2d2b904981719a896e44fcb1ff00c8f29`;
- CRC PASS.

Generated source:
- SHA256 `2d93b4bc09cd4259e027808547ea003820139f2c2d48b7591c8ea5ccfe038a2d`;
- bytes `24097`.

Kext executable:
- version `0.0.9`;
- arch `x86_64`;
- UUID `E3BE3246-7F7A-36B8-822D-7D1AEB35D721`;
- executable SHA256 `23bbc4a30a0c445a20a2821530a427256662e4e4832eaa6c82b1219540460fcf`.

Independent lineage proof reconstructs exact D97DL SHA256 `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2` after reversing observer additions.

Observer semantics:
- gate `-ocmcd97eh`;
- target exact symbol `__ZN14IOAccelSurface11set_id_modeEjj`;
- passes original `that`, `id`, `mode` unchanged to Apple;
- logs first 32 calls only;
- reports `id`, `mode`, `badBits = mode & 0xFF8073C0`, `goodBits = mode & 0x007F8C3F`, original return;
- returns original IOReturn unchanged;
- no bit stripping, return coercion, or framebuffer mutation.

## D97EJ — active EFI identity PASS
User manually deployed D97EH to active EFI and verified exact version/SHA/UUID before reboot.

D97EJ checkpoint commit: `4f6964a38cb197775b9b8a65176c2e5686fe0c3e`.

## D97EK — first D97EH VESA boot: load PASS, route UNPROVEN
VESA boot at 11:52 proves:
- OCLPMetalCompat 0.0.9 loaded exact;
- Lilu 1.7.3 and WhateverGreen 1.7.1 loaded;
- IOAcceleratorFamily2 487.4.3 loaded;
- AppleIntelFramebufferAzul / AppleIntelHD5000Graphics loaded;
- D97BV build/kernel/cpu/bootarg gates PASS and `_cs_validate_page` route PASS;
- D97BV functional mode ACTIVE.

Unified log proves kernelmanagerd receives IOAcceleratorFamily2 load notification at `11:53:00.646238`, but contains:
- no `D97EH_ROUTE PASS`;
- no `D97EH_ROUTE NEGATIVE`;
- no `D97EH_SET_ID_MODE`;
- no `uuid mismatch`;
- no explicit MachInfo/symbol failure tied to the observer.

Lilu 1.7.3 implementation audit shows:
- KextInfo + callback registration is processed during patcher setup;
- already-loaded kexts can be processed on Big Sur+ when `Loaded` is set;
- bundle id + current-binary UUID are checked before callback;
- KC mode may initialize MachInfo from memory, so missing standalone executable does NOT alone prove KextInfo failure.

Classification:
- `D97EK_D97EH_KEXT_LOAD=PASS`;
- `D97EK_IOACCELERATORFAMILY2_VESA_LOAD=YES`;
- `D97EK_D97EH_ROUTE_STATUS=UNPROVEN`;
- `D97EK_ACCELERATED_BOOT_AUTHORIZED=NO`.

D97EK checkpoint commit: `8af4659248832e2f5468dbacc8b88362d46a2a10`.

## D97EL — telemetry-only successor ARMED FOR BUILD
D97EL is designed as OCLPMetalCompat 0.0.10 and preserves D97EH observer semantics and registration behavior exactly. It adds only IORegistry telemetry:
- `D97ELObserverRequested`;
- `D97ELCallbackSeenCount`;
- `D97ELTargetCallbackSeenCount`;
- `D97ELLastCallbackIndex`;
- `D97ELKextLoadIndex`;
- `D97ELRouteStatus`;
- `D97ELSetIdModeCallCount`.

No mode mutation, no return coercion, no registration behavior change.

Authority:
- telemetry generator commit `1fb87c18169a9bd1b74c2b3ff67badc77449c1d4`;
- generator blob `16fdcd6de0de7681a2abdf4c30716fb81a0d0f3e`;
- generator SHA256 `b0d48e176e2b1e9b2bafa902007b80800963108c13d2d76f51fd578baa992637`;
- expected generated D97EL source SHA256 `3a103b84ae8c18c7259c672dff9dd5c0f11d04d88554c8da8e60c5c0c04b9003`;
- Intel iMac build helper commit `cf694429557eadaedcf59a7cedce3ff24f3fca27`.

## Current causal frontier
`Tahoe/CoreDisplay producer semantics -> IOAccelSurface::set_id_mode(id, mode) -> legacy Haswell IOAccelerator acceptance`.

Need exact accelerated runtime `id`, `mode`, candidate rejected bits, and original IOReturn before any functional correction.

External NootedGreen masks remain orientation only. Clearing any mode bits is NOT authorized until ASUS2 measurement.

## CURRENT ACTION — BUILD D97EL ON INTEL IMAC ONLY
Run the authoritative `OCLP7_D97EL_IMAC_BUILD.sh` on the authorized Intel iMac 9900K.

Build only. No target mutation, no EFI, no Root Patch, no reboot.
Return the resulting ZIP for independent audit.

Only after build audit may D97EL be deployed to ASUS2 for another VESA-first gate.

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
