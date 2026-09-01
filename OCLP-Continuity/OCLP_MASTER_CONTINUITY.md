# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260901_D97AB_CYCLE_CRITERION_FALSE_NEGATIVE_D97AC_SCC_AUDIT_READY.md`
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
- D71R: compiler-service lifecycle and deterministic termination are observable through launchd.
- D80 perturbative crash retired by D81 clean control.
- D83: validator receives upstream `llvm::Module*` and derives resource metadata/counters internally.
- D93: RMP `+0` bitcodeType, `+0x08` primary length, `+0x10` primary pointer, `+0x18/+0x20` plugin-data family.
- D95/D95D: 14/14 deliberate SIGILL captures; wrapped LLVM bitcode STRUCTURAL-SEMANTIC PROVEN; exact Golden runtime semantics UNKNOWN.
- D96C: six counter values stable at `validSimulatorMetadata` REL+`0x58B`.
- D97JB: full CFG 81 blocks; REL+`0x58B` dominates all six late predicates and is their earliest post-final-write common dominator.

## D97 compiler and selector provenance
D97 downstream MTLCompiler snapshot:
- site fileoff `0x9D6BD`, cave `0xF80`, UD2 `0xF9F`, R11 magic `0x2152544E43373944`;
- installed 32023 SHA `c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118`.
D97H observed repeated simulator-family service cycles but zero downstream D97 SIGILL.

D97K-T proved:
- MTLCompilerService dynamically selects 3802 or 32023;
- selector semantics: 3802 loads 3802, 32023 loads 32023, other values select no valid path;
- selector is low32 of XPC key `llvmVersion`;
- cached Metal.framework writes `llvmVersion` through exact `_xpc_dictionary_set_uint64`.

## D97U/V/W and D97X/Y/Z
D97U proved the first instruction after the receiver getter at fileoff `0x25C3` preserves full RAX and low32 EAX.
D97V installed a terminal UD2 capture. D97V/VA FASTLANE and manual Root Patch FULL PASS, but D97W produced repeated launchd SIGILL without an accessible register report.

A universal launchd-visible classifier replaced the failed register channel:
- exit 123 = `llvmVersion=3802`;
- exit 124 = `llvmVersion=32023`;
- exit 125 = other.

D97X found no safe executable zero cave, a valid STATIC NEGATIVE.
D97Y proved a safe complete-instruction in-place block `0x25C3..0x25EB`, length 40. D97ZA/D97Z FASTLANE and manual Root Patch FULL PASS. D97Z committed service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`.

## D97AA decisive runtime result
Accelerated boot `17:12`; VESA `17:14` excluded.
D97AA verified exact D97Z identity and classified 12 unique MTLCompilerService children for WindowServer PID 177:
- exit 123: `0`;
- exit 124: `12`;
- exit 125: `0`;
- signal exits: `0`;
- spawn without explicit exit: `0`.

Classification: `RUNTIME_LLVMVERSION_32023_PROVEN_ALL_12_OBSERVED_REQUESTS`.
H4 (`runtime selects 3802`) is rejected for the observed cohort. D97H zero downstream marker is not explained by compiler-generation selection. The unresolved causal interval is `MTLSimCompiler::validSimulatorMetadata` entry through, but not including, REL+`0x58B`.

## D97AB observed static mapper result
Artifact:
- commit `e0519e5b38c029e5bfd6ba141c422b43ca64246e`;
- blob `366fb2a45895723d103b7edb31679a4cd5dd9a16`.

D97AB read-only mapper PASS:
- exact D97 -> P7 reconstruction;
- validator range exact `0x7FFB162C7132..0x7FFB162C7830`;
- 408 instructions, full 81-block CFG, 75 reachable;
- REL+`0x279` indirect switch resolved;
- candidate REL+`0x58B` and three early error xrefs all reachable;
- residual finite terminals B10 (`0xB9..0xCE`) and B80 (`0x6CC..0x6FE`);
- shared cave `0xF80..0xF90` and all six terminal patch windows individually SAFE.

D97AB reported two residual cycles and marked the entire partition incomplete because its criterion was `cycle count == 0`. That is a mapper-methodology false negative: a cyclic CFG component is not an outcome if it has outgoing edges to classified outcomes. D97AB did not perform SCC condensation, closed-SCC detection, reverse outcome reachability or a reachable unresolved-edge gate. No FASTLANE is authorized from D97AB alone.

## D97AC SCC-hardened mapper ready
Wrapper `OCLP7_D97AC_SCC_SINK_AND_RESIDUAL_TERMINAL_HARDENED_WRAPPER.command`:
- commit `6f7848011bca95aa9d1b6cfce7d25b256d860e06`;
- blob `8ddbf1f524c86b2932c2fbaee54f433f19d454d8`.

D97AC is identity-pinned to the exact D97AB blob and changes only static analysis methodology:
- Tarjan SCC condensation;
- closed nonterminal SCC detection;
- reverse reachability from all known and residual finite outcomes;
- reachable outside/unresolved edge gate;
- residual terminal inbound/raw-byte provenance;
- separation of finite-path exhaustiveness from any global loop-termination claim.

A future runtime classifier, if statically authorized, must retain the liveness gate: every spawned MTLCompilerService PID must emit exactly one classifier exit; any spawned PID without one invalidates runtime classification.

## CURRENT ACTION — D97AC
Run D97AC only and return both complete reports:
- `OCLP7_D97AC_SCC_SINK_AND_RESIDUAL_TERMINAL_HARDENED_WRAPPER_REPORT.txt`;
- `OCLP7_D97AC_READONLY_PRE_D97_VALIDATOR_SCC_FINITE_OUTCOME_AUDIT_REPORT.txt`.

Do not Root Patch or reboot. A FASTLANE may be designed only after D97AC proves zero closed nonterminal SCCs, zero reachable outside/unresolved edges, finite-outcome reachability for every reachable block, retained safe windows/cave, and the runtime liveness gate.

D82 remains reserve-only. Patch8 remains unauthorized.
