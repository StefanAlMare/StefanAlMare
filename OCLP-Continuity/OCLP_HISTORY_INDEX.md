# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-03 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260903_D97AJ_A4F_FULLY_RESOLVED_CFG_NO_LATE_BYPASS_DIAGNOSTIC_ORIGIN_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

This is an index/frontier summary. Exact historical detail remains in incremental checkpoints and repository history.

## Permanent protocol
Routine/small tests, source edits, probes, packaged-runtime tests, artifact/reassembly checks, live app/hardware/accelerated/VESA evidence stay on ASUS2. GitHub is only for major/substantial compile/build/package. No automatic Root Patch/reboot. Golden immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

## Functional baseline and durable D97 facts
P1 -> P2b -> P3 -> AIR00 -> D34; true-five SHA256 `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`. P6/P7 retained with runtime sufficiency NEGATIVE.

D97AD final MTLCompiler SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; historical accelerated boot `2026-09-02 00:10`, VESA `00:12` excluded. D97AEQ proved 28/28 natural exit(1) and invalidated the whole-stage classifier. D97AES proved historical D5CE/32023 diagnostic sender cohort and rejected 3802/H4 generation selection for that cohort. D97AER mapped the five late simulator-limit diagnostics after D97AD candidate terminal REL `0x58B`. D97AET sender PCs did not directly prove traversal past that terminal. D226 cache is separate lineage and cross-image semantic site mapping is not established. D97AEZ task-port method retired.

## D97AF / D97AG
D97AF UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`; deterministic D97AD->UUID-only postimage SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`.

D97AF build/deploy passed but Root Patch invalidated by packaged Python missing `os.listxattr`; old exception handling continued after failure.

D97AG replaced xattr access with fail-closed `/usr/bin/xattr` and installed fatal unmount+bare-reraise boundary. D97AG major build workflow/run/job `348876070 / 33696449978 / 100466229401`, app ZIP SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`, packaged exe SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, x86_64. ASUS2 artifact/frozen-runtime audit and exact live deployment passed.

Manual D97AG Root Patch proved the corrected xattr backend in the real patch path, then failed closed at `/bin/chflags`. The fatal boundary worked; staged postimage `dd`, atomic target rename, LC_UUID commit and new snapshot were not reached.

ASUS2 proved `/bin/chflags` absent and `/usr/bin/chflags` valid/executable x86_64+arm64e; all other transaction tool paths valid.

## D97AH local source PASS
D97AH changes exactly two method-local string tokens `/bin/chflags` -> `/usr/bin/chflags` in `patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp`.

Exact identities:

```text
HELPERS_SHA256=6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c
D97AH_METHOD_SHA256=fea34f69735ac244a064b55b58e4b95a6972e270f282d6d4f4d1fbecefd0503a
D97AH_PATCH_SHA256=66c536cb069d6eb04184294c79fce4b720f0d7d603b99c083969bed8776ee59c
D97AH_PATCH_BYTES=1005
SYSPATCH_SHA256=93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69
METAL_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
```

First local wrapper false-failed from substring overlap with no mutation; AST/token-exact rerun passed and changed exactly one source file.

## D97AH major build evolution
First major build compiled successfully and matched source/package module fingerprints, but a flawed auditor expected two duplicated `/usr/bin/chflags` constant-pool entries; Python deduplicated the constant. v2 YAML was invalid and ran zero jobs. v3 corrected the audit and proved constant pool old/new `0/1` plus LOAD_CONST old/new `0/2`, then build/package audit passed but Actions artifact upload failed because artifact storage quota was full. v4 is non-authoritative.

## D97AH authoritative v5 build/private release PASS
Private repo/branch/head: `StefanAlMare/Private-Work` / `oclp7-d97ah-github-build` / `d04ddd28c784a0b30c6629feeface10804d5d591`.
Workflow/run/job: `349436422 / 33769927671 / 100697248264`, Intel/x86_64, all 15 steps success.

Exact source/package identities repeat local D97AH. Source=packaged module fingerprints:
helpers `8112fec67f5d6928fa960ef25db80c6290499cc2e0acbd4c9d1fff7ce07dc322`; syspatch `8b754ef5f118b8e902e89ec32ed4717bad18bebfef5e4b38c7f33c76afe69571`; metal `0c3994d77d3396fc00967a155a1d70fea9d4337c2a865bbc05abfd05d80a54bf`.
Packaged chflags audit: constant pool old/new `0/1`, LOAD_CONST old/new `0/2`; D97AD, D97AG xattr backend and fatal boundary unchanged.

Exact v5 application:

```text
APP_ZIP_BYTES=751494634
APP_ZIP_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
PACKAGED_EXE_BYTES=6596544
PACKAGED_EXE_SHA256=207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf
PACKAGED_ARCH=x86_64
PART00_BYTES=390000000
PART00_SHA256=bca0943a2ca8f3ce219cdf2dc28306cab4aa20c9ec1b49c20658c006d502faa5
PART01_BYTES=361494634
PART01_SHA256=8eb51af7b095b96d9755f8dfa8ba8e20d045038fbe76524d8b51370b2687df7e
```

Delivery is private release ID `382116519`, tag `oclp7-d97ah-run-33769927671-attempt-1`, target head `d04ddd28c784a0b30c6629feeface10804d5d591`. Release API confirms exactly seven uploaded assets and exact SHA256 digests. Reports ZIP SHA256 `54d382b74aabd02ceba0fcb62a0489ba9f93f95932657a75f8ecc1652f0428d5`. Signing/notarization remains unverified.

## D97AH ASUS2 private-release audit v2 PASS
Full v2 rerun passed exact release assets, split/reassembly, ZIP CRC/safe-member audit, packaged executable identity, reports checksums, explicit byte-for-byte report/app executable comparison and all report content gates.

Exact audited ZIP identity: `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`. Executable `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64.

The user's later deletion of Desktop-visible files explained repeated missing-ZIP preflight failures; exact artifact identity remained intact in Trash. This was user housekeeping, not an OCLP/system failure.

## D97AH deploy tooling evolution
The first D97AH deploy-transform wrapper false-failed because its placeholder itself contained `D97AG`. Subsequent local validator audits found two additional tooling-only assumptions: `D97AH-deploying` appears three times, not two, and the final state assignment uses shell quotes. All failures occurred before inner deployment/application mutation.

The final public deploy-v4 wrapper applied exactly those three validator corrections, with pinned identity and local parse gates. Final transformed inner deploy SHA256 `590b11ec37b0c9d7162e365460a788132c33881c9bee6599f40af6a9a4381285`, `14858` bytes.

## D97AH exact deploy/open PASS
The final one-shot action recreated the exact audited Desktop ZIP from the exact Trash copy immediately before deployment, then ran the pinned v4 deployment flow.

Exact live D97AG preimage before switch: `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, x86_64.

Timestamped exact D97AG backup retained:
`/Applications/OpenCore-Patcher.app.D97AG-before-D97AH-20260903-200708`.

Current live D97AH:
`/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher`, `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64.

Fresh exact-path PID after open: `13110`. Exact deploy/open PASS; no source/system-target/Golden/Root Patch/reboot mutation during deploy.

## D97AH manual Root Patch — FULL PASS
The complete raw Root Patch output was audited. Exact local metallib `26.6.2-25G82` was used; elevated mount, preflight and patchsets completed. P1/P2b/P3/AIR00/D34 plus retained P6/P7 and D97AD passed again. D97AD committed SHA remained `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`.

The real privileged D97AH LC_UUID transaction crossed the former D97AG `/bin/chflags` blocker and completed:

```text
D97AF_TARGET_FLAGS_PRE=524288
D97AF_TARGET_XATTRS_PRE=[]
D97AF_TARGET_ACL_PRE=NONE
D97AF_LC_UUID_BUILD_STAMP_PRE_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755
D97AF_LC_UUID_BUILD_STAMP_OLD=D5CE0008-587C-3861-971A-4BAEFB7B9C5B
D97AF_LC_UUID_BUILD_STAMP_NEW=A4F456DF-7447-49BF-AC4F-102D90023A1E
D97AF_LC_UUID_BUILD_STAMP_OFFSET=0xAB0
D97AF_LC_UUID_BUILD_STAMP_POST_SHA=a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e
D97AF_LC_UUID_ATOMIC_SAME_VOLUME_RENAME=PASS
D97AF_TARGET_METADATA_PRESERVE_EXACT=PASS
D97AF_LC_UUID_BUILD_STAMP=PASS
```

Downstream patching also completed normally: patchset info write, RSR handling, AuxKC build/force, APFS snapshot creation, root-volume unmount, then `Patching complete`. Classification: `D97AH_ROOT_PATCH=FULL_PASS`.

## D97AH accelerated boot — NEGATIVE
Exact current VESA recovery `kern.boottime` is `2026-09-03 23:17:53 +0300`, so the preceding evidence from the 23:15 boot through 23:17:52 is authoritative accelerated D97AH evidence. Earlier provisional attribution of the 23:16:59 WindowServer to VESA was corrected.

The accelerated boot did not yield a usable GUI. Intel Haswell accelerator/framebuffers initialized, MTLCompilerService repeatedly spawned and disappeared during compilation, WindowServer repeatedly received `XPC_ERROR_CONNECTION_INTERRUPTED`, and the known downstream pipeline/SIGABRT chain remained. Classification: `D97AH_ACCELERATED_BOOT=NEGATIVE_NO_USABLE_GUI`.

## D97AF stamped runtime provenance — PROVEN 28/28
Read-only structured unified-log JSON for the accelerated cohort produced `140` MTLCompilerService records and `28` PIDs:
`350,358,362,364,370,372,375,379,383,386,390,391,398,403,405,407,423,425,429,431,432,434,435,437,440,442,444,446`.

There were exactly 28 simulator-diagnostic records. Every one of them has sender:

```text
/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler
UUID=A4F456DF-7447-49BF-AC4F-102D90023A1E
```

Aggregates:

```text
DIAGNOSTIC_RECORD_COUNT=28
EXPECTED_STAMP_UUID_ALL_RECORD_MATCHES=28
OLD_UUID_ALL_RECORD_MATCHES=0
EXPECTED_STAMP_UUID_DIAG_MATCHES=28
OLD_UUID_DIAG_MATCHES=0
```

Thus `D97AF_RUNTIME_PROVENANCE=PROVEN_28_OF_28_DIAGNOSTIC_COHORT`. Historical D97AES had already rejected H4 as a generation-selection explanation by proving 32023/D5CE sender provenance. The new D97AF A4F result removes the remaining old/stale-D5CE sender ambiguity for the current failing cohort: the diagnostics are emitted by the 32023 image carrying the project-unique D97AF stamp.

Direct memory text-byte reading remains not performed. Exact MTLCompilerService exit status for this D97AH boot remains UNKNOWN/INCONCLUSIVE from the current JSON collector; zero textual matches for exit110–114 or exit1 are not NEGATIVE evidence.

## D97AI / D97AJ fully resolved A4F CFG
D97AI verified exact A4F SHA/UUID and exact D97AD exit110 bytes at `0x9D6BD`; it confirmed the five late simulator-limit xrefs at `0x9D6C8`, `0x9D6EE`, `0x9D712`, `0x9D73A`, `0x9D75D`. D97AI remained INCONCLUSIVE only because its generic CFG did not resolve `jmpq *%rax` at REL+`0x279`.

D97AB/D97AC history identified that exact indirect as a seven-entry switch. D97AJ revalidated all seven entries on the exact current A4F image and replaced only that known indirect edge set. Result:

```text
CFG_REACHABLE_INSTRUCTION_COUNT_WITH_SWITCH=317
CFG_REACHABLE_WITH_EXIT110_BLOCKED_AND_SWITCH=314
REACHABLE_UNRESOLVED_INDIRECT_COUNT_AFTER_KNOWN_SWITCH=0
```

All five late diagnostic xrefs are `REACHABLE_NORMAL=NO` and `REACHABLE_WITH_EXIT110_BLOCKED=NO`.

Authoritative classification:
`D97AJ_STATIC_LATE_BLOCK_BYPASS_EXIT110=NEGATIVE_IN_FULLY_RESOLVED_REACHABLE_CFG`.

Internal CFG bypass is closed as an explanation.

## CURRENT ACTION
No Root Patch and no reboot.

The next bounded read-only ASUS2 action is a full-image A4F diagnostic-origin/external-entry audit: enumerate every code xref to the five exact simulator-limit string literals and its owning function; enumerate direct branches/calls from outside `validSimulatorMetadata` into its interior, especially late region `0x9D6C5..0x9D77F`; enumerate statically recoverable address-taken/RIP-relative references into those internal addresses.

If another xref or external entry exists, map its earliest upstream payload/state handoff for H1/H2/H3. If neither exists, persist the stamped-runtime-vs-fully-resolved-static contradiction before any new runtime observer.

No source/system/Golden mutation, service launch, Root Patch or reboot. Return complete raw output and STOP.
