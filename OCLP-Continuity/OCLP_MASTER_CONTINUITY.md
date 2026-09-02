# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260902_D97AEZ_FIRST_ACTIVATION_PRINT_DISABLED_ENABLED_FALSE_NEGATIVE.md`
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

Protocol is permanently GitHub-first. The assistant executes in GitHub everything technically possible there, including validation, source/workflow integration, compile/diff, build/package, packaged-app audit, SHA/manifest work, artifact publication and complete CI audit. The user is never asked to compile/build/package locally and runs only identity-pinned actions that inherently require live ASUS2 state: local cache/file/log/hardware evidence, exact installed-state proof, privileged backup/deploy, opening OCLP, manual Root Patch, accelerated boot and VESA recovery. ASUS2 is Intel Haswell `x86_64`, never ARM; observer setup is called activation/deploy, while literal `arm64` is allowed only as a negative non-x86_64 CI fixture. Never auto Root Patch or reboot. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized.

Accelerated diagnostics permanently use the gated hardware-feedback FASTLANE in rule 12B: GitHub must exercise every implementation path it can simulate before one complete pinned ASUS2 action is issued; ASUS2 alone performs live activation/deploy, any actually required manual Root Patch, the no-image accelerated boot, bounded wait, manual hard reset/VESA recovery and pinned evidence retrieval. The user never combines fragments or repeats a foreground VESA surrogate for an earlier accelerated cohort.

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

## D97AEY complete GitHub correction, artifact audits and public identities
The mixed-provenance size contract was corrected without loosening any gate: helper source and site manifest changed only final-target size `1636864 -> 1636896`; helper workflow changed only its two matching assertions. Target SHA256 remains exactly `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. Source/publication merge commit is `761c0cb98c7fa8791d0cb9698a0ce6833620f0eb`: source blob `6250bebcbe5fe3177f98eeba46cbfd523155b206`, SHA256 `009ca0c749f2921ef6c0a0bf089ff11eab24c6e0ffc6af34d2b845523a8c8c16`, 68382 bytes; site blob `3743965fb9e3565f63acb4877264da99d1b5c854`, SHA256 `7db43b482fe34a8bbca622927a7f5801af6227589bac592f6363310941add341`, 5928 bytes.

Corrected-helper private commit/tree `47e12a69ac5212978c1768acd3699f904dc4238b` / `ebacd2075b83ee95c3d4b09e3d0e8b7ce0fdf813` produced successful macOS Intel run `33632008783`, job `100253487864`. All compile/link, source/site/public provenance, 31-window contract, universal/no-PID boundary, Mach-O/import/minimum-OS, ad-hoc codesign/no-entitlement, exact six-marker self-test and packaging steps passed. Production scan was not run. Downloaded artifact `9847219598` is exact: ZIP 94170 bytes, SHA256 `611e38dc05ced8ad00ed97f8849b10139bf9b386df147fe3427ba7b3f7702348`; safe six-file outer ZIP, safe 28-entry inner tar, and all 22 payload checksums passed independent audits.

The corrected signed helper is 94928 bytes, x86_64, UUID `CF378D7F-333C-3603-86BD-E2C5FAAFCEDF`, mode `100755`, blob `9f22460e8c1e51a2ae091eb7377e958f6a148e35`, SHA256 `f55b79d498e52a63b5d7c6cdbfde8b7a4c109e14158c7fe1b8c47e2883a85dc9`; public immutable merge commit/tree `4f46e3c97d5cbd89cf77efd5a6a0044aefab52a7` / `0e3a97a5abe4a81eb32848274f06190ad77418f8`.

The wrapper changed only helper commit/tree/blob/SHA pins and final target bytes; helper bytes remain 94928. Corrected-wrapper private commit/tree `1e5fd2e730543df382ff1fe117d315c0aef25560` / `995081d0489187738aacd8f11bf54ce68754c7bb` produced successful macOS X64 run `33633032040`, job `100256947822`. Exact checkout, zsh parse/mode, supply chain, RC fixture matrix, adversarial rejection, report/log gates, public helper provenance/codesign/self-test, exact Unified Log trailer and runtime primitives all passed. Wrapper execution and production helper execution were not run. Artifact `9847598233` is exact: ZIP 64896 bytes, SHA256 `80a416e8747ddc6d0ec9f13438bf5e6552a02a93c1767d7886f0d233ed9b4587`; 20 safe unique regular entries, CRC PASS, all 18 payload SHA256 and Git-blob records PASS.

The corrected wrapper is 886 lines / 40522 bytes, mode `100755`, blob `79178583cb84a3f3f8ed6aa0e64d3c1752e17f7d`, SHA256 `65d2b3bf418af1980b37de9c653a142133f6991afab531fcc4fc15d32fc33ec0`; public immutable merge commit/tree `6fcac6e8cc96b90861ca83aad1aebb85b94ae3a5` / `583bb1f6c549fe99a55e76a65e42873d440b2125`.

The stale `1636864` value is proven to come from the PSP Git donor SHA256 `4f65fb...5641`, while live final D97AD is stable `1636896` / SHA256 `524a16...a755`. PSP CI re-signing strongly explains why Git donor size is not authoritative for the installed final donor, but the exact +32-byte operation is not claimed byte-for-byte without the release-DMG donor. Classification remains tooling false negative, now repaired end-to-end. No service launch/stop, source/system/Golden/target mutation, Root Patch or reboot occurred.

## D97AEY corrected size-contract acceptance / D97AEX foreground VESA calibration
The exact corrected public wrapper at commit `6fcac6e8cc96b90861ca83aad1aebb85b94ae3a5`, blob `79178583cb84a3f3f8ed6aa0e64d3c1752e17f7d`, SHA256 `65d2b3bf418af1980b37de9c653a142133f6991afab531fcc4fc15d32fc33ec0`, 40522 bytes, passed its outer identity gate and ran once on ASUS2. The exact corrected helper commit/tree `4f46e3c97d5cbd89cf77efd5a6a0044aefab52a7` / `0e3a97a5abe4a81eb32848274f06190ad77418f8`, blob `9f22460e8c1e51a2ae091eb7377e958f6a148e35`, SHA256 `f55b79d498e52a63b5d7c6cdbfde8b7a4c109e14158c7fe1b8c47e2883a85dc9`, 94928 bytes, passed download, identity, codesign and the exact six-marker self-test.

Tahoe `26.6.2 / 25G82 / x86_64`, selector-only service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, final D97AD target size `1636896` and SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755` all passed before the watch and remained stable after it. `PRE_WATCH_IDENTITY_GATES=PASS` closes the earlier mixed-provenance byte-count false negative end-to-end.

The helper's production mode genuinely ran in the foreground for 120 seconds at 25 ms with minimum three complete instances on stable current-online/VESA boot UUID `85583BA8-8C7A-49F7-B7A5-F4D2E5285C3F`. It completed 3696 polls and observed zero exact-path instances, zero complete D5CE captures, `MATCH=0`, `MISMATCH=0`, and no race or pending classifications. The sole valid terminal result is `D97AEX_RESULT=COVERAGE_INCOMPLETE_STOP`, helper/wrapper/outer RC `3`. Summary parsing, counter invariants, terminal contract and transcript tee all passed. This is a valid empty fail-closed foreground calibration, not a tooling failure and not a runtime match or mismatch.

The guarded Unified Log query completed and parsed exact trailer `{"count":0,"finished":1}` with zero visible records/PIDs. Its 25-byte NDJSON SHA256 is `6a105b91d25933f6c54289af691d9c991a86c63c340ca13a472b5a44aa88c346`. This corroborates only an empty log-visible window; inter-poll visibility, Unified Log completeness and global spawn-cohort coverage remain unproven.

The returned report is 227 lines / 12289 bytes, blob `619d6ce7e0e59da8243e63eca29103d4820f967b`, SHA256 `607a246b5025be220952e0d49499c83a613dd5477085407c8181569e969cc43b`. The terminal transcript is 14324 bytes, blob `0e63734f0fd5f9c4321ce01e7e201fb1b496ffa7`, SHA256 `7ada726dcfcff7c49bfa76b8f39b37a6c3e3df891584cdec29f9edadef54a8b6`. All 227 report lines appear in the transcript in exact order and value after presentation blanks and the sole TTY `Password:` line are removed; `REPORT_FINAL_IDENTITY=PASS` and outer RC `3` are exact. The later Terminal session-save warning is unrelated postlude.

No production PID was captured, so `task_read_for_pid` authorization against a live target remains NOT TESTED; runtime LC_UUID and all 31 bounded windows / 330 bytes remain unread; `COHORT_BOUNDED_31_WINDOW_BYTES_PROVEN=UNKNOWN`; exact runtime D97AD text remains UNKNOWN. No source/system/Golden/target-code/process-control mutation, target service launch/stop, Root Patch or reboot occurred.

User methodological correction is authoritative: opening Terminal and starting a passive watcher does not cause MTLCompilerService to exist. The helper expressly uses `SERVICE_LAUNCH=AUTO-NO` and can only observe a service instance created naturally by another Metal client. In the online VESA recovery lane, the run could validate the corrected identity gates and watcher mechanics, but it could not reliably overlap the natural WindowServer/MTLCompilerService cohort from the failed accelerated boot. Therefore `D97AEY_SIZE_CONTRACT_LIVE_ACCEPTANCE=PASS`, while `D97AEX_ACCELERATED_HARDWARE_CAUSAL_TEST=NOT_PERFORMED`. The foreground run must not be called an accelerated runtime proof.

## D97AEZ GitHub full PASS / frozen release
The minimal passive boot-bound observer is complete. Frozen public release content commit/tree `eba63b606f4a48f747b1605e682d4ac2a624bb40` / `3622a4bf5ab0c34e444634b40ccf0f0fe18fa71d`; wrapper payload commit/tree `b30a02fed23cdd75de880c90947f5c985571b53a` / `51b4df3c6935dbf818b5269c99a7752d71da2eba`.

Public release/continuity PR `StefanAlMare/StefanAlMare#15` is integrated at merge commit `97efe39c2ce870e28636c65c16c8a9e518aa4a7b`. Private exhaustive-audit PR `StefanAlMare/Private-Work#7` is integrated at merge commit `7804216be8d72f4105c9a4798ced71070d7706c2`.

Runner identity: blob `74ab4b67f2d2bfe2e7635b1d4025e488d59c2ad2`, SHA256 `9c2dc2060ea557dfea9ca1901b055f1242ba4e34f5ec29297e6b847997a320a4`, 36701 bytes, mode `100755`. Plist identity: blob `8ef97872d0a29c28a91c9d1818bf0c5c7492c080`, SHA256 `90c0801805319126520cc946d9f2bb4a69e95fd7a0be4a85914a1c3305ec03c5`, 1027 bytes, mode `100644`. Activation wrapper: blob `484182b44283c338213faeae46b9c8b2592df744`, SHA256 `1fe59799df1e46822dca2ffb4a0d203bd8f06cc41923fa7cfc78c29acd81c115`, 39883 bytes. Retrieval wrapper: blob `4492668f573c4ed6f4b9a3256bf9e449f273c983`, SHA256 `4e738b39fbd6dbaee95107f5caa65cbe78da8f6343698b55f20be36d963f1948`, 50220 bytes.

Private exact branch head/tree `09c937d32a13fd03242b0f6b9fdc7b5c8c6c3a66` / `cac21270170b010f8265b77aa39fd9c2658a4d2d`; PR merge-test SHA `2f577b1e5ea344d9dfec47c18723fd1e7700ef50`. Workflow ID `348570767`, run `33655550721`, job `100333075176` completed `success` on `macos-15-intel`; all 10 declared workflow steps passed, and all 11 numbered steps through artifact upload, including automatic setup, succeeded. Static/provenance, exact helper self-test, fresh x86_64 rebuild, same/next-boot state, atomic claim, duplicate/no-rerun, RC0/2/3/4, non-x86_64 negative, identity drift, contradictory/truncated, grep-error, watchdog, signal overlap, interrupted/truncated-deploy and wrapper/package gates all passed.

GitHub exposed and closed two real zsh defects before freeze: the compound `local` expansion under `set -u`, and sticky RC2 propagation from a failed grep into descriptor close under `set -e`. Final descriptor closes are the independently audited exact three-line delta `exec [34]>&- || true`; descriptors close, stderr remains available and strict sealing continues.

Downloaded artifact `9856618441` ZIP SHA256 `f7d377c7080eb709781d3e41b40803193be02fd74e02517e6d387b595d43f5e2`, inner tar SHA256 `d0ffcaf3164524013fbb6b6321288efddc83e53d9c2dc8650d34fc43faaa1969`, and nested release-wrapper tar SHA256 `dd05a77a309b6093c7045f259f6b9293ee7d3b27f3b8bacfddfcb480fcca2c11` passed downloaded CRC/path/type/hash and byte-for-byte wrapper/manifest audit. `D97AEZ_GITHUB_EXHAUSTIVE_AUDIT=PASS`; production runner, launchd system action and ASUS2 accelerated runtime were explicitly not run in GitHub.

## D97AEZ first ASUS2 activation — launchctl vocabulary false negative
The exact public activation wrapper blob `484182b44283c338213faeae46b9c8b2592df744`, SHA256 `1fe59799df1e46822dca2ffb4a0d203bd8f06cc41923fa7cfc78c29acd81c115`, 39883 bytes ran once on ASUS2. Outer wrapper identity, Tahoe `26.6.2 / 25G82 / x86_64`, pinned commit/tree and all staged runner/plist/helper identities passed. Helper codesign and exact six-marker self-test passed. Live selector-only service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` and final D97AD target SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`, 1636896 bytes, passed stable stat/hash/stat gates.

The exclusive root observer install completed with exact runner/helper/plist identities, empty launchd logs, exact 35-line deploy record SHA256 `bdd4d5fa61614a82a1760d1505a2810b66f3575fac426288173867021c57f127`, and immutable flag PASS. Current activation boot UUID remains `85583BA8-8C7A-49F7-B7A5-F4D2E5285C3F`.

After `launchctl enable`, Tahoe returned the exact enabled database line `"com.stefanalmare.oclp7.d97aez.boot-bound-one-shot" => enabled`. The wrapper incorrectly required only the older boolean spelling `=> false`, so it classified an actually enabled state as `OBSERVER_EXPLICIT_ENABLE_AUDIT_FAILED`. Classification: `D97AEZ_PRINT_DISABLED_ENABLED_VOCABULARY=TOOLING_FALSE_NEGATIVE`; no D97AD or runtime conclusion.

Fail-closed behavior worked: bootstrap was not reached, bootout reported not loaded, disable passed, activation ended RC2. The observer is not loaded and is disabled. Exact installed residue remains for identity-bound recovery; no CLAIM, DONE, helper production output or accelerated evidence was produced. No OCLP opening, Root Patch, reboot, target-process control, service launch/stop, target/Golden byte mutation occurred.

Returned transcript: 394 lines / 11259 bytes, blob `013404ddecab88a8e189536586f6837d4fb1d806`, SHA256 `4ff333dac5b22b6bfa1719a9baeaea58fd0b8b7f752a99edb4a2715a3fc27e80`.

## ACTIVE FRONTIER / CURRENT NEXT ACTION — GitHub recovery correction; user STOP
The exact unresolved hardware question remains: **during a new failed accelerated boot, do naturally spawned exact-path MTLCompilerService processes map the current D97AD 31-window postimage or different runtime text?** MATCH negates only the known bounded P7-vs-D97AD mismatch hypothesis within 31 windows of a completely captured cohort; MISMATCH moves to deployment/cache/image provenance; absent/denied/raced/wrong-boot/interrupted/incomplete evidence remains UNKNOWN.

Assistant action: build and exhaustively audit in GitHub one identity-pinned recovery activation wrapper. It must recognize only the exact fail-closed installed residue, prove current boot/deploy binding, accept only semantically enabled `launchctl print-disabled` spellings (`enabled` or boolean `false`) with exact one-line cardinality, reject disabled/true/absent/ambiguous forms, enable/bootstrap the unchanged observer, prove the same-boot skip, and stop. Fresh-install behavior and runtime payload must remain unchanged.

User action is STOP. Do not rerun the old wrapper, do not delete the installed residue, do not open OCLP, do not Root Patch and do not reboot. No ASUS2 command is authorized until the corrected GitHub lane and downloaded artifact audit pass.

Baseline remains P1+P2b+P3+AIR00+D34; Golden immutable/read-only; D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized.
