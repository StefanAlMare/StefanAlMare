# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260901_D97ZA_FASTLANE_FULL_PASS_ROOTPATCH_AUTHORIZED.md`
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

## D97U/V installation and D97W observation
D97U proves receiver boundary after `xpc_dictionary_get_uint64` at fileoff `0x25C3`; RAX full64 / EAX low32 are live and selector paths do not overlap.
D97V installed a terminal UD2 capture; D97V/VA FASTLANE and manual Root Patch were FULL PASS. Installed D97V service SHA `bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19`.

D97W analyzed accelerated boot 14:00, excluding VESA 14:03. DiagnosticReports provided zero in-window RAX reports, while unified log showed 15 explicit MTLCompilerService SIGILL terminations. Register-report channel NEGATIVE; SIGILL channel POSITIVE_REPEATED. Runtime `llvmVersion` remained UNKNOWN.

## Deterministic exit-classifier methodology
Do not repeat register-dependent SIGILL capture. Universal terminal launchd-visible classifier:
- exit 123 = EAX exactly 3802;
- exit 124 = EAX exactly 32023;
- exit 125 = any other EAX.
Transport: Darwin x86_64 exit syscall `0x2000001`. No PID filter and no crash-report dependency.

## D97X retained STATIC NEGATIVE
D97X proved no executable zero-run >=48 bytes and no safe cave. Cave placement remains unauthorized. This is a valid STATIC NEGATIVE, not tooling failure.

## D97Y in-place classifier STATIC PROVEN
D97Y artifact commit `4e3d2333d1d28350295ce2710e82431edba1ed3f`, blob `549c894920b9fb1d688272f6b50034b3763bcf55`.

D97Y proved:
- complete straight-line block file `0x25C3..0x25EB`, length 40, six complete instructions;
- no direct target, RIP xref, symbol or function boundary inside;
- exact 36-byte classifier plus four NOPs;
- exact exit semantics 123/124/125;
- selector paths and first untouched instruction retained;
- synthetic final service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- synthetic disassembly PASS.

Classifications: complete block STATIC PROVEN, inbound safety STATIC PROVEN, classifier STATIC PROVEN.

## D97ZA/D97Z FASTLANE — FULL PASS
D97ZA wrapper:
- commit `32ebc5a679b92f4ea6a9dc7a234e6281d7f61177`;
- blob `c0816d84048364eb793dcab0f55c3a4e8bcc1a70`.

Payload commit `09543f3f5e7ad816d15650580ed17165eb698b0f`; all four payload identities PASS. Reconstructed core SHA256 exact `419516697a9d69b888ec8fb03c10d6892c809c2e1a7653f190739f87350c3716`. Wrapper zsh parse, six Python-block compile, anchors and forbidden-automation audit all PASS.

Core precheck and offline proof:
- exact live D97V app SHA `9b2b981afb2cc4a56e3b9b8a2e97c454a3bcce9522a37d0cd17629bd5ae76e45`;
- exact visible D97V service SHA `bdb861da010542200a1fc480e796ba6d3405c842344612d162019c17d2b1fb19`;
- exact selector-only reconstruction SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- complete-block, inbound-reference, rel8, semantic-test and synthetic-disassembly gates PASS;
- expected D97Z service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`.

Source integration:
- D97V helper/call replaced by D97Z in place, not stacked;
- selector/control/P6/P7/D97 helper segments unchanged;
- active order selector -> D97Z -> control -> P6 -> P7 -> D97;
- exactly two allowed tracked files changed;
- exact deltas and whitespace audits PASS.

Build/package/deploy:
- build PASS in 78.81 seconds;
- packaged D97V call absent and D97Z call present exactly once;
- packaged order exact; D97Z privileged write count 3; downstream D97 retained;
- packaged audit PASS;
- dist/live executable SHA `0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f`;
- backup `/Applications/OpenCore-Patcher.app.D97V-before-D97Z-20260901-164617` with exact prior SHA;
- deploy SHA match and fresh process PID 1380 provenance PASS;
- OCLP opened;
- core RC 0 and wrapper PASS;
- Root Patch AUTO-NO and reboot AUTO-NO.

Classification: **D97ZA/D97Z FASTLANE FULL PASS**. Runtime remains UNTESTED.

## CURRENT ACTION — manual Root Patch
Manual Root Patch in the freshly deployed/opened OCLP application is AUTHORIZED.
Return the complete Root Patch output for assistant audit. Do not reboot until explicit post-Root-Patch authorization.

Expected key evidence:
- selector 31001 -> 32023 PASS;
- D97Z preimage SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- D97Z committed/final service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- D97Z classifier PASS with block `0x25C3..0x25EB` and exits `123/124/125`;
- retained true-five/P6/P7/D97 lineage;
- AuxKC and APFS snapshot completion.

D82 remains reserve-only. Patch8 remains unauthorized.
