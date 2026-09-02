# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-02 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260902_D97AEX_VESA_CALIBRATION_RECLASSIFIED_HARDWARE_TEST_CONTRACT_RESET.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Permanent protocol
Permanent GitHub-first split: assistant executes all GitHub-capable validation, source/workflow integration, compile/diff, build/package, packaged-app audit, SHA/manifest, artifact publication and CI audit. User performs only identity-pinned ASUS2-dependent evidence/deploy plus manual Root Patch/boot/VESA recovery after explicit authorization. No user local compilation/build/package by default; no automatic Root Patch/reboot. Golden immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized.

## GitHub-first execution methodology
User-directed permanent methodology change on 2026-09-02: work must not be shifted to the user when it can run in GitHub. GitHub failures are repaired/rerun by the assistant. A genuine GitHub capability blocker causes STOP and must be recorded; local compilation requires explicit user override. Historical user-run full-FASTLANE wording is superseded prospectively. D97AD private GitHub Actions build/deploy provenance already proves the split model operationally. D97AEV remains the current ASUS2-only exception because its decisive input is the real machine's Cryptex dyld shared cache.

## Functional baseline
P1 -> P2b -> P3 -> AIR00 -> D34. True-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`. P6/P7 retained, runtime sufficiency NEGATIVE.

## Durable milestones
D22 AIR semantics PROVEN. D69/D70 WindowServer downstream. D71R compiler lifecycle observable. D83 upstream llvm::Module*. D93 RMP contract. D95D wrapped LLVM bitcode structural-semantic proof. D96C/D97JB late validator frontier/static CFG.

## D97 provenance / exact transition
D97AA proved runtime 32023 selection in an earlier cohort. D97AC statically mapped validator finite outcomes. D97AD exact transition produced selector-only service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` and final MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. Private build/deploy and manual Root Patch passed exactly.

## Accelerated D97AD boot
Selected boot `2026-09-02 00:10`; VESA `00:12` excluded. D97AEQ: exact visible D97AD identity PASS, 28/28 normal exit(1), zero signals/missing, zero exits110–114; runtime whole-stage outcome INVALID.

D97AER proved visible late simulator-limit xrefs are after candidate REL+0x58B. D97AES proved all diagnostic senders are 32023 path/UUID; 3802 NEGATIVE. D97AET proved the Cryptex x86_64h shared cache contains 32023 path and not 3802; archived PC/backtrace did not directly prove traversal beyond the visible terminal.

## D97AEU
D97AEU discovered main x86_64h cache and `.01`–`.06` subcaches. The target MTLCompiler 32023 record is replicated in each `imagesText` table with the same logical identity: cache UUID `D2265480-60EB-3526-BAF7-2D6596149186`, load `0x7FFD03141000`, text size `0xCE239`, same path. The load maps into subcache `.05`.

The mapper stopped at `CACHED_IMAGE_HIT_CARDINALITY_FAIL:7` before byte comparison. Classification: TOOLING FALSE FAILURE caused by counting replicated tables as distinct images. No cache byte result was produced.

## D97AEV / D97AEW
D97AEV passed pinned wrapper/base identities, all three transform cardinalities and all required anchors, but its raw `reboot` substring check falsely matched the legitimate `/System/Volumes/Preboot/...` cache path. It stopped before fixed-wrapper write/parse/core execution. Classification: TOOLING FALSE FAILURE; all cache-byte comparisons NOT REACHED; no mutation/Root Patch/reboot.

D97AEW pins D97AEV commit `b8350946e307ec2df253ffb795b31c2104034372` / blob `1060f611b3fec7fc66f80d7674d2fb06a2cdfe6d` and replaces only the scanner block with a reversible command-boundary correction plus safe/dangerous regression corpus. The GitHub-audited D97AEW wrapper is commit `2d14c7831d4adc9578daf5b80b55b72f663d836a`, blob `45876fa66e9018053882be7b01eeccabcfe8046b`, SHA256 `cdd976be2ee2981aec2d35055e96fc0559f2f3277a9e38d62f2476817ef74394`.

GitHub-first validation completed `success` in private workflow ID `348172340`, run `33600569828`, job `100153125476`, exact audit head `3a152504867fa743750f5307749c9d152bf9164e`; every job step passed. Artifact `9835010017` ZIP digest `4f02b891ee4004806117e473ffc67f29fdf28ec65a7061e1e5b7b7e0c0fb339a` matched after download; its single complete report also passed content audit. Live ASUS2 mapper execution remains the only required local step.

## D97AEW live result
D97AEW/D97AEV/D97AEU completed with RC `0`. Seven raw cache records deduplicated to one logical 32023 image, UUID `D2265480-60EB-3526-BAF7-2D6596149186`, distinct from visible filesystem UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.

At the six visible D97AD image offsets the cache is OTHER `6/6` (`PRE=0`, `POST=0`), while the visible file is D97AD POST `6/6`. The cache shared stub is OTHER; retained functional postimages match visible filesystem `16/16` but cache `0/16` at those same offsets; both sender-PC windows differ. Positional cache/filesystem byte identity is NEGATIVE. Semantic cache-site mapping and runtime cache execution remain UNKNOWN; no cache intervention is authorized.

## D97AEW primary-source correction / D5CE provenance
Apple dyld source proves the `imagesText` UUID is copied from the selected input Mach-O slice and is not regenerated by cache optimization. D97AEW's D226 `.05` reads are physically valid, but D5CE offsets cannot be transferred to D226 without same-input identity. The former OTHER/0-of-16 results are therefore numerical cross-image observations, not semantic classifier results: `CACHE_PHYSICAL_BYTE_READ=VALID`, `CROSS_IMAGE_SITE_CORRELATION=NOT_ESTABLISHED`, `D97AD_CACHE_PATCH_DISCRIMINATOR=INCONCLUSIVE`.

The exact official release lineage is OCLP 1.3.0 -> PatcherSupportPkg 1.4.6 -> 14.2 Beta 1 MTLCompiler 32023. The exact unmodified packaged PSP payload UUID is `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`, git blob `ef4389a312867860b2034a42ca75e95162a0f10e`, SHA256 `4f65fb8890a5b18a222c9b0171b6c8240672fb48334fb7739892b7591ffc5641`. Public dsce v7 and v10 change only the first four UUID bytes and preserve the final twelve; exact v8 source is internal/unpublished. The 2023 release provenance independently separates D5CE from the current Tahoe D226 input, and the differing tails corroborate that lineage under the documented algorithm.

D97AES is reclassified as direct runtime provenance: 33/33 simulator diagnostics across 28/28 PIDs came from immediate sender DSO 32023/D5CE; current cache D226 is NEGATIVE as the immediate sender of those records. This does not exclude D226 elsewhere and does not prove exact D97AD postimage bytes because the known P7-to-D97AD transform lineage preserves D5CE. Exact runtime D97AD text remains UNKNOWN. The earlier semantic-D226 next action is superseded and becomes reserve-only static cross-build research.

## D97AEX GitHub helper build and artifact audit
Frozen source commit `5272206915adb71a1b08d5fe131da40a799b3943`, blob `edcb086b00dd760ba67a9a4f7ccaaea1b5baae41`, SHA256 `04bbf5b0a6e4ba18928d45ca1e9588ddda95055d048c98550528659f7e300658` implements a finite poll-sampled universal/no-PID read-only watcher over exactly 31 windows / 330 bytes per pass. Three independent source audits passed.

Private run `33612947825`, job `100192139189`, head `222fc2c79de2dab46101aaa47591d613dcd96896` succeeded on `macos-15-intel`: compile/link, x86_64 Mach-O, exact source/site/public provenance, imports, ad-hoc no-entitlement signing, six-marker self-test and packaging passed; production scan was not run. Artifact `9839742433` ZIP SHA256 `e4604aeba99e1860cb36f76aabf1a37b6472aabf1c27057ea905937c0b42f322`, inner tar SHA256 `47de50185a65b11a4a54982f84ba8124abd1a352dce1f62c46980d13c51a6a1e`, and every inner payload checksum passed three independent post-download audits.

The exact signed helper is 94928 bytes / mode 0755 / blob `528fd75bea3c9ed262daebf55142902a3795fcb8` / SHA256 `bb0ed72910d7ef379276303463af9676b1a712e2f1f755e126234cada43eee1f`, published without production execution at public commit `18880de15acde73ca366c8c0e6e8e6aa4ea3a9f0`. GitHub build/artifact/public-binary gates are PASS. Live Tahoe authorization for the private read-only task port and runtime text result remain UNKNOWN/NOT RUN.

## D97AEX wrapper GitHub audit and public anchor
Frozen wrapper identity: 886 lines / 40522 bytes, blob `5e0cbe4e0041537666d1655fba32161d756e4df7`, SHA256 `98361e388c40556565b00c11283ed3600386acc996b8e1a7e06ae8169075fd37`; exact zsh/static/RC/threat/census audits PASS with zero blockers.

Private final commit/tree `c912f21980a2aa5bc9b14f7d634fc7e07a063c90` / `b9f3fdf1bff541ee52c4aced05e55599c8584b81`; final run `33620774640`, job `100217036670`, SUCCESS. Earlier runs `33620220763` and `33620376174` were fail-closed/diagnostic iterations that established the actual macOS trailer `{"count":0,"finished":1}`; no production watcher ran.

Downloaded artifact `9842808563`: 64888-byte ZIP, SHA256 `08b91fc6528696e90aad51f7b3cc76e4a8a659dc826e20bf78b03c9c8908c32a`; 20 safe entries, CRC PASS, 18/18 SHA256 and 18/18 Git blobs PASS, all reports PASS. Helper execution was self-test only; wrapper/production/sudo/service launch NOT RUN.

Public immutable wrapper anchor: merge commit `da979b5938a8a52bba4e976b5606ccf5c1d951aa`, publication tree `84af62761a14a171253262f6538f7ede31d4cb0a`, path `OCLP7_D97AEX_PINNED_WRAPPER.command`, mode `100755`, exact blob/SHA/bytes above.

## D97AEX first live attempt — pre-watch tooling false negative
Exact public wrapper `da979b5938a8a52bba4e976b5606ccf5c1d951aa` / blob `5e0cbe4e0041537666d1655fba32161d756e4df7` / SHA256 `98361e388c40556565b00c11283ed3600386acc996b8e1a7e06ae8169075fd37` passed outer identity and ran once on ASUS2.

OS/build/arch, helper/codesign/self-test/sudo, helper pre-watch and service pre-watch identities passed. Stable target stat/hash/stat reported exact D97AD SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755` and size `1636896`; wrapper expected `1636864`, therefore RC2 `PREWATCH_FAIL_CLOSED_STOP`. The smaller size belongs to the unmodified donor SHA `4f65fb...5641`; helper source carries the same mixed-provenance size constant. Runtime watcher and log census were NOT RUN.

Report: 96 lines / 5389 bytes / blob `dab425a8e09b88308e90f88e3d124a4cd31ef112` / SHA256 `39a4febf181d35437016a69ee7c4fc50a1ae339dd29670aebf3d35dc78d3510b`. No service launch/stop, system/Golden/target mutation, Root Patch or reboot. Classification: tooling false negative, no target-drift or runtime-text conclusion.

## D97AEY end-to-end size-provenance repair
The correction retained exact target SHA256 `524a16...a755` and every fail-closed identity gate while changing stale donor size `1636864` to live final-D97AD size `1636896` in source/site and the two matching workflow assertions. Source/site public commit `761c0cb98c7fa8791d0cb9698a0ce6833620f0eb`; blobs `6250bebcbe5fe3177f98eeba46cbfd523155b206` and `3743965fb9e3565f63acb4877264da99d1b5c854`.

Corrected helper: private commit/tree `47e12a69ac5212978c1768acd3699f904dc4238b` / `ebacd2075b83ee95c3d4b09e3d0e8b7ce0fdf813`; successful run/job `33632008783` / `100253487864`; artifact `9847219598`, ZIP 94170 bytes / SHA256 `611e38dc05ced8ad00ed97f8849b10139bf9b386df147fe3427ba7b3f7702348`; all outer/inner safety and 22 payload checks passed. Signed helper blob `9f22460e8c1e51a2ae091eb7377e958f6a148e35`, SHA256 `f55b79d498e52a63b5d7c6cdbfde8b7a4c109e14158c7fe1b8c47e2883a85dc9`, 94928 bytes, public commit/tree `4f46e3c97d5cbd89cf77efd5a6a0044aefab52a7` / `0e3a97a5abe4a81eb32848274f06190ad77418f8`.

Corrected wrapper: private commit/tree `1e5fd2e730543df382ff1fe117d315c0aef25560` / `995081d0489187738aacd8f11bf54ce68754c7bb`; successful run/job `33633032040` / `100256947822`; artifact `9847598233`, ZIP 64896 bytes / SHA256 `80a416e8747ddc6d0ec9f13438bf5e6552a02a93c1767d7886f0d233ed9b4587`; 20 safe entries, 18/18 SHA256 and Git blobs PASS. Public wrapper commit/tree `6fcac6e8cc96b90861ca83aad1aebb85b94ae3a5` / `583bb1f6c549fe99a55e76a65e42873d440b2125`; blob `79178583cb84a3f3f8ed6aa0e64d3c1752e17f7d`, SHA256 `65d2b3bf418af1980b37de9c653a142133f6991afab531fcc4fc15d32fc33ec0`, 40522 bytes, 886 lines, mode 100755.

All GitHub compile/codesign/self-test/provenance/static/RC/adversarial/log/packaging gates passed. Helper production scan and wrapper execution were NOT RUN; no service launch, system/Golden/target mutation, Root Patch or reboot.

## D97AEY size-contract acceptance / D97AEX foreground VESA calibration
The corrected public wrapper commit/tree `6fcac6e8cc96b90861ca83aad1aebb85b94ae3a5` / `583bb1f6c549fe99a55e76a65e42873d440b2125`, blob `79178583cb84a3f3f8ed6aa0e64d3c1752e17f7d`, SHA256 `65d2b3bf418af1980b37de9c653a142133f6991afab531fcc4fc15d32fc33ec0`, 40522 bytes, passed outer identity and ran once on ASUS2. Corrected helper commit/tree `4f46e3c97d5cbd89cf77efd5a6a0044aefab52a7` / `0e3a97a5abe4a81eb32848274f06190ad77418f8`, blob `9f22460e8c1e51a2ae091eb7377e958f6a148e35`, SHA256 `f55b79d498e52a63b5d7c6cdbfde8b7a4c109e14158c7fe1b8c47e2883a85dc9`, 94928 bytes, passed download, codesign and exact six-marker self-test.

OS/build/arch, helper, selector-only service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, and final D97AD target `1636896` bytes / SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755` all passed pre-watch and remained stable post-watch. `PRE_WATCH_IDENTITY_GATES=PASS` closes the old mixed donor/final-size false negative.

The helper's production mode ran in the foreground for 120 seconds / 25 ms / minimum three on stable current-online/VESA boot UUID `85583BA8-8C7A-49F7-B7A5-F4D2E5285C3F`: 3696 polls, zero exact-path instances visible, zero complete D5CE captures, MATCH0, MISMATCH0 and zero race/pending classifications. Exact result `COVERAGE_INCOMPLETE_STOP`, RC3, is a valid fail-closed empty calibration, not a tool failure or runtime mismatch. The complete Unified Log parser exposed zero records/PIDs and exact 25-byte trailer-only NDJSON SHA256 `6a105b91d25933f6c54289af691d9c991a86c63c340ca13a472b5a44aa88c346`; this is log-visible only and does not prove global absence.

Report identity: 227 lines / 12289 bytes / blob `619d6ce7e0e59da8243e63eca29103d4820f967b` / SHA256 `607a246b5025be220952e0d49499c83a613dd5477085407c8181569e969cc43b`. Transcript identity: 14324 bytes / blob `0e63734f0fd5f9c4321ce01e7e201fb1b496ffa7` / SHA256 `7ada726dcfcff7c49bfa76b8f39b37a6c3e3df891584cdec29f9edadef54a8b6`. Exact report embedding, final report identity and outer RC3 passed. No live PID meant task-read authorization was not exercised and none of the 31 windows / 330 bytes were read; exact runtime D97AD text remains UNKNOWN. No service launch/stop, target/Golden mutation, Root Patch or reboot.

## User correction — foreground Terminal run was not the accelerated hardware test
Opening Terminal and starting D97AEX cannot create MTLCompilerService: the helper is deliberately passive and states `SERVICE_LAUNCH=AUTO-NO`. The foreground VESA run accepted the corrected size/identity contract and watcher mechanics, but no natural service PID appeared, task-read was never exercised, and none of the runtime windows were read. Authoritative reclassification: `D97AEY_SIZE_CONTRACT_LIVE_ACCEPTANCE=PASS`; `D97AEX_ACCELERATED_HARDWARE_CAUSAL_TEST=NOT_PERFORMED`; exact runtime D97AD text remains UNKNOWN.

## CURRENT ACTION — accelerated-hardware test contract first; user STOP
Do not repeat the VESA foreground watch and do not substitute an induced VESA workload. Before any new collector implementation, the assistant must show the user the minimal test contract and causal decision table for the single unresolved question: whether naturally spawned exact-path MTLCompilerService processes in a new accelerated boot map the current D97AD 31-window postimage or different runtime text. MATCH can negate only the known P7-vs-D97AD bounded-provenance mismatch hypothesis within those tested windows of a completely captured observed cohort; it cannot establish whole-image or runtime-semantic identity. Only the orchestration may then be built/audited in GitHub; the decisive execution remains ASUS2 hardware during an explicitly authorized accelerated boot. No new patch, Root Patch, command or reboot is authorized now.
