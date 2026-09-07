# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative runtime checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97ED_SINGLE_FRAMEBUFFER_VECTOR_ARMED_ACCEL_TEST_AUTHORIZED.md`
Current Root Patch execution checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`
Current build design: `OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch is installed;
- D97DZ root-patched VESA validation PASS;
- first accelerated boot failed through repeated WindowServer SIGSEGV during CoreDisplay display initialization;
- D97EC established native platform baseline 0x0A260006 = 3 pipes / 3 ports / 3 framebuffer memories;
- user has now manually armed the bounded D97ED logical count-vector experiment: 1 pipe / 1 port / 1 framebuffer memory, with con2 overrides removed;
- current running session remains VESA recovery until the one-attempt D97ED accelerated test is launched;
- active EFI compatibility kext remains D97DL `OCLPMetalCompat.kext` 0.0.7, UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- VESA remains the established recovery mode.

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

Therefore the selective-3802 adapter delivery mechanism is CLOSED PASS under VESA.

## D97DX native-Metal-safe Root Patch — PASS
Exact source baseline b9df76; exact tracked delta four files only.
Tahoe policy:
- Common: only legacy `MTLCompilerService.xpc` under native Metal.framework plus private MTLCompiler/GPUCompiler lanes;
- Extended: CoreImage/RenderBox/private compiler compatibility only; NO whole Metal.framework donor;
- exact Pyquick 25G82 metallib map, 182 entries;
- no `MetalOld.dylib`;
- no main legacy `Versions/A/Metal` donor;
- no true-five.

Manual Root Patch execution PASS:
- exact 25G82 MetallibSupportPkg used;
- Metal 3802 Common/Extended/metallibs executed;
- Monterey GVA/OpenCL executed;
- Intel Haswell patchset executed;
- Auxiliary Kernel Collection rebuilt and forced;
- final `Patching complete` reached.

## D97DZ — post-Root-Patch VESA validation PASS
Root-patched VESA boot proved:
- Root Patch metadata present;
- legacy main on-disk `Metal.framework/Versions/A/Metal` ABSENT;
- `MetalOld.dylib` ABSENT;
- legacy `MTLCompilerService` SHA256 exact `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- Lilu 1.7.3, OCLPMetalCompat 0.0.7, WhateverGreen 1.7.1 loaded;
- patched AppleIntelFramebufferAzul and AppleIntelHD5000Graphics loaded;
- D97BV functional mode ACTIVE/requested=1;
- display remained VESA, HD4400 4 MB, 1366x768;
- shared-cache SITE/CAVE topology remained byte-identical and exact native preimages remained present.

D97DZ checkpoint commit: `d99fe62b65e8633611368241c8dabb2cfb273492`.

## D97EB — accelerated failure classified
Evidence ZIP:
- `OCLP7_D97EB_ACCEL_FAIL_20260907_023429.zip`;
- bytes `1633378`;
- SHA256 `c5e141f4e5e8a9de60b09ebde4229814a0846065582b0796cd3a8bf9bd467374`;
- CRC PASS.

Accelerated WindowServer behavior:
- FB1 obtains valid internal 1366x768 mode;
- FB2/FB3 fail mode-info queries and report capabilities with no devices;
- `GPU: FB: 3 of 3 opened`;
- four `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` messages;
- CoreDisplay reports offline display state;
- WindowServer PID 177 exits by SIGSEGV at `02:24:58.799390`;
- launchd respawns WindowServer PID 348 and the sequence repeats.

Critical negatives:
- no kernel panic;
- no `_MTL4*` unresolved-superclass evidence;
- no MTLCompilerService failure before first WindowServer crash;
- D97BK legacy-main-Metal ABI failure was NOT repeated.

D97EB checkpoint commit: `a6e4b75d5e658ab83d710b9d0a847459ba7cc1c7`.

## D97EC — VESA topology limit and 0x0A260006 baseline
VESA topology proved:
- IGPU device-id 0x0412;
- effective VESA platform-id appears ffffffff under `-igfxvesa`;
- only IONDRVFramebuffer/.Display_boot is attached in VESA;
- no live AppleIntelFramebufferAzul nodes are available for accelerated topology inspection;
- project EFI baseline uses AAPL,ig-platform-id `0600260a` = 0x0A260006;
- WhateverGreen's documented Azul table defines 0x0A260006 as mobile, 3 pipes / 3 ports / 3 framebuffer memories, connectors LVDS + DP + DP;
- therefore D97EB's `3 of 3 opened` is consistent with native platform topology, not accidental connector overexposure.

D97EC checkpoint commit: `30017797506a8adcca97e6c77708b10a47f0a72e`.

## D97ED — bounded single-framebuffer count-vector experiment ARMED
User manually confirmed completion of the exact instructed DeviceProperties mutation:
- preserve `AAPL,ig-platform-id = 0600260A`;
- preserve `device-id = 12040000`;
- preserve `framebuffer-patch-enable = 01000000`;
- preserve `framebuffer-cursormem = 00009000`;
- set `framebuffer-pipecount = 01000000`;
- set `framebuffer-portcount = 01000000`;
- set `framebuffer-memorycount = 01000000`;
- remove/disable `framebuffer-con2-enable` and `framebuffer-con2-type`;
- no con0 index/busid/type override.

Purpose: keep native LVDS framebuffer 0 but suppress the two inactive external framebuffer slots from Tahoe CoreDisplay enumeration.

D97ED checkpoint commit: `d138f211766848fb125d13c70e51b147bce18449`.

## CURRENT ACTION — ONE D97ED ACCELERATED DIAGNOSTIC BOOT AUTHORIZED
Make only `-igfxvesa` inactive (prefer `#-igfxvesa` for easy restoration).
Retain active:
- `-ocmcdiag`;
- `-ocmcd97bv`.
Keep `#-ocmcd97bvcave` inactive.
Make no other EFI/Root Patch/system changes.

Then perform exactly one accelerated diagnostic reboot.

If usable GUI appears, stop and report success without further mutation.
If black screen / verbose recurrence / unusable GUI appears, recover by reactivating `-igfxvesa` and return to VESA. Analyze only that immediately preceding D97ED accelerated boot under the permanent recovery rule.

Still forbidden until D97ED is evaluated:
- another Root Patch;
- any additional EFI/framebuffer mutation;
- global 3802 forcing;
- legacy main Metal shadow;
- true-five reapplication;
- CoreDisplay donor/downgrade without ABI audit;
- Golden mutation.
