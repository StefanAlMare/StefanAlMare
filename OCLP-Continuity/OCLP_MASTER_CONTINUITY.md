# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97AZ_V4_GOLDEN_B_VALUE_BACKSLICE_PASS_LLVMVERSION_LEFT_EDGE_D97BB_PRELUDE_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
Updated: 2026-09-04 EEST

## Mandatory startup
Before any technical change read in full, in order:
1. `OCLP_PERMANENT_WORKING_RULES.md`;
2. this MASTER;
3. `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. exact checkpoint named above;
5. `OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP_HISTORY_INDEX.md`.

Incremental checkpoints are authoritative for historical detail. This MASTER is current state/frontier only.

## Target and execution contract
Target Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 family `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.
Routine/static/log/small work stays on ASUS2 under user control. GitHub is only for major compile/build/package and identity-pinned script persistence/delivery. Never auto Root Patch or reboot.

## Golden comparator authority — explicit user override
User may manually restore ORIGINAL OCLP Root Patch and boot working Golden Sequoia as many times as useful. This supersedes old immutable/no-boot wording narrowly. Assistant does not automate Golden Root Patch/reboot and does not install experimental Golden system-file patches without separate explicit authorization.

## AUTHORITATIVE PROJECT ARCHITECTURE
The ORIGINAL working OCLP donor/root-patch path is the immutable semantic target:
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor path -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Historical P1/P2b/P3/AIR00/D34/P6/P7 are adapters/hypotheses, not axioms. Final Tahoe comparator must use the SAME ORIGINAL OCLP functional content as Golden; only a separately audited minimal Tahoe eligibility/OS-support bypass may differ. Before Tahoe Root Patch prove that bypass changes eligibility only, not payloads, selector/compiler logic, request layout, AIR/bitcode handling or graphics-driver content.

## Golden snapshots
### GOLDEN_A
Sequoia `15.7.9 / 24G830`. D97AU/D97AX/D97AY runtime/static snapshot retained.

### GOLDEN_B — current
Sequoia `15.8 / 24H22`. User reports no EFI changes, manually reapplied same original OCLP Root Patch, accelerated GUI working.

Critical donor artifacts are byte-identical across GOLDEN_A -> GOLDEN_B:
- 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Original selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`; no 32023 immediate in original selector.
G1 receiver schema: `requestType:uint64`, `sandboxTokens:value`, `llvmVersion:uint64`, `pluginPath:string`, `targetData:value`, `data:value`, `client_name:string`, `APISpecifiedTimeoutInSeconds:uint64`.
G2 original 32023 donor dialect includes `+0xD0/+0x88/+0x8C` in getReadParameters and `+0xC4/+0xC8/+0xCC/+0xDC/+0xE0` in invokeLowerModule.

## GOLDEN_A retained runtime oracle
D97AU boot3m: total451; 32023=220; 3802=193; 8 exact-generation PIDs; 32023 PCs `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`; 3802 PCs `0x1DFA3=96`, `0x238E3=97`.

Original selector source chain was statically traced to `xpc_dictionary_get_uint64(request,"llvmVersion")`. Thus generation selection and producer `llvmVersion` are causally linked; exact per-lane runtime values must still be labeled according to the strongest proved chain, not guessed.

## GOLDEN_B producer rebase D97BA
Exact D97BA batch:
- JSON 10774 bytes / SHA256 `f702cd1bff179ce268d18d1ab42762f0e4fcba066b488de7fc3e1ae599444a48`;
- TXT 16246 bytes / SHA256 `79f2aa9d3e65f14258e75d1459127b4f5801b492418d6a750550a478df1a3ad4`.

Cached Metal text on 15.8:
- `0x7FF80D343000..0x7FF80D5C5C3D`;
- SHA256 `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`.

All primary request-builder xrefs retain GOLDEN_A offsets:
llvmVersion `+0x2D81F`, requestType `+0x2D832`, sandboxTokens `+0x2D914`, targetData `+0x2D939`, data `+0x2D95E`, pluginPath `+0x2D97F`, client_name `+0x2D9FD`, timeout `+0x2DA13`; alternate requestType `+0x1089E1`, data `+0xDB881`.
Classification: `G1_GOLDEN_B_METAL_PRIMARY_EIGHT_KEY_REQUEST_BUILDER_REBASE=STATIC_PROVEN_SAME_OFFSETS`.

G3 GOLDEN_B: HD4400/Metal2/display online, Azul 18.0.8 + HD5000Graphics 18.0.8 loaded, framebuffer events, `Metal compositor activated` `18:13:35.728/35.730`. Classification `G3_GOLDEN_B_15_8_METAL_COMPOSITOR_SUCCESS=RUNTIME_OBSERVED`.
D97BA boot3m MTL query returned zero records; printed runtime-lane label is retracted. Authoritative: `G1_GOLDEN_B_15_8_BOOT3M_GENERATION_LANE=INCONCLUSIVE_VISIBILITY_CHANNEL_ZERO_RECORDS`.

## D97AZ V4 — GOLDEN_B primary request-builder static backslice PASS
Exact returned files:
- TXT 17967 bytes / SHA256 `04b89d8b9e8b2d6dcd8a8210a90e7406ea1bc3632d64646d8385c248fe51f1e2`;
- JSON 8841 bytes / SHA256 `445cfb3160513756a9be40a374d2137694c658ab08048ca3b2181fa67d3d0ce6`.

Core markers: `G1_GOLDEN_PRIMARY_REQUEST_BUILDER_VALUE_BACKSLICE=COMPLETE_FOR_STATIC_CHANNEL`, `RUNTIME_VALUE_CLAIM=NO`, `D97AZ_AUDIT=COMPLETE`.

### Proven primary field sources
- `requestType`: `movl 0x8(%r13),%r14d -> movq %r14,%rdx -> uint64 setter`; classification `STATIC_VALUE_SOURCE_PROVEN` for `[r13+0x8]`.
- `APISpecifiedTimeoutInSeconds`: `[r13+0x18] -> RDX -> uint64 setter`; `STATIC_VALUE_SOURCE_PROVEN`.
- `pluginPath`: immediate setter source stack local `[rbp-0x48]`; root origin still upstream.
- `sandboxTokens`: helper-return RAX -> RDX after branch involving `[r13+0x70]`; `STRUCTURAL_SOURCE_MAPPED`.
- `targetData`: helper-return RAX sourced from stack local `[rbp-0x50]`; `STRUCTURAL_SOURCE_MAPPED`.
- `data`: helper-return RAX sourced from R12; `STRUCTURAL_SOURCE_MAPPED`.
- `client_name`: helper-return RAX after non-null test; `STRUCTURAL_SOURCE_MAPPED`.

Alternate requestType path is exact: `movl $0x9,%edx` then same uint64-setter-family target. Classification `G1_GOLDEN_ALTERNATE_REQUESTTYPE_VALUE_9=STATIC_VALUE_PROVEN`.

Setter-family targets cluster consecutively:
- `0x7FF80D50FDC8`: string fields pluginPath/client_name;
- `0x7FF80D50FDCE`: uint64 fields llvmVersion/requestType/timeout/requestType_alt;
- `0x7FF80D50FDD4`: value fields sandboxTokens/targetData/data.
Exact imported symbol names were not independently recovered; treat these as schema-supported setter-family mappings.

### llvmVersion frontier
D97AZ V4 extraction began exactly at the proven llvmVersion xref `0x7FF80D37081F` to avoid mid-instruction x86 disassembly. Sequence is key LEA -> `movq %rax,%rdi` -> uint64-setter-family call at `0x7FF80D370829`. No RDX write exists *inside the captured range before the call*, so `NO_WRITER` is a left-edge limitation.
Authoritative classification: `G1_GOLDEN_LLVMVERSION_STATIC_SOURCE=UNKNOWN_RANGE_LEFT_EDGE`.
Do not interpret this as semantic absence.

D97AZ `NM_OWNER=..._traceLog` hint is not authoritative for cached-code function ownership and is retired from semantic use.

## CURRENT FRONTIER / NEXT ACTION — D97BB V2
Remain in GOLDEN_B `15.8 / 24H22`. Do NOT start Tahoe eligibility bypass yet.

Run only hardened wrapper:
`OCLP7_D97BB_V2_GOLDEN_15_8_LLVMVERSION_FUNCTION_START_HARDENED_WRAPPER.command`
- wrapper commit `4e99313000e59b57b28b761571e2d56fbd96429b`;
- wrapper Git blob `e51f547b3765688b772b43937dc0f3d762a9c801`.

Core:
`OCLP7_D97BB_GOLDEN_15_8_LLVMVERSION_FUNCTION_START_AND_RDX_SOURCE.command`
- commit `c05563fdeae951c5731051c73ac7e43fd7f2ffdd`;
- blob `c02a2e7c196f3260858be55f6175ba275120ac35`.

D97BB pins GOLDEN_B OS/build, donor hashes and cached Metal text SHA. It parses the cached Metal Mach-O `LC_FUNCTION_STARTS`, derives a real containing-function boundary for `0x7FF80D37081F`, disassembles only that bounded function region, revalidates the llvmVersion key RIP target and uint64-setter-family call, then back-slices RDX from the setter to its first safely resolvable source.

Goal: resolve the exact static source of Golden llvmVersion without arbitrary pre-xref alignment. No debugger attach, persistent instrumentation, system mutation, Root Patch or reboot.

After D97BB, use only the minimum additional Golden runtime channel needed for fields whose exact runtime values are not already logically established by exhaustive selector/runtime evidence.