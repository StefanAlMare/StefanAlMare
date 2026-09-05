# OCLP7 CHECKPOINT — D97BJ functional Tahoe delta PASS; PyInstaller universal2 packaging blocker

Date: 2026-09-05 EEST

## Runtime state entering checkpoint
- Tahoe 26.6.2 / 25G82 booted in VESA.
- D97BH local MetallibSupportPkg fallback runtime = PASS; exact local `26.6.2-25G82` was found and OCLP became capable of patching.
- D97BI then proved exact b9df76 requests nonexistent `Universal-Binaries/13.2.1-25/.../Metal.framework` on Darwin 25.
- Historical Tahoe work had already identified existing donor `13.2.1-24` and exact 25G82 metallib map requirements.

## D97BJ local source preparation result
User ran D97BJ local build script in Tahoe VESA.

Proven PASS before packaging:
- exact source checkout HEAD `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- exact Golden tree baseline verified before edits;
- exact Golden payload DMGs reused;
- exact Pyquick `sys_patch_dict.py` for `26.6.2-25G82` verified with SHA256 `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`;
- Tahoe functional source delta applied successfully;
- Tahoe metallib map contains 182 entries;
- functional changed-file set exactly:
  1. `opencore_legacy_patcher/support/metallib_handler.py`
  2. `opencore_legacy_patcher/sys_patch/patchsets/detect.py`
  3. `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`
- functional changes:
  - host max Sequoia -> Tahoe;
  - Tahoe `Metal.framework` donor forced to `13.2.1-24`;
  - Tahoe-only exact 25G82 metallib destination/source map from Pyquick;
  - exact local host-build MetallibSupportPkg preferred before remote API;
- Python syntax validation PASS;
- DEBUG privileged helper build PASS, SHA256 `a1b4189d01b3107c753a290491dfbca7dc5ba64b5279f71daf901aa74c9d7f87`.

Classification:
`D97BJ_TAHOE_FUNCTIONAL_SOURCE_DELTA_PREPACKAGING=PASS`.

## Packaging failure — tooling only
PyInstaller build reached application packaging and failed during `COLLECT`, not during OCLP source analysis or compilation.

Observed environment:
- PyInstaller `6.22.2`;
- Python `3.13.13`;
- macOS `26.6.2` x86_64;
- wxPython `4.3.1` wheel resolved as `cp313 ... macosx_10_13_x86_64`.

Exact failure:
`PyInstaller.utils.osx.IncompatibleBinaryArchError: .../wx/_adv.cpython-313-darwin.so is not a fat binary!`

Exact b9df76 `OpenCore-Patcher-GUI.spec` requests:
`target_arch="universal2"`.

Therefore current wxPython dependency is x86_64-only while the spec requests universal2 collection.

Classification:
`D97BJ_BUILD_FAILURE=PACKAGING_ARCH_MISMATCH_TOOLING_ONLY`

This is NOT evidence against the Tahoe functional delta.

## Authorized packaging correction
Target ASUS2 is Intel Haswell/x86_64 only. No arm64 execution is required for this comparator.

Resume from the already prepared worktree and venv; do not reclone/redownload dependencies.

Packaging-only change:
`OpenCore-Patcher-GUI.spec: target_arch="universal2" -> target_arch="x86_64"`.

This produces a four-file working diff where only three files are functional OCLP source delta and the fourth is packaging-only architecture selection.

Expected changed files after packaging correction:
- `OpenCore-Patcher-GUI.spec` (packaging only)
- `opencore_legacy_patcher/support/metallib_handler.py`
- `opencore_legacy_patcher/sys_patch/patchsets/detect.py`
- `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`

## CURRENT ACTION
Run the audited `D97BJ_resume_x86_64.sh` against existing worktree:
`~/Developer/OpenCore-Legacy-Patcher-D97BJ-b9df76-Tahoe25G82`

The resume script must:
1. verify preserved D97BJ functional source state;
2. change only PyInstaller packaging target to x86_64;
3. rebuild application only;
4. ad-hoc sign custom x86_64 application;
5. assemble bounded debug-helper wrapper;
6. include exact official Dortania helper as restore asset;
7. produce final app/ZIP hashes and audit output;
8. run no Root Patch and no reboot.

Do not open/use D97BJ for Root Patch until final resume output is audited.