# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97BB_GOLDEN_B_LLVMVERSION_SOURCE_PROVEN_RBX_PLUS_0x20_OBJECT_PROVENANCE_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Protocol / final architecture
Routine/static/log/small work stays ASUS2; GitHub only major compile/build/package plus identity-pinned script persistence/delivery. No automatic Root Patch/reboot.

Final comparator architecture:
`Tahoe native producer -> Golden-equivalent ingress -> ORIGINAL OCLP donor -> Golden-equivalent compiler output -> Haswell driver -> image`.

First characterize Golden completely, then use SAME ORIGINAL OCLP functional content on Tahoe with only a separately audited eligibility/OS-support bypass. Historical Tahoe custom patches remain evidence only unless later reintroduced as producer-side normalization.

## Golden snapshots
### GOLDEN_A — Sequoia 15.7.9 / 24G830
Complete D97AU/D97AX/D97AY snapshot retained.
Golden 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`, UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.
Golden 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`, UUID `D5CE0007-FAD0-3468-A62E-A21995BCA9F5`.
Original MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.
Original selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`.
D97AU boot3m: total451, 32023=220, 3802=193, 8 exact-generation PIDs; 32023 PCs `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`; 3802 PCs `0x1DFA3=96`, `0x238E3=97`.
D97AX G1 receiver schema and G2 donor dialect mapped; G3 reaches Metal compositor.
D97AY primary request-builder xrefs: llvmVersion `+0x2D81F`, requestType `+0x2D832`, sandboxTokens `+0x2D914`, targetData `+0x2D939`, data `+0x2D95E`, pluginPath `+0x2D97F`, client_name `+0x2D9FD`, timeout `+0x2DA13`; alternate requestType `+0x1089E1`, data `+0xDB881`.

### GOLDEN_B — Sequoia 15.8 / 24H22 current
User updated Sequoia, no EFI changes, manually reapplied same original OCLP Root Patch; acceleration works. Critical donor hashes unchanged from GOLDEN_A.
D97BA: cached Metal text unchanged address range `0x7FF80D343000..0x7FF80D5C5C3D`, SHA `f3e49d47...`; all primary/alternate xref offsets match GOLDEN_A; G3 success reconfirmed. Boot3m MTL zero-record lane is visibility-INCONCLUSIVE.

## D97AZ V4 — GOLDEN_B primary value/dataflow backslice PASS
Exact files:
- TXT 17967 bytes / SHA256 `04b89d8b9e8b2d6dcd8a8210a90e7406ea1bc3632d64646d8385c248fe51f1e2`;
- JSON 8841 bytes / SHA256 `445cfb3160513756a9be40a374d2137694c658ab08048ca3b2181fa67d3d0ce6`.

Static source map:
- primary requestType = 32-bit `[R13+0x8]` -> R14 -> RDX;
- timeout = qword `[R13+0x18]` -> RDX;
- pluginPath immediate setter source = `[RBP-0x48]`;
- sandboxTokens helper return after `[R13+0x70]` condition;
- targetData helper return sourced from `[RBP-0x50]`;
- data helper return sourced from R12;
- client_name helper return after non-null test;
- alternate requestType path exact immediate `9`.
Setter-family targets: string `0x7FF80D50FDC8`, uint64 `0x7FF80D50FDCE`, value `0x7FF80D50FDD4`.
llvmVersion was initially `UNKNOWN_RANGE_LEFT_EDGE` only because extraction began at its xref.

## D97BB — GOLDEN_B llvmVersion source + containing-function boundary PASS
Exact files:
- TXT 4779 bytes / SHA256 `694647bdfa56ca79b9446df8d9fb1a383e48834c13bbdd7462d68e1f6810c4e1`;
- JSON 4113 bytes / SHA256 `3ede6711d2494b3a9f3ae3900c0c9f8572b0c955b46b325789a7e6026fca63e2`.

Cached Metal `LC_FUNCTION_STARTS` proves containing function `0x7FF80D370756..0x7FF80D370C28` and llvmVersion xref offset `0xC9`.
Exact source chain:
- `0x7FF80D37081B`: `movslq 0x20(%rbx), %rdx`;
- `0x7FF80D37081F`: llvmVersion key;
- `0x7FF80D370829`: uint64 setter-family call.
Classification: `G1_GOLDEN_PRIMARY_LLVMVERSION_SOURCE_RBX_PLUS_0x20=STATIC_VALUE_SOURCE_PROVEN`.

Original exhaustive selector plus GOLDEN_A runtime donor provenance logically constrains corresponding request llvmVersion values: 3802 donor lane <- llvmVersion 3802; 32023 donor lane <- llvmVersion 31001. This is composed static+runtime evidence, not direct runtime register capture.

## CURRENT ACTION — producer object provenance
Remain in GOLDEN_B 15.8 / 24H22. Do not start Tahoe eligibility bypass yet.
Next bounded read-only static collector inspects only the already-proven primary request-builder function entry/prelude to identify exact provenance of RBX and R13, then relate `[RBX+0x20]=llvmVersion`, `[R13+0x8]=requestType`, `[R13+0x18]=timeout`, `[R13+0x70]` sandbox-token condition to explicit producer objects. No broad cache scan, system mutation, debugger attach, persistent instrumentation, Root Patch or reboot.
After this, decide whether a minimal Golden runtime capture remains necessary or whether the Golden contract is sufficient to begin the identical-OCLP Tahoe eligibility-bypass phase.