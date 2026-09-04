# OCLP7 CHECKPOINT — 2026-09-05 — D97BF GitHub compilation suspended / alternative macOS executor required

Status: **AUTHORITATIVE EXECUTION-LANE OVERRIDE**.
Previous technical checkpoint: `OCLP7_CHECKPOINT_20260905_D97BE_EXACT_GOLDEN_GATE_CHAIN_PROVEN_ONE_LINE_TAHOE_ELIGIBILITY_D97BF_BUILD_NEXT.md`.

## User instruction
The user explicitly instructed:
- do not perform any more GitHub compilation/build jobs until the GitHub Actions quota is reset/unblocked;
- find another build solution;
- the restriction applies specifically to compilation/build execution, not to repository persistence/read-only audit.

This instruction takes immediate precedence over the earlier GitHub-first build lane for D97BF while the quota condition persists.

## Technical state unchanged
D97BE remains closed and the exact comparator source contract is unchanged:
- upstream Golden source: `dortania/OpenCore-Legacy-Patcher@b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`;
- only authorized functional delta:
  `_max_os = os_data.sequoia.value` -> `_max_os = os_data.tahoe.value` in `opencore_legacy_patcher/sys_patch/patchsets/detect.py`;
- no Haswell/Metal3802/sys_patch/sys_patch_helpers/selector/compiler/donor functional edits.

Previously started GitHub CI attempts established useful pre-build evidence only:
- exact Golden commit checkout succeeded;
- exact Golden tree observed: `7c3411fde7d40604164c8877a5ab5594448083ac`;
- one-file / one-insertion / one-deletion Tahoe eligibility diff passed;
- protected Golden blobs were repeatedly proven byte-identical for:
  - constants.py `bdba8738efe1be132427200e0c9a842998e21b86`;
  - os_data.py `094ec597de4ed6b09c42d49d8aceda7888d7fde2`;
  - intel_haswell.py `5ef1ae0f541c413974906a125ad76704680e127c`;
  - metal_3802.py `4276b1aede0134b4d2bbd6980fb3f0e1214302ad`;
  - sys_patch.py `d92544778cba207baa462b1650a6a9a5742d284d`;
  - sys_patch_helpers.py `e4c153e11bd7e5f41c991af83c4c77bc8495a844`;
  - metallib_handler.py `6530e14311fd0ff798395a363ecfc7f4eba78caa`.

The failed GitHub attempts did **not** invalidate the one-line source hypothesis. The observed failures before the user stop instruction were CI/audit-lane issues rather than a proven OCLP functional build failure.

## Temporary build-lane policy
Until the user explicitly states that GitHub Actions quota has reset/unblocked:
- `GITHUB_COMPILATION=FORBIDDEN_BY_USER`;
- no new GitHub Actions build/compile/package run may be triggered for this project;
- GitHub may still be used for persistence, source reading, static audit, checkpointing and artifact metadata when those actions do not trigger compilation;
- any already-started run is not to be treated as authority for future execution and must not cause another run to be launched.

## Alternative executor ranking
### A — Preferred: controlled Intel Mac build
Use a separate Intel Mac with macOS capable of the upstream OCLP build toolchain. This gives the closest architectural match to the previously used `macos-15-intel` CI environment and avoids cross-architecture PyInstaller uncertainty.

This is **local compilation**, therefore it still requires explicit user authorization before commands are issued/executed under the project's standing rule.

### B — Best external free cloud fallback: Codemagic
Current public pricing/docs indicate:
- individual free plan includes 500 macOS M2 VM minutes/month;
- max build duration 120 minutes;
- independent of GitHub Actions compute quota.

Because this is Apple Silicon, the D97BF build must explicitly audit the resulting application's `x86_64`/universal architecture and packaged Python module identity before it can be accepted.

### C — Other external macOS CI
CircleCI currently provides hosted macOS on M4 Pro paid tiers and supports universal/x86_64 cross-compilation. Bitrise offers Apple-silicon macOS trials/plans. Buildkite hosted macOS is Apple-silicon and paid. These are lower priority than A/B for this one comparator build.

## CURRENT ACTION
Select/prepare a **non-GitHub macOS build executor** while preserving the exact D97BF source and audit contract.

No Root Patch is authorized.
No reboot is authorized.
Golden remains immutable/read-only.
