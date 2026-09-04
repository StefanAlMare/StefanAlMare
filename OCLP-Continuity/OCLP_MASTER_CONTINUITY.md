# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97BC_GOLDEN_CONTRACT_STRUCTURAL_CLOSED_IDENTICAL_OCLP_TAHOE_ELIGIBILITY_PREFLIGHT_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
Updated: 2026-09-04 EEST

## Mandatory startup
Before any technical change read in full, in order:
1. `OCLP_PERMANENT_WORKING_RULES.md`;
2. this MASTER;
3. `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. the exact checkpoint named above;
5. `OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP_HISTORY_INDEX.md`.

## Target / execution contract
Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable accelerated GUI.
Routine/static/log/small work stays on ASUS2 under user control. GitHub is for major compile/build/package plus identity-pinned script persistence/delivery. Never auto Root Patch or reboot.

## Authoritative architecture
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Final Tahoe comparator must use the SAME ORIGINAL OCLP functional content as Golden. The only permitted Tahoe-specific functional delta is a separately audited minimal eligibility/OS-support bypass. Historical P1/P2b/P3/AIR00/D34/P6/P7 are evidence/adapters only and are not part of the identical-OCLP comparator unless later independently justified as producer normalization.

## Golden snapshots
GOLDEN_A = Sequoia `15.7.9 / 24G830`, full D97AU/D97AX/D97AY runtime/static oracle.
GOLDEN_B = Sequoia `15.8 / 24H22`, no EFI changes per user, same original OCLP Root Patch manually reapplied, acceleration working.

Critical donor artifacts byte-identical A->B:
- 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.
Original selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`.

## Golden contract book — current accepted closure
Receiver XPC schema: requestType:uint64, sandboxTokens:value, llvmVersion:uint64, pluginPath:string, targetData:value, data:value, client_name:string, timeout:uint64.
GOLDEN_B cached Metal text `0x7FF80D343000..0x7FF80D5C5C3D`, SHA `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`; primary eight-key xrefs rebased identically to GOLDEN_A.
G3 GOLDEN_B reaches `Metal compositor activated` with HD4400/Metal2 and Azul/HD5000 loaded.

D97BB proved primary request-builder function `0x7FF80D370756..0x7FF80D370C28` via `LC_FUNCTION_STARTS` and llvmVersion source `movslq 0x20(%rbx),%rdx` -> key -> uint64 setter.

D97BC exact returned files:
- JSON 1740 bytes / SHA256 `67458836538b52b7ada6d54400bd396aa8eb6521b6cffbed0c87fdf93767c530`;
- TXT 5768 bytes / SHA256 `b4e9207e439d5740a214ad09f00f4565dbb2c0680b1d93e5b45f6f38327ddef5`.

D97BC revalidated function boundary and maps object origins:
- `movq %rdi,%rbx` => RBX = ABI_ARG1_RDI;
- `movq %rsi,%r13` => R13 = ABI_ARG2_RSI.
No later RBX/R13 writes occur before mapped field uses.

Producer layout bound to ABI objects:
- ABI arg1/RDI + `0x20` signed dword -> llvmVersion;
- ABI arg2/RSI + `0x08` dword -> primary requestType;
- ABI arg2/RSI + `0x18` qword -> timeout;
- ABI arg2/RSI + `0x70` byte -> sandboxTokens path condition;
- alternate requestType path = immediate 9.
Other D97AZ helper-return paths remain structurally mapped.

Classification:
- `G1_GOLDEN_RBX_ORIGIN_CLASS=STATIC_ABI_ORIGIN_PROVEN`;
- `G1_GOLDEN_R13_ORIGIN_CLASS=STATIC_ABI_ORIGIN_PROVEN`;
- `G1_GOLDEN_PRIMARY_LLVMVERSION_SOURCE_RBX_PLUS_0x20=STATIC_VALUE_SOURCE_PROVEN`.

GOLDEN_A runtime dual generation remains authoritative: combined with exhaustive unchanged selector semantics, observed 3802 donor traffic corresponds to request llvmVersion 3802 and observed 32023 donor traffic corresponds to request llvmVersion 31001. This is composed static+runtime proof. GOLDEN_B zero-record MTL log query remains visibility-INCONCLUSIVE and does not negate it.

## Golden closure decision
Golden is sufficiently characterized to BEGIN the identical-OCLP Tahoe eligibility phase. No extra Golden reboot is required solely for structural provenance. Not every payload byte/runtime field is claimed captured; remaining unknowns remain explicit and can be measured symmetrically if Tahoe diverges there.

## CURRENT FRONTIER / NEXT ACTION — READ-ONLY TAHOE ELIGIBILITY PREFLIGHT
Do NOT Root Patch or reboot.

Next bounded action must read-only audit the exact OCLP lineage/resources and Tahoe canonical source to:
1. identify locally observable original OCLP app/version/build/identity used by working Golden;
2. locate exact OS/root-patch eligibility gates for Tahoe;
3. separate eligibility-only control flow from payload selection/mutation paths;
4. record hashes/identities needed to prove SAME ORIGINAL OCLP functional content;
5. propose the smallest eligibility-only delta with a fail-closed manifest.

No source mutation during preflight. Only after eligibility-only isolation is proven may a minimal local source integration be made and audited; major build/package then belongs in the GitHub build lane. Root Patch and reboot remain separately authorized manual actions.
