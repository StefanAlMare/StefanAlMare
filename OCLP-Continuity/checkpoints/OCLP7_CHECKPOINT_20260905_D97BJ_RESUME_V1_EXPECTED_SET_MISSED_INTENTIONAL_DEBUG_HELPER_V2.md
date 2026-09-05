# OCLP7 CHECKPOINT — D97BJ resume v1 expected-set correction

Date: 2026-09-05 EEST

## State
Tahoe 26.6.2 / 25G82 remains booted in VESA. D97BJ functional Tahoe source delta remains PASS and no Root Patch/reboot occurred.

## Resume v1 result
User ran `D97BJ_resume_x86_64.sh`.

PASS before stop:
- preserved D97BJ functional source state;
- PyInstaller packaging target changed from `universal2` to `x86_64`.

The script then stopped at its changed-file-set audit. Observed changed files were exactly:
1. `OpenCore-Patcher-GUI.spec`
2. `ci_tooling/privileged_helper_tool/com.dortania.opencore-legacy-patcher.privileged-helper`
3. `opencore_legacy_patcher/support/metallib_handler.py`
4. `opencore_legacy_patcher/sys_patch/patchsets/detect.py`
5. `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`

The extra file relative to the v1 expectation is NOT contamination: it is the intentional DEBUG privileged-helper binary built in the immediately preceding D97BJ preparation step with `make debug` / `-DDEBUG` and ad-hoc signing.

Pinned intentional DEBUG helper SHA256 from prior PASS:
`a1b4189d01b3107c753a290491dfbca7dc5ba64b5279f71daf901aa74c9d7f87`.

Classification:
`D97BJ_RESUME_V1_FAILURE=EXPECTED_SET_AUDIT_BUG_ONLY`

The functional Tahoe delta remains unchanged and PASS.

## Corrected expected working diff
Exactly five changed tracked files are expected during the resumed build:
- three functional Tahoe source files;
- `OpenCore-Patcher-GUI.spec` packaging-only x86_64 change;
- the intentional DEBUG helper binary.

The corrected resume must verify the DEBUG helper SHA256 above before continuing.

## CURRENT ACTION
Run `D97BJ_resume_x86_64_v2.sh` against the existing worktree and venv. It must not reclone, redownload dependencies, Root Patch, or reboot. It should continue to application build, ad-hoc signing, bounded helper wrapper assembly, final hashes and audit output.

Do not open/use D97BJ for Root Patch until final V2 output is audited.