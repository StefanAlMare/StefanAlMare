# OCLP7 CHECKPOINT — 2026-09-01 — D97AEP D97AD app deployed / manual Root Patch ready

## Classification
`D97AEO/D97AEP_FASTLANE_DEPLOY=FULL_PASS`.

The exact D97AD application built from the validated three-file Tahoe source snapshot is now deployed at `/Applications/OpenCore-Patcher.app` and fresh-process provenance is proven. No Root Patch or reboot has occurred after this deployment.

## GitHub build provenance
- Private repository: `StefanAlMare/Private-Work`.
- Branch: `oclp7-d97ad-github-build`.
- Exact source snapshot commit: `1faab13865eb945198f3551688f11f1ba645e29a`.
- Workflow: `.github/workflows/oclp7-d97ad-build-v2.yml`.
- Workflow run: `33553271179`; job: `100007798331`; conclusion `success`; Intel runner `macos-15-intel`.
- Artifact ID `9818489515`, name `OCLP7-D97AD-OpenCore-Patcher-v2`, size `751552700` bytes.
- Artifact digest `sha256:d570342beed9ceac1f37df24d7c4fa1ba0ad106114139f2e555ccba3f64ccc63`.
- Inner application ZIP SHA256 `c7951479492acbb2ce352d0958a2be84219db4b10484a0ce8cbb9238d0ef778c`.
- Packaged/deployed D97AD executable SHA256 `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`.

GitHub packaged audit proved D97Z absent, D97 absent, D97AD present exactly once, D97AD runtime contract PASS, and Tahoe Metal 3802 compiler substrate PASS.

## D97AEO / D97AEP local deployment audit
D97AEP corrected only the zsh special `path`/`PATH` variable collision in D97AEO (`path` -> `tool_path` at exactly three references); artifact identity and deployment/rollback logic were unchanged.

D97AEO then proved:
- active GitHub login `StefanAlMare`;
- exact workflow run/head SHA and artifact metadata PASS;
- downloaded inner app ZIP SHA equals `c7951479492acbb2ce352d0958a2be84219db4b10484a0ce8cbb9238d0ef778c`;
- downloaded SHA manifest and GitHub build audit PASS;
- staged app is x86_64 and executable SHA equals `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`;
- live predeploy app was exact D97Z SHA `0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f`;
- D97Z backup created at `/Applications/OpenCore-Patcher.app.D97Z-before-D97AD-GitHub-20260901-232929`, executable SHA exact `0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f`;
- deployed live app SHA exact `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`;
- fresh live process PID 3621 at `/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher`;
- `D97AEO_HARDENED_GITHUB_ARTIFACT_DOWNLOAD_AUDIT_DEPLOY=PASS`;
- `D97AEP_PATH_SAFE_DOWNLOAD_AUDIT_DEPLOY=PASS`.

## Current live layers before manual Root Patch
Application layer:
- D97AD packaged app is live and verified: `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`.

Root-patched system layer remains the previous D97Z/D97 generation because no Root Patch has been run after D97AD deployment:
- expected visible MTLCompilerService = D97Z SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- expected visible MTLCompiler 32023 = D97 SHA `c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118`.

## Exact expected post-Root-Patch D97AD identities
The manual Root Patch must transition, by replacement rather than stacking:
- service: D97Z classifier removed; selector-only MTLCompilerService SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- MTLCompiler 32023: D97 removed; D97AD whole-stage classifier installed; final SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`.

Retained active functional/order contract:
`selector -> true-five control -> P6 -> P7 -> D97AD`.

D97AD outcomes:
- exit 110: validator reaches REL+`0x58B`;
- exit 111: buffer-index error REL+`0x29A`;
- exit 112: sampler-index error REL+`0x2D9`;
- exit 113: nested argument-buffer error REL+`0x3E2`;
- exit 114: other early return REL+`0xB9` or unwind/cleanup REL+`0x6CC`.

D97AC remains authoritative: zero closed nonterminal SCCs, zero reachable outside/unresolved edges, zero reachable blocks without a classified finite-outcome path. Global termination is not statically claimed. Mandatory runtime liveness gate after the later accelerated boot: every spawned MTLCompilerService PID must emit exactly one controlled exit 110–114; any missing classifier exit, signal, or other primary exit invalidates the runtime classification.

## CURRENT SINGLE NEXT ACTION
Manual Root Patch only, from the currently deployed `/Applications/OpenCore-Patcher.app` D97AD build.

After Root Patch completes, DO NOT reboot. Return the complete Root Patch transcript from `Starting Patch Process` through the final completion/reboot prompt. Assistant must audit exact service/MTL identities and patch chain before authorizing an accelerated boot.

D50/D68/D82 remain reserve-only. D84 retired. Patch8 unauthorized. Golden Sequoia remains immutable/read-only.
