# OCLP7 CHECKPOINT — D97AEX GITHUB BUILD + DOWNLOADED ARTIFACT AUDIT PASS / WRAPPER NEXT

Date: 2026-09-02 EEST  
Status: authoritative continuation checkpoint  
Previous authority: `OCLP7_CHECKPOINT_20260902_D97AEW_PHYSICAL_READ_VALID_D5CE_RUNTIME_TEXT_NEXT.md`

## Immutable project state

- Functional baseline remains exactly `P1+P2b+P3+AIR00+D34`.
- True-five SHA remains `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
- Golden Sequoia remains immutable/read-only.
- D50/D68/D82 remain reserve-only; D84 retired; Patch8 unauthorized.
- GitHub-first remains mandatory: the assistant performs all validation, integration, compilation, packaging, application/artifact audit, SHA/provenance and publication work possible in GitHub. The user performs only identity-pinned ASUS2-only proof/deploy operations.
- No automatic Root Patch or reboot.

## Accepted D97AEW/D5CE starting fact

D97AEW's physical reads from the Tahoe D226 shared-cache input are valid, but D5CE filesystem offsets are not transferable across the different D226 lineage. `CACHE_PHYSICAL_BYTE_READ=VALID`, `CROSS_IMAGE_SITE_CORRELATION=NOT_ESTABLISHED`, and `D97AD_CACHE_PATCH_DISCRIMINATOR=INCONCLUSIVE` remain authoritative.

D97AES directly proves that 33/33 simulator diagnostics from 28/28 observed PIDs had immediate sender DSO 32023/D5CE, not current-cache D226. It does not prove the exact current D97AD text bytes because the P7-to-D97AD lineage preserves the same D5CE UUID. Before D97AEX, `RUNTIME_EXACT_CURRENT_D97AD_TEXT_BYTES=UNKNOWN`.

## Frozen D97AEX source and public source anchor

D97AEX is a finite, poll-sampled, universal/no-PID, read-only D5CE runtime-text provenance watcher. It does not launch or stop MTLCompilerService. It requests only Apple's private `task_read_for_pid(..., TASK_FLAVOR_READ)` path and reads with `mach_vm_read_overwrite`; it has no debugger/control-port fallback and fails closed.

Frozen source identity:

- path: `OCLP7_D97AEX_READONLY_D5CE_RUNTIME_TEXT_PROVENANCE_READER.cpp`;
- lines/bytes: `1806 / 68382`;
- git blob: `edcb086b00dd760ba67a9a4f7ccaaea1b5baae41`;
- SHA256: `04bbf5b0a6e4ba18928d45ca1e9588ddda95055d048c98550528659f7e300658`;
- public source commit: `5272206915adb71a1b08d5fe131da40a799b3943`;
- public source tree: `965aa1f4433a66c72d7d0981d42d8703fbe218c6`.

Exact site manifest:

- path: `OCLP7_D97AEX_SITE_MANIFEST.json`;
- git blob: `52f7713708105a50481f7c6a532d1380cfec73cb`;
- SHA256: `42a61970a03a4f66e37028182c5fb72b1aa4b37b8f931657b7050c78ec184007`;
- bytes: `5928`;
- exactly 31 non-overlapping windows / 330 bytes per pass / 660 bytes double-read;
- 23 patch windows / 202 bytes and 8 invariant windows / 128 bytes;
- the patch set includes six D97AD terminal sites, the 33-byte shared stub and all 16 specified retained D34/AIR00/P6/P7 windows; invariants include six late-frontier windows plus both historical sender-PC far-frontier windows.

Three independent frozen-source audits passed with zero blockers: exact byte manifest/classifier/self-test, general source review, and API/race/read-only safety review. The method explicitly limits conclusions to the observed poll-sampled cohort and never claims global spawn coverage, full-image SHA, or branch execution.

## Private GitHub build provenance

Private GitHub build input:

- repository: `StefanAlMare/Private-Work`;
- branch: `oclp7-d97aex-github-build`;
- private commit: `222fc2c79de2dab46101aaa47591d613dcd96896`;
- private tree: `b091529a4d60572ad798d77fbb5892aea40be43d`;
- workflow blob/SHA256: `dff2b6223b7ac75079f0402d501e938aa5167cb9` / `ff5df1df5b82a3cfcc33c3e4a2002f78f82a1fcdea2d203fc80884c36d85b232`;
- identity-manifest blob/SHA256: `27de5f1c8321fac5a7d724e6b2471968d9fa7e95` / `1f52bb082b74f229ff966a4cd5ef519f7fbfcde6a4fb7f2bc322e29f4472986e`.

GitHub Actions result:

- run ID `33612947825`;
- job ID `100192139189`;
- exact head `222fc2c79de2dab46101aaa47591d613dcd96896`;
- conclusion `success`;
- runner `macos-15-intel`, Xcode `16.4`, Apple clang `17.0.0`, SDK `15.5`, deployment target `15.0`;
- compilation `C++17 -O2 -Wall -Wextra -Werror -arch x86_64 -lbsm`: PASS;
- exact source/site/public-anchor identity: PASS;
- architecture, load-command/import and `LC_BUILD_VERSION` audits: PASS;
- required `task_read_for_pid` and `mach_vm_read_overwrite` imports: PASS;
- forbidden mutation/control imports: empty;
- ad-hoc signature, no Team ID and no entitlements: PASS;
- exact six-marker self-test RC `0`: PASS;
- production scan: `NOT_RUN`.

## Downloaded artifact audit

GitHub artifact:

- artifact ID `9839742433`;
- name `OCLP7-D97AEX-runtime-text-provenance-helper`;
- outer ZIP bytes/SHA256: `94141` / `e4604aeba99e1860cb36f76aabf1a37b6472aabf1c27057ea905937c0b42f322`;
- exact six unique regular outer files, no path traversal, duplicate, link or special entry;
- inner tar bytes/SHA256: `71969` / `47de50185a65b11a4a54982f84ba8124abd1a352dce1f62c46980d13c51a6a1e`;
- inner tar: 28 unique entries under one expected root, 23 regular files + 5 directories, no unsafe entry;
- all 22 inner payload checksums pass with no missing or unlisted payload.

Exact signed helper:

- bytes/mode: `94928 / 0755`;
- git blob: `528fd75bea3c9ed262daebf55142902a3795fcb8`;
- SHA256: `bb0ed72910d7ef379276303463af9676b1a712e2f1f755e126234cada43eee1f`;
- Mach-O: thin x86_64 executable, minimum macOS `15.0`, SDK `15.5`;
- signed Mach-O UUID: `67A1590A-91F7-3581-8E2A-42B13E88642C`;
- ad-hoc CodeDirectory: all 19 SHA256 code-page hashes independently recomputed PASS, no entitlement slot;
- exact 88 normalized undefined imports match the CI report; required read APIs present and forbidden mutation/control intersection empty.

Three independent post-download audits passed with zero blockers: archive/inventory/identity, consolidated build-report cross-check, and independent signed Mach-O/CodeDirectory audit. The pre-sign Mach-O report has 18 load commands / 1376 bytes; the final signed binary correctly has 19 / 1392 because signing adds `LC_CODE_SIGNATURE`. The consolidated report was produced before the final package-extraction step; those final markers are PASS in the authentic GitHub log and were independently reproduced, so no claim is made that the consolidated report alone contains them.

The exact helper was published, without execution, at public commit `18880de15acde73ca366c8c0e6e8e6aa4ea3a9f0`, tree `f6806366a19f3f9da034611d04e39e4bb00e7486`, mode `100755`, blob `528fd75bea3c9ed262daebf55142902a3795fcb8`.

## Authoritative result

`D97AEX_GITHUB_SOURCE_STATIC_AUDIT=PASS`  
`D97AEX_GITHUB_COMPILE_LINK_MACHO_CODESIGN_SELFTEST=PASS`  
`D97AEX_GITHUB_PRODUCTION_SCAN=NOT_RUN`  
`D97AEX_DOWNLOADED_ARTIFACT_IDENTITY_AUDIT=PASS`  
`D97AEX_PUBLIC_BINARY_IDENTITY=PASS`  
`D97AEX_LIVE_TASK_READ_AUTHORIZATION=UNKNOWN`  
`D97AEX_LIVE_RUNTIME_TEXT_RESULT=NOT_RUN`

The GitHub-capable lane is complete through binary publication. The only remaining capability unknown is whether Tahoe on ASUS2 grants the private read-only task port to this exact ad-hoc helper under `sudo`. A denial is a decisive blocker and must produce STOP; it does not authorize LLDB, debugger/control-port fallback, SIP/AMFI changes, Root Patch or reboot.

## ACTIVE FRONTIER / CURRENT NEXT ACTION

The assistant must now design and audit the exact pinned D97AEX wrapper in GitHub. The wrapper must:

1. fetch only public binary commit `18880de15acde73ca366c8c0e6e8e6aa4ea3a9f0` and verify blob `528fd75bea3c9ed262daebf55142902a3795fcb8`, SHA256 `bb0ed72910d7ef379276303463af9676b1a712e2f1f755e126234cada43eee1f`, bytes `94928` and executable mode;
2. verify exact service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` and visible target SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755` before and after the watch;
3. run the helper self-test and then the default finite natural-instance watcher (`120 s / 25 ms / minimum 3 complete`) without launching MTLCompilerService;
4. preserve helper RC semantics: `0` bounded observed-cohort match, `2` fail-closed blocker, `3` incomplete coverage STOP, `4` bounded observed-cohort mismatch;
5. add a retrospective, read-only Unified Log visible-cohort/PID census, explicitly scoped as `LOG_VISIBLE` and explicitly retaining `GLOBAL_SPAWN_COHORT_COVERAGE=UNKNOWN`; log unavailability must remain UNKNOWN, not be converted into a false complete cohort;
6. verify helper/service/target identities again after execution, emit one complete report, and contain no automatic service launch, source/system/Golden mutation, Root Patch or reboot.

The wrapper and its scanner/identity/RC/log-census contract must pass GitHub CI and downloaded-artifact audit before publication. Only after that may the user receive one minimal wrapper-identity-pinned ASUS2 command.

No user action is currently authorized. No Root Patch or reboot is authorized. Golden remains read-only.
