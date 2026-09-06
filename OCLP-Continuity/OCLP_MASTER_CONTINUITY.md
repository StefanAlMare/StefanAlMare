# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative runtime checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EA_ACCELERATED_BOOT_FAIL_CHRONOLOGY_FIXED.md`
Current Root Patch execution checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`
Current build design: `OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`
Current accelerated-failure collector: `OCLP-Continuity/artifacts/OCLP7_D97EB_ACCELERATED_BOOT_EVIDENCE_COLLECTOR.sh`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch is installed;
- first root-patched VESA validation completed PASS;
- first accelerated boot attempt failed at GUI transition and user recovered into established VESA mode;
- current running session is VESA recovery boot at `2026-09-07 02:25 EEST`;
- active EFI compatibility kext remains D97DL `OCLPMetalCompat.kext` 0.0.7, UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- current recovery policy must remain unchanged while evidence is collected.

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

## D97EA — first accelerated boot failed; chronology fixed
User observation:
- accelerated/root-patched boot progressed through verbose to the black-screen GUI transition point where the progress bar would normally appear;
- verbose text then reappeared;
- user powered off with the physical button and recovered via VESA.

Exact `last reboot` chronology:
- `02:23` accelerated diagnostic boot;
- same-minute `shutdown time 02:23` lifecycle event;
- `02:25` current VESA recovery boot.

Authoritative accelerated evidence window:
`2026-09-07 02:22:30` through `2026-09-07 02:24:59 EEST`.

The current VESA session is excluded from failure analysis. Same-minute shutdown evidence makes an orderly userspace shutdown/restart plausible; kernel panic/compiler failure/userspace failure remain unclassified until logs are audited.

D97EA chronology checkpoint commit: `7a27384f3855d780b02bbf3519934b98f8c92e88`.

## CURRENT ACTION — D97EB READ-ONLY FAILURE EVIDENCE COLLECTION
Do NOT repeat accelerated boot.
Do NOT alter current VESA recovery policy.
Do NOT Root Patch again.

Run only the exact D97EB collector on ASUS2 while in current VESA recovery. It collects:
- exact accelerated-window unified lifecycle logs;
- exact accelerated-window Metal/GPU/kernel evidence;
- pmset chronology;
- relevant WindowServer/MTLCompilerService/GPU/panic/watchdog crash reports;
- current D97 runtime and Root Patch metadata for orientation;
- packaged ZIP + manifest.

Collector source Git blob: `8ffebb8cc42f31b3704b43bd6de440a4f3b84c57`.
Collector GitHub commit: `128db71e1f992e0b037ae22b27a2f602a11d882c`.

Return the D97EB ZIP for analysis. No EFI/root/snapshot mutations and no reboot are part of collection.

Still forbidden until D97EB analysis:
- another accelerated boot;
- any EFI change;
- global 3802 forcing;
- legacy main Metal shadow;
- true-five reapplication;
- Golden mutation.
