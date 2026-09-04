# OCLP7 CHECKPOINT — 2026-09-04 — D97AS classifier STATIC-PROVEN; D97AT Golden working comparator static exact, live waitfor inconclusive; D97AU next

## Authority / user Golden comparator override
Target Tahoe remains `26.6.2 / 25G82`, Haswell HD4400/4600, SMBIOS `MacBookAir6,2`. Accepted functional baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

User explicitly changed the prior Golden rule on 2026-09-04: the user may manually restore Golden Sequoia with ORIGINAL OCLP Root Patch and may manually boot Golden for runtime comparison. Assistant must not perform or automate Golden Root Patch/reboot. Golden remains a comparator and must receive no experimental system-file patching unless separately explicitly authorized. Read-only/static/log collectors and temporary user-invoked debugger attachment are allowed when they do not persistently modify Golden system files. This explicit later instruction supersedes the older `must never be booted` wording for comparator sessions.

## D97AS — six-predicate terminal classifier feasibility STATIC-PROVEN
User returned complete D97AS output. Exact natural Tahoe target remained `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9 / UUID 0FC4C627-2A5D-491B-8101-00CAAA7116B7`.

Proposed span `0x9D6BD..0x9D72D` exclusive is exactly 112 bytes, instruction aligned, with no instruction split, no D34 overlap, zero outside-to-span-interior CFG entries and one intended outside edge to span start. Fully resolved natural CFG remains zero reachable unresolved indirects.

Exact preimage SHA256 `2c82095cc1bcbab127be3abc298e5b56946485d13bbfeeae501b103bd952fa02`.

Classifier encoding:
- 107 bytes code + 5 NOPs = 112 bytes;
- code SHA256 `d6fb354149e6585253c850012d56538362159bdda00920cc09b99da2d293593a`;
- full patch SHA256 `d677f8c5d2dda8a5c9813918807ce92b05f988ce47d656f1f280f0c36739c44d`;
- synthetic image SHA256 `fed569ac34dbc34099f2405dde985d982ea6567de79ea7d0f893c553a6e8a77d`;
- exit contract `160..223`, bits = buffers>=65, samplers>=17, textures>=129, constant buffers>=15, interpolated inputs>=32, interpolated component inputs>=125.

Synthetic disassembly exactly matched intended checks, add 160, Darwin exit syscall, `ud2`, padding. `D97AS_SIX_PREDICATE_BITMASK_TERMINAL_CLASSIFIER=STATIC_PROVEN_FEASIBLE`. This is design proof only; not integrated/deployed/root-patched/runtime-tested.

## Golden Sequoia manually restored by user
User manually restored original OCLP Root Patch and booted working Golden Sequoia. D97AT collector confirmed:
- macOS `15.7.9 / 24G830`;
- boot at Fri Sep 4 12:54:24 2026 local;
- Intel HD Graphics 4400, Device ID `0x0412`, Metal Support `Metal 2`, internal display online;
- AppleIntelFramebufferAzul 18.0.8 and AppleIntelHD5000Graphics 18.0.8 loaded;
- Authenticated Root disabled; custom SIP configuration as printed by system.

No experimental Root Patch/system-file mutation was performed by D97AT.

## Golden exact MTLCompiler identity — PROVEN
Golden 32023:
- path `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`;
- bytes `1636896`;
- SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.

Golden 3802 also present:
- bytes `438560`;
- SHA256 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- UUID `D5CE0007-FAD0-3468-A62E-A21995BCA9F5`.

Known Golden root-patched 32023 SHA matched exactly.

## Golden vs Tahoe same late validator contract — STRUCTURAL-SEMANTIC exact static match
Golden `MTLSimCompiler::validSimulatorMetadata`:
- start `0x7FFB162C7132`;
- end `0x7FFB162C7830`;
- 408 instructions;
- 1790 function bytes;
- function SHA256 `45240c5139dbb344e743910cab8f9d160e2b3b587477817af60a5f5d25582b98`.

All six locals/thresholds/compare/branch addresses match Tahoe exactly:
- buffers `[rbp-0x1f0] >=65`;
- samplers `[rbp-0x1f8] >=17`;
- textures `[rbp-0x1f4] >=129`;
- constant buffers `[rbp-0x200] >=15`;
- interpolated inputs `[rbp-0x1fc] >=32`;
- interpolated component inputs `[rbp-0x1ec] >=125`.

`GOLDEN_TAHOE_STATIC_SIX_COUNTER_CONTRACT=EXACT_MATCH`.

## Critical comparator observation — working Golden also emits truncated simulator messages
D97AT passive recent runtime collection:
- `GOLDEN_MTL_LOG_RECORD_COUNT=1041`;
- `GOLDEN_MTL_LOG_PID_COUNT=29`;
- `GOLDEN_SELECTED_UUID_SENDER_RECORDS=484` for exact 32023/D5CE;
- `GOLDEN_LATE_RELATED_MESSAGE_COUNT=149`.

Working Golden repeatedly emits privacy/format-decoded fragments such as `upported in the simulator but <decode: mismatch for [%u] ...> were used` from exact 32023/D5CE. Therefore the same truncated late-message text observed on failing Tahoe is NOT failure-specific and must not be used alone as evidence that a late donor predicate fired or that the validator caused the failure.

## New generation-mix observation — hypothesis only pending boot-aligned comparator
Golden recent logs contain heavy sender activity from BOTH compiler generations:
- 3802/D5CE0007 sender PCs with hundreds of records;
- 32023/D5CE0008 sender PCs with hundreds of records.

Tahoe D97AN historical accelerated cohort had 351 MTL records with exact sender distribution 79 from 32023/0FC4 and zero observed 3802 sender records. This is a real observational difference, but current Golden D97AT window covered ~20 minutes of working desktop activity whereas Tahoe D97AN covered the short accelerated boot failure window. Do NOT promote generation mix to cause until a boot-aligned Golden first-three-minute comparison is collected.

## D97AT live raw-value capture — INCONCLUSIVE/tooling-lane limitation
D97AT requested 4 LLDB rounds, each 20 seconds. All returned zero hits and timed out around `process attach --name MTLCompilerService --waitfor`.

The breakpoint relocation design itself used LLDB `ResolveFileAddress`, so ASLR is not currently identified as the failure. More likely, `--waitfor` waited for a newly launched named service while Golden already had a persistent active MTLCompilerService PID (notably PID 360 generated exact 32023 logs for many minutes). The old live method therefore did not test explicit attachment to an existing active service.

Authoritative classification:
`D97AT_GOLDEN_RAW_SIX_COUNTER_VALUES=INCONCLUSIVE_ZERO_HITS_WAITFOR_EXISTING_SERVICE_NOT_TESTED`.
Do not interpret zero hits as zero counter values, no validator traffic, or attach denial.

## D97AU prepared — existing-PID raw capture + boot-aligned generation comparator
Public wrapper:
- `OCLP7_D97AU_GOLDEN_EXISTING_PID_RAW_COUNTER_AND_BOOT_GENERATION_COMPARATOR.command`;
- commit `19e61d3a85bacfed2bcab03020a2a2ad4e895a70`;
- Git blob `c10d4cd98700fe465b1d2cc659bf4cc619a42245`.

D97AU is Golden-only and fail-closes unless OS is exactly 15.7.9/24G830 and exact Golden 32023 SHA is present. It performs no experimental Root Patch/reboot/system-file mutation.

It does two bounded jobs:
1. reconstructs an exact Golden boot-aligned first-three-minute MTLCompilerService window from `kern.boottime`, reports exact 3802 vs 32023 sender counts/PID mixing and 32023 outer-PC counts, with Tahoe D97AN reference counts printed separately;
2. enumerates currently live MTLCompilerService PIDs, attaches temporarily with root LLDB to existing PIDs (not `--waitfor`), selects exact 32023 module by UUID/path, resolves file address `0x7FFB162C76C3`, captures up to 8 hits of the six raw dword locals plus threshold mask/status-equivalent and backtrace, then detaches. If attach or hits fail, it reports that without altering Golden system files.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
Remain in working Golden Sequoia. Run D97AU once and return both report and JSON. Do not reboot to Tahoe yet. No original/experimental Root Patch is needed before D97AU because user has already manually restored and booted working Golden.

After D97AU:
- if raw Golden values are captured, persist them immediately as comparator baseline before returning to Tahoe;
- independently evaluate boot-aligned 3802/32023 generation behavior versus Tahoe D97AN;
- only then decide the next Tahoe diagnostic/repair step.
