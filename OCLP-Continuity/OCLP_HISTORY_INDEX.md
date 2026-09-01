# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-01 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260901_D97AD_ROOTPATCH_FULL_PASS_ACCELERATED_BOOT_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.
Repository recovery: `OCLP_REPOSITORY_RECOVERY_20260901.md`.

## Permanent protocol
Identity-pinned FASTLANE -> complete audit -> manual Root Patch -> complete audit -> accelerated boot -> VESA recovery -> analyze only immediately preceding accelerated boot -> persist. Golden immutable/read-only. No automatic Root Patch/reboot. Missing `.ips` alone never hard negative. Control-flow is not semantic proof.

## Functional baseline
P1 -> P2b -> P3 -> AIR00 -> D34.
True-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
Golden SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`.
D34 cave protected. P6/P7 retained, sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. Patch8 unauthorized.

## Durable milestones
- D22: AIR2.6/Metal3.1 SEMANTIC PROVEN.
- D69/D70: WindowServer downstream of compiler XPC failure.
- D71R: service lifecycle and deterministic termination observable through launchd.
- D83: upstream `llvm::Module*`; metadata counters derived internally.
- D93: primary RMP contract.
- D95D: wrapped LLVM bitcode STRUCTURAL-SEMANTIC PROVEN.
- D96C: six-counter state stable at validator REL+0x58B.
- D97JB: REL+0x58B universal for all six late predicates and earliest post-final-write common dominator.

## D97 compiler generation provenance
D97K-T traced MTLCompilerService selection to XPC key `llvmVersion` and proved cached Metal.framework writes it through exact `_xpc_dictionary_set_uint64`.
Selector semantics STATIC PROVEN: 3802 loads MTLCompiler 3802; 32023 loads 32023; other values select no valid path.

## D97U through D97Z
D97U mapped the receiver post-getter boundary with RAX/EAX live. D97V register capture produced repeated SIGILL but no register report. D97Z replaced it with launchd exits 123/124/125. D97X found no safe zero cave; D97Y proved the service in-place block. D97ZA/D97Z FASTLANE and Root Patch FULL PASS.

## D97AA — runtime llvmVersion 32023 PROVEN
Accelerated boot `17:12`; VESA `17:14` excluded.
Twelve MTLCompilerService children produced twelve primary exit 124 results, zero 123, zero 125, zero signals and zero missing exits.
Classification: `RUNTIME_LLVMVERSION_32023_PROVEN_ALL_12_OBSERVED_REQUESTS`.
H4 (`runtime selects 3802`) rejected for the observed cohort. Unresolved interval returned to `validSimulatorMetadata` entry through REL+0x58B.

## D97AB / D97AC — whole-stage finite outcomes
D97AB reconstructed exact P7 and mapped 408 instructions, 81 blocks, 75 reachable blocks and the REL+0x279 switch. It found candidate REL+0x58B, three known early errors, two residual finite outcomes, safe cave and six safe patch windows. Its zero-cycle exhaustiveness gate was a methodology false negative.

D97AC Tarjan SCC and reverse reachability proved:
- zero closed nonterminal SCCs;
- zero reachable outside/unresolved edges;
- zero blocks without a classified finite-outcome path;
- finite-path partition exhaustive STATIC PASS;
- static global termination not claimed;
- all six windows and shared exit-stub cave safe.

Outcome codes:
- 110 candidate REL+0x58B;
- 111 buffer index REL+0x29A;
- 112 sampler index REL+0x2D9;
- 113 nested argument buffer REL+0x3E2;
- 114 other early REL+0xB9 or REL+0x6CC.
Mandatory runtime liveness gate: every spawned service PID must emit exactly one 110–114.

## D97AD — final identity/source transition FULL PASS
D97AD proved selector-only service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, exact P7 reconstruction, six exact non-overlapping postimages, synthetic disassembly PASS and final D97AD MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. Planned active order is `selector -> control -> P6 -> P7 -> D97AD`, by replacement rather than stacking.

## D97AEA through D97AEI — tooling failures and source-state recovery
Several wrapper/audit failures were classified as tooling rather than Haswell evidence: a truncated P6 expected SHA literal, narrow regex/AST binding assumptions, stale pre-transition source expectations, and source-range/code-object identity methods that did not reproduce the historical measurement contract.

D97AEI finally reproduced the exact historical retained-helper segment SHAs through `ast.get_source_segment` for selector, control, P6 and P7 and proved exact post-transition call order/receiver. It also exposed a third tracked dirty file, `metal_3802.py`.

## D97AEJ — Tahoe Metal 3802 substrate classified required
`metal_3802.py` working copy blob `2ea2a73c1642892d14168168b7961b3385cece81`, SHA256 `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`, was proven semantic and historical, not accidental. It supplies the Tahoe compiler substrate including `MTLCompilerService.xpc`, MTLCompiler/GPUCompiler framework handling and retained QuartzCore metallib behavior. It is therefore an authorized third tracked file for the exact D97AD snapshot.

## D97AEK/L/M — exact private three-file snapshot push FULL PASS
Authorized tracked files:
- `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`;
- `opencore_legacy_patcher/sys_patch/sys_patch.py`;
- `opencore_legacy_patcher/sys_patch/sys_patch_helpers.py`.

After correcting only push-lane tooling issues (`snapshot-v2` stale `git add` path and a self-referential forbidden-operation scanner), the exact source snapshot was pushed to private repo `StefanAlMare/Private-Work`, branch `oclp7-d97ad-github-build`, commit `1faab13865eb945198f3551688f11f1ba645e29a`.

## Private GitHub Actions D97AD build FULL PASS
Workflow `.github/workflows/oclp7-d97ad-build-v2.yml`, run `33553271179`, job `100007798331`, Intel runner `macos-15-intel`, completed successfully.

Artifact:
- ID `9818489515`;
- name `OCLP7-D97AD-OpenCore-Patcher-v2`;
- size `751552700`;
- digest `sha256:d570342beed9ceac1f37df24d7c4fa1ba0ad106114139f2e555ccba3f64ccc63`;
- inner app zip SHA `c7951479492acbb2ce352d0958a2be84219db4b10484a0ce8cbb9238d0ef778c`;
- packaged app executable SHA `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`.

Packaged audit proved D97Z and D97 absent, D97AD exactly once, runtime contract PASS, Tahoe compiler substrate PASS.

## D97AEO / D97AEP — exact artifact download/audit/deploy FULL PASS
D97AEP corrected only the zsh special `path` parameter collision in D97AEO. The corrected deployment pipeline verified GitHub run/artifact metadata, downloaded and verified the exact artifact, validated the inner ZIP, manifest and build audit, verified staged x86_64 app SHA, backed up the exact D97Z app, deployed the exact D97AD app, and proved a fresh process at the canonical `/Applications/OpenCore-Patcher.app` path.

Current D97AD live app executable SHA:
`5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`.

D97Z backup:
`/Applications/OpenCore-Patcher.app.D97Z-before-D97AD-GitHub-20260901-232929`, executable SHA `0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f`.

## D97AD manual Root Patch — FULL PASS
The validated D97AD application completed the manual Root Patch successfully.

The transcript proved the retained chain and exact identities:
- selector `31001 -> 32023` verified;
- P2b request-layout bridge verified;
- P3 serialized-bitcode path verified;
- AIR00 and D34 verified;
- true-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`;
- P6 committed SHA `4b7660f6ddebd615cca4e67667f2e29a29366aa5b872866cfa79592d2cb6be76`;
- P7 committed SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`;
- D97AD committed MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`;
- D97AD classifier PASS and outcome/liveness contract printed exactly.

D97Z service terminal classifier and downstream D97 six-counter diagnostic are absent from the Root Patch transcript, matching the packaged/source transition. Patch process completed through AKC build, APFS snapshot creation and unmount without error.

## CURRENT ACTION
Accelerated D97AD boot is authorized. If no usable image appears, recover through the permanent VESA procedure. After returning in VESA, first provide `last reboot | head -n 5` so the accelerated and recovery sessions can be pinned before any unified-log audit. Runtime result is valid only if every spawned MTLCompilerService PID in the accelerated cohort produces exactly one classifier exit 110–114; signal/other/missing exit invalidates the cohort.

D82 remains reserve-only; Patch8 unauthorized.
