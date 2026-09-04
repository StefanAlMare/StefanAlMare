# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97BB_GOLDEN_LLVMVERSION_SOURCE_PROVEN_D97BC_OBJECT_PROVENANCE_V2_READY.md`
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
Sequoia `15.8 / 24H22`. No EFI changes per user; same original OCLP Root Patch reapplied manually; accelerated GUI working.

Critical donor artifacts remain byte-identical across A->B:
- 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Original selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`; no original 32023 immediate branch.
Receiver schema: requestType:uint64, sandboxTokens:value, llvmVersion:uint64, pluginPath:string, targetData:value, data:value, client_name:string, timeout:uint64.
G2 original donor dialect retains mapped request offsets including `+0xD0/+0x88/+0x8C` and `+0xC4/+0xC8/+0xCC/+0xDC/+0xE0`.

## GOLDEN_A runtime oracle
D97AU boot3m: total451; 32023=220; 3802=193; distinct generation PIDs; 32023 PCs `0x9A9FC/0x9FFEE/0xA0521`; 3802 PCs `0x1DFA3/0x238E3`.
Original selector source is `xpc_dictionary_get_uint64(request,"llvmVersion")`. Combined with exhaustive selector semantics, GOLDEN_A 3802 donor provenance corresponds to request llvmVersion 3802 and GOLDEN_A 32023 donor provenance corresponds to request llvmVersion 31001. This is composed static+runtime proof, distinct from direct runtime register capture.

## GOLDEN_B producer rebase
Cached Metal text `0x7FF80D343000..0x7FF80D5C5C3D`, SHA256 `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`.
All primary xrefs match GOLDEN_A offsets: llvmVersion `+0x2D81F`, requestType `+0x2D832`, sandboxTokens `+0x2D914`, targetData `+0x2D939`, data `+0x2D95E`, pluginPath `+0x2D97F`, client_name `+0x2D9FD`, timeout `+0x2DA13`; alternate requestType `+0x1089E1`, data `+0xDB881`.
G3 GOLDEN_B reaches `Metal compositor activated`. D97BA boot3m MTL zero-record lane is visibility-INCONCLUSIVE.

## D97AZ/D97BB static producer contract
D97AZ proved:
- primary requestType source = dword `[R13+0x8]`;
- timeout source = qword `[R13+0x18]`;
- sandboxTokens path conditioned by byte `[R13+0x70]`;
- alternate requestType = immediate `9`;
- pluginPath immediate setter source `[RBP-0x48]`; targetData/data/client_name helper-return paths structurally mapped.
Setter-family targets: string `0x7FF80D50FDC8`, uint64 `0x7FF80D50FDCE`, value `0x7FF80D50FDD4`.

D97BB exact batch:
- TXT 4779 bytes / SHA256 `694647bdfa56ca79b9446df8d9fb1a383e48834c13bbdd7462d68e1f6810c4e1`;
- JSON 4113 bytes / SHA256 `3ede6711d2494b3a9f3ae3900c0c9f8572b0c955b46b325789a7e6026fca63e2`.

`LC_FUNCTION_STARTS` proves primary request-builder function `0x7FF80D370756..0x7FF80D370C28`.
Exact llvmVersion chain: `movslq 0x20(%rbx),%rdx` at `0x7FF80D37081B` -> llvmVersion key -> uint64 setter at `0x7FF80D370829`.
Classification: `G1_GOLDEN_PRIMARY_LLVMVERSION_SOURCE_RBX_PLUS_0x20=STATIC_VALUE_SOURCE_PROVEN`.

## CURRENT FRONTIER / NEXT ACTION — D97BC V2
Remain in GOLDEN_B `15.8 / 24H22`. Do NOT start Tahoe eligibility bypass yet.

Run only hardened wrapper:
`OCLP7_D97BC_V2_GOLDEN_15_8_PRIMARY_REQUEST_BUILDER_OBJECT_PROVENANCE_HARDENED_WRAPPER.command`
- wrapper commit `02bfb4c212dc62a7659469e5439b6003e02721df`;
- wrapper Git blob `43e1a9a96c211f0db530dfa3395dde30d97a42d2`.

Core:
`OCLP7_D97BC_GOLDEN_15_8_PRIMARY_REQUEST_BUILDER_OBJECT_PROVENANCE.command`
- commit `6457b6f5c613de18f60ae6517fc3f05ee8323240`;
- core Git blob `7513123504d526bb5439410c453080d909fef218`.

D97BC revalidates GOLDEN_B/donor/Metal/function boundaries, disassembles only the proven primary function, inventories writes to RBX/R13 and traces their explicit origins conservatively.
Goal: map `[RBX+0x20]=llvmVersion`, `[R13+0x8]=requestType`, `[R13+0x18]=timeout`, `[R13+0x70]` sandbox condition to explicit producer object/ABI relationships.
No broad cache scan, debugger attach, persistent instrumentation, system mutation, Root Patch or reboot.

After D97BC decide whether one minimal Golden runtime capture remains necessary or whether Golden is sufficiently characterized to begin the separately audited identical-OCLP Tahoe eligibility-bypass phase.