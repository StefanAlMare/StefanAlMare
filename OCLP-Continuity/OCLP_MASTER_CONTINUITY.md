# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260901_D97AC_FINITE_OUTCOME_PARTITION_STATIC_PROVEN_D97AD_FINAL_IDENTITY_MAP_READY.md`
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

One action at a time. Identity-pinned FASTLANE -> full audit -> manual Root Patch -> full audit -> accelerated boot -> VESA recovery -> analyze only immediately preceding accelerated boot -> persist.
Never auto Root Patch or reboot. Missing `.ips` alone is never hard negative. Control-flow is not semantic proof.
D50/D68/D82 remain reserve-only. D84 retired. Patch8 unauthorized.

Architecture: `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working Sequoia/OCLP donor path -> image`.

## Accepted functional lineage
P1 selector bridge -> P2b request layout `+0xD0 -> +0x110` -> P3 serialized-bitcode path -> AIR00 AIR2.6/Metal3.1 -> D34 semantic-equivalent reset.
D34 protected cave `0xEF8..0xEFE = 48 89 F8 48 89 37 C3`.
P6 retained SHA `4b7660f6ddebd615cca4e67667f2e29a29366aa5b872866cfa79592d2cb6be76`, runtime sufficiency NEGATIVE.
P7 retained SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`, runtime sufficiency NEGATIVE.

## Durable semantic/runtime facts
- D22: AIR2.6/Metal3.1 SEMANTIC PROVEN.
- D36-D44 invalidated by D34 cave collision.
- D69/D70: WindowServer/SkyLight is downstream of compiler XPC failure.
- D71R: compiler-service lifecycle and deterministic termination observable through launchd.
- D80 perturbative crash retired by D81 clean control.
- D83: validator receives upstream `llvm::Module*` and derives resource metadata/counters internally.
- D93: RMP `+0` bitcodeType, `+0x08` primary length, `+0x10` primary pointer, `+0x18/+0x20` plugin-data family.
- D95/D95D: wrapped LLVM bitcode STRUCTURAL-SEMANTIC PROVEN; exact Golden runtime semantics UNKNOWN.
- D96C: six counter values stable at `validSimulatorMetadata` REL+`0x58B`.
- D97JB: full CFG 81 blocks; REL+`0x58B` dominates all six late predicates and is their earliest post-final-write common dominator.

## D97 compiler and selector provenance
D97 downstream snapshot:
- site fileoff `0x9D6BD`, cave `0xF80`, UD2 `0xF9F`, R11 magic `0x2152544E43373944`;
- installed MTLCompiler 32023 SHA `c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118`.
D97H observed repeated simulator-family service cycles but zero downstream D97 SIGILL.

D97K-T proved:
- MTLCompilerService dynamically selects 3802 or 32023;
- selector semantics: 3802 loads 3802, 32023 loads 32023, other values select no valid path;
- selector is low32 of XPC key `llvmVersion`;
- cached Metal.framework writes `llvmVersion` through exact `_xpc_dictionary_set_uint64`.

## D97U through D97Z
D97U proved full RAX/low32 EAX live immediately after the receiver getter at fileoff `0x25C3`.
D97V installed a terminal UD2 capture; repeated SIGILL was visible but no accessible register report was generated.

D97Z replaced the failed register channel with universal launchd-visible exits:
- 123 = `llvmVersion=3802`;
- 124 = `llvmVersion=32023`;
- 125 = other.

D97X found no safe zero cave. D97Y proved a safe in-place service block `0x25C3..0x25EB`. D97ZA/D97Z FASTLANE and manual Root Patch FULL PASS. D97Z service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`; live app SHA `0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f`.

## D97AA decisive runtime result
Accelerated boot `17:12`; VESA `17:14` excluded.
Twelve unique MTLCompilerService children for WindowServer PID 177 yielded:
- exit 123: `0`;
- exit 124: `12`;
- exit 125: `0`;
- signal exits: `0`;
- spawned PID without explicit exit: `0`.

Classification: `RUNTIME_LLVMVERSION_32023_PROVEN_ALL_12_OBSERVED_REQUESTS`.
H4 (`runtime selects 3802`) is rejected for the observed cohort. The unresolved causal interval is inside `MTLSimCompiler::validSimulatorMetadata`, from entry through but not including REL+`0x58B`.

## D97AB methodology correction
D97AB reconstructed exact P7 and mapped the exact validator CFG: 408 instructions, 81 blocks, 75 reachable, indirect switch REL+`0x279` resolved. Candidate REL+`0x58B`, three known early errors and two residual finite outcomes were mapped. Shared cave and all six patch windows were SAFE.

D97AB marked the partition incomplete solely because cyclic regions existed. That criterion was retired: a cycle is not an outcome when it has outgoing paths to classified finite outcomes.

## D97AC — finite-path outcome partition STATIC PROVEN
Wrapper:
- commit `6f7848011bca95aa9d1b6cfce7d25b256d860e06`;
- blob `8ddbf1f524c86b2932c2fbaee54f433f19d454d8`.

D97AC wrapper/core PASS and RC 0. Exact D97 -> P7 reconstruction and validator identity retained.

SCC-hardened decisive gates:
- `CLOSED_NONTERMINAL_SCC_COUNT=0`;
- `REACHABLE_OUTSIDE_OR_UNRESOLVED_EDGE_COUNT=0`;
- `BLOCKS_WITHOUT_PATH_TO_CLASSIFIED_FINITE_OUTCOME_COUNT=0`;
- `ALL_REACHABLE_BLOCKS_HAVE_CLASSIFIED_FINITE_OUTCOME_PATH=PASS`;
- `FINITE_PATH_OUTCOME_PARTITION_EXHAUSTIVE_STATIC=PASS`;
- global termination explicitly not claimed because cyclic SCCs exist;
- `SCC_HARDENED_CLASSIFIER_STATIC_READY=YES`.

Finite outcomes and codes:
- 110 candidate/D97 boundary REL+`0x58B`;
- 111 buffer-index error REL+`0x29A`;
- 112 sampler-index error REL+`0x2D9`;
- 113 nested argument-buffer error REL+`0x3E2`;
- 114 normal early return REL+`0xB9` or unwind/cleanup REL+`0x6CC`.

Shared cave `0xF80..0xF90` remains zero and without target/xref/symbol. Stub `b8010000020f050f0b`. All six complete-instruction windows are SAFE.

Classification: `STATIC_PROVEN_FOR_FASTLANE_DESIGN_ONLY_WITH_RUNTIME_LIVENESS_GATE`.
Mandatory runtime gate: every spawned MTLCompilerService PID must emit exactly one exit 110–114; a missing, signal or other exit invalidates the runtime run.

## Required next integration architecture
The next diagnostic must replace, not stack:
1. remove D97Z service helper/call so Root Patch leaves selector-only MTLCompilerService SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
2. replace D97 MTLCompiler helper/call with the whole-stage classifier because it reuses D97's site/cave;
3. retain selector, true-five control, P6 and P7 unchanged.

## D97AD exact final-image/source-transition mapper ready
Artifact:
- commit `96d91d25f9959666c1ade1df10ff2c3c4dfe0cc8`;
- blob `536009a4d1ba9497f0a33fdb17f62dfa9a5089c4`.

D97AD is strictly read-only. It verifies exact live D97Z service/app and D97 MTLCompiler, reconstructs selector-only service and P7, verifies all six pre/postimages and non-overlap with D34/P6/P7, calculates the exact synthetic final MTL SHA, disassembles all six site heads, and proves the current-to-planned source transition: remove D97Z and replace D97 with D97AD, not stacked.

## CURRENT ACTION — D97AD
Run D97AD only and return:
`OCLP7_D97AD_READONLY_PRE_D97_WHOLE_STAGE_FINAL_IMAGE_AND_SOURCE_TRANSITION_MAP_REPORT.txt`.

Do not Root Patch or reboot. Build the FASTLANE only after the exact final SHA and source-transition map pass assistant audit.

D82 remains reserve-only. Patch8 remains unauthorized.
