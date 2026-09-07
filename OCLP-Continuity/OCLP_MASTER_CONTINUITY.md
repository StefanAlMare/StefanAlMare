# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative runtime checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EF_1FB_NEGATIVE_SET_ID_MODE_FRONTIER.md`
Current Root Patch execution checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`
Current build design: `OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS MacBookAir6,2;
- D97DX native-Metal-safe Root Patch remains installed;
- current session is VESA recovery boot at `2026-09-07 10:07 EEST`;
- active EFI compatibility kext remains D97DL `OCLPMetalCompat.kext` 0.0.7, UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- active recovery args retain `-igfxvesa -ocmcdiag -ocmcd97bv`; `#-ocmcd97bvcave` is inert;
- D97ED 1/1/1 accelerated experiment failed and D97EE analysis has closed framebuffer-count tuning as a solution.

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

D97EE evidence proves this took effect in the accelerated boot proper (~03:07:54 onward):
- `Creating FB 1 of 1`;
- `Created FB 1 of 1`;
- `GPU: FB: 1 of 1 opened`.

Yet the critical failure class persisted:
- four `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` events;
- main display forced offline;
- WindowServer SIGSEGV;
- respawned WindowServer repeats the pattern.

Second WindowServer also shows mode 0/depth 0 and failure of IOFBGetDisplayModeInformation for the sole framebuffer, so 1/1/1 is not a viable solution and may distort normal internal-FB mode semantics.

Classifications:
- `D97EE_1FB_APPLIED=YES`;
- `D97EE_EXTERNAL_FB2_FB3_NECESSARY_FOR_CORE_CRASH=NO`;
- `D97EE_IOACCEL_SURFACE_BAD_BITS=PERSISTS`;
- `D97EE_WINDOWSERVER_SIGSEGV=PERSISTS`;
- `D97EE_SINGLE_FB_VECTOR_SOLUTION=NEGATIVE`;
- `D97EE_FRAMEBUFFER_COUNT_TUNING_FRONTIER=CLOSED_NEGATIVE`.

D97EF checkpoint commit: `6547ddfa10fa02664116567a252b4044342c453b`.

## Current causal frontier
The active frontier is now specifically:
`Tahoe/CoreDisplay producer semantics -> IOAccelSurface::set_id_mode(id, mode) -> legacy Haswell IOAccelerator acceptance`.

Need to determine the exact `mode` value(s), rejected bit(s), and original IOReturn before applying any functional correction.

External orientation only: NootedGreen has a related `set_id_mode` diagnostic/fix and classifies candidate mode bits using masks `0xff8073c0` and `0x007f8c3f`, but its TGL/RPL context differs from Haswell. Its functional masking is NOT authorized for transplant. Tahoe ASUS2 logs name `IOAccelSurface::set_id_mode`, while NootedGreen routes `IOAccelLegacySurface::set_id_mode`; exact 25G82 target symbol resolution is mandatory.

## CURRENT ACTION
Remain VESA. No accelerated boot yet.

First restore pre-D97ED IGPU baseline manually:
- remove `framebuffer-pipecount`;
- remove `framebuffer-portcount`;
- remove `framebuffer-memorycount`;
- restore `framebuffer-con2-enable = 01000000`;
- restore `framebuffer-con2-type = 00080000`;
- retain 0x0A260006/device-id/framebuffer-patch-enable/framebuffer-cursormem.

Then perform read-only exact symbol audit of Tahoe 25G82 `IOAcceleratorFamily2` for `set_id_mode`.

After symbol resolution:
- derive a new diagnostic-only OCLPMetalCompat revision from exact D97DL source;
- gated by a new explicit boot arg;
- original `id` and `mode` passed unchanged;
- bounded logs of id, mode, candidate badBits/goodBits and original return;
- no mode mutation or return coercion;
- build locally on authorized Intel iMac 9900K;
- static/binary audit;
- first deployment boot remains VESA;
- accelerated diagnostic boot requires separate authorization after route/load PASS.

Still forbidden:
- clearing `0xff8073c0` or any mode bits before measurement;
- another unchanged accelerated boot;
- retaining 1/1/1 as production configuration;
- another Root Patch;
- CoreDisplay donor/downgrade without independent ABI audit;
- legacy main Metal shadow;
- global forced-3802;
- true-five reapplication;
- Golden mutation.
