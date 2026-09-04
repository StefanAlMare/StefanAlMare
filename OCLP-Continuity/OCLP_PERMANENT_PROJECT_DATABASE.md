# OCLP PERMANENT PROJECT DATABASE — ASUS2 Tahoe Haswell

Updated: 2026-09-05 EEST
Scope: **all continuations OCLP 11, OCLP 12, OCLP 13, OCLP 14, OCLP 15 and later**.
Purpose: consolidated durable project state. Detailed evidence remains in MASTER, HISTORY, RETROSPECTIVE and the checkpoint corpus. When current-state wording conflicts, the newest authoritative checkpoint explicitly linked by MASTER wins; permanent safety/methodology rules remain governed by `OCLP_PERMANENT_WORKING_RULES.md` and `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

---

## 1. End goal
Run macOS Tahoe `26.6.2 / 25G82` on ASUS2 with Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, with stable hardware acceleration and usable GUI.

The objective is not merely to suppress WindowServer failure, but to preserve the working Golden/OCLP downstream contract and correct the earliest Tahoe incompatibility required for the controlled comparator.

---

## 2. Authoritative architecture
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver handoff -> image`

Comparator rule:
- Golden Sequoia is the working oracle;
- Tahoe receives the same ORIGINAL OCLP functional root-patch content as Golden;
- historical experimental Tahoe compiler/payload mutations are not imported by default;
- only the smallest separately audited Tahoe host-OS eligibility delta is permitted before the controlled comparison.

---

## 3. Golden systems / immutable rule
### GOLDEN_A
- Sequoia `15.7.9 / 24G830`.

### GOLDEN_B
- Sequoia `15.8 / 24H22`;
- same EFI according to user;
- original OCLP Root Patch manually reapplied;
- hardware acceleration works.

Golden is **immutable/read-only**. Never boot or modify Golden merely to collect new evidence. Use persisted evidence or read-only mounted/static inspection only when genuinely required.

---

## 4. Exact Golden ORIGINAL-OCLP source lineage
Working Golden root-patch manifest:
`/System/Library/CoreServices/OpenCore-Legacy-Patcher.plist`

Pinned identity:
- manifest bytes `34173`;
- manifest SHA256 `8f16dce6102e40a6a28fcb347df31d3132b5b465262b44f3b6d73f6757f73aa0`;
- OCLP `v2.5.0`;
- PatcherSupportPkg `v1.9.6`;
- manifest OS `24.6 (24H22)`;
- Time Patched `September 04, 2026 @ 18:04:54`;
- Metal Library Used `/Library/Application Support/Dortania/MetallibSupportPkg/15.7.9-24G830`;
- exact upstream commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`.

Classification:
`GOLDEN_ROOTPATCH_ORIGINAL_OCLP_SOURCE_COMMIT=PINNED_b9df76ebdf3e768b37c1cc980e8444aa837c623e`.

---

## 5. Golden installed component invariants
Donor/compiler components:
- 32023 SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 SHA256 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Haswell components:
- AppleIntelFramebufferAzul binary SHA256 `3ff93ec8ce42c9d9f124c0a93e9d48e52b7e3c81ae47d4ede6948e452dd2624f`;
- AppleIntelHD5000Graphics binary SHA256 `a7ec5021532163b3202b448d25e1035e4d4ed6e25f770bba99fe9c7df77adbee`;
- AppleIntelHD5000GraphicsMTLDriver binary SHA256 `7fa9e4d882916d7bff700cf23b4be62cfb82c1dbf92b5482b231b6c23657df42`.

Original selector mapping:
- request `3802 -> Versions/3802`;
- request `31001 -> Versions/32023`.

---

## 6. Golden request/producer contract closure
Receiver XPC schema:
- `requestType:uint64`;
- `sandboxTokens:value`;
- `llvmVersion:uint64`;
- `pluginPath:string`;
- `targetData:value`;
- `data:value`;
- `client_name:string`;
- `timeout:uint64`.

Primary Golden request builder:
- function region `0x7FF80D370756..0x7FF80D370C28`;
- `RBX = ABI arg1/RDI`;
- signed dword `[RBX+0x20] -> llvmVersion`;
- `R13 = ABI arg2/RSI`;
- dword `[R13+0x08] -> requestType`;
- qword `[R13+0x18] -> timeout`;
- byte `[R13+0x70]` gates `sandboxTokens`;
- alternate requestType immediate `9`.

Classifications:
- RBX/R13 origin `STATIC_ABI_ORIGIN_PROVEN`;
- llvmVersion source `STATIC_VALUE_SOURCE_PROVEN`.

Golden runtime evidence retains the 3802/32023 dual-generation mapping under unchanged selector semantics.

---

## 7. Historical accepted functional baseline
Exactly:
1. P1 selector bridge;
2. P2b request-layout bridge `request+0xD0 -> request+0x110`;
3. P3 serialized-bitcode path;
4. AIR00 fallback producing AIR 2.6 / Metal 3.1;
5. D34 semantic-equivalent reset.

True-five historical SHA:
`6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.

D22 remains semantic proof for AIR 2.6 / Metal 3.1.

These are evidence/history, not automatically part of the identical-OCLP comparator.
- P6/P7 runtime sufficiency NEGATIVE;
- D50/D68/D82 reserve-only;
- D84 retired;
- D36-D44 invalidated for D34 cave overlap.

---

## 8. Retained causal model
`MTLCompilerService failure -> XPC_ERROR_CONNECTION_INTERRUPTED -> pipeline creation failure -> SkyLight/CopyPipelineState abort -> WindowServer death`

WindowServer is downstream, not root cause.

---

## 9. Rejected Tahoe/T2 experimental worktree
Historical local source path:
`/Volumes/AsusLaptop/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82`

Observed state:
- HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`;
- branch `alex-tahoe-25G82-custom`;
- prior/tag `8969550`;
- `origin/main e371b71468464ea3a13b8b82c3ca5298a71df141`;
- `origin/Development 85ea01b333c9a7e50c44f054a52614425c3058a2`;
- tracked custom changes included `metal_3802.py`, `sys_patch.py`, `sys_patch_helpers.py` and D97/.before material.

Classification:
`TAHOE_CURRENT_WORKTREE_IDENTICAL_OCLP_BASELINE=REJECTED_DIRTY_CUSTOM`.

Never clean/reset/mutate this worktree merely to manufacture a comparator.

---

## 10. D97BE exact Golden eligibility audit — CLOSED / scope corrected
Exact source `b9df76...` proved:
- `detect.py`: `_min_os = os_data.big_sur.value`, `_max_os = os_data.sequoia.value`;
- outside range sets unsupported-host validation;
- propagation: `_validation_check_unsupported_host_os()` -> `requirements[UNSUPPORTED_HOST_OS]` -> `_can_patch(requirements)` -> `_cant_patch` -> `self.can_patch` -> `PatchSysVolume.start_patch()` enforcement;
- exact `os_data.py` already defines `sequoia = 24`, `tahoe = 25`;
- Haswell remains non-native/patchable on Darwin 25;
- MetallibSupportPkg required from Sequoia onward;
- original `LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell model-specific` composition remains active;
- `metallib_handler.py` uses dynamic Dortania MetallibSupportPkg manifest and has no fixed Tahoe maximum.

The user correctly recalled a historical second Tahoe blocker from a different Tahoe-aware/custom OCLP source: legacy GPU classes could be excluded or treated as native on Tahoe, causing patchset selection to skip them or `patches()` to return `{}`.

Exact Golden `b9df76...` does **not** contain that blocker:
- `intel_haswell.IntelHaswell` is unconditionally listed in `_hardware_variants`;
- `IntelHaswell.native_os()` is exactly `return self._xnu_major < os_data.ventura.value`, so Darwin 25 returns `False`;
- `IntelHaswell.patches()` proceeds to the original Metal3802/GVA/OpenCL/model-specific composition;
- `LegacyMetal3802._os_requires_patches()` is `self._xnu_major >= os_data.ventura.value`, with no Tahoe maximum.

Classification:
`HISTORICAL_TAHOE_PATCHSET_NATIVE_OS_BLOCKER_APPLIES_TO_B9DF76=NO`.

Correct static conclusion:
`B9DF76_TAHOE_STATIC_SOURCE_GATE_REQUIRED_FOR_HASWELL_PATCHSET_SELECTION=ONE_LINE_DETECT_MAX_OS`.

Authorized static host-eligibility delta:
```diff
-        _max_os = os_data.sequoia.value
+        _max_os = os_data.tahoe.value
```

Scope: this proves the sole currently demonstrated Tahoe-specific **static source gate before Haswell patchset generation** in exact b9df76. It does **not** prove that one line is sufficient for a completely successful Tahoe Root Patch.

Full Root Patch success remains `NOT_YET_PROVEN` and can still depend on:
- MetallibSupportPkg availability/matching;
- network/package retrieval when needed;
- SIP;
- FileVault;
- SecureBootModel;
- AMFI;
- dirty/repatch state;
- root-volume mount/kernel-cache/snapshot behavior;
- any Tahoe runtime incompatibility not represented by an explicit source guard.

Original validation gates remain intact and are not to be bypassed.

---

## 11. D97BF source identity pre-build evidence
Before GitHub compilation was suspended, CI attempts proved:
- exact checkout `b9df76...` PASS;
- tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- only `opencore_legacy_patcher/sys_patch/patchsets/detect.py` changed;
- exact diff `1 insertion / 1 deletion`;
- protected blobs unchanged:
  - constants.py `bdba8738efe1be132427200e0c9a842998e21b86`;
  - os_data.py `094ec597de4ed6b09c42d49d8aceda7888d7fde2`;
  - intel_haswell.py `5ef1ae0f541c413974906a125ad76704680e127c`;
  - metal_3802.py `4276b1aede0134b4d2bbd6980fb3f0e1214302ad`;
  - sys_patch.py `d92544778cba207baa462b1650a6a9a5742d284d`;
  - sys_patch_helpers.py `e4c153e11bd7e5f41c991af83c4c77bc8495a844`;
  - metallib_handler.py `6530e14311fd0ff798395a363ecfc7f4eba78caa`.

CI failures at that stage were audit/workflow-lane failures, not proven OCLP functional build failures.

---

## 12. User Desktop OCLP 2.5.0 — exact official Golden lineage PROVEN
Read-only local audit of:
`/Users/alex/Desktop/OpenCore-Patcher.app`

Observed:
- bundle created `2026-03-19 18:36:42 +0200`;
- modified `2026-03-21 21:34:22 +0200`;
- `du -sh` `777M`;
- OCLP `2.5.0`;
- bundle ID `com.dortania.opencore-legacy-patcher`;
- Build Date `2026-03-19 09:33:30`;
- BuildMachineOSBuild `21G531`;
- universal executable `x86_64 arm64`;
- executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- Info.plist SHA256 `6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`;
- Developer ID Application `Mykola Grymalyuk (S74BDJXQMD)`;
- signing timestamp displayed locally `19 Mar 2026 at 18:33:46`;
- strict/deep codesign verification PASS, `codesign_exit=0`;
- payloads present: `payloads.dmg` ~46M and `Universal-Binaries.dmg` ~612M, timestamped `19 Mar 18:32`.

Official upstream provenance:
- exact Golden commit `b9df76...` created `2026-03-19T16:31:54Z`;
- no later upstream commit from `16:31:55Z` through `20:00:00Z` that day;
- official Dortania push workflow run `23305527165` head SHA exactly `b9df76...`, started `16:32:02Z`;
- successful job `67778441258`, label `x86_64_monterey`, completed `16:41:53Z`;
- official `OpenCore-Patcher.pkg` artifact `6010508330` created `16:41:49Z`.

Classification:
`USER_DESKTOP_APP_OFFICIAL_B9DF76_SOURCE_LINEAGE=PROVEN_BY_OFFICIAL_WORKFLOW_PROVENANCE`.

Separate byte-identity question:
`USER_DESKTOP_APP_BYTE_IDENTITY_TO_EXPIRED_OFFICIAL_ARTIFACT=UNAVAILABLE_EXPIRED_ARTIFACT`.

Engineering consequence: a fresh full OCLP application build is no longer the only possible D97BF route. A deterministic modification of a copy of the frozen PyInstaller module may permit the exact static Tahoe eligibility change without recompiling the whole app, but only after the complete frozen selection contract is audited.

---

## 13. User local OpenCore-Patcher.pkg reference
TrueNAS Reader manifest:
- batch `20260904T225753Z-dv103208c1-178bdb6a`;
- bytes `738123183`;
- SHA256 `b4e32cbfb1f978f670ccafff7b513d352e0665366caa73faeed0dbcd428dc364`.

Preserve the original PKG unchanged as evidence. Its earlier size mismatch against a public reshared nightly does not contradict the proven source lineage of the Desktop `.app`.

---

## 14. Current execution responsibility / quota override
General policy is GitHub-first, but the user explicitly suspended **GitHub compilation/build/package jobs** until the Actions quota resets/unblocks.

Until explicitly lifted:
- no new GitHub Actions compile/build/package run;
- GitHub remains allowed for source reading, static audit, provenance, persistence/checkpoints and metadata;
- if a full build is needed it must use a non-GitHub macOS executor;
- local compilation still requires explicit user authorization;
- never auto Root Patch;
- never auto reboot.

---

## 15. Permanent diagnostic methodology
- keep evidence classes distinct: REACHED, CONTROL-FLOW PROVEN, SEMANTIC PROVEN, STRUCTURAL-SEMANTIC PROVEN, STATIC-MAPPED/PROVEN, NEGATIVE, INCONCLUSIVE, UNKNOWN;
- module-boundary methodology by default;
- at large boundaries ask both where execution went and whether payload/state remains good;
- whole-stage/multi-threshold diagnostics preferred to one-address/one-reboot scans;
- universal/no-PID coverage where request/process variability exists;
- same-cohort rules for mutually exclusive sampled classifiers;
- capture raw evidence before interpretation;
- D34 cave `0xEF8..0xEFE` protected.

---

## 16. Permanent accelerated-boot/VESA rule
After a Root Patch test, accelerated boot may have no usable image. Normal recovery is hard restart/power cycle followed by VESA boot.

Analyze the immediately preceding accelerated diagnostic boot, not blindly the latest boot. Use `last reboot` chronology and never mix VESA recovery logs into accelerated-boot evidence.

---

## 17. Persistence / startup / CURRENT ACTION
Persist decisive PROVEN/NEGATIVE results immediately; otherwise no later than every 10 substantive technical assistant responses. Update this database when durable state changes, MASTER, HISTORY when phase/history changes, and a new incremental checkpoint.

Future OCLP12/OCLP13/OCLP14/OCLP15+ startup:
1. read this database in full;
2. read `OCLP_PERMANENT_WORKING_RULES.md`;
3. read `OCLP_MASTER_CONTINUITY.md`;
4. read `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
5. read the exact current checkpoint named by MASTER;
6. consult retrospective/history when needed.

### CURRENT ACTION — expanded read-only frozen-app eligibility audit
On the proven reference `/Users/alex/Desktop/OpenCore-Patcher.app`:
1. identify the PyInstaller CArchive/PYZ layout and viewer availability;
2. prove frozen `opencore_legacy_patcher.sys_patch.patchsets.detect` matches exact b9df76 except for any later authorized working-copy edit;
3. prove frozen `opencore_legacy_patcher.sys_patch.patchsets.hardware.graphics.intel_haswell` matches exact b9df76 for inclusion/native/patch composition;
4. verify packaged MetallibSupportPkg resolution and determine whether `26.6.2 / 25G82` has a usable local or remote match;
5. only after those checks decide whether a one-module direct patch is sufficient for the comparator app;
6. preserve the proven Desktop app unchanged while auditing.

If direct patching is unsafe/non-deterministic, return to exact-source non-GitHub build lane; local compilation remains prohibited until explicit authorization.

No Root Patch is authorized. No reboot is authorized. Golden remains immutable/read-only.

Full evidence archive: `OCLP-Continuity/checkpoints/`.
Current authoritative checkpoint is linked by MASTER.