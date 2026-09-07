# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative runtime checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EI_D97EH_BUILD_INDEPENDENT_AUDIT_PASS.md`
Current Root Patch execution checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`
Current build design: `OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch remains installed;
- current session is VESA recovery;
- active EFI compatibility kext is still D97DL `OCLPMetalCompat.kext` 0.0.7 until D97EH deployment is performed;
- VESA recovery args retain `-igfxvesa -ocmcdiag -ocmcd97bv`; `#-ocmcd97bvcave` inert;
- D97ED/D97EE closed framebuffer-count tuning as a solution;
- D97EG resolved exact failing interface symbol to `IOAccelSurface::set_id_mode(uint32_t,uint32_t)`;
- D97EH 0.0.9 observer-only build has passed independent source/binary audit and is authorized only for VESA-first deployment, not accelerated execution yet.

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
D97ED temporarily forced:
- `framebuffer-pipecount = 1`;
- `framebuffer-portcount = 1`;
- `framebuffer-memorycount = 1`;
- con2 override removed.

D97EE proves the experiment took effect:
- `Creating FB 1 of 1`;
- `Created FB 1 of 1`;
- `GPU: FB: 1 of 1 opened`.

Yet the core failure persisted:
- four `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits`;
- main display forced offline;
- WindowServer SIGSEGV;
- respawned WindowServer repeats the pattern.

Classifications:
- `D97EE_1FB_APPLIED=YES`;
- `D97EE_EXTERNAL_FB2_FB3_NECESSARY_FOR_CORE_CRASH=NO`;
- `D97EE_IOACCEL_SURFACE_BAD_BITS=PERSISTS`;
- `D97EE_WINDOWSERVER_SIGSEGV=PERSISTS`;
- `D97EE_SINGLE_FB_VECTOR_SOLUTION=NEGATIVE`;
- `D97EE_FRAMEBUFFER_COUNT_TUNING_FRONTIER=CLOSED_NEGATIVE`.

## D97EG — exact set_id_mode symbol resolved
ASUS2 read-only audit proved:
- `/System/Library/Extensions/IOAcceleratorFamily2.kext` exists;
- standalone executable is absent in this VESA filesystem view / implementation is KC-backed;
- `AppleIntelHD5000Graphics.kext` contains dynamically looked-up import `__ZN14IOAccelSurface11set_id_modeEjj`.

Therefore exact failing interface imported by legacy Haswell driver is:
`IOAccelSurface::set_id_mode(uint32_t id, uint32_t mode)`.

IOAcceleratorFamily2 bundle identity on ASUS2:
- bundle id `com.apple.iokit.IOAcceleratorFamily2`;
- version `487.4.3`;
- not shown loaded during VESA, as expected.

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

Independent lineage proof:
- reverse exactly the three D97EH generator replacements from packaged source;
- reconstructed base SHA256 is exact D97DL authority `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`;
- therefore D97BV is preserved exactly outside the observer additions.

Observer semantics:
- gate `-ocmcd97eh`;
- target exact symbol `__ZN14IOAccelSurface11set_id_modeEjj` in `com.apple.iokit.IOAcceleratorFamily2`;
- passes original `that`, `id`, `mode` unchanged to Apple;
- logs only first 32 calls;
- reports `id`, `mode`, `badBits = mode & 0xFF8073C0`, `goodBits = mode & 0x007F8C3F`, original return;
- returns original IOReturn unchanged;
- no bit stripping, no return coercion, no framebuffer mutation.

Independent x86_64 disassembly confirms original saved `that/id/mode` are restored into `rdi/esi/edx` before indirect original call; mask operations occur only after return for logging; final return reloads original return value.

Packaging note:
- all payload hashes in `SHA256SUMS.txt` validate except its own self-entry;
- self-hash is a manifest-generation tooling bug, not a payload integrity failure;
- ZIP/source/executable/Info.plist and all non-self manifest entries validate exactly.

D97EI checkpoint commit: `e3ac6110ea39285c6b4891de55bfb4ed6a69973a`.

## Current causal frontier
`Tahoe/CoreDisplay producer semantics -> IOAccelSurface::set_id_mode(id, mode) -> legacy Haswell IOAccelerator acceptance`.

Need exact accelerated runtime `id`, `mode`, candidate rejected bits, and original IOReturn before any functional correction.

External NootedGreen masks remain orientation only. Clearing any mode bits is NOT authorized until ASUS2 measurement.

## CURRENT ACTION — D97EH VESA-FIRST DEPLOYMENT AUTHORIZED
Remain on normal pre-D97ED 3/3/3 IGPU baseline:
- remove `framebuffer-pipecount`, `framebuffer-portcount`, `framebuffer-memorycount` if still present;
- restore `framebuffer-con2-enable = 01000000` and `framebuffer-con2-type = 00080000`;
- retain 0x0A260006/device-id/framebuffer-patch-enable/framebuffer-cursormem.

Deploy audited D97EH `OCLPMetalCompat.kext` 0.0.9 to the exact active EFI BundlePath used by OpenCore, replacing D97DL only after keeping a backup.
Enable `-ocmcd97eh` but KEEP `-igfxvesa -ocmcdiag -ocmcd97bv` active for the first deployment boot.
Do not Root Patch.
Do not perform accelerated boot yet.

VESA deployment gate must verify:
- OCLPMetalCompat 0.0.9 loaded, exact UUID/hash if obtainable;
- D97BV functional mode/state remains healthy;
- no new kext/load regression;
- IOAcceleratorFamily2 observer route may remain dormant in VESA because accelerator is not loaded.

Only after that VESA gate may one accelerated observer boot be separately authorized.

Still forbidden:
- clearing `0xff8073c0` or any mode bits;
- another unchanged accelerated boot;
- retaining 1/1/1 as production configuration;
- another Root Patch;
- CoreDisplay donor/downgrade without independent ABI audit;
- legacy main Metal shadow;
- global forced-3802;
- true-five reapplication;
- Golden mutation.
