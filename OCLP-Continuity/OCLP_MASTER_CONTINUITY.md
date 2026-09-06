# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Current authoritative runtime checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DT_D97DL_FULL_VESA_PAIR_PASS.md`
Current build checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_BUILD_REPORT_PASS_LOCAL_ARTIFACT_AUDIT_NEXT.md`
Current build design: `OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`
Current local artifact audit: `OCLP-Continuity/artifacts/OCLP7_D97DY_D97DX_LOCAL_ARTIFACT_AUDIT.sh`

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- current boot mode VESA; `-igfxvesa` retained;
- `-ocmcdiag` present;
- full D97BV arg `-ocmcd97bv` present;
- active `OCLPMetalCompat.kext` = D97DL 0.0.7;
- D97DL UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- no active Root Patch.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo.

## D97BV / D97DT runtime closure
D97DT remains FULL VESA PAIR PASS on exact Tahoe 25G82:
- exact D97DL 0.0.7 loaded;
- functional mode ACTIVE;
- route/build 25G82 PASS;
- same PID mapped CAVE then SITE;
- CAVE exact replacement, tail zero, mutation/postimage PASS, write count 1, Apple validation `0xF/0/0`;
- SITE cave-prereq PASS, exact replacement, mutation/postimage PASS, write count 1, Apple validation `0xF/0/0`;
- D97DR separately proved cross-process CAVE visibility.

Therefore the selective-3802 adapter delivery mechanism is CLOSED PASS under VESA.

## D97DU / D97DX native-Metal-safe Root Patch baseline
Exact source baseline:
- OCLP commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`.

Tahoe-only functional policy:
- `detect.py`: host max Sequoia -> Tahoe;
- `metallib_handler.py`: exact local host-build MetallibSupportPkg before API;
- `metal_3802.py`:
  - Common installs only legacy `MTLCompilerService.xpc` into native Metal.framework plus private compiler lanes;
  - Extended retains CoreImage/RenderBox/private compiler compatibility but NO whole `Metal.framework` donor;
  - exact 25G82 Pyquick metallib map, 182 entries;
  - upstream behavior preserved off Tahoe;
- packaging-only `OpenCore-Patcher-GUI.spec`: x86_64.

Forbidden in synthesized Tahoe patch dictionary:
- whole `/System/Library/Frameworks/Metal.framework` donor;
- donor `13.2.1-24/Metal.framework`;
- `MetalOld.dylib`;
- donor main `Versions/A/Metal`;
- true-five reapplication.

## D97DX returned build report — PASS
Returned iMac report proves:
- tracked source delta bounded to exactly four files;
- Python `3.13.15` x86_64 PASS;
- patchdict/assets exact identities PASS;
- synthesized Tahoe patch dictionary PASS;
- whole Metal donor count 0;
- `MetalOld.dylib` count 0;
- main legacy Metal binary install count 0;
- XPC-only legacy ingress PASS;
- private compiler lanes PASS;
- exact 25G82 metallib entry count 182;
- explicit macOS SDK/header gates PASS;
- DEBUG helper x86_64 PASS, SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- inner app x86_64 PASS, executable SHA256 `986402e0d3a8d56f726b6fca41284fd1bb51631f9e675cd4631a11d29edb7b11`;
- source diff SHA256 `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- ZIP bytes `722858206`;
- ZIP SHA256 `2f84fcaf39eb6c5a917ebb7b878bf2bef495050981b52fbe41e971fa1fe5cf1a`;
- target official-helper save/restore policy PASS;
- official helper not bundled;
- `D97DX_BUILD_STATUS=PASS`.

No Root Patch, EFI mutation, system-root mutation, or reboot occurred.

D97DX build report checkpoint commit: `114b08ab92f9cdf712d81ad585e7de65e67711e8`.

## Oversized ZIP handling / D97DY
The final D97DX ZIP is ~723 MB and is too large to require upload through chat.
Do NOT ask the user to upload the full ZIP.

D97DY performs an independent LOCAL iMac audit and emits only a small TXT:
- verify exact ZIP SHA/size;
- full ZIP CRC integrity test without full extraction;
- selected ZIP member hashes;
- on-disk app binary/helper architectures and hashes;
- codesign gates;
- embedded audit and source patch identity;
- exact changed-file set;
- re-synthesized Tahoe Metal3802 dictionary;
- whole Metal/main Metal/MetalOld exclusion gates;
- exact 182-entry metallib map;
- target launcher fail-closed official-helper save/restore policy;
- verify official helper is not bundled.

D97DY authority commit: `5deee1e3adf5eb02b2fef449040069e6a7f6a4cd`.

## NEXT ACTION
On the Intel iMac, run `OCLP7_D97DY_D97DX_LOCAL_ARTIFACT_AUDIT.sh` against the existing D97DX app/ZIP/worktree.
Return only:
- the small `OCLP7_D97DY_D97DX_LOCAL_ARTIFACT_AUDIT_<timestamp>.txt`;
- `OCLP7_D97DX_b9df76_NATIVE_METAL_SAFE.patch`.

The large D97DX ZIP does not need to be uploaded.

After independent audit of those small artifacts, manual Root Patch on ASUS2 may be separately authorized.

Still NOT authorized:
- Root Patch now;
- removal of `-igfxvesa`;
- accelerated boot;
- any reboot into a new root-patched/accelerated configuration.
