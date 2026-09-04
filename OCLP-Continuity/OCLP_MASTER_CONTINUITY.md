# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97BB_GOLDEN_B_LLVMVERSION_SOURCE_PROVEN_RBX_PLUS_0x20_OBJECT_PROVENANCE_NEXT.md`
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
Original selector source chain is `xpc_dictionary_get_uint64(request,"llvmVersion")`. Combined with exhaustive original selector semantics, runtime 3802 donor provenance constrains corresponding request llvmVersion to 3802 and runtime 32023 donor provenance constrains corresponding request llvmVersion to 31001. Preserve this as composed static+runtime proof, distinct from direct runtime register capture.

## GOLDEN_B producer rebase D97BA
Cached Metal text `0x7FF80D343000..0x7FF80D5C5C3D`, SHA256 `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`.
All primary request-builder xrefs retain GOLDEN_A offsets: llvmVersion `+0x2D81F`, requestType `+0x2D832`, sandboxTokens `+0x2D914`, targetData `+0x2D939`, data `+0x2D95E`, pluginPath `+0x2D97F`, client_name `+0x2D9FD`, timeout `+0x2DA13`; alternate requestType `+0x1089E1`, data `+0xDB881`.
G3 GOLDEN_B reaches `Metal compositor activated` `18:13:35.728/35.730`. D97BA boot3m MTL query zero-record lane is `INCONCLUSIVE_VISIBILITY_CHANNEL_ZERO_RECORDS`.

## D97AZ V4 — primary request-builder static source map
- requestType source = 32-bit `[R13+0x8]` -> R14 -> RDX; `STATIC_VALUE_SOURCE_PROVEN`.
- timeout source = qword `[R13+0x18]` -> RDX; `STATIC_VALUE_SOURCE_PROVEN`.
- pluginPath immediate setter source = stack local `[RBP-0x48]`; root origin upstream.
- sandboxTokens = helper return, conditioned by byte `[R13+0x70]`; structural source mapped.
- targetData = helper return sourced from `[RBP-0x50]`; structural source mapped.
- data = helper return sourced from R12; structural source mapped.
- client_name = helper return after non-null test; structural source mapped.
- alternate requestType path writes immediate `9` before same uint64 setter family.
Setter-family targets: string `0x7FF80D50FDC8`, uint64 `0x7FF80D50FDCE`, value `0x7FF80D50FDD4`; exact imported names not independently recovered.

## D97BB — llvmVersion source PROVEN
Exact batch:
- TXT 4779 bytes / SHA256 `694647bdfa56ca79b9446df8d9fb1a383e48834c13bbdd7462d68e1f6810c4e1`;
- JSON 4113 bytes / SHA256 `3ede6711d2494b3a9f3ae3900c0c9f8572b0c955b46b325789a7e6026fca63e2`.

D97BB parsed cached Metal `LC_FUNCTION_STARTS` and proved primary containing function `0x7FF80D370756..0x7FF80D370C28`; llvmVersion xref is offset `0xC9` in that function.
Exact setter chain:
- `0x7FF80D37081B`: `movslq 0x20(%rbx), %rdx`;
- `0x7FF80D37081F`: llvmVersion key LEA -> RSI;
- `0x7FF80D370826`: `movq %rax,%rdi`;
- `0x7FF80D370829`: uint64-setter-family call.
Classification: `G1_GOLDEN_PRIMARY_LLVMVERSION_SOURCE_RBX_PLUS_0x20=STATIC_VALUE_SOURCE_PROVEN`.
This supersedes D97AZ `UNKNOWN_RANGE_LEFT_EDGE`.

## CURRENT FRONTIER / NEXT ACTION — producer object provenance
Remain in GOLDEN_B `15.8 / 24H22`. Do NOT start Tahoe eligibility bypass yet.

Next bounded read-only collector should inspect only the proven function `0x7FF80D370756..0x7FF80D370C28`, especially its entry/prelude, to establish where RBX and R13 originate.
Goals:
1. identify exact writes that initialize/copy RBX and R13;
2. map them to ABI arguments/object pointers/upstream fields where possible;
3. consolidate `[RBX+0x20]=llvmVersion`, `[R13+0x8]=requestType`, `[R13+0x18]=timeout`, `[R13+0x70]` sandbox-token condition into explicit producer object relationships;
4. no broad cache scan, debugger attach, persistent instrumentation, system mutation, Root Patch or reboot.

After RBX/R13 provenance is established, decide whether the Golden contract needs one minimal runtime capture or is sufficient to begin the separately audited identical-OCLP Tahoe eligibility-bypass phase.