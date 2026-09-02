# OCLP7 CHECKPOINT — D97AEX WRAPPER GITHUB + DOWNLOADED ARTIFACT AUDIT PASS / ASUS2 RUNTIME PROOF NEXT

Date: 2026-09-02 EEST  
Status: authoritative continuation checkpoint  
Previous authority: `OCLP7_CHECKPOINT_20260902_D97AEX_GITHUB_BUILD_ARTIFACT_AUDIT_PASS_WRAPPER_NEXT.md`

## Immutable project state

- Functional baseline remains exactly `P1+P2b+P3+AIR00+D34`.
- True-five SHA remains `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
- Golden Sequoia remains immutable/read-only.
- D50/D68/D82 remain reserve-only; D84 retired; Patch8 unauthorized.
- GitHub-first remains mandatory: the assistant performs all validation, integration, compilation, packaging, application/artifact audit, SHA/provenance and publication work possible in GitHub. The user performs only identity-pinned ASUS2-only proof/deploy operations.
- No automatic Root Patch or reboot.

## Accepted causal starting fact

D97AEW's Tahoe D226 shared-cache reads are physically valid, but D5CE filesystem offsets cannot be transferred to the different D226 lineage. `CACHE_PHYSICAL_BYTE_READ=VALID`, `CROSS_IMAGE_SITE_CORRELATION=NOT_ESTABLISHED`, and `D97AD_CACHE_PATCH_DISCRIMINATOR=INCONCLUSIVE` remain authoritative.

D97AES directly proves that 33/33 observed simulator diagnostics across 28/28 PIDs had immediate sender DSO 32023/D5CE, not current-cache D226. It does not prove exact current D97AD text bytes because the P7-to-D97AD transform lineage preserves the same D5CE UUID. Before the live D97AEX proof, `RUNTIME_EXACT_CURRENT_D97AD_TEXT_BYTES=UNKNOWN`.

## Frozen helper anchor retained

- public helper commit/tree: `18880de15acde73ca366c8c0e6e8e6aa4ea3a9f0` / `f6806366a19f3f9da034611d04e39e4bb00e7486`;
- path: `OCLP7_D97AEX_READONLY_D5CE_RUNTIME_TEXT_PROVENANCE_READER`;
- mode/blob: `100755` / `528fd75bea3c9ed262daebf55142902a3795fcb8`;
- bytes/SHA256: `94928` / `bb0ed72910d7ef379276303463af9676b1a712e2f1f755e126234cada43eee1f`;
- thin x86_64 Mach-O, ad-hoc signed, no entitlements, UUID `67A1590A-91F7-3581-8E2A-42B13E88642C`;
- exact site manifest: 31 windows / 330 bytes per pass, comprising 23 patch windows / 202 bytes and 8 invariant/far-frontier windows / 128 bytes.

## Frozen D97AEX pinned wrapper

Exact wrapper identity:

- path: `OCLP7_D97AEX_PINNED_WRAPPER.command`;
- lines/bytes: `886 / 40522`;
- git blob: `5e0cbe4e0041537666d1655fba32161d756e4df7`;
- SHA256: `98361e388c40556565b00c11283ed3600386acc996b8e1a7e06ae8169075fd37`;
- exact `zsh -f -n`: PASS.

The wrapper is a login-user orchestrator with no arguments and rejects whole-wrapper EUID 0. It downloads only the immutable helper commit above, verifies helper blob/SHA/bytes/mode/Mach-O/codesign and exact six-marker self-test, validates Tahoe `26.6.2 / 25G82 / x86_64`, then uses `sudo -v` and invokes only the exact helper through sanitized `sudo -n -- env -i` with `--duration 120 --interval-ms 25 --min-complete 3`.

It applies fail-closed service and target stat/hash/stat identity gates before and after, preserves helper and tee `pipestatus`, accepts only the exact RC 0/2/3/4 transcript grammars and counter invariants, and never upgrades an invalid core result through census evidence.

The retrospective Unified Log query is read-only and temporally guarded. Its exact demonstrated trailer contract is `{"count":N,"finished":1}`, exactly once, last, with numeric `N` equal to the number of preceding non-empty event records. It scopes all census claims to `LOG_VISIBLE`, compares only PID-number sets, does not claim cohort equivalence, and retains `GLOBAL_SPAWN_COHORT_COVERAGE=UNKNOWN`.

The wrapper never launches or stops MTLCompilerService, contains no debugger/control-port fallback and makes no source, system target, Golden, code-byte, Root Patch or boot mutation. It discloses the normal sudo credential-cache metadata effect and possible page-in/timing observational perturbation. Its only persistent output is one unique Desktop report, mode 0600, finalized by stat/hash/stat identity.

## Independent wrapper audits

Final independent RC audit: PASS, zero blockers. RC0/2/3/4 grammar, counter invariants, post gates and final-report identity are fail-closed. The exact real trailer and all positive/adversarial trailer fixtures pass.

Final independent census audit: PASS, zero blockers. `count=0` and valid nonzero cardinality are accepted; mismatch, boolean `finished`, duplicate/extra fields, wrong ordering and records after the trailer are rejected. Parser success can modify only the log-census branch and cannot turn an invalid core outcome into success.

Final independent threat-model delta: PASS, zero blockers. Command boundary remains download/self-test/sudo credential validation/exact helper/read-only log query/explicit temporary artifacts only.

## Private GitHub audit provenance

- repository/branch: `StefanAlMare/Private-Work` / `oclp7-d97aex-wrapper-audit`;
- final private commit/tree: `c912f21980a2aa5bc9b14f7d634fc7e07a063c90` / `b9f3fdf1bff541ee52c4aced05e55599c8584b81`;
- workflow blob/SHA256: `98caacb300b55eb7153a8977d21445111cccf154` / `7baeb8b645fcf41eb8b5f7f97e629032498797604939060ff0c3aeb2f64e8941`;
- identity-manifest blob/SHA256: `a78bbfd103e81fbecf7628b42e17b6aa2a1d7894` / `ba30632d221aa111a9d926a396fa81fda708c3f4e28eabc7a7e3c2c402533164`;
- static-auditor blob/SHA256: `48ae8f76c5510033d3b90a1d3740ca862dccc387` / `c7f00fd6a2787a4045fcf2820d701ea06599f87c797bd3b9eaeeadf9edd4a300`;
- action pins: checkout v4.2.2 `11bd71901bbe5b1630ceea73d27597364c9af683`; upload-artifact v4.6.2 `ea165f8d65b6e75b540449e92b4886f43607fa02`.

CI iteration record:

1. run `33620220763` failed closed only because the first wrapper assumed an unproven boolean `finished:true` trailer;
2. diagnostic run `33620376174` proved the real macOS output is exactly `{"count":0,"finished":1}`;
3. final run `33620774640`, job `100217036670`, exact head `c912f21980a2aa5bc9b14f7d634fc7e07a063c90`, completed `success`; every step passed on macOS 15.7.9 / build 24G830 / X64 / zsh 5.9.

The failed and diagnostic iterations were evidence-preserving CI corrections. None ran the wrapper or production watcher. The helper was executed only with `--self-test`; there was no sudo, service launch, Root Patch or reboot.

## Downloaded final artifact audit

- artifact ID/name: `9842808563` / `OCLP7-D97AEX-pinned-wrapper-audit`;
- final run/job: `33620774640` / `100217036670`;
- outer ZIP bytes/SHA256: `64888` / `08b91fc6528696e90aad51f7b3cc76e4a8a659dc826e20bf78b03c9c8908c32a`;
- GitHub digest matches the independently downloaded ZIP SHA256 exactly;
- exactly 20 unique root-level entries; CRC PASS; zero duplicate, traversal, absolute path, symlink or special unsafe entry;
- wrapper mode `100755`, helper audit copy `100500`, static auditor `100755`;
- all 18 payload entries in `SHA256SUMS.txt` independently verify;
- all 18 payload Git hashes in `GIT_BLOBS.txt` independently verify;
- wrapper, identity manifest, static auditor and workflow are byte-identical to the frozen staging inputs;
- exact helper audit copy retains blob `528fd75bea3c9ed262daebf55142902a3795fcb8` and SHA256 `bb0ed72910d7ef379276303463af9676b1a712e2f1f755e126234cada43eee1f`;
- consolidated, static, syntax/mode, public-provenance, codesign/self-test, live-log probe, census/pipestatus/report fixture reports: PASS;
- consolidated report blob: `0c4f6b729b539825bfc0e5d044faa16d3d2be522`;
- actual log probe: 25 bytes / SHA256 `6a105b91d25933f6c54289af691d9c991a86c63c340ca13a472b5a44aa88c346`, raw trailer `{"count":0,"finished":1}`, stderr empty.

Independent downloaded-artifact audit: PASS, zero blockers. `PRODUCTION_HELPER_EXECUTION=NOT_RUN`, `WRAPPER_EXECUTION=NOT_RUN`, `HELPER_EXECUTION=SELF_TEST_ONLY`, and `SERVICE_LAUNCH=AUTO-NO` are confirmed by authentic logs and reports.

## Public wrapper publication

The exact frozen wrapper is public at:

- immutable merge commit: `da979b5938a8a52bba4e976b5606ccf5c1d951aa`;
- publication tree: `84af62761a14a171253262f6538f7ede31d4cb0a`;
- path: `OCLP7_D97AEX_PINNED_WRAPPER.command`;
- mode: `100755`;
- blob: `5e0cbe4e0041537666d1655fba32161d756e4df7`;
- bytes/SHA256: `40522` / `98361e388c40556565b00c11283ed3600386acc996b8e1a7e06ae8169075fd37`.

The public file was fetched back at the immutable merge commit and its blob/content identity matches the frozen audited wrapper.

## Authoritative result

`D97AEX_PINNED_WRAPPER_STATIC_RC_THREAT_CENSUS_AUDIT=PASS`  
`D97AEX_PINNED_WRAPPER_GITHUB_CI=PASS`  
`D97AEX_PINNED_WRAPPER_DOWNLOADED_ARTIFACT_AUDIT=PASS`  
`D97AEX_PINNED_WRAPPER_PUBLIC_IDENTITY=PASS`  
`D97AEX_GITHUB_PRODUCTION_WATCH=NOT_RUN`  
`D97AEX_LIVE_TASK_READ_AUTHORIZATION=UNKNOWN`  
`D97AEX_LIVE_RUNTIME_TEXT_RESULT=NOT_RUN`

The GitHub-capable lane is complete. The remaining unknowns are inherently ASUS2-only: whether Tahoe grants this exact ad-hoc helper the private read-only task port under the wrapper's exact sudo boundary, and what the bounded observed natural-instance cohort contains.

## ACTIVE FRONTIER / CURRENT NEXT ACTION

Authorize exactly one ASUS2-only execution of the immutable public wrapper. The user must run the separately supplied minimal command that verifies wrapper commit/blob/SHA256/bytes before `/bin/zsh -f` execution.

The wrapper itself performs the exact helper download and identity checks, self-test, pre/post service and target gates, 120-second universal/no-PID natural-instance watch, strict RC transcript audit and retrospective read-only `LOG_VISIBLE` census. It does not launch or stop MTLCompilerService.

After execution, STOP. Return:

1. the complete terminal transcript, including the outer wrapper identity markers and final RC;
2. the exact Desktop report file named by the wrapper's `REPORT=` line.

Interpretation is bounded and fail-closed:

- RC `0`: observed complete cohort matches all 31 expected D97AEX windows;
- RC `4`: observed complete cohort has at least one bounded window mismatch;
- RC `3`: coverage incomplete; STOP;
- RC `2`: fail-closed blocker, including task-read denial or any identity/grammar/post-gate failure; STOP.

No result authorizes a debugger/control-port fallback, Root Patch or reboot. The returned evidence must be audited and decisively persisted before any further action. Golden remains immutable/read-only.
