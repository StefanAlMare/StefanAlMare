# OCLP7 CHECKPOINT — D97AG TAHOE XATTR + LOCAL SOURCE INTEGRATION PASS; GITHUB BUILD NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AF_ROOT_PATCH_INVALID_PACKAGED_OS_LISTXATTR_FIX_NEXT.md`.

## Carry-forward boundary
The previous manual D97AF Root Patch is invalid/partial. P1, P2b, P3, AIR00, D34, retained P6/P7 and D97AD passed, then packaged D97AF raised `AttributeError: module 'os' has no attribute 'listxattr'` during the initial metadata gate. D97AF did not reach target data-fork read, UUID transformation, temporary file, sibling reservation or rename. OCLP nevertheless continued to AuxKC and snapshot creation, so that inactive snapshot remains unauthorized for reboot.

The last proven installed app is D97AF executable SHA256 `ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470`. Do not run Root Patch from it.

## Exact D97AG correction
D97AG changes exactly two source files:

1. In D97AF `_xattrs`, replace unavailable packaged-Python `os.listxattr` and `os.getxattr` with external `/usr/bin/xattr -s` name enumeration and `/usr/bin/xattr -s -p -x` exact binary-value reads. Every nonzero exit, stderr byte, malformed newline/name/cardinality or invalid hex is fatal.
2. In the shared Metal-chain exception handler, call `self._unmount_root_vol()` and then bare `raise`. This makes a custom Metal exception escape before `_write_patchset`; therefore rebuild/AuxKC/snapshot are not reached after such failure.

Patch identity:

```text
D97AG_SOURCE_CORRECTION_PATCH_SHA256=2c4e93e57b2d13762ef90020496f87c2a95c7e39553ff60f948bfacd2b6b659b
D97AG_SOURCE_CORRECTION_PATCH_BLOB=532f8729658b3bc287fa83963043a4d2a8aa816a
D97AG_SOURCE_CORRECTION_PATCH_BYTES=3137
```

Public exact source artifacts are jointly present at commit `4df8a88644e4694fffe3684983ee81af5ba1d212`. The corrected short launcher is public at commit `453c6b3ef450c9c3d80f1d68996dac14279a8cd4`, SHA256 `cd8b3da4fd88cea16b8c795007356a4fdbcd7fe9c7207dde31d1cbd83c7db35c`, git blob `b9f629ce8ae0bf8df5b8fca3d65d6a34b5d1aa7b`, `4042` bytes.

## Tahoe hardware capability PASS
The corrected launcher ran on ASUS2 and printed:

```text
D97AG_LAUNCHER_IDENTITY=PASS
D97AG_TAHOE_XATTR_BACKEND=PASS
D97AG_LIVE_SYSTEM_TARGET=ABSENT_ACCEPTED_BEFORE_ROOT_PATCH_DONOR_INSTALL
D97AG_PINNED_INPUT_IDENTITIES=PASS
```

The capability probe created a regular private temporary file, wrote binary xattr bytes `00 0A 0D FF 41` through `/usr/bin/xattr -s -w -x`, enumerated the exact name with `-s`, read the exact value with `-s -p -x`, and compared both. This proves the selected external backend on the actual Tahoe host. It did not mutate a project or system target.

The live unpatched/VESA-side path `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler` was absent. That is accepted because Root Patch installs the 14.2 Beta 1 donor into the mounted root before the custom chain. This absence does not prove the later mounted-root target identity and is not a reason to reboot.

## Local source integration PASS
Exact source root: `/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82`.

```text
SOURCE_BRANCH=alex-tahoe-25G82-custom
SOURCE_HEAD=4143b7077a9a4e5aa41ec7a06c0888597eda9b06
SOURCE_TRACKED_STATUS=EXACT_D97AF_THREE_FILES
HELPERS_PRE_SHA256=a240a3cb62ce25381ef6bd9e2d78e36dc379c25f9e9c5641e07cd9841e820d8e
SYSPATCH_PRE_SHA256=ccf5ad96de9ef9051cc30ac61bf3c24522628f5e26122d6c0af5abb352f777c9
METAL_PRE_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
HELPERS_POST_SHA256=ac4724159c0a6ce8802940f11ec02f803e85d8ca934d4629d3640ec1e58d32a2
SYSPATCH_POST_SHA256=93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69
METAL_POST_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
D97AD_METHOD_SHA256=bb66b1d5d883251431d5a7fa7bc42c0cc9bcb15ec77c74506bb2eae5bf987a12
D97AF_CORRECTED_METHOD_SHA256=1abd24399b9c39b215d7c06ecaf18fdfe24faeb19a743ac2ea957a20c99dc8d5
D97AG_XATTR_BACKEND_SOURCE_SHA256=d02e98be14d1881202565560198a9eb5b3ec3200057db98c4b0820454dab2019
```

All patch scope, forward/reverse applicability, postimage, Python compile/AST, D97AD unchanged, forbidden-Python-xattr absence, native-reader cardinality, active call order and shared fatal-boundary gates passed. Outer RC was `0`.

Recoverable backup: `/Users/alex/Desktop/OCLP7_D97AG_SOURCE_BACKUP_20260903-023142.w9fQQg`.
Report: `/Users/alex/Desktop/OCLP7_D97AG_LOCAL_SOURCE_CORRECTION_REPORT_20260903-023140_2760.txt`.

## Mutation ledger
```text
LOCAL_SOURCE_MUTATION=YES_EXACT_TWO_FILES
INSTALLED_APP_MUTATION=NO
SYSTEM_TARGET_MUTATION=NO
GOLDEN_MUTATION=NO
ROOT_PATCH_MUTATION=NO
SNAPSHOT_MUTATION=NO
REBOOT=NO
```

Baseline stays exactly P1+P2b+P3+AIR00+D34. P6/P7 are retained with runtime sufficiency NEGATIVE. Golden is immutable/read-only. D50/D68/D82 are reserve-only; D84 retired; Patch8 unauthorized. D97AEX/D97AEZ external observer is retired.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Do not run Root Patch and do not reboot.

The assistant must finish the substantial Intel GitHub FASTLANE: exact D97AD snapshot -> D97AF transition -> D97AG correction -> compile/AST/diff -> native macOS xattr probe -> actual PyInstaller-frozen xattr probe -> x86_64 app build -> packaged code-object/identity audit -> bounded artifact delivery -> independent download/reassembly/app audit -> exact backup/deploy -> open OCLP -> STOP.

Only after the corrected D97AG application is proven live may the user run a separately authorized manual Root Patch in the current session. Before any reboot, the returned Root Patch log must prove exact donor identity, every active patch stage, D97AF final target SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`, no traceback, AuxKC and snapshot completion. Never auto Root Patch or reboot.
