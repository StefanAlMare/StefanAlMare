# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260902_D97AER_STATIC_LATE_MESSAGES_CONTRADICT_VISIBLE_D97AD_RUNTIME_PROVENANCE_NEXT.md`
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

D97Z installed launchd-visible exits 123/124/125. D97AA observed 12 unique MTLCompilerService children in the accelerated cohort, all primary exit 124, zero 123/125/signals/missing. Classification: `RUNTIME_LLVMVERSION_32023_PROVEN_ALL_12_OBSERVED_REQUESTS`; H4 rejected for that cohort.

## D97AC — finite-path partition STATIC PROVEN
D97AC established zero closed nonterminal SCCs, zero reachable outside/unresolved edges, zero reachable blocks without a classified finite-outcome path, and finite-path partition exhaustive STATIC PASS; global termination not claimed because cyclic SCCs exist.

Mapped outcomes:
- 110 reaches REL+`0x58B`;
- 111 buffer-index error REL+`0x29A`;
- 112 sampler-index error REL+`0x2D9`;
- 113 nested argument-buffer error REL+`0x3E2`;
- 114 normal early return REL+`0xB9` or unwind/cleanup REL+`0x6CC`.

Shared cave and all six complete-instruction windows are SAFE. Mandatory runtime gate: every spawned MTLCompilerService PID must emit exactly one exit 110–114; missing, signal or other exit invalidates the run.

## D97AD — exact final transition FULL PASS
D97AD proved selector-only service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, exact P7 reconstruction, six exact non-overlapping postimages, synthetic disassembly PASS and exact final D97AD MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. Active order `selector -> control -> P6 -> P7 -> D97AD` is by replacement, not stacking.

## D97AD source snapshot / private build / deployment
Exact post-transition source state used three authorized tracked files: `metal_3802.py`, `sys_patch.py`, `sys_patch_helpers.py`; `metal_3802.py` is required historical Tahoe compiler substrate.

Private lane:
- repo `StefanAlMare/Private-Work`, branch `oclp7-d97ad-github-build`;
- snapshot commit `1faab13865eb945198f3551688f11f1ba645e29a`;
- workflow run `33553271179`, job `100007798331`, Intel runner success;
- artifact `9818489515`, digest `sha256:d570342beed9ceac1f37df24d7c4fa1ba0ad106114139f2e555ccba3f64ccc63`;
- inner ZIP SHA `c7951479492acbb2ce352d0958a2be84219db4b10484a0ce8cbb9238d0ef778c`;
- packaged/live D97AD executable SHA `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`.

D97AEO/D97AEP deployment FULL PASS. D97Z backup remains `/Applications/OpenCore-Patcher.app.D97Z-before-D97AD-GitHub-20260901-232929`, SHA `0a572f116293b3010276a035780e2ad5cd2414c29ff927461ed59f614d986e1f`.

## D97AD manual Root Patch — FULL PASS
Root Patch transcript proved selector `31001 -> 32023`, P2b, P3, AIR00, D34, true-five, P6 SHA `4b7660...`, P7 SHA `6e0e312...`, D97Z absent, D97 absent, and exact D97AD MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. Patch completed through AKC, APFS snapshot and unmount without error.

## D97AD accelerated boot chronology
Selected accelerated boot `2026-09-02 00:10`; VESA recovery `00:12` excluded. Fatal WindowServer PID 394 launched `00:11:32.9517`, crashed `00:11:47.9888`, boot UUID `B6B4D4C3-D751-4FB0-AE64-2AF8AA1B9CC0`, COREANIMATION code 4 with `XPC_ERROR_CONNECTION_INTERRUPTED` after multiple retries. GPUCompiler 32023 libraries were visible in the crash report.

## D97AEQ — runtime result: classifier coverage failed, 28/28 natural exit(1)
D97AEQ read-only audit verified visible selector-only service SHA `a8716ffd...`, visible exact D97AD MTL SHA `524a16a...`, all six terminal postimages and shared exit stub.

Selected accelerated window produced 28 unique service PIDs, 28 exact launchd exit records, zero missing exits, zero signals, zero exits 110–114, and all 28 normal `exit(1)`.

Authoritative classification:
- `D97AEQ_AUDIT_TOOL_EXECUTION=PASS`;
- `D97AD_VISIBLE_DISK_IDENTITY=PASS`;
- `D97AD_CLASSIFIER_EXIT_EXECUTION_FOR_OBSERVED_COHORT=NEGATIVE`;
- `D97AD_RUNTIME_LIVENESS_GATE=FAIL`;
- `D97AD_WHOLE_STAGE_OUTCOME_CLASSIFICATION=INVALID`;
- `NATURAL_MTLCOMPILERSERVICE_EXIT1=RUNTIME_PROVEN_28_OF_28`.

Fatal WindowServer PID 394 hosted 12 observed service children, all exit(1). Final child PID 441 exited at `00:11:47.968`, ~20.8 ms before WindowServer crash, strongly corroborating `compiler service failure -> XPC interruption -> WindowServer abort`.

## D97AER — static late-message map exposes executed-image contradiction
D97AER reverified selector-only service SHA and exact visible D97AD 32023 SHA. Visible 3802 SHA is `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`.

Visible 32023 contains the simulator-limit diagnostic family. Five resolved late message xrefs are all inside `MTLSimCompiler::validSimulatorMetadata` and all strictly after the D97AD candidate terminal REL `0x58B`:
- buffers REL `0x596`;
- samplers REL `0x5BC`;
- textures REL `0x5E0`;
- constant buffers REL `0x608`;
- interpolated inputs REL `0x62B`.

Disassembly immediately before the first late message visibly contains the exact D97AD terminal at REL `0x58B` (exit110 + unconditional jump to shared exit stub). Therefore those late messages cannot be emitted by normal fallthrough through the exact patched 32023 D97AD path without first taking exit110. D97AEQ observed zero exit110 and 28/28 exit(1).

Visible 3802 contains the same six messages; its validator owns all six xrefs, including nested argument buffer REL `0x4CB` and late resource-limit family REL `0x619..0x6C3`. Therefore compact message text alone does not distinguish 32023 from 3802.

D97AER compact historical log search found no explicit 32023/3802 image path, so executed generation/path remains UNKNOWN. D97AER proved the simulator diagnostic appears for all 28 spawned PIDs. Its local `RUNTIME_EXIT1_PID_COUNT=0` is a tooling false negative caused by regex shape; D97AEQ remains authoritative for 28/28 exit(1).

Authoritative classifications:
- `D97AER_STATIC_32023_LATE_DIAGNOSTIC_XREFS=STATIC_PROVEN_AFTER_REL_0x58B`;
- `D97AER_RUNTIME_SIMULATOR_DIAGNOSTIC=REACHED_FOR_ALL_28_OBSERVED_PIDS`;
- `D97AER_COMPACT_LOG_GENERATION_PROVENANCE=UNKNOWN`;
- `D97AER_EXIT1_LOCAL_CORRELATOR=TOOLING_FALSE_NEGATIVE`;
- `EXACT_VISIBLE_D97AD_32023_EXECUTION_PROVENANCE=UNRESOLVED`;
- `VISIBLE_D97AD_BYTES_VS_RUNTIME_LATE_MESSAGE=CONTRADICTION_REQUIRING_EXECUTED_IMAGE_PROVENANCE`.

Do not promote 3802, stale mapping, shared-cache execution, or static-CFG failure to fact without direct evidence.

## CURRENT ACTION — D97AES JSON SENDER-IMAGE PROVENANCE
Run a read-only historical unified-log JSON mapper on the exact `00:10..00:12` accelerated window. Extract raw simulator-diagnostic records and every available `senderImagePath`, `senderImageUUID`, `processImagePath`, `processImageUUID`, source/format metadata and PID. Compare sender path/UUID against visible MTLCompiler 32023 and 3802 Mach-O UUIDs. Repair launchd exit(1) parsing only as corroboration; D97AEQ remains authoritative for exit counts.

No source/system/Golden mutation, service launch, Root Patch or reboot. D82 remains reserve-only. Patch8 remains unauthorized.
