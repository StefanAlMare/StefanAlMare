# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260901_D97AEP_D97AD_APP_DEPLOYED_ROOTPATCH_READY.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
Updated: 2026-09-01 EEST

## Mandatory startup
Before any technical change read in full:
1. `OCLP_PERMANENT_WORKING_RULES.md`;
2. this MASTER;
3. `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. the exact checkpoint named above;
5. `OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP_HISTORY_INDEX.md`.

## Permanent contract
Target Tahoe `26.6.2 / 25G82`, Intel Haswell HD4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
Local OCLP branch `alex-tahoe-25G82-custom`, expected HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`.
Golden root-patched MTLCompiler SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`, immutable/read-only.
True-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.

One action at a time. Identity-pinned FASTLANE -> full audit -> manual Root Patch -> full audit -> accelerated boot -> VESA recovery -> analyze only the immediately preceding accelerated boot -> persist.
Never auto Root Patch or reboot. Missing `.ips` alone is never a hard negative. Control-flow is not semantic proof.
D50/D68/D82 remain reserve-only. D84 retired. Patch8 unauthorized.

Architecture: `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working Sequoia/OCLP donor path -> image`.

## Accepted functional lineage
P1 selector bridge -> P2b request layout `+0xD0 -> +0x110` -> P3 serialized-bitcode path -> AIR00 AIR2.6/Metal3.1 -> D34 semantic-equivalent reset.
D34 protected cave `0xEF8..0xEFE = 48 89 F8 48 89 37 C3`.
P6 retained MTL SHA `4b7660f6ddebd615cca4e67667f2e29a29366aa5b872866cfa79592d2cb6be76`, runtime sufficiency NEGATIVE.
P7 retained MTL SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`, runtime sufficiency NEGATIVE.

Retained source-helper segment SHAs:
- selector `adb3981f5ac58820d4715436f56936ce2cae1bcf7c162107d215ff6150ee61a4`;
- true-five control `254104fa863b6d0b8e9c27a6db907b423c3153958d3e51fc4cbd912c7ebe6ac9`;
- P6 `ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0da06c13a`;
- P7 `a8fdac12d07a152e4a9ba5fc79558e0c594634f7762f6fd373421176e1a5b66b`.

## Durable semantic/runtime facts
- D22: AIR2.6/Metal3.1 SEMANTIC PROVEN.
- D69/D70: WindowServer/SkyLight is downstream of compiler XPC failure.
- D71R: compiler-service lifecycle and deterministic termination are observable through launchd.
- D83: validator receives upstream `llvm::Module*` and derives metadata/resource counters internally.
- D93: RMP `+0` bitcodeType, `+0x08` primary length, `+0x10` primary pointer, `+0x18/+0x20` plugin-data family.
- D95D: wrapped LLVM bitcode STRUCTURAL-SEMANTIC PROVEN; exact Golden runtime semantics UNKNOWN.
- D96C: six counter values stable at `validSimulatorMetadata` REL+`0x58B`.
- D97JB: full CFG 81 blocks; REL+`0x58B` dominates all six late predicates and is their earliest post-final-write common dominator.

## D97 compiler-generation provenance
D97K-T proved MTLCompilerService selector semantics and provenance:
- 3802 loads MTLCompiler 3802;
- 32023 loads MTLCompiler 32023;
- another value selects no valid compiler path;
- selector is low32 of request key `llvmVersion`;
- cached Metal.framework writes `llvmVersion` through exact `_xpc_dictionary_set_uint64`.

D97Z installed launchd-visible exits 123/124/125. D97AA observed 12 unique MTLCompilerService children in the accelerated cohort, all with primary exit 124, zero 123, zero 125, zero signals and zero missing exits. Therefore `RUNTIME_LLVMVERSION_32023_PROVEN_ALL_12_OBSERVED_REQUESTS`; the 3802-selection hypothesis is rejected for that cohort.

## D97AC — finite-path partition STATIC PROVEN
D97AC established:
- zero closed nonterminal SCCs;
- zero reachable outside/unresolved edges;
- zero reachable blocks without a path to a classified finite outcome;
- every reachable block has a path to a classified finite outcome;
- finite-path partition exhaustive STATIC PASS;
- global termination not claimed because cyclic SCCs exist.

Mapped outcomes:
- 110 reaches REL+`0x58B`;
- 111 buffer-index error REL+`0x29A`;
- 112 sampler-index error REL+`0x2D9`;
- 113 nested argument-buffer error REL+`0x3E2`;
- 114 normal early return REL+`0xB9` or unwind/cleanup REL+`0x6CC`.

Shared cave and all six complete-instruction windows are SAFE. Mandatory runtime gate: every spawned MTLCompilerService PID must emit exactly one exit 110–114; missing, signal or other exit invalidates the run.

## D97AD — exact final transition FULL PASS
D97AD proved:
- removing D97Z reconstructs selector-only service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- removing D97 reconstructs exact P7 SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`;
- all six outcome pre/postimages and the shared stub are exact and non-overlapping with D34/P6/P7;
- synthetic disassembly PASS;
- exact final D97AD MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`;
- planned active order `selector -> control -> P6 -> P7 -> D97AD` is statically proven.

## D97AD source snapshot and private GitHub build
The exact local post-transition source state was verified with three authorized tracked changes: `metal_3802.py`, `sys_patch.py`, and `sys_patch_helpers.py`. `metal_3802.py` is the required historical Tahoe compiler substrate, not an accidental dirty file.

Private snapshot/build lineage:
- private repo `StefanAlMare/Private-Work`;
- branch `oclp7-d97ad-github-build`;
- snapshot commit `1faab13865eb945198f3551688f11f1ba645e29a`;
- workflow `.github/workflows/oclp7-d97ad-build-v2.yml`;
- run `33553271179`, job `100007798331`, Intel runner, conclusion success;
- artifact `9818489515`, `OCLP7-D97AD-OpenCore-Patcher-v2`;
- artifact digest `sha256:d570342beed9ceac1f37df24d7c4fa1ba0ad106114139f2e555ccba3f64ccc63`;
- inner app zip SHA `c7951479492acbb2ce352d0958a2be84219db4b10484a0ce8cbb9238d0ef778c`;
- packaged D97AD executable SHA `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`.

Packaged audit proved D97Z absent, D97 absent, D97AD exactly once, exact D97AD runtime contract, and Tahoe Metal 3802 compiler substrate.

## D97AEO / D97AEP — D97AD app deployment FULL PASS
D97AEP corrected only a zsh special-parameter collision (`path` rebinding `PATH`) in D97AEO by renaming three tool-loop references to `tool_path`; all artifact/deploy identities and rollback logic remained unchanged.

D97AEO then passed exact workflow/artifact metadata, downloaded artifact, inner ZIP/manifest/build-audit validation, x86_64 staged app identity, D97Z live preimage identity, backup, deployment SHA equality, and fresh-process provenance.

Current live application:
`/Applications/OpenCore-Patcher.app` executable SHA `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`.
Fresh process proven at the canonical application path.

D97Z backup:
`/Applications/OpenCore-Patcher.app.D97Z-before-D97AD-GitHub-20260901-232929`, executable SHA `0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f`.

No Root Patch or reboot occurred after D97AD application deployment. Therefore the currently root-patched system layer remains D97Z service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c` plus D97 MTL SHA `c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118` until the next manual Root Patch.

Expected post-Root-Patch identities:
- selector-only MTLCompilerService SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- D97AD MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`;
- active order `selector -> control -> P6 -> P7 -> D97AD`.

## CURRENT ACTION — MANUAL ROOT PATCH D97AD
Manual Root Patch is authorized from the currently deployed D97AD application only. Do not reboot when patching completes. Return the complete Root Patch transcript for assistant audit. Only after exact service/MTL identities and the full patch chain are audited may an accelerated boot be authorized.

D82 remains reserve-only. Patch8 remains unauthorized.
