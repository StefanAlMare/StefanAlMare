# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-01 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260901_D97ZA_FASTLANE_FULL_PASS_ROOTPATCH_AUTHORIZED.md`.
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
D97K-T traced the runtime compiler selector from MTLCompilerService to XPC key `llvmVersion` and proved cached Metal.framework writes that key through exact `_xpc_dictionary_set_uint64`. Selector semantics are STATIC PROVEN: 3802 loads MTLCompiler 3802, 32023 loads 32023, other values select no valid path.

## D97U/V and D97W
D97U mapped the exact post-getter boundary at fileoff `0x25C3`; RAX/EAX live and no selector overlap.
D97V/VA FASTLANE and manual Root Patch FULL PASS. Installed terminal service SHA `bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19`.
D97W found no in-window register report but 15 explicit launchd SIGILL terminations. Register channel NEGATIVE; SIGILL channel POSITIVE_REPEATED; runtime `llvmVersion` remained UNKNOWN.

## Deterministic exit-code methodology
Universal terminal classifier:
- exit 123 for EAX 3802;
- exit 124 for EAX 32023;
- exit 125 for other.
Uses Darwin x86_64 exit syscall and launchd accounting; no PID filter and no `.ips` dependency.

## D97X / D97Y
D97X returned a valid STATIC NEGATIVE: no statically safe executable zero cave.
D97Y then proved a safe complete-instruction in-place block:
- file `0x25C3..0x25EB`, length 40, six straight-line instructions;
- no direct target, RIP xref, symbol or function boundary inside;
- exact 36-byte classifier plus four NOPs;
- selector paths and next instruction retained;
- synthetic final service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- synthetic disassembly PASS.

## D97ZA/D97Z — FASTLANE FULL PASS
D97ZA wrapper commit `32ebc5a679b92f4ea6a9dc7a234e6281d7f61177`, blob `c0816d84048364eb793dcab0f55c3a4e8bcc1a70`.
Payload commit `09543f3f5e7ad816d15650580ed17165eb698b0f`; all four payload identities and exact decompressed core SHA256 `419516697a9d69b888ec8fb03c10d6892c809c2e1a7653f190739f87350c3716` PASS. Zsh parse, six Python-block compile, anchors and forbidden-automation audit PASS.

D97Z core:
- exact live D97V app and service identities PASS;
- D97V -> selector-only -> D97Z offline proof PASS;
- exact final service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- D97V helper/call replaced by D97Z in place, not stacked;
- selector/control/P6/P7/D97 helper identities retained;
- active call order selector -> D97Z -> control -> P6 -> P7 -> D97;
- exactly two allowed tracked files changed; exact deltas and whitespace gates PASS;
- build PASS in 78.81 seconds;
- packaged D97V absent, D97Z present once, order exact, privileged write count 3, downstream D97 retained;
- dist/live app SHA `0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f`;
- backup exact prior D97V SHA;
- deploy SHA match, fresh process PID 1380 and open OCLP PASS;
- core RC 0, wrapper PASS, Root Patch AUTO-NO, reboot AUTO-NO.

Classification: **D97ZA/D97Z FASTLANE FULL PASS**. Runtime untested.

## CURRENT ACTION
Manual Root Patch is AUTHORIZED in the freshly deployed/opened OCLP app. Return complete Root Patch output for audit. Do not reboot until explicit authorization after that audit.

Expected evidence: selector PASS; D97Z preimage `a8716ffd...`; D97Z final/committed SHA `2ce8d92c...`; classifier block/exits PASS; retained true-five/P6/P7/D97; AuxKC and APFS snapshot completion. D82 remains reserve-only; Patch8 unauthorized.
