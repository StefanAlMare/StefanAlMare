# OCLP7 CHECKPOINT — D97AEY GITHUB REPAIR FULL PASS / ASUS2 RUNTIME PROOF READY

Date: 2026-09-02 EEST  
Status: authoritative continuation checkpoint  
Previous authority: `OCLP7_CHECKPOINT_20260902_D97AEX_PREWATCH_MIXED_SIZE_PROVENANCE_FALSE_NEGATIVE_D97AEY_GITHUB_REPAIR_NEXT.md`

## Immutable project state

- Functional baseline remains exactly `P1+P2b+P3+AIR00+D34`.
- True-five SHA remains `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
- Golden Sequoia remains immutable/read-only.
- D50/D68/D82 remain reserve-only; D84 retired; Patch8 unauthorized.
- GitHub-first remains mandatory; the user does not compile/build/package locally.
- Module-boundary + semantic evidence + far-frontier and universal/no-PID remain mandatory.
- No automatic Root Patch or reboot.

## Decisive prior live result

The first D97AEX wrapper attempt passed wrapper/helper/OS/codesign/self-test/sudo/service gates, then stopped fail-closed before production watch because it paired final D97AD SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755` with stale PSP Git-donor size `1636864`. The live stable target was exact SHA-matched D97AD at `1636896`; no drift/corruption was supported. Production task-read/watch/log/post gates were not run.

The stale size is proven to originate in the unmodified PSP Git donor SHA256 `4f65fb8890a5b18a222c9b0171b6c8240672fb48334fb7739892b7591ffc5641`. PSP release CI re-signs ad-hoc binaries, so its Git size is not authoritative for the final installed donor; this strongly explains the distinction, while the exact +32-byte operation is not claimed byte-for-byte without the release-DMG donor.

## Exact correction boundary

The repair did not remove or widen a gate and did not accept both sizes.

- helper source: only `kExpectedTargetFileSize 1636864 -> 1636896`;
- site manifest: only `file_size 1636864 -> 1636896`;
- helper workflow: only the two matching size assertions;
- wrapper: helper commit/tree/blob/SHA repins plus `TARGET_BYTES_EXPECTED 1636864 -> 1636896`;
- wrapper identity manifest: the same exact authority updates;
- static auditor and wrapper workflow logic: unchanged.

Exact target SHA256, regular-file/non-symlink/nlink-1, stat-before/hash/stat-after, pre/post gates, 31 windows, universal/no-PID selection, finite duration, service non-launch and all safety boundaries remain unchanged.

## Corrected source and manifest publication

Public merge commit/tree: `761c0cb98c7fa8791d0cb9698a0ce6833620f0eb` / `69bf186b4522e7a5faa8e2ab20071692890fd9f2`.

- source blob `6250bebcbe5fe3177f98eeba46cbfd523155b206`;
- source SHA256 `009ca0c749f2921ef6c0a0bf089ff11eab24c6e0ffc6af34d2b845523a8c8c16`;
- source bytes/lines `68382 / 1806`;
- site blob `3743965fb9e3565f63acb4877264da99d1b5c854`;
- site SHA256 `7db43b482fe34a8bbca622927a7f5801af6227589bac592f6363310941add341`;
- site bytes/lines `5928 / 72`.

## Corrected helper GitHub build and artifact audit

Private commit/tree: `47e12a69ac5212978c1768acd3699f904dc4238b` / `ebacd2075b83ee95c3d4b09e3d0e8b7ce0fdf813`.

GitHub Actions:

- run `33632008783`;
- job `100253487864`;
- conclusion `success`;
- compile/link, public/source/site identity, exact 31-window topology, universal/no-PID option boundary, Mach-O/import/minimum-OS, ad-hoc codesign/no-entitlement, exact six-marker self-test and packaging: PASS;
- helper production scan: NOT RUN.

Downloaded artifact `9847219598`:

- GitHub/local ZIP bytes `94170`;
- GitHub/local ZIP SHA256 `611e38dc05ced8ad00ed97f8849b10139bf9b386df147fe3427ba7b3f7702348`;
- inner tar SHA256 `3f6c04c8dd488a7d914fdcdbbcfb451973f5fa4f46570cf1647bca8b3d3d5e08`;
- safe six-file outer ZIP, safe unique 28-entry inner tar, no traversal/symlink/hardlink/device nodes;
- all 22 payloads exactly covered and SHA256 PASS;
- independent audits: PASS, zero blockers.

Corrected signed helper:

- path `OCLP7_D97AEX_READONLY_D5CE_RUNTIME_TEXT_PROVENANCE_READER`;
- bytes `94928`;
- Git mode `100755`;
- blob `9f22460e8c1e51a2ae091eb7377e958f6a148e35`;
- SHA256 `f55b79d498e52a63b5d7c6cdbfde8b7a4c109e14158c7fe1b8c47e2883a85dc9`;
- Mach-O thin x86_64;
- UUID `CF378D7F-333C-3603-86BD-E2C5FAAFCEDF`;
- ad-hoc codesign/designated requirement PASS, no entitlements;
- exact self-test SHA256 `ba6c489151d595d9217ffdc2d8058798b454a8843d2a594d0477e1ff1cefca95`, 345 bytes, six lines: PASS.

Public immutable helper merge commit/tree: `4f46e3c97d5cbd89cf77efd5a6a0044aefab52a7` / `0e3a97a5abe4a81eb32848274f06190ad77418f8`.

## Corrected wrapper GitHub audit and artifact audit

Private commit/tree: `1e5fd2e730543df382ff1fe117d315c0aef25560` / `995081d0489187738aacd8f11bf54ce68754c7bb`.

GitHub Actions:

- run `33633032040`;
- job `100256947822`;
- conclusion `success`;
- exact checkout, zsh parse/mode, command boundary, pinned supply chain, RC fixture matrix `0,2A,2B,3,4`, adversarial rejection, final report identity, log-visible contract, public helper commit/tree/blob/SHA/mode, codesign, exact self-test, exact Unified Log trailer and census/report primitives: PASS;
- wrapper execution: NOT RUN;
- production helper execution: NOT RUN;
- service launch, Root Patch, reboot: AUTO-NO.

Downloaded artifact `9847598233`:

- GitHub/local ZIP bytes `64896`;
- GitHub/local ZIP SHA256 `80a416e8747ddc6d0ec9f13438bf5e6552a02a93c1767d7886f0d233ed9b4587`;
- exactly 20 safe unique regular root files, CRC PASS, no traversal or special entries;
- all 18 payload SHA256 records PASS;
- all 18 payload Git blobs PASS;
- wrapper/manifest/auditor/workflow/helper are byte-identical to the audited inputs;
- consolidated result `D97AEX_WRAPPER_GITHUB_AUDIT=PASS`.

Corrected wrapper:

- path `OCLP7_D97AEX_PINNED_WRAPPER.command`;
- lines/bytes `886 / 40522`;
- mode `100755`;
- blob `79178583cb84a3f3f8ed6aa0e64d3c1752e17f7d`;
- SHA256 `65d2b3bf418af1980b37de9c653a142133f6991afab531fcc4fc15d32fc33ec0`.

Public immutable wrapper merge commit/tree: `6fcac6e8cc96b90861ca83aad1aebb85b94ae3a5` / `583bb1f6c549fe99a55e76a65e42873d440b2125`.

## Safety and execution boundary

All GitHub helper runtime execution was exact `--self-test` only. The wrapper itself and production helper watch were never executed in GitHub. No service launch/stop, task-read production attachment, source/system/Golden/target code mutation, Root Patch or reboot occurred.

Classification:

`D97AEY_MIXED_PROVENANCE_REPAIR=PASS`  
`D97AEY_HELPER_GITHUB_BUILD_AND_ARTIFACT_AUDIT=PASS`  
`D97AEY_HELPER_PUBLIC_IDENTITY=PASS`  
`D97AEY_WRAPPER_GITHUB_AND_ARTIFACT_AUDIT=PASS`  
`D97AEY_WRAPPER_PUBLIC_IDENTITY=PASS`  
`D97AEX_PRODUCTION_RUNTIME_TEXT_RESULT=NOT_RUN_UNKNOWN`.

## ACTIVE FRONTIER / CURRENT NEXT ACTION — corrected D97AEX ASUS2 runtime proof

The GitHub lane is complete. The user is authorized to run exactly once only the corrected wrapper through the exact outer identity gate issued by the assistant:

- public commit `6fcac6e8cc96b90861ca83aad1aebb85b94ae3a5`;
- path `OCLP7_D97AEX_PINNED_WRAPPER.command`;
- blob `79178583cb84a3f3f8ed6aa0e64d3c1752e17f7d`;
- SHA256 `65d2b3bf418af1980b37de9c653a142133f6991afab531fcc4fc15d32fc33ec0`;
- bytes `40522`.

The wrapper may request the sudo password. It then validates the corrected helper and observes all naturally occurring exact-path MTLCompilerService PIDs for 120 seconds / 25 ms / minimum three complete samples. It never launches or stops the service. Return the entire terminal transcript plus the unique Desktop report.

No local compilation, OCLP opening, Root Patch or reboot is authorized. Golden remains immutable/read-only.
