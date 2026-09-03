# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-03 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_GITHUB_BUILD_RELEASE_PASS_ASUS2_AUDIT_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

This is an index/frontier summary. Exact historical detail remains in incremental checkpoints and repository history.

## Permanent protocol
Routine/small tests, source edits, probes, packaged-runtime tests, artifact/reassembly checks, live app/hardware/accelerated/VESA evidence stay on ASUS2. GitHub is only for major/substantial compile/build/package. No automatic Root Patch/reboot. Golden immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

## Functional baseline and durable D97 facts
P1 -> P2b -> P3 -> AIR00 -> D34; true-five SHA256 `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`. P6/P7 retained with runtime sufficiency NEGATIVE.

D97AD final MTLCompiler SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; selected accelerated boot `2026-09-02 00:10`, VESA `00:12` excluded. D97AEQ invalidated whole-stage classifier; D97AES proved D5CE/32023 diagnostic sender cohort; D226 cache is separate lineage and cross-image semantic site mapping is not established. D97AEZ task-port method retired.

## D97AF / D97AG
D97AF UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`; deterministic D97AD->UUID-only postimage SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`.

D97AF build/deploy passed but Root Patch invalidated by packaged Python missing `os.listxattr`; old exception handling continued after failure.

D97AG replaced xattr access with fail-closed `/usr/bin/xattr` and installed fatal unmount+bare-reraise boundary. D97AG major build workflow/run/job `348876070 / 33696449978 / 100466229401`, app ZIP SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`, packaged exe SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, x86_64. ASUS2 artifact/frozen-runtime audit and exact live deployment passed.

Manual D97AG Root Patch proved the corrected xattr backend in the real patch path, then failed closed at `/bin/chflags`. The fatal boundary worked; staged postimage `dd`, atomic target rename, LC_UUID commit and new snapshot were not reached. Reboot remained unauthorized.

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

Delivery is private release ID `382116519`, tag `oclp7-d97ah-run-33769927671-attempt-1`, target head `d04ddd28c784a0b30c6629feeface10804d5d591`. Release API confirms exactly seven uploaded assets and exact SHA256 digests. Reports ZIP SHA256 `54d382b74aabd02ceba0fcb62a0489ba9f93f95932657a75f8ecc1652f0428d5`. `OCLP7_D97AH_GITHUB_BUILD_AND_RELEASE_DELIVERY=PASS`.

Signing/notarization remains unverified and is not classified PASS.

## CURRENT ACTION
ASUS2 STOP. Live installed app remains exact D97AG. Do not deploy, Root Patch or reboot.

Run one bounded ASUS2-only audit of the exact private release: verify release ID/tag/head and all seven asset hashes/sizes, download them, verify manifests/checksum sets, reassemble exact v5 app ZIP `751494634` / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`, verify ZIP integrity and exact packaged x86_64 executable `6596544` / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, audit reports ZIP and compare carried executable byte identity, then retain verified ZIP on Desktop and STOP.

Only after ASUS2 audit PASS may a separate D97AG->D97AH backup/deploy/open/STOP action be authorized. Root Patch and reboot remain unauthorized.