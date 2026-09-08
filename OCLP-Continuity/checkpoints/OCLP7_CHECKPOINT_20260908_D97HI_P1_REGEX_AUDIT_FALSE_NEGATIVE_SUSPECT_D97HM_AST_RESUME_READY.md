# OCLP7 CHECKPOINT — 2026-09-08 — D97HI P1 REGEX AUDIT FALSE-NEGATIVE SUSPECT / D97HM AST RESUME READY

## Current host
Authorized portable Intel MacBook Pro build host:
- x86_64 Intel Core i9-9880H;
- macOS 15.7.9 / 24G830;
- Xcode + SDK 26.2;
- Python 3.13.15 x86_64;
- sufficient free space.

ASUS2 remains forbidden as a compilation host.

## D97HL/D97HK progress before stop
Portable bootstrap successfully:
- verified exact D97DU/D97GS/D97HI authority blobs;
- cloned exact upstream `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- verified exact tree;
- applied D97DX native-Metal-safe policy;
- created isolated Python 3.13 venv and installed requirements;
- synthesized Tahoe Metal3802 patch dictionary PASS;
- regenerated exact Universal-Binaries SHA `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`;
- reconstructed exact D97DX source diff SHA `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- reconstructed exact D97GS P1 source diff SHA `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- inserted D97HI P3 source;
- produced current D97HI source diff SHA `c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`.

## Stop
D97HI source contract audit reported:
- P1 regex pre hash `4302a73061f15f373cc0167c3f921b1aefc93e10f95932ecc1c20cacebb2ddb3`;
- P1 regex post hash `e1be3d2b40f084d1fa42a74df0950d58c94be4b9867ae70f0366df07f6c71fad`;
- `D97HI_P1_METHOD_BYTE_IDENTICAL=FAIL`;
- stop before build.

No inner build, wrapper assembly, Root Patch, target mutation or reboot occurred.

## Classification
The regex audit delimits P1 by searching until the following method definition. D97HI inserts a new method immediately after P1, so blank-line separator inclusion can alter the regex-captured bytes without changing the FunctionDef body.

This is therefore `INCONCLUSIVE_TOOLING_BOUNDARY` until a method-boundary audit proves whether P1 itself changed.
Do NOT call P1 preserved until that audit passes.

## D97HM exact resolution
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HM_RESUME_AFTER_P1_AUDIT_FALSE_NEGATIVE_AND_BUILD_INNER.sh`
- commit `ac528a97f01fc31d5bd629371d3a86b2df16c4ab`;
- blob `81a4079447e884ee0c8bb7dbf48b4662a45a0da6`.

D97HM:
1. requires current full D97HI source diff SHA exactly `c4590568...`;
2. locates exact saved D97GS patch SHA `cae9c...`;
3. reconstructs D97GS in a temporary detached worktree;
4. uses Python AST `lineno/end_lineno` to extract exactly `_d97gs_apply_p1_selector_bridge` from D97GS and current D97HI;
5. compares those FunctionDef ranges byte-for-byte, excluding inter-method separator blank lines;
6. fails closed if any actual P1 function byte differs;
7. verifies exact P3 constants/hook/order and full source identity;
8. only then builds and packages D97HI inner app.

No reclone/requirements reinstall is needed if current state is intact.
No wrapper, Root Patch, target transfer, reboot, P2b, AIR00 or D34 is authorized until D97HM PASS and independent inner audit.
