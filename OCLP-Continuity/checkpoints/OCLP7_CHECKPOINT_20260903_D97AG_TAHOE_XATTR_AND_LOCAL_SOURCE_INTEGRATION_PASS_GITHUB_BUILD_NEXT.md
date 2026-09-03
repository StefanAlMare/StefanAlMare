# OCLP7 CHECKPOINT — D97AG TAHOE XATTR + LOCAL SOURCE INTEGRATION PASS; GITHUB BUILD PASS; ASUS2 AUDIT NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AF_ROOT_PATCH_INVALID_PACKAGED_OS_LISTXATTR_FIX_NEXT.md`.
Detailed successor checkpoint: `OCLP7_CHECKPOINT_20260903_D97AG_GITHUB_BUILD_PASS_ASUS2_ARTIFACT_RUNTIME_AUDIT_NEXT.md`.

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

## Mutation ledger through source integration
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

## 2026-09-03 permanent execution-lane correction
Explicit user authority supersedes any broader GitHub-first reading.

- Routine/small tests, ordinary validations, source inspection, small edits, local probes, diagnostic iteration, diff checks, capability checks and packaged-runtime tests run on ASUS2 so the user retains direct control and visibility.
- GitHub is used only for major/substantial compilation, build or packaging workloads.
- Existing audited artifact-delivery mechanisms are reused to bring the major-build outputs to ASUS2.
- Technical executability on GitHub is not enough to move a routine test there.
- Local compilation of a major build is not an implicit fallback and requires explicit user authorization.
- Root Patch and reboot remain manual-only and separately authorized.

## D97AG major Intel GitHub build — PASS
The major build had already completed before this continuation and was not rerun. Private repo/branch/head are `StefanAlMare/Private-Work` / `oclp7-d97ag-github-build` / `4bde01b09717d076499ebf3640b5e4c0378798dd`. Workflow/run/job are `348947684 / 33696449978 / 100466229401` on `macos-15-intel / x86_64`; all substantive build/package/upload steps completed `success`.

Exact final identities:

```text
D97AG_APP_ZIP_BYTES=751494420
D97AG_APP_ZIP_SHA256=d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846
D97AG_PACKAGED_EXE_BYTES=6596544
D97AG_PACKAGED_EXE_SHA256=29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628
D97AG_PACKAGED_ARCH=x86_64
```

The reports artifact was independently downloaded and its actual SHA256 equals its GitHub digest exactly: artifact `9872066045`, `18021887` bytes, SHA256/digest `da5b9e2d2a55786c1b6a4f3c64c054779ad73f394578e1a5e07c2bd0fd287217`.

Delivery artifacts are part00 `9872061067` / outer digest `a3f0426126126a3e71351c645135757f7a89f7cc1a9f9d269e2cb9fdf17b926a`, payload SHA256 `87189ac03eb044b3d674dddeb091ccafbb4705ac246c26d9f648bba5e66dc60e`; part01 `9872064375` / outer digest `7e167cef69dd9fa602a314ca138b2e94b6f76cf777fc3a65edf73b848fdc0e40`, payload SHA256 `9952bf53e223fb9688102f18865afdb2ea58fa07362d807da61651e908955d23`.

Packaged/source fingerprints agree; D97AD is unchanged; D97AG is present exactly once; forbidden packaged `listxattr/getxattr` names are absent; `/usr/bin/xattr` is retained; the D97AF target contract remains preimage `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755` -> postimage `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`.

Historical GitHub-side native/frozen runtime probes are informative build evidence only and do not replace the current required ASUS2 local packaged-runtime test.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Do not run Root Patch and do not reboot.

GitHub major build/package is complete and audited. The next action is one bounded ASUS2-only, non-system-mutating artifact/runtime audit: exact run/job/artifact binding -> download the two part artifacts plus reports artifact -> verify outer and inner hashes/member sets -> exact two-part reassembly -> verify app ZIP `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846` -> verify packaged executable `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628` / x86_64 -> execute the exact frozen auditor locally against that packaged executable -> STOP with no `/Applications` mutation and no OCLP launch.

Only after this local audit is returned and accepted may a separate recoverable backup/deploy/open-OCLP/STOP action be authorized. Manual Root Patch is later and separately authorized only after exact D97AG live application identity is proven. Never auto Root Patch or reboot.
