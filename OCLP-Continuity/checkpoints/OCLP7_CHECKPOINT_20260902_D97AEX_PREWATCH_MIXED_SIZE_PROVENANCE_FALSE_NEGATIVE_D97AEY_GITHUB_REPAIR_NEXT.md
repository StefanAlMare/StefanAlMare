# OCLP7 CHECKPOINT — D97AEX PRE-WATCH MIXED-SIZE PROVENANCE FALSE NEGATIVE / D97AEY GITHUB REPAIR NEXT

Date: 2026-09-02 EEST  
Status: authoritative continuation checkpoint  
Previous authority: `OCLP7_CHECKPOINT_20260902_D97AEX_WRAPPER_GITHUB_ARTIFACT_AUDIT_PASS_ASUS2_RUNTIME_PROOF_NEXT.md`

## Immutable project state

- Functional baseline remains exactly `P1+P2b+P3+AIR00+D34`.
- True-five SHA remains `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
- Golden Sequoia remains immutable/read-only.
- D50/D68/D82 remain reserve-only; D84 retired; Patch8 unauthorized.
- GitHub-first remains mandatory; the user does not compile/build/package locally.
- No automatic Root Patch or reboot.

## Returned live evidence identity

The user executed exactly the immutable public D97AEX wrapper:

- public commit: `da979b5938a8a52bba4e976b5606ccf5c1d951aa`;
- path: `OCLP7_D97AEX_PINNED_WRAPPER.command`;
- blob: `5e0cbe4e0041537666d1655fba32161d756e4df7`;
- SHA256: `98361e388c40556565b00c11283ed3600386acc996b8e1a7e06ae8169075fd37`;
- bytes: `40522`;
- outer identity gate: PASS.

Runtime report path: `/Users/alex/Desktop/OCLP7_D97AEX_PINNED_WRAPPER_REPORT.txt.CM4tMX`.

Attached report identity:

- lines/bytes: `96 / 5389` with final LF;
- git blob: `dab425a8e09b88308e90f88e3d124a4cd31ef112`;
- SHA256: `39a4febf181d35437016a69ee7c4fc50a1ae339dd29670aebf3d35dc78d3510b`.

All 96 report records appear in the terminal transcript in the same order and with the same values. Interface escaping/link rendering is presentation-only. The later `shell_session_save... parameter not set` line occurred after outer RC2 and is not a D97AEX result.

## Gates that passed

- Tahoe product/build/architecture: `26.6.2 / 25G82 / x86_64`: PASS;
- pinned helper download: RC0;
- helper pre-self-test blob/SHA256/bytes/mode/nlink/stat stability: PASS;
- Mach-O x86_64 and codesign designated requirement: PASS;
- exact six-record helper self-test, RC0, SHA256 `ba6c489151d595d9217ffdc2d8058798b454a8843d2a594d0477e1ff1cefca95`, 345 bytes: PASS;
- sudo credential validation: PASS;
- helper pre-watch identity: PASS;
- selector-only service pre-watch stat/hash/stat identity: PASS, SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

## Decisive pre-watch target gate

The exact target path was a regular nlink-1 file. Its stat-before and stat-after records were identical:

- device `16777231`;
- inode `1152921500319643803`;
- size `1636896` (`0x18FA20`);
- mtime `1788296134`;
- mode `0755`;
- nlink `1`.

The full-file SHA256 between those stable stats was exact authoritative D97AD:

`524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`.

The wrapper expected the same SHA256 but `TARGET_BYTES_EXPECTED=1636864` (`0x18FA00`). Therefore it emitted exactly:

`PRE_WATCH_TARGET_IDENTITY=FAIL|REASON=BYTE_COUNT_MISMATCH`  
`PRE_WATCH_IDENTITY_GATES=FAIL_CLOSED`  
`D97AEX_WRAPPER_RESULT=PREWATCH_FAIL_CLOSED_STOP`  
`D97AEX_WRAPPER_EXIT_RC=2`  
`D97AEX_OUTER_WRAPPER_RC=2`.

## Root cause classification

The repository contains the exact official unmodified PSP donor:

- size `1636864`;
- SHA256 `4f65fb8890a5b18a222c9b0171b6c8240672fb48334fb7739892b7591ffc5641`;
- UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.

The size constant came from that donor while the hash constant came from the transformed/deployed D97AD image. This is a mixed-provenance identity pair. The +32-byte final growth is structurally compatible with regenerated signature growth, but the live report did not record final `LC_CODE_SIGNATURE` fields, so that mechanism is not promoted from plausible explanation to fact.

Under ordinary SHA-256 trust, stable full-file hash equality to the authoritative D97AD SHA is strong exact byte-stream identity. APFS clone/compression/sparse representation cannot explain the logical `%z` mismatch. Collision/preimage speculation is not operationally credible. The evidence does not support target drift or corruption.

The public helper source independently contains `kExpectedTargetFileSize=1636864`; `query_target_file_identity()` would therefore have failed with RC2 even if only the wrapper constant had been changed. End-to-end helper plus wrapper repair is mandatory. Removing the size gate or accepting both sizes is not authorized.

Authoritative classification:

`D97AEX_PREWATCH_IDENTITY_CONTRACT_MIXED_PROVENANCE=PROVEN`  
`D97AEX_PREWATCH_TOOLING_FALSE_NEGATIVE=PROVEN`  
`D97AEX_TARGET_D97AD_SHA_IDENTITY=PASS`  
`D97AEX_TARGET_DRIFT_OR_CORRUPTION=NOT_SUPPORTED`  
`D97AEX_LIVE_TASK_READ_AUTHORIZATION=NOT_TESTED`  
`D97AEX_LIVE_RUNTIME_TEXT_RESULT=NOT_RUN_UNKNOWN`.

## Execution and mutation boundary

The wrapper stopped before the temporal boot/timezone gate and before the production helper command. There was no privileged `helper --duration 120 --interval-ms 25 --min-complete 3`, task-read attachment, poll, runtime window capture, helper summary, Unified Log census or post-watch gate.

The helper ran only as the unprivileged exact `--self-test`. No MTLCompilerService launch/stop, target process control, source/system/Golden/target code mutation, Root Patch or reboot occurred. Only declared ephemeral private-temp files, the unique Desktop report, ordinary sudo timestamp metadata and possible self-test/page-in timing effects occurred.

## ACTIVE FRONTIER / CURRENT NEXT ACTION — assistant GitHub D97AEY

The user remains at STOP. No ASUS2 command is authorized.

The assistant must implement an evidence-minimal exact correction from donor-size `1636864` to final-D97AD-size `1636896` in every end-to-end identity authority:

1. helper source `kExpectedTargetFileSize`;
2. exact site/source manifest `file_size` and its generated identities;
3. helper GitHub build workflow constants and source/manifest/provenance assertions;
4. pinned wrapper `TARGET_BYTES_EXPECTED`;
5. wrapper identity manifest;
6. wrapper static auditor expected constants;
7. wrapper GitHub workflow fixtures and provenance assertions.

The authoritative target SHA256 remains exactly `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. Regular-file, non-symlink, nlink-1, stat-before/hash/stat-after and pre/post identity gates remain mandatory. Do not loosen the gate and do not accept both sizes.

GitHub-first completion order:

1. independent static delta/source/manifest audit;
2. compile/link corrected helper on macOS Intel;
3. Mach-O/import/minimum-OS/codesign/no-entitlement/exact-self-test/package audit;
4. successful GitHub run and downloaded-artifact identity/inventory audit;
5. immutable public corrected-helper publication;
6. corrected wrapper repin and full zsh/static/RC/threat/census/provenance audit;
7. successful wrapper GitHub run and downloaded-artifact audit;
8. immutable public corrected-wrapper publication;
9. persist exact commits/trees/blobs/SHA/bytes/runs/jobs/artifacts;
10. only then issue a new minimal identity-pinned ASUS2 command.

No local user compilation, OCLP opening, Root Patch or reboot is authorized. Golden remains immutable/read-only.
