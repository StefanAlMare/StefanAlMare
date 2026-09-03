# OCLP7 CHECKPOINT — D97AH GITHUB BUILD/PRIVATE RELEASE PASS; ASUS2 AUDIT NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_LOCAL_SOURCE_PASS_GITHUB_BUILD_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 remain retained with runtime sufficiency NEGATIVE. Golden Sequoia remains immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine/small tests, runtime checks, artifact/reassembly checks and live-state evidence remain ASUS2-only. GitHub is reserved for major/substantial compilation/build/package work. Never auto Root Patch or reboot.

## D97AH exact source correction carried forward
D97AH changes only the two exact `/bin/chflags` string tokens inside `patch_mtl_compiler_tahoe_d97af_lc_uuid_build_stamp` to `/usr/bin/chflags`.

Exact local source identities:

```text
HELPERS_SHA256=6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c
D97AH_METHOD_SHA256=fea34f69735ac244a064b55b58e4b95a6972e270f282d6d4f4d1fbecefd0503a
D97AH_PATCH_SHA256=66c536cb069d6eb04184294c79fce4b720f0d7d603b99c083969bed8776ee59c
D97AH_PATCH_BYTES=1005
SYSPATCH_SHA256=93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69
METAL_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
```

ASUS2 has already proved `/bin/chflags` absent and `/usr/bin/chflags` present/executable universal x86_64+arm64e. The D97AG xattr backend is already real-Root-Patch PROVEN; the D97AG fatal boundary is already PROVEN working. Reboot remains unauthorized.

## D97AH major build audit evolution
The first major D97AH workflow reconstructed and applied the exact source transition and completed the PyInstaller build successfully, but its post-build auditor incorrectly required two copies of `/usr/bin/chflags` in the method constant pool. Python deduplicated the identical string constant, so constant-pool count was one although the method has two uses. Module source/packaged fingerprints were already identical. Classification: `BUILD_SUCCEEDED_POST_BUILD_AUDITOR_FALSE_FAILURE_CONSTANT_POOL_DEDUP`; no delivery occurred.

A v2 audit-replay workflow was rejected by GitHub YAML parsing before any job/build; classification `CI_WRAPPER_PARSE_FALSE_FAILURE_ZERO_BUILD`.

The corrected v3 packaged auditor proved the appropriate distinction:

```text
PACKAGED_CONSTANT_POOL_/bin/chflags=0
PACKAGED_CONSTANT_POOL_/usr/bin/chflags=1
PACKAGED_LOAD_CONST_/bin/chflags=0
PACKAGED_LOAD_CONST_/usr/bin/chflags=2
D97AH_PACKAGED_CHFLAGS_CONSTANT_POOL_DEDUP_AUDIT=PASS
```

v3 rebuilt and audited the application successfully, but Actions artifact upload failed after the build because repository Actions artifact storage quota was full. Classification: `BUILD_PACKAGE_AUDIT=PASS`, `ACTIONS_ARTIFACT_DELIVERY=INFRA_STORAGE_QUOTA_FAILURE`. No build/source semantic failure occurred.

A v4 release workflow contained a delivery pin to a previous run's app ZIP identity and is non-authoritative; no state depends on it.

## Authoritative D97AH v5 major Intel build PASS
Authoritative workflow/run/job:

```text
PRIVATE_REPOSITORY=StefanAlMare/Private-Work
BUILD_BRANCH=oclp7-d97ah-github-build
HEAD_SHA=d04ddd28c784a0b30c6629feeface10804d5d591
WORKFLOW_PATH=.github/workflows/oclp7-d97ah-build-v5-release.yml
WORKFLOW_ID=349436422
RUN_ID=33769927671
RUN_ATTEMPT=1
JOB_ID=100697248264
RUNNER=macos-15-intel / x86_64
RUN_STATUS=completed
RUN_CONCLUSION=success
```

All 15 reported job steps completed `success`. v5 replays the exact v3 reconstruction/build/audit pipeline, then binds all delivery identities to the bytes produced in the same v5 run and uses a private GitHub Release rather than Actions artifact storage.

Exact source/package evidence repeated PASS:

```text
D97AH_GENERATED_PATCH_SHA256=66c536cb069d6eb04184294c79fce4b720f0d7d603b99c083969bed8776ee59c
D97AH_GENERATED_PATCH_BYTES=1005
HELPERS_SHA256=6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c
SYSPATCH_SHA256=93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69
METAL_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
D97AH_METHOD_SHA256=fea34f69735ac244a064b55b58e4b95a6972e270f282d6d4f4d1fbecefd0503a
D97AD_METHOD_SHA256=bb66b1d5d883251431d5a7fa7bc42c0cc9bcb15ec77c74506bb2eae5bf987a12
D97AG_XATTR_BACKEND_SOURCE_SHA256=d02e98be14d1881202565560198a9eb5b3ec3200057db98c4b0820454dab2019
```

Source and packaged module fingerprints are identical:

```text
helpers=8112fec67f5d6928fa960ef25db80c6290499cc2e0acbd4c9d1fff7ce07dc322
syspatch=8b754ef5f118b8e902e89ec32ed4717bad18bebfef5e4b38c7f33c76afe69571
metal=0c3994d77d3396fc00967a155a1d70fea9d4337c2a865bbc05abfd05d80a54bf
```

Packaged method audit proves constant-pool old/new `0/1` and actual `LOAD_CONST` old/new `0/2`; xattr backend and fatal boundary remain unchanged. Signing/notarization was not validated and is not classified PASS.

## Exact v5 packaged application identities

```text
D97AH_APP_ZIP_BYTES=751494634
D97AH_APP_ZIP_SHA256=d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48
D97AH_PACKAGED_EXE_BYTES=6596544
D97AH_PACKAGED_EXE_SHA256=207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf
D97AH_PACKAGED_ARCH=x86_64
```

Split/reassembly within the build passed exactly:

```text
PART00_NAME=OCLP7-D97AH-OpenCore-Patcher.app.zip.part-00
PART00_BYTES=390000000
PART00_SHA256=bca0943a2ca8f3ce219cdf2dc28306cab4aa20c9ec1b49c20658c006d502faa5
PART01_NAME=OCLP7-D97AH-OpenCore-Patcher.app.zip.part-01
PART01_BYTES=361494634
PART01_SHA256=8eb51af7b095b96d9755f8dfa8ba8e20d045038fbe76524d8b51370b2687df7e
```

## Private release delivery PASS
Because Actions artifact storage quota was full, v5 used a private GitHub Release tied to the exact same-run head. Release API independently confirms:

```text
RELEASE_ID=382116519
RELEASE_TAG=oclp7-d97ah-run-33769927671-attempt-1
RELEASE_TARGET_HEAD=d04ddd28c784a0b30c6629feeface10804d5d591
DRAFT=false
PRERELEASE=false
```

Exact release assets:

```text
ASSET_ID=542931717 | OCLP7-D97AH-OpenCore-Patcher.app.zip.part-00 | BYTES=390000000 | SHA256=bca0943a2ca8f3ce219cdf2dc28306cab4aa20c9ec1b49c20658c006d502faa5
ASSET_ID=542931727 | OCLP7-D97AH-OpenCore-Patcher.app.zip.part-01 | BYTES=361494634 | SHA256=8eb51af7b095b96d9755f8dfa8ba8e20d045038fbe76524d8b51370b2687df7e
ASSET_ID=542931721 | D97AH_SPLIT_MANIFEST.env | BYTES=829 | SHA256=2997451ebf1a1b16e7425e897c06e03c9b8dc81d2080e2e247e61a7903518ddd
ASSET_ID=542931718 | PARTS.SHA256 | BYTES=222 | SHA256=ec7dfa09ad14a7c6e9f8c79d9cc8e630a5ff16b9b1c128b6090b61d0b4cb5799
ASSET_ID=542931720 | OCLP7-D97AH-REPORTS.zip | BYTES=6515462 | SHA256=54d382b74aabd02ceba0fcb62a0489ba9f93f95932657a75f8ecc1652f0428d5
ASSET_ID=542931733 | OCLP7_D97AH_RELEASE_ASSET_IDENTITY.txt | BYTES=776 | SHA256=3a5b6cca6e01c4c8b8fa6c084b223ae277737d74c38a89a7053502f4c23f8114
ASSET_ID=542931734 | RELEASE-ASSETS.SHA256 | BYTES=587 | SHA256=92307b80c3fdb1063bb212a5a1b780e8cebe74b3ec69b0dd106b617ec99ae61f
```

GitHub reports all seven assets in state `uploaded`; v5 audited exact asset set/cardinality, size and SHA256 digest where supplied. `OCLP7_D97AH_GITHUB_BUILD_AND_RELEASE_DELIVERY=PASS`.

## ASUS2 private-release audit attempt 1 — tooling false failure at cmp
ASUS2 ran the exact public wrapper commit `d926fbb736198409931e6bee13aeb3da896dcd73`, blob `7f11298c46a43c15d2ac1a77d80fd05d4e1e2f08`; wrapper SHA256 `3dd4d4a71be5e2bb4ca6003d035e1c3f5b7851959e9c1e6c62f41bea3c2a1ecf`, bytes `19937`, local zsh parse PASS.

Before the failure, ASUS2 proved all of the following PASS:
- exact private release API binding, release ID/head, and seven-asset set;
- exact downloaded asset bytes/SHA256 for all seven assets;
- `RELEASE-ASSETS.SHA256`, `PARTS.SHA256`, and split manifest consistency;
- exact reassembled ZIP bytes `751494634` / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`, ZIP CRC and safe-member audit;
- exact packaged executable bytes `6596544` / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf` / x86_64;
- reports ZIP safe-member audit, exact report file set and `REPORTS.SHA256` checksum set.

The wrapper then emitted `/bin/cmp: no such file or directory` at the intended report-executable versus app-executable byte comparison. Source inspection proves the wrapper had already independently required the carried report executable to match the exact expected bytes and SHA256, then executed literal `/bin/cmp -s "$REPORT_EXE" "$APP_EXE"`. Because the executable `/bin/cmp` itself could not be launched, the generic failure label `REPORT_AND_APP_EXECUTABLE_DIFFER` does NOT prove a byte difference. Classification: `D97AH_ASUS2_AUDIT_ATTEMPT1=TOOLING_FALSE_FAILURE_CMP_ABSOLUTE_PATH_NO_MUTATION`.

No verified ZIP was retained by that incomplete run. No source, `/Applications`, system target, Golden, Root Patch, snapshot or reboot mutation occurred.

## Mutation ledger

```text
ASUS2_SOURCE_MUTATION=ALREADY_D97AH_EXACT_ONE_FILE
ASUS2_INSTALLED_APP_MUTATION=NO_NEW_MUTATION_DURING_BUILD_OR_AUDIT_ATTEMPT1
LIVE_APP_REMAINS=D97AG_EXACT
SYSTEM_TARGET_MUTATION=NO_NEW_MUTATION
GOLDEN_MUTATION=NO
ROOT_PATCH=AUTO-NO
REBOOT=AUTO-NO
```

The live installed app remains D97AG executable SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`. Do not run Root Patch from it again.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Do not deploy, Root Patch or reboot.

Run one bounded read-only ASUS2 capability/path probe for `cmp` only. Prove whether `/bin/cmp` exists, whether `/usr/bin/cmp` exists and is executable, and the shell resolution from `command -v`, `whence -a`, `type -a`, and `/usr/bin/which -a` when available. No source, application, system, Golden, Root Patch or reboot mutation.

If and only if ASUS2 proves a valid executable `cmp` at a different absolute path, correct only the ASUS2 audit wrapper's `cmp` tool path in a new public wrapper identity, then rerun the complete private-release artifact audit from the beginning. Do not infer complete audit PASS from matching SHA256 alone; preserve the explicit byte-comparison gate.

Only after a complete ASUS2 release/reassembly audit is returned and accepted may a separate backup/deploy/open-OCLP/STOP action be authorized.