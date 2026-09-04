# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-04 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260904_D97AZ_V4_GOLDEN_B_VALUE_BACKSLICE_PASS_LLVMVERSION_LEFT_EDGE_D97BB_PRELUDE_NEXT.md`.
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
D97AX G1 receiver schema: requestType/sandboxTokens/llvmVersion/pluginPath/targetData/data/client_name/timeout. G2 original donor dialect mapped. G3 reaches `Metal compositor activated`.
D97AY primary Metal request-builder offsets: llvmVersion `+0x2D81F`, requestType `+0x2D832`, sandboxTokens `+0x2D914`, targetData `+0x2D939`, data `+0x2D95E`, pluginPath `+0x2D97F`, client_name `+0x2D9FD`, timeout `+0x2DA13`; alternate requestType `+0x1089E1`, data `+0xDB881`.
Golden 3802 `0x238E3` maps to pipeline build start; `0x1DFA3` to pipeline timing/serialization.

### GOLDEN_B — Sequoia 15.8 / 24H22 current
User updated Sequoia, no EFI changes, manually reapplied same original OCLP Root Patch; acceleration works.
Critical donor hashes unchanged from GOLDEN_A.

## D97BA — GOLDEN_B producer rebase PASS
Exact files:
- JSON 10774 bytes / SHA256 `f702cd1bff179ce268d18d1ab42762f0e4fcba066b488de7fc3e1ae599444a48`;
- TXT 16246 bytes / SHA256 `79f2aa9d3e65f14258e75d1459127b4f5801b492418d6a750550a478df1a3ad4`.

Cached Metal text `0x7FF80D343000..0x7FF80D5C5C3D`, SHA256 `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`.
All eight primary and both alternate request-builder xref offsets match GOLDEN_A exactly.
G3 working corridor reconfirmed; `Metal compositor activated` at `18:13:35.728/35.730`.
D97BA boot3m MTL query returned zero records; printed runtime-lane label retracted. Authoritative: `INCONCLUSIVE_VISIBILITY_CHANNEL_ZERO_RECORDS`.

## D97AZ V4 — GOLDEN_B primary value/dataflow backslice PASS
Exact files:
- TXT 17967 bytes / SHA256 `04b89d8b9e8b2d6dcd8a8210a90e7406ea1bc3632d64646d8385c248fe51f1e2`;
- JSON 8841 bytes / SHA256 `445cfb3160513756a9be40a374d2137694c658ab08048ca3b2181fa67d3d0ce6`.

Static source map:
- primary requestType = 32-bit `[r13+0x8]` -> R14 -> RDX; `STATIC_VALUE_SOURCE_PROVEN`;
- timeout = qword `[r13+0x18]` -> RDX; `STATIC_VALUE_SOURCE_PROVEN`;
- pluginPath immediate setter source = `[rbp-0x48]`;
- sandboxTokens helper return after `[r13+0x70]` condition;
- targetData helper return sourced from `[rbp-0x50]`;
- data helper return sourced from R12;
- client_name helper return after non-null test.

Alternate requestType path writes exact immediate `9` to EDX before the same uint64-setter-family target: `G1_GOLDEN_ALTERNATE_REQUESTTYPE_VALUE_9=STATIC_VALUE_PROVEN`.

Setter-family target grouping:
- `0x7FF80D50FDC8`: string family pluginPath/client_name;
- `0x7FF80D50FDCE`: uint64 family llvmVersion/requestType/timeout/requestType_alt;
- `0x7FF80D50FDD4`: value family sandboxTokens/targetData/data.
Imported names themselves not independently recovered.

llvmVersion remained `NO_WRITER` only because V4's exact aligned extraction begins at the llvmVersion key xref `0x7FF80D37081F`; setter follows at `0x...70829`, so its RDX writer lies before the captured left edge. Authoritative: `G1_GOLDEN_LLVMVERSION_STATIC_SOURCE=UNKNOWN_RANGE_LEFT_EDGE`, not semantic absence.
D97AZ `NM_OWNER=traceLog` hint is retired as non-authoritative shared-cache function ownership.

## CURRENT ACTION — D97BB V2
Remain in GOLDEN_B 15.8 / 24H22. Do not start Tahoe eligibility bypass.

Run hardened wrapper `OCLP7_D97BB_V2_GOLDEN_15_8_LLVMVERSION_FUNCTION_START_HARDENED_WRAPPER.command`:
- commit `4e99313000e59b57b28b761571e2d56fbd96429b`;
- blob `e51f547b3765688b772b43937dc0f3d762a9c801`.

Core `OCLP7_D97BB_GOLDEN_15_8_LLVMVERSION_FUNCTION_START_AND_RDX_SOURCE.command`:
- commit `c05563fdeae951c5731051c73ac7e43fd7f2ffdd`;
- blob `c02a2e7c196f3260858be55f6175ba275120ac35`.

D97BB pins current Metal SHA, parses cached Metal `LC_FUNCTION_STARTS`, derives the actual containing function boundary for llvmVersion xref, disassembles only that bounded function region and back-slices RDX into the uint64 setter. No system mutation, debugger attach, persistent instrumentation, Root Patch or reboot.
