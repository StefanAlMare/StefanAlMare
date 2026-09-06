# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative runtime checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EB_WINDOWSERVER_SIGSEGV_COREDISPLAY_HASWELL_FRAMEBUFFER_FRONTIER.md`
Current Root Patch execution checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`
Current build design: `OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch is installed;
- root-patched VESA validation D97DZ PASS;
- first accelerated boot failed in WindowServer/CoreDisplay framebuffer initialization and user recovered into established VESA mode;
- current running session remains VESA recovery;
- active EFI compatibility kext remains D97DL `OCLPMetalCompat.kext` 0.0.7, UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- current VESA recovery policy must remain unchanged until the framebuffer topology audit closes.

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
- `OCLP7_D97EB_ACCEL_FAIL_20260907_023429.zip`
- bytes `1633378`
- SHA256 `c5e141f4e5e8a9de60b09ebde4229814a0846065582b0796cd3a8bf9bd467374`
- CRC PASS.

Chronology correction:
- prior VESA session initiated a normal software shutdown at `02:23:21.748201` via `shutdown <- sessionlogoutd`;
- accelerated boot begins around `02:23:58`;
- `Previous shutdown cause: 5` at `02:24:00.432575` belongs to the prior voluntary shutdown and is NOT accelerated-failure evidence.

Accelerated WindowServer PID 177:
- spawned `02:24:16.4165`, running/INIT `02:24:18.6208`;
- CoreDisplay starts display initialization around `02:24:56`;
- reports offline main-display conditions;
- creates FB1 of 3 and obtains internal 1366x768 mode;
- FB2 and FB3 fail `IOFBGetDisplayModeInformation()` and capability queries report no devices;
- reports `GPU: FB: 3 of 3 opened`;
- kernel legacy Haswell framebuffer/IOAccelerator path remains active;
- four `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` messages appear at `02:24:58.777–.778`;
- CoreDisplay then reports another offline display;
- WindowServer PID 177 becomes a corpse and exits by SIGSEGV at `02:24:58.799390`;
- launchd immediately respawns WindowServer PID 348, which begins the same failure sequence before user poweroff.

Critical negatives:
- no kernel panic;
- no `_MTL4*` unresolved-superclass evidence;
- no MTLCompilerService failure before first WindowServer crash;
- no useful compiler-path runtime evidence before WindowServer death.

Therefore D97BK's legacy-main-Metal ABI failure is closed and was NOT repeated.

Current frontier:
`Tahoe WindowServer/CoreDisplay <-> legacy Haswell framebuffer/IOAccelerator display semantics`

Classifications:
- `D97EB_KERNEL_PANIC=NO`;
- `D97EB_WINDOWSERVER_REACHED=YES`;
- `D97EB_WINDOWSERVER_FIRST_CRASH=SIGSEGV`;
- `D97EB_WINDOWSERVER_SIGSEGV_TIME=2026-09-07 02:24:58.799390+0300`;
- `D97EB_COREDISPLAY_OFFLINE_FB_ERRORS=PROVEN`;
- `D97EB_IOFB_MODE_INFO_FAILURE_FB2_FB3=PROVEN`;
- `D97EB_IOACCEL_SURFACE_BAD_BITS=PROVEN`;
- `D97EB_MTL4_UNRESOLVED=ABSENT`;
- `D97EB_MTLCOMPILERSERVICE_PRECRASH=NOT_REACHED_OR_NO_EVIDENCE`;
- `D97EB_NEW_FRONTIER=TAHOE_COREDISPLAY_LEGACY_HASWELL_FRAMEBUFFER_IOACCEL_COMPATIBILITY`.

D97EB checkpoint commit: `a6e4b75d5e658ab83d710b9d0a847459ba7cc1c7`.

## Upstream orientation
Official Dortania Tahoe tracking identifies Metal 3802 (Ivy Bridge/Haswell/Kepler) as an active Tahoe graphics-support workstream with initial promising results. No public Metal3802-specific Tahoe CoreDisplay shim was identified. Non-Metal CoreDisplay downgrade logic exists but must not be transplanted into the native-Metal path without an ABI audit.

## CURRENT ACTION — READ-ONLY FRAMEBUFFER TOPOLOGY AUDIT
Remain in VESA recovery.
Do NOT repeat accelerated boot.
Do NOT alter Root Patch or EFI yet.

Collect current ASUS2 topology only:
- effective `AAPL,ig-platform-id` and device-id;
- IGPU registry properties;
- AppleIntelFramebuffer@0/@1/@2 nodes;
- online/offline/attached-display relationship;
- connector type / pipe / port-count / memory properties where exposed;
- system display state.

Decision after topology audit:
A. if FB2/FB3 are incorrectly exposed/misdeclared, prefer a bounded framebuffer topology correction;
B. if topology is already correct and dead pipes are expected, investigate a narrowly-scoped CoreDisplay/IOAccelerator compatibility shim.

Still forbidden until topology audit closes:
- another accelerated boot;
- EFI mutation;
- another Root Patch;
- global 3802 forcing;
- legacy main Metal shadow;
- true-five reapplication;
- CoreDisplay donor/downgrade without independent ABI audit;
- Golden mutation.
