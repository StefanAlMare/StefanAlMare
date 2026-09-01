# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-02 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260902_D97AES_RUNTIME_32023_SENDER_PROVEN_EXECUTED_TEXT_PROVENANCE_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.
Repository recovery: `OCLP_REPOSITORY_RECOVERY_20260901.md`.

## Permanent protocol
Identity-pinned FASTLANE -> complete audit -> manual Root Patch -> complete audit -> accelerated boot -> VESA recovery -> analyze only immediately preceding accelerated boot -> persist. Golden immutable/read-only. No automatic Root Patch/reboot. Missing `.ips` alone never hard negative. Control-flow is not semantic proof.

## Functional baseline
P1 -> P2b -> P3 -> AIR00 -> D34. True-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`. Golden SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`. D34 cave protected. P6/P7 retained, sufficiency NEGATIVE. D50/D68/D82 reserve-only. D84 retired. Patch8 unauthorized.

## Durable milestones
D22 AIR2.6/Metal3.1 SEMANTIC PROVEN. D69/D70 WindowServer downstream. D71R compiler lifecycle observable. D83 upstream llvm::Module*. D93 RMP contract. D95D wrapped LLVM bitcode STRUCTURAL-SEMANTIC PROVEN. D96C six-counter state. D97JB REL+0x58B common dominator.

## D97 provenance and classifier line
D97K-T mapped compiler generation selection. D97AA proved runtime llvmVersion 32023 for an earlier cohort. D97AC statically mapped finite outcomes in `validSimulatorMetadata`. D97AD exact transition produced selector-only service SHA `a8716ffd...` and final MTL SHA `524a16a...`, with six exact terminal postimages/shared stub.

Private snapshot/build/deploy and manual Root Patch all passed exactly; live D97AD app executable SHA `5a214ab2...`.

## Selected accelerated D97AD boot
Accelerated boot `2026-09-02 00:10`; VESA recovery `00:12` excluded. WindowServer PID394 crashed `00:11:47.9888` after compiler XPC interruption; final child PID441 exited ~20.8 ms earlier.

## D97AEQ — runtime coverage failure
Exact visible D97AD identities/postimages PASS. 28 unique service PIDs, 28 exact launchd exits, zero signals/missing, zero exits110–114, natural exit(1)=28/28. Classifier execution NEGATIVE; liveness gate FAIL; whole-stage outcome INVALID.

## D97AER — late diagnostic contradiction
Visible 32023 simulator-limit xrefs resolve inside `validSimulatorMetadata` at REL `0x596`, `0x5BC`, `0x5E0`, `0x608`, `0x62B`, all after exact D97AD exit110 REL `0x58B`. Runtime nevertheless emitted simulator diagnostics for all 28 PIDs with zero exit110. Compact generation provenance UNKNOWN.

## D97AES — runtime sender 32023 PROVEN
Historical unified-log JSON contained 33 simulator-diagnostic records across all 28 service PIDs. Every record reports sender path `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler` and sender UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`, exactly the visible 32023 LC_UUID. Sender path/UUID histograms: 32023=33, 3802=0, unknown=0. Thus runtime diagnostic sender generation/path/UUID 32023 is PROVEN for all observed PIDs; 3802 explanation is NEGATIVE.

Archived `formatString` is truncated and cannot identify the exact late branch. Sender path/UUID still does not prove exact current text bytes; filesystem-patched vs cached/stale 32023 execution remains unresolved.

## CURRENT ACTION
D97AET read-only executed-text provenance mapper: extract `senderProgramCounter`/`backtrace.frames`, map exact runtime image offsets to visible 32023 callsites, and inspect dyld/shared-cache provenance. No Root Patch/reboot. D82 reserve-only; Patch8 unauthorized.
