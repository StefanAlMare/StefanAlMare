# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260902_D97AES_RUNTIME_32023_SENDER_PROVEN_EXECUTED_TEXT_PROVENANCE_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
Updated: 2026-09-02 EEST

## Mandatory startup
Before any technical change read in full:
1. `OCLP_PERMANENT_WORKING_RULES.md`;
2. this MASTER;
3. `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. the exact checkpoint named above;
5. `OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP_HISTORY_INDEX.md`.

## Permanent contract
Target Tahoe `26.6.2 / 25G82`, Intel Haswell HD4600/4400 family `8086:0412`, SMBIOS `MacBookAir6,2`.
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
- true-five control `254104fa863b6d0b8e9c27a6db907b423c3153958d3e51fc4cbd912c7ebe6ac9`;
- P6 `ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0b545f0da06c13a`;
- P7 `a8fdac12d07a152e4a9ba5fc79558e0c594634f7762f6fd373421176e1a5b66b`.

## Durable semantic/runtime facts
- D22: AIR2.6/Metal3.1 SEMANTIC PROVEN.
- D69/D70: WindowServer/SkyLight is downstream of compiler XPC failure.
- D71R: compiler-service lifecycle and deterministic termination observable through launchd.
- D83: validator receives upstream `llvm::Module*` and derives metadata/resource counters internally.
- D93: RMP `+0` bitcodeType, `+0x08` primary length, `+0x10` primary pointer, `+0x18/+0x20` plugin-data family.
- D95D: wrapped LLVM bitcode STRUCTURAL-SEMANTIC PROVEN; exact Golden runtime semantics UNKNOWN.
- D96C: six counter values stable at `validSimulatorMetadata` REL+`0x58B`.
- D97JB: full CFG 81 blocks; REL+`0x58B` dominates all six late predicates and is their earliest post-final-write common dominator.

## D97 compiler-generation provenance
D97K-T proved MTLCompilerService selector semantics and provenance: 3802 loads MTLCompiler 3802; 32023 loads MTLCompiler 32023; other value selects no valid compiler path; selector is low32 of request key `llvmVersion`; cached Metal.framework writes that key through exact `_xpc_dictionary_set_uint64`.
D97AA observed 12 unique MTLCompilerService children in an earlier accelerated cohort, all primary exit124 => runtime llvmVersion 32023 PROVEN for that cohort.

## D97AC / D97AD
D97AC statically proved the finite-path partition of 32023 `validSimulatorMetadata`: 110 candidate REL+`0x58B`; 111 buffer-index REL+`0x29A`; 112 sampler-index REL+`0x2D9`; 113 nested argument-buffer REL+`0x3E2`; 114 normal early return REL+`0xB9` or unwind REL+`0x6CC`. Global termination not claimed.

D97AD exact transition FULL PASS: selector-only service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`; final MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`; six exact terminal postimages/shared stub; active order `selector -> control -> P6 -> P7 -> D97AD` by replacement.

## D97AD build/deploy/Root Patch
Exact three-file source snapshot built privately from commit `1faab13865eb945198f3551688f11f1ba645e29a`; GitHub Actions run `33553271179` succeeded; packaged/live app executable SHA `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`. D97AEO/D97AEP deployment FULL PASS. Manual Root Patch FULL PASS through AKC/APFS snapshot/unmount with exact D97AD MTL SHA.

## Selected accelerated boot
`2026-09-02 00:10` accelerated D97AD boot selected; `00:12` VESA recovery excluded. Fatal WindowServer PID394 crashed `00:11:47.9888` with COREANIMATION `XPC_ERROR_CONNECTION_INTERRUPTED`; final compiler child PID441 exited `00:11:47.968`, ~20.8 ms earlier.

## D97AEQ — runtime classifier coverage NEGATIVE
D97AEQ verified exact visible selector-only service, D97AD MTL SHA, six postimages/shared stub. Runtime window contained 28 unique service spawns and 28 exact launchd exits: zero signals/missing, zero exits110–114, all 28 natural `exit(1)`.
Classification: audit PASS; visible identity PASS; classifier execution NEGATIVE; liveness gate FAIL; whole-stage outcome classification INVALID; natural exit1 RUNTIME PROVEN 28/28.

## D97AER — static late-message contradiction
Visible 32023 late simulator diagnostics map inside `validSimulatorMetadata` at REL `0x596`, `0x5BC`, `0x5E0`, `0x608`, `0x62B`, all strictly after D97AD exit110 at REL `0x58B`. Runtime emitted the simulator diagnostic for all 28 PIDs despite zero exit110. Compact logs could not identify generation. Visible 3802 contains the same message family.

## D97AES — runtime sender generation 32023 PROVEN
D97AES historical JSON parsing found 33 simulator-diagnostic records spanning all 28 observed service PIDs. Every diagnostic record has:
- sender path `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`;
- sender UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`, exactly visible 32023 LC_UUID;
- expected MTLCompilerService process path/UUID.

Histograms: sender path 32023=33, 3802=0, unknown=0; sender UUID 32023=33, 3802=0, unknown=0. Therefore runtime diagnostic sender generation/path/UUID 32023 is PROVEN for all 28 diagnostic PIDs; 3802 explanation is NEGATIVE for this cohort.

`formatString` is archived only as truncated `upported in the simulator but %u were used`, so exact branch remains UNKNOWN. D97AES local exit parser is incomplete; D97AEQ remains authoritative for 28/28 exit1.

Important boundary: sender path/LC_UUID proves generation but not exact current text-byte provenance. The contradiction now specifically asks whether runtime 32023 text is the root-patched filesystem image or a cached/stale 32023 mapping (e.g. dyld/shared cache). Do not promote cache execution to fact without direct evidence.

## CURRENT ACTION — D97AET EXECUTED-TEXT PROVENANCE
Run a read-only mapper on the same historical JSON window that extracts `senderProgramCounter` and `backtrace.frames` for every simulator diagnostic, normalizes image offsets to the proven 32023 sender, maps them to visible 32023 late callsite/xref families, and inspects available dyld/shared-cache provenance sufficiently to discriminate filesystem-patched versus cached/stale 32023 text where possible.

No source/system/Golden mutation, service launch, runtime instrumentation, Root Patch or reboot. D82 remains reserve-only. Patch8 remains unauthorized.
