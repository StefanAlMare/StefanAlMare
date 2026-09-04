# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260904_D97AT_GOLDEN_WORKING_COMPARATOR_STATIC_EXACT_LIVE_WAITFOR_INCONCLUSIVE_D97AU_EXISTING_PID_CAPTURE_NEXT.md`
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

## Permanent contract / baseline
Target Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600, SMBIOS `MacBookAir6,2`. Accepted baseline exactly P1+P2b+P3+AIR00+D34, true-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`. P6/P7 retained runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. D34 cave protected.

Routine/static/log/small work stays ASUS2; GitHub only major compile/build/package. Never auto Root Patch/reboot.

### Explicit Golden comparator override — 2026-09-04
User explicitly superseded the older `Golden must never be booted` restriction for comparator work. User may manually restore ORIGINAL OCLP Root Patch on Golden Sequoia and manually boot Golden to collect runtime comparator data. Assistant must not automate Golden Root Patch or reboot and must not install experimental system-file patches on Golden unless separately explicitly authorized. Read-only/static/log collection and temporary user-invoked debugger attachment are permitted when no persistent Golden system-file mutation occurs.

Architecture remains `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working donor path -> image`.

## Tahoe D97AM through D97AQ retained state
D97AM source/build/artifact/deploy/Root Patch FULL PASS. Historical accelerated 02:29 remains `NEGATIVE_NO_USABLE_GUI`; 02:32 VESA excluded.

D97AN: exact natural 32023 runtime provenance PROVEN 79/79, old D5CE/A4F zero; 3802 sender records zero in the 351-record accelerated-window MTL cohort. Runtime PCs 0x9FFEE=7, 0xA0521=7, 0xA5F81=65.

D97AO: natural validator CFG fully resolved, all five late xrefs STATIC-PROVEN reachable, zero unresolved indirects.

D97AP: specialized start->timing CONTROL-FLOW PROVEN for observed cohort; backend 65 starts, no static timing site.

D97AQ: RunningBoard direct termination binding channel exhausted: 23 monitor exits, zero exact-cohort direct bindings; exact service termination remains UNKNOWN/INCONCLUSIVE.

## D97AR — exact six late counter predicate map
Exact natural donor threshold locals:
- `[rbp-0x1f0] >=65` buffers;
- `[rbp-0x1f8] >=17` samplers;
- `[rbp-0x1f4] >=129` textures;
- `[rbp-0x200] >=15` constant buffers;
- `[rbp-0x1fc] >=32` interpolated inputs;
- `[rbp-0x1ec] >=125` interpolated component inputs.

## D97AS — six-bit terminal classifier STATIC-PROVEN FEASIBLE
Proposed natural Tahoe span `0x9D6BD..0x9D72D` exclusive = 112 instruction-aligned bytes, no split, no D34 overlap, zero outside-to-interior CFG edges, one intended edge to span start. Exact preimage SHA `2c82095cc1bcbab127be3abc298e5b56946485d13bbfeeae501b103bd952fa02`.

107-byte classifier + 5 NOPs; code SHA `d6fb354149e6585253c850012d56538362159bdda00920cc09b99da2d293593a`; full patch SHA `d677f8c5d2dda8a5c9813918807ce92b05f988ce47d656f1f280f0c36739c44d`. Status `160+6-bit mask`, exact threshold order above. Synthetic disassembly PASS. Not integrated/deployed/runtime-tested.

## D97AT — working Golden comparator
User manually restored original OCLP Root Patch and booted Golden Sequoia. Collector confirmed working `15.7.9 / 24G830`, Intel HD4400 `0x0412`, Metal 2, display online, Azul/HD5000 graphics drivers loaded.

Golden exact 32023 identity: `1636896 / ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269 / D5CE0008-587C-3861-971A-4BAEFB7B9C5B`. Golden 3802 identity: `438560 / 85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40 / D5CE0007-FAD0-3468-A62E-A21995BCA9F5`.

Golden `validSimulatorMetadata` exact same static six-counter contract as Tahoe; 408 instructions, 1790 bytes, function SHA `45240c5139dbb344e743910cab8f9d160e2b3b587477817af60a5f5d25582b98`.

Working Golden passive logs: 1041 MTL records, 29 PIDs, 484 exact 32023/D5CE sender records, 149 simulator/late-related decoded fragments. This proves the truncated `supported in simulator...were used` text is not failure-specific.

Golden recent logs also show both 3802 and 32023 heavily active. Tahoe failing short boot cohort showed zero 3802; this is observational only until boot-aligned Golden comparison.

D97AT LLDB raw counter capture: 4 rounds, zero hits, each timing out around `process attach --name MTLCompilerService --waitfor`. Breakpoint relocation used `ResolveFileAddress`; zero hits are classified INCONCLUSIVE, likely because new-process wait mode did not test already-active persistent service PID. Do not infer counter values from zero hits.

## CURRENT ACTION — D97AU while still in Golden
Run public wrapper `OCLP7_D97AU_GOLDEN_EXISTING_PID_RAW_COUNTER_AND_BOOT_GENERATION_COMPARATOR.command`, commit `19e61d3a85bacfed2bcab03020a2a2ad4e895a70`, Git blob `c10d4cd98700fe465b1d2cc659bf4cc619a42245`.

D97AU fail-closes on exact Golden OS/build and 32023 SHA. It reconstructs the first 3 minutes after Golden boot and compares 3802/32023 sender generation activity and exact 32023 outer PCs against Tahoe D97AN reference counts. Then it attaches temporarily to already-live MTLCompilerService PIDs, selects exact 32023 module by UUID/path, resolves file address `0x7FFB162C76C3`, and captures up to 8 raw six-counter hits plus threshold mask and backtrace. No experimental Root Patch/reboot/system-file mutation.

Remain in Golden and return D97AU report+JSON. Do not reboot Tahoe before D97AU is audited.