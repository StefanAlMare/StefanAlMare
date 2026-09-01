# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260901_D97AA_RUNTIME_LLVMVERSION_32023_PROVEN_D97AB_WHOLE_STAGE_MAP_READY.md`
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

One action at a time. Identity-pinned FASTLANE -> full audit -> manual Root Patch -> full audit -> accelerated boot -> VESA recovery -> analyze only accelerated boot -> persist.
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
- D96C: six counter values are stable at `validSimulatorMetadata` REL+`0x58B`.
- D97JB: full CFG 81 blocks; REL+`0x58B` dominates all six late predicates and is their earliest post-final-write common dominator.

## D97 downstream snapshot
D97 MTLCompiler patch:
- site fileoff `0x9D6BD`;
- cave `0xF80`;
- UD2 `0xF9F`;
- R11 magic `0x2152544E43373944`;
- installed 32023 SHA `c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118`.
D97H observed repeated simulator-family service cycles but zero downstream D97 SIGILL. The causal reason remained unresolved.

## D97K-T compiler-version provenance
- D97K: visible 32023 is exact D97; visible 3802 is distinct/non-D97; Current points to 32024.
- D97L: MTLCompilerService dynamically selects compiler paths 3802 or 32023.
- D97M: selector STATIC PROVEN: 32023 loads 32023; 3802 loads 3802; other values select no valid path.
- D97N/O: selector originates from low32 of `xpc_dictionary_get_uint64(request,"llvmVersion")`.
- D97QB/R/S/T: cached Metal.framework owns and writes key `llvmVersion`; exact call target is `_xpc_dictionary_set_uint64`. `METAL_WRITES_LLVMVERSION=STATIC_PROVEN`.

## D97U/V/W register-channel experiment
D97U proved the first instruction after the receiver getter at fileoff `0x25C3` preserves full RAX and low32 EAX.
D97V installed a terminal UD2 capture. D97V/VA FASTLANE and manual Root Patch were FULL PASS; service SHA `bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19`.
D97W accelerated boot produced repeated launchd-visible SIGILL terminations but no `.ips/.crash` with RAX. Register-report channel NEGATIVE; SIGILL channel POSITIVE_REPEATED.

## D97X/Y/Z deterministic exit classifier
Because the crash-register channel failed, a universal launchd-visible terminal classifier was adopted:
- exit 123 = EAX/llvmVersion 3802;
- exit 124 = EAX/llvmVersion 32023;
- exit 125 = other.

D97X found no safe executable zero cave: valid STATIC NEGATIVE.
D97Y proved a safe complete-instruction in-place block file `0x25C3..0x25EB`, length 40, with no inbound direct target, RIP xref, symbol or function boundary. Exact postimage:
`3dda0e0000740c3d177d0000740a6a7d5feb086a7b5feb036a7c5fb8010000020f050f0b90909090`.
Synthetic final service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`.

D97ZA/D97Z FASTLANE FULL PASS:
- D97V replaced by D97Z, not stacked;
- selector/control/P6/P7/D97 retained;
- source/build/package/deploy/fresh-process audits PASS;
- live app SHA `0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f`.

D97Z manual Root Patch FULL PASS:
- selector `31001 -> 32023` verified;
- committed service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- true-five/P6/P7/downstream D97 retained;
- AuxKC and APFS snapshot completed.

## D97AA decisive runtime result
Boot chronology:
- accelerated D97Z classifier boot `17:12`;
- VESA recovery `17:14`, excluded.

D97AA verified the exact D97Z service and block, then classified every observed MTLCompilerService child spawned by WindowServer PID 177.
Observed service PIDs: `323,326,328,331,334,337,340,343,351,353,357,361`.

Exact unique primary results:
- exit 123 / 3802: `0`;
- exit 124 / 32023: `12`;
- exit 125 / other: `0`;
- signal exits: `0`;
- spawned PIDs without explicit exit: `0`.

The reported 33 `unknown` lines are ancillary launchd lifecycle lines repeated after explicit exits, not additional process outcomes.

Authoritative classifications:
- `RUNTIME_LLVMVERSION_32023_PROVEN_ALL_12_OBSERVED_REQUESTS`;
- `PRIMARY_LAUNCHD_EXIT_CLASSIFIER_CHANNEL_POSITIVE`;
- D97Z visible service execution PROVEN;
- no request variation in the observed cohort.

Causal consequence: H4 (`runtime selects 3802`) is rejected for the complete observed cohort. D97H zero downstream D97 marker is not explained by compiler-generation selection. The unresolved causal interval returns to `MTLSimCompiler::validSimulatorMetadata` entry through, but not including, REL+`0x58B`.

## D97AB read-only whole-stage mapper ready
Artifact `OCLP7_D97AB_READONLY_PRE_D97_VALIDATOR_WHOLE_STAGE_OUTCOME_MAP.command`:
- commit `e0519e5b38c029e5bfd6ba141c422b43ca64246e`;
- blob `366fb2a45895723d103b7edb31679a4cd5dd9a16`.

D97AB verifies exact D97, reconstructs exact P7 in a temporary copy, rebuilds the full validator CFG including the REL+`0x279` indirect switch, and partitions all paths before REL+`0x58B` into:
- candidate reached;
- buffer-index error REL+`0x29A`;
- sampler-index error REL+`0x2D9`;
- nested argument-buffer error REL+`0x3E2`;
- any other early terminal outcomes.
It audits residual cycles, complete-instruction terminal windows and the reusable D97 cave at `0xF80` for one shared normal-exit stub. It does not integrate or mutate anything.

## CURRENT ACTION — D97AB
Run D97AB only and return the complete report:
`OCLP7_D97AB_READONLY_PRE_D97_VALIDATOR_WHOLE_STAGE_OUTCOME_MAP_REPORT.txt`.

Do not Root Patch or reboot. A FASTLANE may be designed only after full assistant audit of CFG completeness, path exhaustiveness, patch-window safety and cave safety.

D82 remains reserve-only. Patch8 remains unauthorized.
