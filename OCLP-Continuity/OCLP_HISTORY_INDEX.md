# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-01 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260901_D97X_NO_SAFE_ZERO_CAVE_D97Y_INPLACE_BLOCK_READY.md`.
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

## D97U/V installation
D97U maps exact receiver boundary after `xpc_dictionary_get_uint64` at fileoff `0x25C3`; RAX/EAX live, no selector overlap.
D97V/VA FASTLANE FULL PASS and manual Root Patch FULL PASS. Installed service SHA `bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19`, terminal site bytes `0f0b9090909090`. Downstream D97 retained.

## D97W — report channel negative, SIGILL channel positive
D97W/D97WA artifacts:
- core commit `c849255bd90a59d8c01378708ff8780cdedbeded`, blob `db02543255b73026b5474686e2014c330c594a45`;
- wrapper commit `c577ee81f1ec1477ec666697ce0b450fe0b95a55`, blob `80a18e7bbc0aeb88414aeeffcdcadd77bdaa8eaa`.

Accelerated boot 14:00; VESA 14:03 excluded.
17 MTLCompilerService reports parsed, zero in content window, zero exact terminal/RAX captures. Register-report channel NEGATIVE.
Unified log shows repeated service respawn and 15 explicit launchd SIGILL terminations in the displayed window. SIGILL channel POSITIVE_REPEATED. D97V terminal control-flow strongly corroborated but exact RIP/RAX not proven. Runtime `llvmVersion` remains UNKNOWN.

## D97X — cave-placement STATIC NEGATIVE
Artifact commit `09d9a64bbf8789a3227693adec37c3d06551ee53`, blob `71bd9caedd19b71d16637d9bdbd5263930824192`.

Exact D97V identity and selector-only reconstruction PASS. Executable `__TEXT,__text` is file `0x23C0..0x360A`; static inventory contains 1329 instructions, 225 direct branch/call targets, 59 RIP-relative targets and 68 symbols.

Zero-runs of at least 48 bytes inside executable text: `0`. Safe cave candidates: `0`.

Classification: `NO_STATICALLY_SAFE_EXECUTABLE_ZERO_CAVE_FOUND`; cave-based classifier NOT AUTHORIZED. This is a valid STATIC NEGATIVE. Cave criteria remain unchanged.

## D97Y — in-place terminal complete-block mapper ready
Artifact commit `4e3d2333d1d28350295ce2710e82431edba1ed3f`, blob `549c894920b9fb1d688272f6b50034b3763bcf55`.

D97Y evaluates a distinct safe placement architecture permitted for explicitly terminal diagnostics: overwrite only a contiguous interval of complete straight-line instructions beginning immediately after the `llvmVersion` getter. It must prove the minimum interval large enough for the 36-byte three-way classifier, exact instruction identities/end boundary, no interior branch target/RIP xref/symbol/function-boundary hazard, retained selector paths and next instruction, deterministic final SHA and valid synthetic disassembly. No integration or Root Patch.

Classifier semantics remain:
- exit 123 for EAX 3802;
- exit 124 for EAX 32023;
- exit 125 for other.

## CURRENT ACTION
Run D97Y only and return its complete report. Do not Root Patch or reboot. If and only if every static gate passes, design one identity-pinned FASTLANE replacing D97V with the in-place deterministic exit classifier.
