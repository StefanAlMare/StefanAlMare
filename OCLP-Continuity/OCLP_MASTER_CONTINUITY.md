# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BJ_RESUME_V1_EXPECTED_SET_MISSED_INTENTIONAL_DEBUG_HELPER_V2.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`

## Mandatory startup
Before proposing a technical modification in any future OCLP continuation, read the permanent database, permanent working rules, this MASTER, the VESA rule, and the current checkpoint linked above.

## Target
macOS Tahoe `26.6.2 / 25G82`, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable accelerated GUI.

## Exact Golden ORIGINAL-OCLP baseline
- upstream `dortania/OpenCore-Legacy-Patcher`;
- exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`.

## Proven user reference app
Official Golden-lineage app executable SHA256:
`0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`.

Reference Info.plist SHA256:
`6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`.

Golden remains read-only/immutable.

## D97BG wrapper result
D97BG successfully proved a wrapper can preserve the exact signed Golden inner OCLP and official helper while bypassing the Tahoe host-OS gate via the built-in developer marker.

However subsequent live Tahoe Root Patch testing proved D97BG is not sufficient for complete Tahoe 25G82 patching because exact b9df76 still contains Tahoe-incompatible Metal3802 payload/path assumptions.

## D97BH MetallibSupportPkg runtime PASS
Exact target package:
- `MetallibSupportPkg-26.6.2-25G82.pkg`;
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Exact local root required by b9df76:
`/Library/Application Support/Dortania/MetallibSupportPkg`.

With the official Dortania manifest temporarily made unreachable, runtime proved:
- local fallback checked `26.6`;
- exact local `26.6.2-25G82` was found;
- Root Patcher reported `Patcher is capable of patching`.

Classification:
`D97BH_25G82_LOCAL_METALLIB_FALLBACK_RUNTIME=PASS`.

## D97BI Metal.framework blocker PROVEN
After Metallib PASS, exact b9df76 failed preflight looking for:
`Universal-Binaries/13.2.1-25/System/Library/Frameworks/Metal.framework`.

Exact source constructs `13.2.1-{Darwin major}`, so Darwin 25 requests nonexistent `13.2.1-25`.
Historical Tahoe work had already identified `13.2.1-24` as the required existing donor.

Classification:
`B9DF76_TAHOE_25_METAL_FRAMEWORK_SOURCE_13_2_1_25=PROVEN_MISSING`.

## D97BJ complete Tahoe source delta — prepackaging PASS
User locally prepared exact b9df76 in Tahoe VESA.

Proven:
- exact b9df76 checkout PASS;
- exact Golden payload DMGs reused;
- exact Pyquick `sys_patch_dict.py` for 25G82 verified;
- Tahoe metallib map contains 182 entries;
- Python syntax PASS;
- DEBUG helper build PASS, SHA256 `a1b4189d01b3107c753a290491dfbca7dc5ba64b5279f71daf901aa74c9d7f87`.

Functional changed files exactly:
1. `opencore_legacy_patcher/support/metallib_handler.py`
2. `opencore_legacy_patcher/sys_patch/patchsets/detect.py`
3. `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`

Functional effects:
- host max Sequoia -> Tahoe;
- Tahoe `Metal.framework` donor -> `13.2.1-24`;
- Tahoe-only exact 25G82 metallib destination/source map from Pyquick;
- prefer exact local host-build MetallibSupportPkg before remote API.

Classification:
`D97BJ_TAHOE_FUNCTIONAL_SOURCE_DELTA_PREPACKAGING=PASS`.

## D97BJ packaging architecture blocker — resolved in design
Current pip resolution installed wxPython `4.3.1` as x86_64-only.
Exact b9df76 `OpenCore-Patcher-GUI.spec` requested `target_arch="universal2"`.
PyInstaller `6.22.2` therefore failed in COLLECT with:
`IncompatibleBinaryArchError: wx/_adv...so is not a fat binary`.

The build had already completed PYZ, PKG/CArchive and EXE stages before COLLECT failure.

Classification:
`D97BJ_BUILD_FAILURE=PACKAGING_ARCH_MISMATCH_TOOLING_ONLY`.

Authorized packaging-only correction for Intel ASUS2:
`OpenCore-Patcher-GUI.spec: target_arch="universal2" -> target_arch="x86_64"`.

## D97BJ resume v1 expected-set audit bug
User ran `D97BJ_resume_x86_64.sh`.

PASS:
- preserved D97BJ functional source state;
- packaging target changed to x86_64.

The script then stopped because its expected changed-file list omitted the already intentionally built DEBUG helper binary.

Observed changed files were exactly:
- `OpenCore-Patcher-GUI.spec`;
- `ci_tooling/privileged_helper_tool/com.dortania.opencore-legacy-patcher.privileged-helper`;
- the three functional Tahoe source files above.

The helper is intentional and pinned to SHA256:
`a1b4189d01b3107c753a290491dfbca7dc5ba64b5279f71daf901aa74c9d7f87`.

Classification:
`D97BJ_RESUME_V1_FAILURE=EXPECTED_SET_AUDIT_BUG_ONLY`.

Correct expected working diff during resume is exactly five tracked files: three functional Tahoe source files + one packaging spec + intentional DEBUG helper binary.

## Execution contract
GitHub Actions compilation remains suspended until user explicitly says quota reset/unblocked.
The user has explicitly executed/authorized the current local Tahoe VESA build path.
Never auto Root Patch.
Never auto reboot.
Golden remains immutable/read-only.

## CURRENT ACTION
Run corrected audited resume script `D97BJ_resume_x86_64_v2.sh` against existing worktree:
`~/Developer/OpenCore-Legacy-Patcher-D97BJ-b9df76-Tahoe25G82`.

The V2 resume must:
1. verify preserved D97BJ functional source state;
2. preserve packaging-only x86_64 target;
3. require exactly the five expected changed tracked files;
4. verify the intentional DEBUG helper SHA256 `a1b4189d...`;
5. rebuild application only;
6. ad-hoc sign custom x86_64 OCLP;
7. assemble bounded debug-helper wrapper with official helper restore asset;
8. produce final app/ZIP/hash/audit output;
9. run no Root Patch and no reboot.

Do not open/use D97BJ for Root Patch until final V2 output is audited.