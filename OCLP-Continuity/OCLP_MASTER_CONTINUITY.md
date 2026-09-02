# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260902_D97AEX_PREWATCH_MIXED_SIZE_PROVENANCE_FALSE_NEGATIVE_D97AEY_GITHUB_REPAIR_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
Updated: 2026-09-02 EEST

## Mandatory startup
Before any technical change read in full:
1. `OCLP_PERMANENT_WORKING_RULES.md`;
2. this MASTER;
3. `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. the exact checkpoint named above;
5. `OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP_HISTORY_INDEX.md`.

## Permanent contract
Target Tahoe `26.6.2 / 25G82`, Haswell HD4600/4400 family, SMBIOS `MacBookAir6,2`. Local OCLP branch `alex-tahoe-25G82-custom`, expected HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`. Golden root-patched MTLCompiler SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`, immutable/read-only. True-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.

Protocol is permanently GitHub-first. The assistant executes in GitHub everything technically possible there, including validation, source/workflow integration, compile/diff, build/package, packaged-app audit, SHA/manifest work, artifact publication and complete CI audit. The user is never asked to compile/build/package locally and runs only identity-pinned actions that inherently require live ASUS2 state: local cache/file/log/hardware evidence, exact installed-state proof, privileged backup/deploy, opening OCLP, manual Root Patch, accelerated boot and VESA recovery. Never auto Root Patch or reboot. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized.

Interaction chain: `assistant GitHub lane -> assistant full audit/persist -> minimal ASUS2-only lane when required -> assistant audit -> manual Root Patch only if authorized -> assistant audit -> accelerated boot -> VESA recovery -> selected accelerated-boot analysis -> persist`.

Architecture: `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working donor path -> image`.

## Accepted functional lineage
P1 selector -> P2b request layout -> P3 serialized bitcode -> AIR00 AIR2.6/Metal3.1 -> D34 semantic-equivalent reset. P6/P7 retained with runtime sufficiency NEGATIVE.

## Durable D97 facts
D97AA proved runtime 32023 selection for an earlier cohort. D97AC statically mapped finite outcomes in `validSimulatorMetadata`. D97AD exact transition produced selector-only service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` and final MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`.

Private D97AD build/deploy and manual Root Patch passed exactly. Selected accelerated boot is `2026-09-02 00:10`; VESA recovery `00:12` excluded.

D97AEQ verified exact visible D97AD bytes but found 28/28 service PIDs terminating normally with `exit(1)`, zero signals/missing and zero classifier exits 110–114. Runtime outcome classification is INVALID; natural exit1 is RUNTIME PROVEN 28/28.

D97AER proved the visible 32023 late simulator-limit xrefs lie after the visible D97AD candidate terminal REL+`0x58B`.

D97AES proved all 33 simulator diagnostics across all 28 PIDs were sent by MTLCompiler path `Versions/32023/MTLCompiler` with UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`; 3802 is NEGATIVE for the cohort.

D97AET found only historical sender/backtrace offsets `0x9FFEE` and `0xA5F81`, both outside the validator, so archived backtrace does not directly prove traversal beyond the visible terminal. It also proved the x86_64h Cryptex dyld shared cache contains the 32023 image path and not the 3802 path. Cache execution remains UNKNOWN.

Candidate discriminator at image offset `0x9D6BD`: P7/pre-D97AD `8b8d10feffff83f941`; D97AD `6a6e5fe9bb38f6ff90`.

## D97AEU tooling failure / cache topology
D97AEU discovered main x86_64h cache plus `.01`–`.06` subcaches. Each parseable subcache replicates the same `imagesText` table. The target 32023 path appeared seven times with identical logical identity: cache-table UUID `D2265480-60EB-3526-BAF7-2D6596149186`, load `0x7FFD03141000`, text size `0xCE239`, same path. The load address lies in the `.05` executable mapping.

D97AEU stopped at raw-hit cardinality `7` before reading any discriminator bytes. This is TOOLING FALSE FAILURE; no byte conclusion is permitted from that run.

## D97AEW corrected cache interpretation
D97AEW, D97AEV and the corrected D97AEU core completed with internal RC `0`. Wrapper/blob/SHA, scanner-only correction, all three D97AEV transforms, retained anchors, zsh parsing and embedded Python compilation passed exactly.

The seven replicated `imagesText` records deduplicate to one cached 32023 image: UUID `D2265480-60EB-3526-BAF7-2D6596149186`, load `0x7FFD03141000`, text size `0xCE239`, executable bytes in subcache `.05`. The physical `.05` address-to-file translation and byte reads are valid.

Apple dyld copies `imagesText.uuid` from the selected input Mach-O slice and preserves that slice's `LC_UUID`; D226 is therefore `CACHE_INPUT_SLICE_UUID`, not a cache-optimization UUID derived from D5CE. Direct transplantation of D5CE filesystem offsets into D226 is cross-lineage and unsupported. Consequently the observed `PRE=0|POST=0|OTHER=6`, OTHER stub, retained `0/16` and differing sender windows are valid physical reads at those numerical D226 offsets, but are not semantic classifications of the corresponding D226 functions. Authoritative status: `CACHE_PHYSICAL_BYTE_READ=VALID`, `CROSS_IMAGE_SITE_CORRELATION=NOT_ESTABLISHED`, `D97AD_CACHE_PATCH_DISCRIMINATOR=INCONCLUSIVE`.

The official OCLP 1.3.0 -> PatcherSupportPkg 1.4.6 donor is 14.2 Beta 1 MTLCompiler 32023 with exact UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`. The public dsce implementations bracketing internal version 8 mark only the first four UUID bytes as `D5 CE 00 <version>` and preserve the final twelve; the exact internal v8 source is not public. Exact 2023 release provenance independently establishes that this donor is not the current Tahoe D226 input, while the different retained UUID tails corroborate the separate lineage under the documented algorithm.

D97AES runtime evidence is now classified precisely: all 33 simulator diagnostics across 28/28 PIDs identify the immediate sender DSO as 32023/D5CE. Apple logging obtains the sender UUID from the loaded sender Mach-O header, and dsce created D5CE specifically for log visibility. Therefore `RUNTIME_DIAGNOSTIC_SENDER_D5CE_DSCE_32023=PROVEN` and `RUNTIME_DIAGNOSTIC_SENDER_CURRENT_D226_CACHE=NEGATIVE` for that diagnostic cohort. This does not exclude D226 elsewhere in those processes and does not prove the exact current D97AD SHA/postimage bytes in memory, because the known P7-to-D97AD transform lineage preserves the same D5CE LC_UUID. `RUNTIME_EXACT_CURRENT_D97AD_TEXT_BYTES=UNKNOWN`.

No source/system/Golden/service/Root Patch/reboot mutation occurred. The previous semantic-D226 mapper frontier is superseded and moved to reserve-only static cross-build research.

## D97AEX GitHub helper build and artifact audit
The frozen universal/no-PID read-only watcher source is public commit `5272206915adb71a1b08d5fe131da40a799b3943`, blob `edcb086b00dd760ba67a9a4f7ccaaea1b5baae41`, SHA256 `04bbf5b0a6e4ba18928d45ca1e9588ddda95055d048c98550528659f7e300658`. Its exact manifest has 31 non-overlapping windows / 330 bytes per pass: 23 patch windows / 202 bytes and 8 late/far invariants / 128 bytes. Three independent source audits passed with zero blockers.

Private GitHub run `33612947825`, job `100192139189`, exact head `222fc2c79de2dab46101aaa47591d613dcd96896` completed `success` on `macos-15-intel`. Compile/link, exact source/manifest/public-anchor identity, x86_64 Mach-O, imports, minimum macOS 15.0 / SDK 15.5, ad-hoc no-entitlement signature, exact six-marker self-test and package audit all passed. Production scan was not run.

Downloaded artifact `9839742433` is exact: ZIP 94141 bytes / SHA256 `e4604aeba99e1860cb36f76aabf1a37b6472aabf1c27057ea905937c0b42f322`; inner tar SHA256 `47de50185a65b11a4a54982f84ba8124abd1a352dce1f62c46980d13c51a6a1e`; all 22 inner payload checksums pass. Three independent post-download audits found zero blockers. The exact signed helper is 94928 bytes, mode 0755, blob `528fd75bea3c9ed262daebf55142902a3795fcb8`, SHA256 `bb0ed72910d7ef379276303463af9676b1a712e2f1f755e126234cada43eee1f`, published without execution at commit `18880de15acde73ca366c8c0e6e8e6aa4ea3a9f0`.

`D97AEX_GITHUB_SOURCE_STATIC_AUDIT=PASS`, `D97AEX_GITHUB_COMPILE_LINK_MACHO_CODESIGN_SELFTEST=PASS`, `D97AEX_DOWNLOADED_ARTIFACT_IDENTITY_AUDIT=PASS`, `D97AEX_PUBLIC_BINARY_IDENTITY=PASS`. Live production execution remains `NOT_RUN`; Tahoe authorization of the private read-only task port remains `UNKNOWN`.

## D97AEX pinned-wrapper GitHub audit and public identity
The frozen wrapper is 886 lines / 40522 bytes, blob `5e0cbe4e0041537666d1655fba32161d756e4df7`, SHA256 `98361e388c40556565b00c11283ed3600386acc996b8e1a7e06ae8169075fd37`. Exact `zsh -f -n`, static/RC/threat/census audits and all positive/adversarial fixtures passed with zero blockers.

Private final audit commit `c912f21980a2aa5bc9b14f7d634fc7e07a063c90`, tree `b9f3fdf1bff541ee52c4aced05e55599c8584b81`, produced successful run `33620774640`, job `100217036670`. The two earlier fail-closed iterations only corrected an unproven Unified Log trailer assumption: run `33620220763` rejected it, and diagnostic run `33620376174` proved the actual macOS trailer `{"count":0,"finished":1}`. No production watcher ran in any CI iteration.

Downloaded artifact `9842808563` is exact: ZIP 64888 bytes / SHA256 `08b91fc6528696e90aad51f7b3cc76e4a8a659dc826e20bf78b03c9c8908c32a`; 20 safe unique entries, CRC PASS, 18/18 payload SHA256 and 18/18 Git blobs PASS. The wrapper, identity manifest, auditor and workflow are byte-identical to the frozen inputs. All consolidated/static/syntax/helper/log/fixture reports pass. Helper execution was self-test only; wrapper execution, production watch, sudo and service launch were not run.

The exact wrapper is public at immutable merge commit `da979b5938a8a52bba4e976b5606ccf5c1d951aa`, publication tree `84af62761a14a171253262f6538f7ede31d4cb0a`, path `OCLP7_D97AEX_PINNED_WRAPPER.command`, mode `100755`, blob `5e0cbe4e0041537666d1655fba32161d756e4df7`. Public content identity matches the frozen SHA256/bytes. `D97AEX_PINNED_WRAPPER_GITHUB_AUDIT=PASS`, `D97AEX_PINNED_WRAPPER_DOWNLOADED_ARTIFACT_AUDIT=PASS`, `D97AEX_PINNED_WRAPPER_PUBLIC_IDENTITY=PASS`, `D97AEX_PRODUCTION_EXECUTION=NOT_RUN`.

## D97AEX first ASUS2 execution — pre-watch mixed-provenance size false negative
The exact public wrapper at commit `da979b5938a8a52bba4e976b5606ccf5c1d951aa`, blob `5e0cbe4e0041537666d1655fba32161d756e4df7`, SHA256 `98361e388c40556565b00c11283ed3600386acc996b8e1a7e06ae8169075fd37`, 40522 bytes, passed its outer identity gate and ran once on ASUS2.

Tahoe `26.6.2 / 25G82 / x86_64`, helper download/blob/SHA/bytes/mode, codesign, exact six-line self-test, sudo credential validation, pre-watch helper identity and selector-only service identity all passed. The target was a stable regular nlink-1 file across stat/hash/stat with size `1636896` and exact authoritative D97AD SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`, but wrapper constant `TARGET_BYTES_EXPECTED=1636864` caused `PRE_WATCH_TARGET_IDENTITY=FAIL|REASON=BYTE_COUNT_MISMATCH`, fail-closed RC `2`.

`1636864` is the exact size of the unmodified PSP donor with different SHA256 `4f65fb8890a5b18a222c9b0171b6c8240672fb48334fb7739892b7591ffc5641`; the pin combined donor size with final transformed D97AD SHA. The helper source independently contains the same mixed-provenance `kExpectedTargetFileSize=1636864`, so wrapper-only repair would still fail before polling. Classification: `D97AEX_PREWATCH_IDENTITY_CONTRACT_MIXED_PROVENANCE=TOOLING_FALSE_NEGATIVE`; target drift/corruption is not supported; runtime text result remains `NOT_RUN/UNKNOWN`.

The returned Desktop report is 96 lines / 5389 bytes, blob `dab425a8e09b88308e90f88e3d124a4cd31ef112`, SHA256 `39a4febf181d35437016a69ee7c4fc50a1ae339dd29670aebf3d35dc78d3510b`. Production helper execution, task-read attachment, watcher, temporal gate, log census and post-watch gates were not reached. Helper execution was self-test only. No service launch/stop, source/system/Golden/target-code/process-control mutation, Root Patch or reboot occurred.

## CURRENT ACTION — assistant GitHub D97AEY size-provenance repair
The user remains at STOP. The assistant must repair in GitHub the complete end-to-end identity contract, not bypass it: set the final D97AD target size to exact `1636896` in the helper source, source/site manifest, helper build workflow/provenance audit, pinned wrapper, wrapper identity manifest, static auditor and wrapper workflow/fixtures while retaining exact target SHA256 `524a16...a755`, regular-file/nlink and pre/post stat/hash/stat gates.

The assistant must rebuild, sign, self-test, package and audit the corrected helper on macOS GitHub Actions; download and independently audit the artifact; publish the corrected helper immutably; repin and fully re-audit the corrected wrapper in GitHub; download/audit its artifact; publish the corrected wrapper immutably; then persist the new identities before any fresh ASUS2 command.

No user action is currently authorized. No local compilation, OCLP opening, Root Patch or reboot is authorized. Baseline remains P1+P2b+P3+AIR00+D34; Golden immutable/read-only; D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized.
