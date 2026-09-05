# OCLP7 CHECKPOINT — D97BH Tahoe 25G82 Metallib local fallback

Date: 2026-09-05 EEST

## State entering checkpoint
- Tahoe 26.6.2 / 25G82 booted in VESA.
- D97BG Tahoe-ready wrapper build/audit PASS.
- User performed Root Patch Restore, then attempted Root Patch with D97BG wrapper.
- OCLP reported MetallibSupportPkg missing and attempted network download.
- Exact Pyquick MetallibSupportPkg for target exists: `26.6.2-25G82`.

## Exact package provenance
Pyquick release tag: `26.6.2-25G82`.
Asset: `MetallibSupportPkg-26.6.2-25G82.pkg`.
Asset bytes: `116574513`.
Asset SHA256: `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.
Historical project evidence shows the extracted tree under `/Library/Application Support/Pyquick/MetallibSupportPkg/26.6.2-25G82`.

## Exact b9df76 local/remote logic
`metallib_handler.py` hardcodes local root:
`/Library/Application Support/Dortania/MetallibSupportPkg`.

On normal startup `_get_latest_metallib()` first calls `_local_metallib_installed()` with `match=None`; in exact b9df76 this does not match an ordinary folder such as `26.6.2-25G82`.
It then fetches the official Dortania manifest from `https://dortania.github.io/MetallibSupportPkg/manifest.json`.

Current official Dortania manifest contains Sequoia 15.x entries and no Tahoe 26.x/25G82 entry. The closest-match branch requires the same major version as the host, therefore it cannot select a 15.x package for host 26.6.2.

If the remote manifest fetch returns `None`, b9df76 enters its built-in local fallback:
1. loose host version = `26.6`;
2. `_local_metallib_installed(match="26.6", check_version=True)`;
3. a local directory named `26.6.2-25G82` under the Dortania MetallibSupportPkg root is accepted.

Classification:
`B9DF76_25G82_METALLIB_REMOTE_MANIFEST_PATH=BLOCKED_BY_NO_26X_ENTRY`
`B9DF76_25G82_METALLIB_LOCAL_FALLBACK_IF_MANIFEST_UNREACHABLE=PROVEN_BY_SOURCE`

## Historical corroboration
The earlier Tahoe-aware OCLP-T2 builder explicitly patched `metallib_handler.py` to prefer an exact local host-build MetallibSupportPkg before API fallback. That earlier workaround was solving this same ordering problem.

## Current action
Do not modify the signed inner OCLP.
Ensure exact local tree exists at:
`/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`

Temporarily make only `dortania.github.io` unreachable while retaining other internet access. Fully quit and relaunch the D97BG Tahoe-ready wrapper. Expected detection path:
- remote manifest fetch fails;
- fallback checks local `26.6`;
- `26.6.2-25G82` is accepted;
- Metallib missing setting clears;
- user then runs manual Root Patch.

Remove the temporary host override after Root Patch completes.

No reboot is authorized by this checkpoint. Root Patch remains manual by user.