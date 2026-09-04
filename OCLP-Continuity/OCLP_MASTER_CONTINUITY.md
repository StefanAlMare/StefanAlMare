# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97BD_ELIGIBILITY_PREFLIGHT_PASS_DIRTY_CUSTOM_TREE_CLEAN_REF_AND_GATE_CHAIN_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
Updated: 2026-09-04 EEST

## Mandatory startup
Before any technical change read in full, in order:
1. `OCLP_PERMANENT_WORKING_RULES.md`;
2. this MASTER;
3. `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. exact checkpoint named above;
5. `OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP_HISTORY_INDEX.md`.

## Target / execution contract
Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable accelerated GUI.
Routine/static/log/small work stays on ASUS2 under user control. GitHub is for major compile/build/package plus identity-pinned script persistence/delivery. Never auto Root Patch or reboot.

## Authoritative architecture
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Tahoe comparator must use SAME ORIGINAL OCLP functional content as Golden. The only permitted Tahoe-specific functional delta is a separately audited minimal eligibility/OS-support bypass. Historical P1/P2b/P3/AIR00/D34/P6/P7 are evidence/adapters only and are excluded from the identical-OCLP comparator unless later independently justified as producer normalization.

## Golden snapshots and contract closure
GOLDEN_A = Sequoia `15.7.9 / 24G830`, full D97AU/D97AX/D97AY runtime/static oracle.
GOLDEN_B = Sequoia `15.8 / 24H22`, no EFI changes per user, same original OCLP Root Patch manually reapplied, acceleration working.

Critical donor artifacts byte-identical A->B:
- 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.
Original selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`.

Receiver XPC schema: requestType:uint64, sandboxTokens:value, llvmVersion:uint64, pluginPath:string, targetData:value, data:value, client_name:string, timeout:uint64.
GOLDEN_B Metal text SHA `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`; eight-key request-builder xrefs rebase identically to GOLDEN_A. G3 reaches `Metal compositor activated` with HD4400/Metal2 and Azul/HD5000 loaded.

D97BB/D97BC bind primary producer layout to function ABI objects:
- primary request-builder `0x7FF80D370756..0x7FF80D370C28` via LC_FUNCTION_STARTS;
- RBX = ABI arg1/RDI; `[RBX+0x20]` signed dword -> llvmVersion;
- R13 = ABI arg2/RSI; `[R13+0x08]` dword -> requestType; `[R13+0x18]` qword -> timeout; `[R13+0x70]` byte gates sandboxTokens;
- alternate requestType path = immediate 9.
Classifications: RBX/R13 `STATIC_ABI_ORIGIN_PROVEN`; llvmVersion source `STATIC_VALUE_SOURCE_PROVEN`.

GOLDEN_A runtime dual generation remains authoritative. Combined with exhaustive unchanged selector semantics, observed 3802 donor traffic corresponds to request llvmVersion 3802 and observed 32023 donor traffic corresponds to request llvmVersion 31001. GOLDEN_B zero-record MTL query remains visibility-INCONCLUSIVE.

Golden is sufficiently characterized to proceed; no extra Golden reboot is required solely for structural provenance.

## D97BD — identical-OCLP Tahoe eligibility preflight PASS
Returned complete terminal transcript:
- bytes `401990`;
- SHA256 `00b6182ddda1e3b10c1427ff1e53b51d364aba8141d1e9f4d5c9c0596cb87c71`.
D97BD core/wrapper identity and compile/safety gates PASS; `D97BD_AUDIT=COMPLETE`, outer/launcher RC 0; no system/source mutation, git fetch/checkout/reset, debugger attach, Root Patch or reboot.

### App identity subsection retired
`/Volumes/AsusLaptop -> /` caused two path aliases to the same root namespace, while app metadata/executable hashes were unresolved. D97BD's printed app non-identity is `INCONCLUSIVE_TOOLING`, not semantic evidence. Exact Golden app/source lineage remains open.

### Current Tahoe source is NOT comparator baseline
Canonical observed source path `/Volumes/AsusLaptop/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82`:
- HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`;
- branch `alex-tahoe-25G82-custom`;
- visible prior/tag commit `8969550` (`4.0.0.16900`, `4.0.0.16047`);
- existing remote refs: `origin/main e371b71468464ea3a13b8b82c3ca5298a71df141`, `origin/Development 85ea01b333c9a7e50c44f054a52614425c3058a2`.

Tracked worktree is dirty in:
- `sys_patch/patchsets/shared_patches/metal_3802.py`;
- `sys_patch/sys_patch.py`;
- `sys_patch/sys_patch_helpers.py`;
with extensive historical `.before-*`/D97 material.
Classification: `TAHOE_CURRENT_WORKTREE_IDENTICAL_OCLP_BASELINE=REJECTED_DIRTY_CUSTOM`.

### Golden installed component invariants expanded
- AppleIntelFramebufferAzul binary SHA `3ff93ec8ce42c9d9f124c0a93e9d48e52b7e3c81ae47d4ede6948e452dd2624f`;
- AppleIntelHD5000Graphics binary SHA `a7ec5021532163b3202b448d25e1035e4d4ed6e25f770bba99fe9c7df77adbee`;
- AppleIntelHD5000GraphicsMTLDriver binary SHA `7fa9e4d882916d7bff700cf23b4be62cfb82c1dbf92b5482b231b6c23657df42`.
Donor hashes above remain comparator invariants.

### Simple max-OS expansion is NOT the eligibility bypass
Current `patchsets/detect.py` census shows `_min_os = big_sur`, `_max_os = tahoe`, then rejects only outside that range. Tahoe is already inside the global range. Do NOT patch `_max_os`.

The exact remaining eligibility chain to resolve is:
`_validation_check_unsupported_host_os()` -> requirements[`UNSUPPORTED_HOST_OS`] -> `_can_patch(requirements)` -> `_cant_patch` -> `self.can_patch` -> `sys_patch.py` enforcement `if not patchset_obj.can_patch`.

Haswell payload construction is separately located in `intel_haswell.py` and shared Metal payload in `metal_3802.py`; the latter is dirty/custom and must not be touched by an eligibility-only comparator edit.

## CURRENT FRONTIER / NEXT ACTION — D97BE CLEAN-REF + EXACT GATE-CHAIN AUDIT
Do NOT Root Patch/reboot or mutate source.

Next bounded local audit must:
1. prove ancestry between HEAD `4143b707...`, candidate clean parent/tag `8969550`, existing origin/main and origin/Development without fetch/checkout/reset;
2. compare exact hashes/contents for detect.py, sys_patch.py, intel_haswell.py, metal_3802.py, sys_patch_helpers.py and datasets/os_data.py across clean refs, committed HEAD and worktree;
3. print exact `_validation_check_unsupported_host_os`, `_can_patch`, requirements construction, can_patch assignment and sys_patch enforcement call chain for each candidate clean ref;
4. inspect bounded Golden root-patch manifest/version markers and correctly resolved app-bundle identity if available;
5. identify the clean ORIGINAL-OCLP source baseline and whether a single eligibility-only delta is actually needed;
6. make no source/system mutation.

Only after D97BE proves baseline+gate may a minimal eligibility-only integration be designed. Eventual integration must leave Haswell/Metal payloads, selector/compiler/donor logic, request layout and Golden component invariants untouched.