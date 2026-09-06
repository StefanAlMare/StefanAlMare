# OCLP7 CHECKPOINT — D97DU iMac preflight false blocker / D97DV ready

Date: 2026-09-07 EEST

## ASUS2 authority unchanged
- Tahoe 26.6.2 / 25G82.
- VESA remains active with `-igfxvesa`.
- D97DL 0.0.7 remains active.
- `-ocmcdiag -ocmcd97bv` remain active.
- D97DT full VESA CAVE->SITE adapter delivery remains PASS.
- no Root Patch has been applied.

## D97DU first iMac build attempt
User ran `OCLP7_D97DU_IMAC_BUILD_AUTHORITY_BOOTSTRAP.sh` on the Intel iMac.

Authority bootstrap identity passed:
- expected Git blob `ceed3890b5d35efbefc38ebf1a40f358884e58b9`;
- actual Git blob identical;
- downloaded authority SHA256 `1684a2fd1b4aecac7852983e3d08b6bba34d43b95d7916f27e8a5b5ffb69d54d`;
- `bash -n` PASS.

The authority helper then stopped fail-closed before cloning/building because it required:
`/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`
on the iMac build host.

This is a build-helper preflight defect. Exact 25G82 MetallibSupportPkg is required on ASUS2 when Root Patch runs, but is not required to compile/package D97DU on the iMac. The D97DU source generator already downloads and SHA-pins exact `sys_patch_dict.py` for 25G82 independently.

No Root Patch, EFI mutation, system patch mutation or reboot occurred.

## Second preflight issue caught from same output
Original helper selected `/usr/local/bin/python3` = Python 3.14.7 because its gate allowed any Python >=3.11.
D97BJ proven packaging lineage used Python 3.13.x. D97DU should not introduce a new Python 3.14 dependency surface.

## D97DV correction
Persisted launcher:
`OCLP-Continuity/artifacts/OCLP7_D97DV_IMAC_BUILD_AUTHORITY_V2.sh`
Git blob: `e7a69e0b8e2c637f4d04ab209bc8eaf5a5dc8357`.

D97DV verifies exact D97DU authority blob then makes only two local build-host corrections:
1. removes the iMac-local 25G82 MetallibSupportPkg hard gate and records it as a target-ASUS2 contract;
2. requires exact x86_64 Python 3.13.x, searching the preserved D97BJ worktree/venv first and refusing Python 3.14.

D97DU native-Metal-safe policy itself is unchanged:
- native Tahoe Metal/Metal4 canonical;
- no legacy main `Versions/A/Metal`;
- no `MetalOld.dylib`;
- legacy `MTLCompilerService.xpc` only inside Metal.framework;
- private compiler lanes retained;
- exact 25G82 metallib map 182 entries;
- no true-five reapply.

## NEXT ACTION
Run D97DV on Intel iMac.
If no exact x86_64 Python 3.13.x is available, stop and return output; do not install or change Python manually.
If build completes, return D97DU ZIP + build report + source diff for independent audit.

Root Patch remains NOT authorized until that build and audit pass.
