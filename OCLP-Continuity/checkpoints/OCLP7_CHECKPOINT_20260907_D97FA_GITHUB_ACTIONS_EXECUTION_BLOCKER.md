# OCLP7 D97FA — GitHub Actions execution blocker after D97EY / D97EZ design

Date: 2026-09-07 EEST
Target project: ASUS2 Tahoe Haswell

## Technical authority entering D97FA
D97EY remains the latest decisive runtime/semantic proof:
- exact accelerated D97EW run `/Users/Shared/OCLP-D97EW-Capture/20260907T115054Z-295`;
- D97ES 0.0.11 exact route PASS;
- first-eight `set_id_mode` tuples captured and persisted;
- `mode=0x24 -> ret=0` SEMANTIC PROVEN for captured calls;
- `mode=0x224`, with exact extra `badBits=0x200` and same `goodBits=0x24`, -> `0xE00002C2` / `kIOReturnBadArgument` SEMANTIC PROVEN for captured calls;
- bit `0x200` semantic name remains UNKNOWN;
- global mask remains forbidden.

D97EY checkpoint commit:
`f2762e713565b1e72498241de639bdd5698c82c6`.

## D97EZ GitHub-first preparation completed
Exact-match experimental architecture was designed in GitHub:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_EXACT_224_ADAPTER_DESIGN.md`
- design commit `8384f183303831ddd117652ef90e5c707a2ee589`.

Generator:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_EXACT_224_ADAPTER_GENERATOR.py`
- current generator commit `cd76d912018bfa60284af3cb732ae8bca84db091`;
- current Git blob `3bf728b999e2163af77742686d7ce9aaac04e8fb`;
- exact D97ES input SHA pin `8184610aca1f2e651e6526e45c05d00a96055711c985571bc34c703ba7f6a8d0`;
- proposed functional gate `-ocmcd97ez`;
- LATENT by default;
- exact-match only: ACTIVE + `originalMode == 0x224` -> `passedMode=0x24`;
- all other modes pass unchanged;
- Apple original called exactly once;
- exact Apple IOReturn returned unchanged;
- global/no-PID counters and original/passed-mode telemetry included;
- no broad mode mask / no return coercion.

GitHub-first build/audit workflow:
`.github/workflows/oclp7-d97ez-exact224-adapter-build.yml`
- initial workflow commit `6c9e21e548904f7c3597ab67cc44d00a002f0fd9`;
- intended runner `macos-15-intel`;
- reconstructs exact D97DL -> D97EH -> D97EL -> D97ES lineage;
- deterministic D97EZ generation;
- source semantic audit;
- pinned Lilu/MacKernelSDK/FeatureUnlock x86_64 build;
- OCLPMetalCompat 0.0.12 build;
- binary identity, strings/nm/disassembly audit;
- SHA manifest and GitHub artifact publication;
- no ASUS2 mutation, Root Patch or reboot.

## GitHub Actions trigger investigation
### Attempt 1 — direct push/main workflow path
The workflow file was created on `main` by commit `6c9e21e548904f7c3597ab67cc44d00a002f0fd9` with `push` on `main` and `workflow_dispatch` configured.

Observed through GitHub Actions runs API:
- query scoped to head SHA returned `total_count=0`, `workflow_runs=[]`;
- repository-wide recent runs query returned `total_count=0`, `workflow_runs=[]`.

The connected GitHub tool exposes read/rerun Actions operations for existing runs but exposes no workflow-dispatch/create-run operation. Therefore `workflow_dispatch` cannot be invoked through the currently available connector.

### Attempt 2 — pull_request native trigger
To exclude a push-trigger-only problem, `pull_request` on `main` was added to the workflow:
- commit `320c8caab6d6f0c7790eef27d2b120acbb883c7e`.

A dedicated branch was created:
`oclp7-d97ez-exact224-ci`.

Draft PR #17 was opened:
`OCLP7 D97EZ GitHub-first exact 0x224 adapter CI audit`.

Initial PR head:
`dc7e11ebf989cc41ed931ba066fc6da1efab4f14`.

The PR contained only a documentation-only CI-trigger note; no runtime/generator change.

Observed:
- `fetch_commit_workflow_runs` for initial PR head returned an empty workflow run list.

### Attempt 3 — synchronize event on already-open PR
A second documentation-only commit was pushed to the same PR branch to force a `pull_request` synchronize event:
- head `58c6c0332e67c43de31260a6c8d613ea8c00f40b`.

Observed:
- `fetch_commit_workflow_runs` for synchronized head returned an empty workflow run list;
- repository-wide Actions runs API still reports `total_count=0`, `workflow_runs=[]`;
- combined commit status for the synchronized head contains no statuses/checks.

## Access/permission boundary
Repository metadata from the authenticated GitHub connection reports:
- repository `StefanAlMare/StefanAlMare`;
- visibility public;
- default branch `main`;
- connector repository permissions include `admin=true`, `maintain=true`, `pull=true`, `push=true`, `triage=true`.

Therefore GitHub content/branch/PR write permission is not the observed blocker.

The current connector does not expose the repository Actions settings/enablement endpoint or a workflow dispatch action. Thus the deeper cause of zero Actions runs (for example repository Actions disabled/restricted versus another GitHub-side execution policy) is not directly observable through the available Actions interface.

## Blocker classification
Directly observed:
- workflow source exists on main = PASS;
- push trigger configured = PASS;
- pull_request trigger configured = PASS;
- branch/PR creation and synchronize event generation = PASS;
- repository write/admin capability = PASS;
- Actions workflow run generation/visibility after all trigger paths = ABSENT;
- existing workflow runs in repository-wide query = ZERO;
- workflow dispatch capability in current connector = UNAVAILABLE.

Classification:
- `D97FA_D97EZ_DESIGN=READY`;
- `D97FA_D97EZ_GENERATOR=READY_FOR_CI`;
- `D97FA_D97EZ_GITHUB_WORKFLOW=CREATED`;
- `D97FA_GITHUB_CONTENT_WRITE=PASS`;
- `D97FA_GITHUB_PUSH_TRIGGER_RUN=ABSENT`;
- `D97FA_GITHUB_PR_OPEN_TRIGGER_RUN=ABSENT`;
- `D97FA_GITHUB_PR_SYNC_TRIGGER_RUN=ABSENT`;
- `D97FA_GITHUB_REPOSITORY_RUN_COUNT=0`;
- `D97FA_GITHUB_WORKFLOW_DISPATCH_CONNECTOR_CAPABILITY=UNAVAILABLE`;
- `D97FA_GITHUB_ACTIONS_EXECUTION=BLOCKED`;
- `D97FA_EXACT_GITHUB_ACTIONS_ROOT_CAUSE=UNKNOWN`;
- `D97FA_LOCAL_COMPILATION_AUTHORIZED=NO`;
- `D97FA_ASUS2_MUTATION_AUTHORIZED=NO`;
- `D97FA_ROOT_PATCH_AUTHORIZED=NO`;
- `D97FA_REBOOT_AUTHORIZED=NO`;
- `D97FA_D97EZ_DEPLOYMENT_AUTHORIZED=NO`.

## GitHub-first policy consequence
Per permanent project rule, a GitHub-eligible build/compile/package/audit operation that is genuinely blocked in GitHub must STOP with the exact blocker documented. Local compilation is not an implicit fallback and requires explicit user authorization.

No D97EZ binary identity, package, deployment or runtime authorization may be claimed from source design alone.

## CURRENT ACTION — GITHUB ACTIONS EXECUTION BLOCKER
Stop D97EZ build progression until GitHub Actions execution becomes available for `StefanAlMare/StefanAlMare` through a working trigger/dispatch path.

Once GitHub Actions becomes executable, resume the existing D97EZ workflow; repair any CI/build failures in GitHub; audit the complete source/build/binary/package/artifact result; then persist a separate deployment checkpoint.

Until then:
- no local compilation fallback;
- no ASUS2 EFI change;
- no new bootarg `-ocmcd97ez` on ASUS2;
- no Root Patch;
- no reboot/accelerated boot;
- D97ES 0.0.11 and current VESA recovery state remain authoritative.