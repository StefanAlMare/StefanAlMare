# OCLP7 CHECKPOINT — 2026-09-04 — D97BD eligibility preflight PASS; dirty custom tree excluded; clean-ref + exact gate-chain audit next

## Architecture
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Tahoe comparator must use SAME ORIGINAL OCLP functional content as Golden. The only Tahoe-specific functional delta permitted is a separately audited minimal eligibility/OS-support bypass. No payload/compiler/selector/request-layout/AIR/bitcode/driver semantic patch is permitted in this comparator.

## D97BD returned execution transcript
User returned complete terminal transcript `Text lipit(20260904-205711).txt`:
- bytes `401990`;
- SHA256 `00b6182ddda1e3b10c1427ff1e53b51d364aba8141d1e9f4d5c9c0596cb87c71`.

Wrapper/core gates:
- D97BD V2 wrapper expected/actual blob `d5efa353b87d7ce892c15f7660fc15696bca2044` — PASS;
- D97BD core expected/actual blob `a3dbc95d8688157692b30e738bbe98e51c2cef94` — PASS;
- core bytes `14469`, SHA256 `c6587e1183b653a0cb87d3699976ab19586f7e5a8462b6534fb747158757695f`;
- embedded Python compile PASS;
- read-only source/system safety gates PASS;
- `D97BD_AUDIT=COMPLETE`, `D97BD_V2_OUTER_RC=0`, `D97BD_V2_LAUNCHER_RC=0`;
- no system/source mutation, git fetch/checkout/reset, debugger attach, Root Patch or reboot.

Classification: `D97BD_IDENTICAL_OCLP_ELIGIBILITY_PREFLIGHT=PASS`.

## OCLP app identity subsection — RETIRED / INCONCLUSIVE_TOOLING
Volume inventory showed `/Volumes/AsusLaptop -> /` symlink. D97BD therefore enumerated `/Applications/OpenCore-Patcher.app` and `/Volumes/AsusLaptop/Applications/OpenCore-Patcher.app` as if independent candidates although they resolve to the same root namespace.

Both app records returned no Info.plist metadata/executable or bundle manifest values. The printed `EXECUTABLE_IDENTICAL=NO` / `BUNDLE_MANIFEST_IDENTICAL=NO` is NOT semantic evidence of two different OCLP apps and is retired.

Exact Golden-app/source lineage remains open and should be recovered from a root-patch manifest/version marker or a correctly resolved app bundle, not from this subsection.

## Canonical Tahoe source identity — current tree is NOT original comparator baseline
Source path observed:
`/Volumes/AsusLaptop/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82`

Git identity:
- HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`;
- branch `alex-tahoe-25G82-custom`;
- HEAD subject `Tahoe 25G82 Haswell experimental compatibility state`.

Immediately preceding visible commit/tag in local history:
- `8969550` tagged `4.0.0.16900` and `4.0.0.16047`.

Local remote refs without fetch:
- `origin/Development 85ea01b333c9a7e50c44f054a52614425c3058a2`;
- `origin/main e371b71468464ea3a13b8b82c3ca5298a71df141`.

Tracked worktree is dirty in exactly the historically dangerous comparator files:
- `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`;
- `opencore_legacy_patcher/sys_patch/sys_patch.py`;
- `opencore_legacy_patcher/sys_patch/sys_patch_helpers.py`.

Many `.before-*` D/P/MTLSelector backups are also present. D97BD custom marker census ends with real D97AM content in `sys_patch_helpers.py` and total printed `163`; the broad regex also contains false-positive P6/P7 strings, so the count itself is not a clean semantic metric. Git status + explicit D97AM lines are sufficient to prove current worktree is historical/custom.

Authoritative classification:
`TAHOE_CURRENT_WORKTREE_IDENTICAL_OCLP_BASELINE=REJECTED_DIRTY_CUSTOM`.
Do not build the identical-OCLP comparator directly from this worktree.

## Golden installed payload/component manifest — accepted invariants
D97BD recorded:
- 32023 bytes `1636896`, SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 bytes `438560`, SHA256 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService bytes `85520`, SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- AppleIntelFramebufferAzul binary bytes `2141488`, SHA256 `3ff93ec8ce42c9d9f124c0a93e9d48e52b7e3c81ae47d4ede6948e452dd2624f`;
- AppleIntelHD5000Graphics binary bytes `863824`, SHA256 `a7ec5021532163b3202b448d25e1035e4d4ed6e25f770bba99fe9c7df77adbee`;
- AppleIntelHD5000GraphicsMTLDriver binary bytes `1371856`, SHA256 `7fa9e4d882916d7bff700cf23b4be62cfb82c1dbf92b5482b231b6c23657df42`.

These hashes are comparator invariants for the eventual Tahoe installed-state audit wherever the exact same original payload is expected.

## Eligibility finding — simple max-OS expansion is NOT the gate
Current source census shows in `sys_patch/patchsets/detect.py`:
- `_min_os = os_data.big_sur.value`;
- `_max_os = os_data.tahoe.value`;
- rejection only if `_xnu_major < _min_os or _xnu_major > _max_os`.

Therefore Tahoe xnu major 25 is already inside the advertised global host-OS range in this lineage. Do NOT design a bypass that merely changes `_max_os`.

The actual eligibility/control chain to resolve is centered on:
- `HardwarePatchsetValidation.UNSUPPORTED_HOST_OS: self._validation_check_unsupported_host_os()`;
- `_can_patch(requirements, ...)`;
- `_cant_patch = not self._can_patch(requirements)`;
- `self.can_patch = not _cant_patch`;
- `sys_patch.py`: `if not patchset_obj.can_patch:`.

Exact function bodies/conditions must be compared in clean refs before any source edit.

## Payload influence separation
Haswell payload construction is visibly separate in `sys_patch/patchsets/hardware/graphics/intel_haswell.py`, including:
- Haswell subclass `METAL_3802_GRAPHICS`;
- AppleIntelFramebufferAzul.kext;
- AppleIntelHD5000Graphics.kext;
- AppleIntelHD5000GraphicsGLDriver.bundle;
- AppleIntelHD5000GraphicsMTLDriver.bundle;
- AppleIntelHD5000GraphicsVADriver.bundle;
- `LegacyMetal3802(...).patches()`.

Shared Metal payload behavior lives in `metal_3802.py`; current worktree copy is dirty/custom and must remain outside any eligibility-only edit.

## CURRENT FRONTIER / NEXT ACTION — D97BE CLEAN-REF + EXACT GATE-CHAIN AUDIT
Remain read-only. No Root Patch/reboot/source mutation.

Next bounded local ASUS2 audit must:
1. prove ancestry relationship among HEAD `4143b707...`, candidate clean parent/tag `8969550`, and existing `origin/main` / `origin/Development` refs without fetch/checkout/reset;
2. compare exact contents/hashes of `detect.py`, `sys_patch.py`, `intel_haswell.py`, `metal_3802.py`, `sys_patch_helpers.py`, `datasets/os_data.py` across those refs and current worktree;
3. print exact bodies/call chain for `_validation_check_unsupported_host_os`, `_can_patch`, requirement construction, `can_patch`, and the sys_patch enforcement site;
4. inspect bounded Golden root-patch manifest/version markers and correctly resolve any actual OCLP app bundle identity if available;
5. identify which clean ref can serve as ORIGINAL-OCLP source baseline and whether any single eligibility-only source delta is actually required;
6. make no source or system mutation.

Only after D97BE proves the clean baseline and gate may an eligibility-only source integration be designed. Any eventual integration must leave Haswell payload, Metal 3802 payload, compiler selector/donor logic and Golden component invariants untouched.