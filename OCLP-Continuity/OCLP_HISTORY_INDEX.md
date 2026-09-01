# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-01 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260901_D97Y_INPLACE_CLASSIFIER_STATIC_PROVEN_D97ZA_FASTLANE_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.
Repository recovery: `OCLP_REPOSITORY_RECOVERY_20260901.md`.

## Permanent protocol
Identity-pinned FASTLANE -> complete audit -> manual Root Patch -> complete audit -> accelerated boot -> VESA recovery -> analyze only accelerated boot -> persist. Golden immutable/read-only. No automatic Root Patch/reboot. Missing `.ips` alone never hard negative. Control-flow != semantic proof.

## Functional baseline
P1 -> P2b -> P3 -> AIR00 -> D34.
True-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.
Golden SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`.
D34 cave protected. P6/P7 retained, sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. Patch8 unauthorized.

## Major durable milestones
- D22: AIR2.6/Metal3.1 SEMANTIC PROVEN.
- D69/D70: WindowServer downstream of compiler XPC failure.
- D71R: service lifecycle observable through launchd.
- D83: upstream `llvm::Module*`; resource counters derived internally.
- D93: primary RMP contract.
- D95D: 14/14 deliberate SIGILL; wrapped LLVM bitcode STRUCTURAL-SEMANTIC PROVEN.
- D96C: six-counter state stable at +0x58B.
- D97H: 64/64 simulator-family/exit1 and zero downstream D97 SIGILL.
- D97JB: +0x58B universal for all six late predicates and earliest post-final-write common dominator.

## D97 compiler-version provenance
- D97K: visible 32023 exact D97, 3802 non-D97, 32024 cache/filesystem discrepancy.
- D97L: service dynamically selects 3802 or 32023.
- D97M: exact selector semantics STATIC PROVEN.
- D97N: selector from `ctx(int)` block +0x20.
- D97O: source is request key `llvmVersion` low32.
- D97P: visible frameworks contained no sender writer.
- D97Q/QA: tooling failures only.
- D97QB: shared-cache scan found Metal request cluster and cached 32024.
- D97R: two Metal callsites with int32 sources `[RBX+0x1C]` / `[RCX+0x38]`.
- D97S: common call target stub -> GOT.
- D97T: GOT slide decode and exact libxpc export equality prove `Metal.framework` writes `llvmVersion` via `_xpc_dictionary_set_uint64`.

## D97U/V installation and D97W observation
D97U mapped the exact receiver boundary after `xpc_dictionary_get_uint64` at fileoff `0x25C3`; RAX/EAX live and no selector overlap.
D97V/VA FASTLANE FULL PASS and manual Root Patch FULL PASS. Installed service SHA `bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19`, terminal bytes `0f0b9090909090`. Downstream D97 retained.

D97W analyzed accelerated boot 14:00, excluding VESA 14:03. DiagnosticReports contained zero in-window register captures, but unified log showed 15 explicit MTLCompilerService SIGILL terminations. Register channel NEGATIVE; SIGILL termination channel POSITIVE_REPEATED. Runtime `llvmVersion` remained UNKNOWN.

## Deterministic exit-code methodology
The register-dependent SIGILL method was retired for this question. Universal terminal launchd-visible classifier:
- exit 123 for EAX 3802;
- exit 124 for EAX 32023;
- exit 125 for other.

## D97X — cave placement STATIC NEGATIVE
Artifact commit `09d9a64bbf8789a3227693adec37c3d06551ee53`, blob `71bd9caedd19b71d16637d9bdbd5263930824192`.
Exact identity/reconstruction PASS, but executable zero-runs >=48 bytes = 0 and safe cave candidates = 0. Cave-based placement unauthorized. This is a valid STATIC NEGATIVE; safety criteria remain unchanged.

## D97Y — in-place complete block and classifier STATIC PROVEN
Artifact commit `4e3d2333d1d28350295ce2710e82431edba1ed3f`, blob `549c894920b9fb1d688272f6b50034b3763bcf55`.

D97Y FULL PASS:
- exact D97V and selector-only identities;
- minimum complete block file `0x25C3..0x25EB`, length 40, six straight-line instructions;
- first untouched instruction at `0x25EB`;
- no direct target, RIP xref, symbol or function boundary inside the block;
- exact 36-byte classifier plus four NOPs;
- all branch destinations and semantic tests PASS;
- selector 32023/3802 and next instruction retained;
- synthetic final service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- synthetic disassembly PASS.

Classifications: in-place complete block STATIC PROVEN, inbound-reference safety STATIC PROVEN, three-way exit classifier STATIC PROVEN.

## D97Z / D97ZA — FASTLANE ready
D97Z compressed core payload commit `09543f3f5e7ad816d15650580ed17165eb698b0f`:
- part1 blob `ad2bac11c3875ae725855031cae5c00de443935d`;
- part2 blob `02325e749088750bef7ce02cfb9cfa09f8d32f29`;
- part3 blob `74517f92d02917fd839f3034f73e51875377ac67`;
- part4 blob `4177b268cad02d4c740fe8b1ac53c08e451ad9a6`.
Core SHA256 `419516697a9d69b888ec8fb03c10d6892c809c2e1a7653f190739f87350c3716`.

D97ZA wrapper `OCLP7_D97ZA_DIRECT_PINNED_INPLACE_EXIT_CLASSIFIER_FASTLANE_WRAPPER.command`:
- commit `32ebc5a679b92f4ea6a9dc7a234e6281d7f61177`;
- blob `c0816d84048364eb793dcab0f55c3a4e8bcc1a70`.

Wrapper verifies all payload blobs, exact decompressed core, zsh/Python contracts and no automatic Root Patch/reboot. Core replaces D97V helper/call by D97Z in the same positions — not stacked — and performs the full validation/integration/build/package/SHA/backup/deploy/open/STOP discipline. Downstream D97 remains retained.

## CURRENT ACTION
Run D97ZA only and return the complete wrapper and core reports. Do not Root Patch or reboot until full assistant audit and explicit authorization. D82 remains reserve-only; Patch8 unauthorized.
