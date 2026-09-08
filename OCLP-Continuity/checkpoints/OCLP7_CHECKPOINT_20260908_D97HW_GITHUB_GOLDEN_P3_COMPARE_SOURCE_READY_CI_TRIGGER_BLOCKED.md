# OCLP D97HW — GitHub Golden/P3 static comparison source ready; CI trigger blocked

Date: 2026-09-08 EEST
Predecessor: `OCLP7_CHECKPOINT_20260908_D97HV_INDEPENDENT_ARCHIVE_AUDIT_PASS_D97HW_READY.md`.

## Scope and unchanged runtime authority
The user requested the next step after asking for a Sequoia comparison at the current compiler boundary.
The six mandatory continuity documents were read in order before implementation.
No ASUS2 or Golden action occurred. No Root Patch, Restore, EFI/NVRAM/framebuffer mutation, compiler execution, acceleration or reboot occurred.
The current recorded target remains Tahoe 26.6.2 / 25G82, Haswell 8086:0412, MacBookAir6,2, framebuffer 3/3/3, optional iGPU tuning OFF.
P1 + P3 only remains the recorded compiler patch state; P2 remains original; P2b/AIR00/D34 remain unauthorized.
The last authoritative accelerated experiment remains 2026-09-08 14:24:02 through approximately 14:27:17 +0300, separate from VESA recovery.
D97HV compiler-frontier evidence and its independent archive audit are unchanged.

## Remotely available donor identity discovered
GitHub release metadata for `dortania/PatcherSupportPkg`, tag `1.9.6`, exposes:
- asset `Universal-Binaries.dmg`;
- asset ID `332386253`;
- declared size `641964544`;
- declared SHA256 `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`;
- download: `https://github.com/dortania/PatcherSupportPkg/releases/download/1.9.6/Universal-Binaries.dmg`.
This declared package digest exactly matches the already-persisted D97DU/D97HI asset pin.
Upstream tag 1.9.6 `build-dmg.sh`, blob `5db6f7f701f8fd331a4bdc55974e777a3958ae9f`, documents its public packaging passphrase and encryption format.
This is metadata/provenance evidence; the new workflow has NOT yet downloaded and byte-verified the asset.

## GitHub-first implementation
New comparator:
`OCLP-Continuity/artifacts/OCLP7_D97HW_GITHUB_GOLDEN_P3_STATIC_COMPARE.py`
Creation commit returned by connector: `cedeed3d6b89b414ec629bf55623e5e3ad49a22f`.

New workflow:
`.github/workflows/oclp-d97hw-golden-p3-static-compare.yml`
Workflow name: `OCLP D97HW Golden vs P3 static comparison`.
Source/workflow head confirmed by refs/heads/main: `56df870a781d9d9f20e4a8fdd3375ebc4c188e8e`.
Requested runner: `macos-15-intel`, standard GitHub-hosted, NOT ASUS2 and NOT Golden.
Triggers: path-filtered push to main and workflow_dispatch.
Permissions: contents read only.

Intended CI gates, NOT yet executed:
1. Fetch exact triggering commit; source syntax and positive/negative guard tests.
2. Download exact 1.9.6 DMG, verify whole-file size and SHA, mount read-only in runner temporary storage.
3. Locate original service SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`, size 85520.
4. Locate Golden-original MTLCompiler32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`, size 1636896.
5. Reconstruct P1 on a disposable copy, only offsets 0x3496/0x3497; require final SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.
6. Reconstruct P3 on a disposable copy, only offset 0xA1574 e1->c9; require SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90` and UUID D5CE0008-587C-3861-971A-4BAEFB7B9C5B.
7. Require original P2 bytes `418b81d0000000 @ 0x9A8CD`.
8. Extract section-owned simulator/bitcode strings, Mach-O metadata, symbols, full disassemblies and instruction-boundary RIP-relative xref candidates for original/P3 copies.
9. Publish text/JSON evidence and SHA manifest only, never donor executables.
10. Assistant audits actual job logs and artifact before causal interpretation.

This replaces delegation of remotely reproducible static analysis to the old ASUS2 D97HW script. The old helper is preserved as history, not the current execution instruction. A local-input collector may be separately justified only if CI cannot reproduce the persisted binary identity or truly target-specific evidence is missing.

## Exact execution blocker observed
After creating the workflow through GitHub contents API:
- GET actions/runs?head_sha=56df870a781d9d9f20e4a8fdd3375ebc4c188e8e&per_page=5 returned total_count=0;
- GET actions/runs?per_page=3 also returned total_count=0;
- refs/heads/main confirmed the workflow/source commit exists;
- the connector rejected GET actions/workflows/oclp-d97hw-golden-p3-static-compare.yml with HTTP 400, URL not allowed by connector;
- tool discovery for workflow/dispatch exposed read/rerun tools but no workflow_dispatch action;
- plugin discovery returned the already-installed GitHub integration, not an additional usable dispatch capability.

Classification: `CI_TRIGGER_NOT_OBSERVED_AND_DIRECT_DISPATCH_UNAVAILABLE_IN_CURRENT_CONNECTOR`.
This is NOT proof of exhausted quota, disabled Actions, invalid YAML, billing failure or a failed runner job. Those causes remain UNKNOWN.
No run ID, job ID, actual runner, artifact ID/digest or CI PASS exists for this attempt. Do not invent them.
No local compile/static-analysis fallback is authorized.

## Important comparison limits
Equal donor bytes do not prove Sequoia traverses the same branch for a corresponding shader/request.
A common validator with different behavior can reflect input data, caller/route selection, dependencies or runtime context; input-layout error is not the only explanation.
The prior explanation `Sequoia passes this exact validator; Tahoe fails it` remains a comparison hypothesis until same-boundary evidence proves it.
P3 changed the observed frontier, but that alone does not establish that all serialized bitcode metadata is semantically valid.
The decode-truncated log fragments are not yet full diagnostics or proof of a specific validator failure. Xref mapping must be joined with runtime provenance.
P2b is not authorized merely because 0xD0 and 0x110 occur in the historical design.

## CURRENT ACTION
Resolve the GitHub execution trigger without changing ASUS2.
A user-side web dispatch is the minimal intervention if available: repository Actions -> `OCLP D97HW Golden vs P3 static comparison` -> Run workflow -> main.
If Actions requires initial enablement or reports a restriction, preserve that exact message before any broader permissions/billing change. Do not assume the cause.
Once a run exists, assistant reads/audits it and its artifact; only then classifies the static comparison and decides whether any ASUS2-specific evidence is necessary.

`D97HW_SOURCE_AND_WORKFLOW=PUBLISHED`
`D97HW_CI_EXECUTION=NOT_OBSERVED`
`D97HW_STATIC_COMPARISON_RESULT=NOT_OBTAINED`
`D97HW_GOLDEN_RUNTIME_EQUIVALENCE=UNKNOWN`
`P2B_AUTHORIZED=NO`
`ROOT_PATCH_AUTHORIZED=NO`
`REBOOT_AUTHORIZED=NO`
