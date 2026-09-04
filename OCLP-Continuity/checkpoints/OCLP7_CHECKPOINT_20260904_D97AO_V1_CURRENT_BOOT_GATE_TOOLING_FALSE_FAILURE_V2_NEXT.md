# OCLP7 CHECKPOINT — 2026-09-04 — D97AO V1 current-boot gate tooling false failure; V2 next

## Authority / retained state
All D97AN conclusions remain unchanged. D97AM accelerated boot `02:29` remains `NEGATIVE_NO_USABLE_GUI`. D97AN proves exact failing 32023 MTLCompiler sender provenance `79/79` for natural-flow UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`, with old D5CE/A4F sender matches zero. Five-late runtime reachability remains INCONCLUSIVE because unified-log messages were truncated; exact service exit status remains UNKNOWN/INCONCLUSIVE.

Previous checkpoint: `OCLP7_CHECKPOINT_20260904_D97AN_NATURAL_UUID_PROVEN_79_OF_79_LATE_PARSER_INCONCLUSIVE_D97AO_STATIC_PC_CFG_NEXT.md`.

## D97AO V1 result — tooling false failure only
Public V1 wrapper commit/blob: `2401be6af44180ae35040ad752ea3b361238d0b7` / `969701ab1fb00bea91d44196b463e3a400efd258`.

The user ran V1 after an additional later reboot. Wrapper identity and parse passed, but current `kern.boottime` was:

```text
{ sec = 1788505699, usec = 290614 } Fri Sep 4 10:08:19 2026
```

V1 still required current boot sec `1788478349` (the historical `02:32` VESA recovery) and therefore stopped immediately with:

```text
D97AO_AUDIT=FAIL_CLOSED|REASON=CURRENT_BOOT_CHANGED_CHRONOLOGY_INVALID
```

No target SHA/UUID check, disassembly, runtime-PC mapping, natural-site byte check, or CFG reconstruction was reached. Mutation ledger remained source/app/system/Golden NO, service launch AUTO-NO, Root Patch AUTO-NO, snapshot NO, reboot AUTO-NO.

Classification: `D97AO_V1=TOOLING_FALSE_FAILURE_CURRENT_BOOT_GATE_ONLY`.

The historical accelerated chronology `02:29` -> `02:32` is already persisted and remains authoritative for D97AN runtime evidence. D97AO is a static audit of the currently installed exact root-patched target and does not semantically require the current boot itself to still be the original `02:32` VESA session. The correct fail-closed gates for D97AO are target SHA/LC_UUID/natural bytes plus static disassembly invariants.

## D97AO V2 prepared
Public V2 wrapper:
- file `OCLP7_D97AO_V2_READONLY_NATURAL_P7_RUNTIME_PC_AND_RESOLVED_CFG_AUDIT.command`;
- commit `d5e83b1bbc2cb40bdd0f33b9e36cb8158705543a`;
- blob `e10803b6c394baf6cd5736dece2839dd3d319f77`.

V2 downloads exact V1 by pinned commit/blob and performs exactly three in-memory replacements limited to the obsolete current-boot equality gate. It retains exact target gates:

```text
EXPECTED_SHA=e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9
EXPECTED_UUID=0FC4C627-2A5D-491B-8101-00CAAA7116B7
NATURAL_SITE_OFF=0x9D6BD
NATURAL_SITE_BYTES=8b8d10feffff83f941
```

It also retains the D97AB seven-entry switch resolution, runtime-PC set `0x9FFEE,0xA0521,0xA5F81`, and five late xrefs `0x9D6C8,0x9D6EE,0x9D712,0x9D73A,0x9D75D` unchanged.

V2 remains strict read-only: no source/app/system/Golden mutation, no service launch, no Root Patch, no snapshot mutation, no reboot.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
Run D97AO V2 once. The audit must first prove the current target is still exact natural-flow postimage `e7739c...` / UUID `0FC4...` and natural bytes at `0x9D6BD`. If those gates pass, map the three D97AN runtime PCs and reconstruct the fully resolved natural-P7 validator CFG.

STOP after D97AO V2 complete output. No Root Patch. No reboot.
