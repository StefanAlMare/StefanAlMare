# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260901_D97AEA_FALSE_SHA_MAP_FAIL_D97AEB_READY.md`
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
- D97Z service `3238bd5efd9161fbe53a58601a01667b37c96ff03c3126adace6cc701aa3bcbf`;
- true-five control `254104fa863b6d0b8e9c27a6db907b423c3153958d3e51fc4cbd912c7ebe6ac9`;
- P6 `ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0b545f0da06c13a`;
- P7 `a8fdac12d07a152e4a9ba5fc79558e0c594634f7762f6fd373421176e1a5b66b`;
- D97 `7147d3be9c63968859fd89958aa74a15db6adad866c5f95059f6a61b39b6ae9c`.

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

## D97AEA observed false tooling failure
Original wrapper commit `5c2510b2e6c3ee613f44afecf96b1f57e1ff8515`, blob `35c8328caf111a5f57e4a5cc656ada1f38ce6f83`.
Original core payload commit `473d4bab1571e2a8907d3ae500fb88e5fd9639c0`, decompressed SHA256 `d8166ed5697cf281a60b19dba4c902470c4900de740006431d7cff5580fa5bb6`.

D97AEA passed payload/core identity, zsh/Python compilation, precheck, exact service and MTL transitions, all six synthetic outcome postimages, collision audit and synthetic disassembly. It stopped in `SOURCE PREIMAGE AUDIT` before integration/build/deploy after printing actual P6 helper segment SHA `ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0b545f0da06c13a` and raising a mismatch. The actual SHA is authoritative; the core's expected P6/P7 entries were reversed.

Classification: `D97AEA_SOURCE_PREIMAGE_AUDIT=FALSE_FAIL_P6_P7_EXPECTED_SHA_MAP`.
No functional design, runtime patch bytes, source transition, live application, Root Patch or boot state changed. Failure rollback was invoked.

## D97AEB correction ready
Artifact `OCLP7_D97AEB_P6_P7_SHA_MAP_FIX_WRAPPER.command`:
- commit `d95e9451cfe0f4b3aa447150d1e481d9ab635a83`;
- blob `d9f3bed3882e268c22ec3b37cc285c4a7228dd37`.

D97AEB reconstructs and pins the original D97AE core, modifies only the two P6/P7 expected-helper SHA literals inside the unique failing embedded Python audit block, proves neutralized textual identity for all remaining logic, recompiles every Python block, parses zsh, retains all functional/runtime anchors and executes the complete D97AE FASTLANE. It does not auto Root Patch or reboot.

## CURRENT ACTION — D97AEB
Run D97AEB only and return:
- `OCLP7_D97AEB_P6_P7_SHA_MAP_FIX_WRAPPER_REPORT.txt`;
- `OCLP7_FASTLANE_D97AE_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER_REPORT.txt`.

Do not Root Patch or reboot even if D97AEB/D97AE return PASS. Manual Root Patch requires a separate full assistant audit.

D82 remains reserve-only. Patch8 remains unauthorized.
