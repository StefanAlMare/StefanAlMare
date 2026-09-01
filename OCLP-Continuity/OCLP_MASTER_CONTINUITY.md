# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260901_D97X_NO_SAFE_ZERO_CAVE_D97Y_INPLACE_BLOCK_READY.md`
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
Target Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.
Local OCLP branch `alex-tahoe-25G82-custom`, expected HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`.
Golden root-patched MTLCompiler SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`, immutable/read-only.
True-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.

One action at a time. Identity-pinned FASTLANE -> full audit -> manual Root Patch -> full audit -> accelerated boot -> VESA recovery -> analyze only accelerated boot -> persist.
Never auto Root Patch or reboot. Missing `.ips` alone is never hard negative. Control-flow != semantic proof.
D50/D68/D82 reserve-only. D84 retired. Patch8 unauthorized.

Architecture: `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working Sequoia/OCLP donor path -> image`.

## Accepted functional lineage
P1 selector bridge -> P2b `+0xD0 -> +0x110` -> P3 serialized-bitcode path -> AIR00 AIR2.6/Metal3.1 -> D34 semantic-equivalent reset.
D34 protected cave: `0xEF8..0xEFE = 48 89 F8 48 89 37 C3`.
P6 retained SHA `4b7660f6ddebd615cca4e67667f2e29a29366aa5b872866cfa79592d2cb6be76`, sufficiency NEGATIVE.
P7 retained SHA `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`, sufficiency NEGATIVE.

## Durable semantic/runtime facts
- D22: AIR2.6/Metal3.1 SEMANTIC PROVEN.
- D36-D44 invalidated by D34 cave collision.
- D69/D70: WindowServer/SkyLight downstream of compiler XPC failure.
- D71R: compiler-service lifecycle/termination observable through launchd.
- D80 perturbative crash retired by D81 clean control.
- D83: validator receives upstream `llvm::Module*` and derives resource metadata/counters internally.
- D93: RMP `+0` bitcodeType, `+0x08` primary length, `+0x10` primary pointer, `+0x18/+0x20` plugin-data family.
- D95/D95D: fileoff `0x9AA75`, cave `0xF80`, UD2 `0xFAC`, R11 `0x2143544942353944`; 14/14 deliberate SIGILL; wrapped LLVM bitcode STRUCTURAL-SEMANTIC PROVEN; exact Golden runtime semantics UNKNOWN.

## D96 / D97
D96C proves six-counter stability at validSimulatorMetadata REL+0x58B / VM `0x7FFB162C76BD`.
D97 snapshot: site fileoff `0x9D6BD`, cave `0xF80`, UD2 `0xF9F`, R11 `0x2152544E43373944`; installed 32023 SHA `c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118`.
D97H accelerated boot: 64 unique MTLCompilerService PIDs, simulator-family activity + exit(1), zero downstream D97 SIGILL.
D97JB: full CFG 81 blocks; +0x58B dominates all six late predicates and is earliest common dominator after final write +0x580. Zero-SIGILL is therefore a runtime provenance contradiction, not reason to move the snapshot earlier.

## D97K-T runtime compiler-selection provenance
- D97K: visible 32023 exact D97; visible 3802 distinct/non-D97; Current -> 32024; visible 32024 absent.
- D97L: MTLCompilerService dynamically references 3802 and 32023; no static MTLCompiler dependency; visible plist 263.8 vs launchd-cache metadata 373.7 mismatch retained.
- D97M: selector STATIC PROVEN: ESI 32023 -> dlopen 32023; ESI 3802 -> dlopen 3802; other values -> NULL.
- D97N: selector originates from captured `ctx(int)` block int32 +0x20.
- D97O: captured value is low32 of `xpc_dictionary_get_uint64(request,"llvmVersion")`.
- D97P: visible scoped scan found no sender writer.
- D97Q operationally incomplete; D97QA exposed mmap RC138/SIGBUS; neither yielded content conclusions.
- D97QB: chunked cache scan found 28 `llvmVersion` hits / 18 owners; cached Metal request cluster became sender candidate; cached MTLCompiler 32024 exists.
- D97R: two cached-Metal callsites use `llvmVersion`, values from int32 `[RBX+0x1C]` and `[RCX+0x38]`.
- D97S: common target is RIP-relative stub through GOT `0x7FF840057F98`, raw `0x0000020002B63342`.
- D97T: slide-info v2 decodes GOT to `0x7FF802B63342`; unique owner `/usr/lib/system/libxpc.dylib`; exact export `0x5342 _xpc_dictionary_set_uint64`; owner load + offset exact. `METAL_WRITES_LLVMVERSION=STATIC_PROVEN`.

## D97U/V installation
D97U proves receiver capture site immediately after the getter:
- key xref `0x25B4`;
- getter `0x25BE`;
- capture instruction `0x25C3`, original `4c89b558ffffff`, length 7;
- RAX full64 / EAX low32 live;
- no overlap with 32023 selector at `0x3496` or 3802 at `0x3478`.

D97V replaced the instruction with terminal `0f0b9090909090`.
D97V/VA FASTLANE FULL PASS; application executable SHA `9b2b981afb2cc4a56e3b9b8a2e97c454a3bcce9522a37d0cd17629bd5ae76e45`.
Manual Root Patch FULL PASS:
- service preimage `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- D97V committed service `bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19`;
- retained true-five/P6/P7/D97 lineage;
- AuxKC and APFS snapshot complete.

## D97W runtime result
Boot chronology:
- 14:00 accelerated D97V;
- 14:03 VESA recovery excluded.

D97W/D97WA identity and read-only gates PASS. Current visible service/site match D97V.
DiagnosticReports channel:
- 17 reports parsed;
- zero reports in accelerated content window;
- zero exact terminal reports and zero RAX captures.
Classification: `D97W_DIAGNOSTIC_REPORT_REGISTER_CHANNEL=NEGATIVE`.

Unified log:
- repeated MTLCompilerService respawns for WindowServer;
- 15 explicit launchd `exited due to SIGILL | sent by exc handler` terminations in the displayed accelerated window;
- corpse production allowed for first five then throttled.
Classification: `D97W_UNIFIED_LOG_SIGILL_TERMINATION_CHANNEL=POSITIVE_REPEATED`.

Conservative conclusion: D97V terminal execution is strongly corroborated, but exact RIP and RAX are not proven because no crash report exists. Runtime `llvmVersion` remains UNKNOWN.

## Methodology decision after D97W
Do not repeat a register-dependent SIGILL capture. Use deterministic launchd-visible normal exit accounting.
Exact classifier semantics:
- exit 123 = EAX exactly 3802;
- exit 124 = EAX exactly 32023;
- exit 125 = any other value.
Universal/no-PID, terminal, no crash-report dependency.

## D97X observed STATIC NEGATIVE
Artifact `OCLP7_D97X_READONLY_EXIT_CODE_CLASSIFIER_CAVE_SAFETY_AND_DESIGN_MAP.command`:
- commit `09d9a64bbf8789a3227693adec37c3d06551ee53`;
- blob `71bd9caedd19b71d16637d9bdbd5263930824192`.

D97X identity and selector-only reconstruction PASS. Exact code map:
- `__TEXT,__text` file `0x23C0..0x360A`, VM `0x1000023C0..0x10000360A`;
- capture/classifier site VM `0x1000025C3`.

Static inventory: 1329 instructions, 225 direct branch/call targets, 59 RIP-relative targets and 68 symbol addresses.
Executable zero-runs >=48 bytes: `0`; safe cave candidates: `0`.

Classifications:
- `D97X_RESULT=NO_STATICALLY_SAFE_EXECUTABLE_ZERO_CAVE_FOUND`;
- `D97X_EXIT_CLASSIFIER_AUTHORIZED=NO` for cave placement;
- this is a valid STATIC NEGATIVE, not a tooling failure.

Do not weaken cave criteria or use unproved non-code bytes.

## D97Y in-place complete-block mapper ready
Artifact `OCLP7_D97Y_READONLY_INPLACE_TERMINAL_CLASSIFIER_BLOCK_SAFETY_MAP.command`:
- commit `4e3d2333d1d28350295ce2710e82431edba1ed3f`;
- blob `549c894920b9fb1d688272f6b50034b3763bcf55`.

D97Y tests a different, rule-compliant architecture: replace a contiguous sequence of complete straight-line instructions beginning at the already-proven first instruction after the getter. Because the diagnostic is terminal, it makes no pass-through claim and does not require a cave.

It requires exact selector-only reconstruction; finds the minimum complete-instruction interval holding the 36-byte classifier; requires the expected instruction identities and exact end boundary; audits direct targets, RIP-relative targets, symbols and containing-symbol boundaries; verifies classifier branch bytes/semantics/syscall; retains both selector paths and the first untouched instruction; derives deterministic final SHA and disassembles the synthetic postimage. It performs no integration or mutation.

## CURRENT ACTION — D97Y
Run D97Y only and return the complete report. Do not Root Patch or reboot.

Only if every complete-block, inbound-reference, classifier and synthetic-disassembly gate passes may one identity-pinned FASTLANE replacing D97V with the in-place deterministic exit classifier be designed.
