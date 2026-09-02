# OCLP7 checkpoint — D97AEY repair PASS / D97AEX zero-cohort RC3 / D97AEZ design next

Date: 2026-09-02 EEST

## Inherited authority
Baseline remains exactly P1+P2b+P3+AIR00+D34. Golden is immutable/read-only. D50/D68/D82 are reserve-only; D84 is retired; Patch8 is unauthorized. Work remains GitHub-first: the assistant performs every possible validation, integration, compile/build/package, audit and publication step; the user performs only identity-pinned evidence that inherently requires ASUS2. Never auto Root Patch or reboot.

## Exact artifacts returned from ASUS2
The executed outer wrapper is the corrected D97AEY delivery of the D97AEX runtime watcher:

- public wrapper commit `6fcac6e8cc96b90861ca83aad1aebb85b94ae3a5`, tree `583bb1f6c549fe99a55e76a65e42873d440b2125`;
- wrapper blob `79178583cb84a3f3f8ed6aa0e64d3c1752e17f7d`, SHA256 `65d2b3bf418af1980b37de9c653a142133f6991afab531fcc4fc15d32fc33ec0`, 40522 bytes;
- helper public commit `4f46e3c97d5cbd89cf77efd5a6a0044aefab52a7`, tree `0e3a97a5abe4a81eb32848274f06190ad77418f8`;
- helper blob `9f22460e8c1e51a2ae091eb7377e958f6a148e35`, SHA256 `f55b79d498e52a63b5d7c6cdbfde8b7a4c109e14158c7fe1b8c47e2883a85dc9`, 94928 bytes, public tree mode `100755`, local runtime mode `0500`;
- report `OCLP7_D97AEX_PINNED_WRAPPER_REPORT.txt.bNhuS0`: 227 lines / 12289 bytes, blob `619d6ce7e0e59da8243e63eca29103d4820f967b`, SHA256 `607a246b5025be220952e0d49499c83a613dd5477085407c8181569e969cc43b`;
- terminal transcript: 14324 bytes, 532 LF delimiters / 533 logical lines, blob `0e63734f0fd5f9c4321ce01e7e201fb1b496ffa7`, SHA256 `7ada726dcfcff7c49bfa76b8f39b37a6c3e3df891584cdec29f9edadef54a8b6`.

All 227 report lines occur byte-for-byte in the transcript in the same order and value after removing presentation-only blank lines and the sole TTY-only `Password:` line. The transcript starts partway through the pasted outer command but contains the complete outer identity result, complete report, `REPORT_FINAL_IDENTITY=PASS`, report bytes/SHA, inner RC3 and outer RC3. The later `shell_session_save...parameter not set` warning is Terminal postlude after the wrapper result and is unrelated.

## D97AEY repair accepted live
The following gates are exact PASS:

- Tahoe `26.6.2`, build `25G82`, `x86_64`;
- corrected helper download/blob/SHA/bytes/mode;
- Mach-O x86_64 and codesign Designated Requirement;
- exact six-marker self-test, RC0, output 345 bytes / 6 lines / SHA256 `ba6c489151d595d9217ffdc2d8058798b454a8843d2a594d0477e1ff1cefca95`;
- 31-entry / 330-byte manifest and exact segment translation;
- sudo credential validation;
- helper pre-watch identity;
- selector-only service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- final D97AD target size `1636896` and SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`;
- `PRE_WATCH_IDENTITY_GATES=PASS`;
- helper/service/target post-watch identities and pre/post stability.

The stale donor-size contract that caused the first D97AEX RC2 false negative is therefore repaired and accepted end-to-end on ASUS2. The production path was reached and executed.

## Production observation
The exact helper ran through sudo with explicit `--duration 120 --interval-ms 25 --min-complete 3` from `2026-09-02 16:12:48+0300` to `16:14:49+0300`. Boot session remained `85583BA8-8C7A-49F7-B7A5-F4D2E5285C3F`; timezone remained `+0300/EEST`.

Exact cohort summary:

- polls `3696`;
- unique exact-path service instances visible at polls `0`;
- complete D5CE instances `0`;
- bounded31 MATCH `0`;
- bounded31 MISMATCH `0`;
- UUID-negative, capture-race, prefilter-race and pending/ended counts all `0`;
- minimum complete required `3`.

The exact terminal markers are `COHORT_COVERAGE=INCOMPLETE`, `COHORT_BOUNDED_31_WINDOW_BYTES_PROVEN=UNKNOWN`, `D97AEX_RESULT=COVERAGE_INCOMPLETE_STOP`. Helper RC is `3`; tee RC is `0`; summary parse, counter invariants, terminal contract and transcript tee are PASS. The wrapper produced exactly one INCOMPLETE result marker, zero MATCH, zero MISMATCH and zero fatal markers. RC3 is the intended fail-closed valid-empty outcome, not a tooling/runtime failure.

## Unified Log scope
The guarded wall-clock query completed RC0 with a complete parser and exact raw trailer `{"count":0,"finished":1}`. NDJSON is 25 bytes / SHA256 `6a105b91d25933f6c54289af691d9c991a86c63c340ca13a472b5a44aa88c346`; stderr is empty. It exposed zero records and zero PIDs.

This establishes only an empty log-visible census for the guarded window. It does not prove global absence, inter-poll absence, Unified Log completeness or equivalence to the helper's cohort. No global cohort claim is authorized.

## Exact epistemic boundary
Proven:

- D97AEY GitHub repair and ASUS2 acceptance PASS;
- production watcher executed with the exact contract;
- zero exact-path PIDs were visible in 3696 polls;
- zero relevant records were visible to the complete Unified Log parser;
- final on-disk D97AD target identity was exact before and after;
- all report, RC and safety contracts passed.

Still UNKNOWN / NOT TESTED:

- any instance that existed wholly between polls;
- global spawn-cohort coverage and log completeness;
- live `task_read_for_pid` authorization against a production target;
- runtime LC_UUID/backing mapping;
- all 31 runtime windows / 330 bytes;
- D97AD runtime MATCH/MISMATCH, branch execution or full-image identity.

The result must never be rewritten as zero global spawns, MATCH, MISMATCH or runtime D97AD proof.

## Safety result
No source, target system file, Golden, target code bytes or process-control mutation occurred. The wrapper did not launch or stop MTLCompilerService. Root Patch and reboot remained AUTO-NO. Only private ephemeral wrapper-owned files, the unique mode-0600 Desktop report and ordinary sudo credential-cache metadata were allowed by contract.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
D97AEY closes PASS. Do not ask the user to repeat the same idle online/VESA run or reduce the minimum-complete gate. The online boot is ordinarily VESA recovery under the permanent rule; that lane cannot silently substitute for the accelerated causal lane.

D97AEZ is assistant-owned GitHub-first work: investigate, design, compile/build and fully audit the smallest bounded passive mechanism that can overlap the already-proven universal/no-PID 31-window helper with a naturally occurring relevant cohort. Primary candidate for investigation is a one-shot boot-bound collector around a future explicitly authorized accelerated boot. It must preserve exact-path selection, all visible PIDs, double-read, min-complete and fail-closed classifications; bind every report to one boot UUID; audit install, run, retrieval and removal; never directly launch/stop MTLCompilerService; never mutate target/Golden bytes; and never auto Root Patch or reboot.

System-file instrumentation is not authorized by this checkpoint. The assistant must first produce an identity-pinned, GitHub-built and audited design plus explicit safety/removal proof. User action is STOP: no local compilation, command, OCLP opening, Root Patch or reboot now.
