# OCLP7 CHECKPOINT — 2026-09-04 — Sequoia updated to 15.8/24H22; original OCLP donor byte-identical; D97AZ old-OS fail-closed; D97BA rebase next

## User-reported state change
User updated working Golden Sequoia from `15.7.9 / 24G830` to `15.8 / 24H22`, made no EFI changes, manually reapplied Root Patch with the same original OCLP, and reports accelerated graphics/GUI works as before.

This does NOT invalidate the persisted 15.7.9 Golden contract book. It creates a new current Golden producer snapshot that must be rebased before further producer-side backslice because Metal.framework/dyld shared cache may have changed.

## D97AZ V3 execution on 15.8 — correct fail-closed
User ran authoritative D97AZ V3 wrapper. Wrapper identity and tooling gates passed:
- wrapper expected/actual blob `1f9ab406f35a3ae51c125584473b3ab64b0ed327`;
- base core expected/actual blob `fec92ab86cad92cc69307284c6ad3cd26ed74c19`;
- base bytes `16218`, SHA256 `88ac10e521337203bf322e9974c698eb6978b188bd6d30f65a8633789af695c6`;
- exactly three xref-aligned range transforms plus signed-rel32 translation applied;
- patched bytes `16113`, SHA256 `f99ad82375cc045cb3abe5b52f5189dc9d93d946a624b46be7e0247d88ea0d71`;
- one Python block compiled; aligned-range/eight-key gates PASS.

Core then observed:
- `OS_VERSION=15.8`;
- `OS_BUILD=24H22`;
- Golden 32023 SHA unchanged `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- Golden 3802 SHA unchanged `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- original MTLCompilerService SHA unchanged `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

D97AZ stopped at `D97AZ_AUDIT=FAIL_CLOSED|REASON=GOLDEN_OS_IDENTITY` because its authoritative target was intentionally pinned to 15.7.9/24G830.

Classification: `D97AZ_ON_SEQUOIA_15_8=TOOLING/IDENTITY_FAIL_CLOSED_NO_BACKSLICE_RESULT`.
No system mutation, cache mmap, persistent extraction/instrumentation, debugger attach, Root Patch or reboot occurred during D97AZ.

## What survives unchanged
Because the three critical original-OCLP donor artifacts are byte-identical across the OS update, the following 15.7.9 evidence remains valid as donor-contract evidence unless later contradicted:
- G1 receiver-side MTLCompilerService eight-key schema;
- original selector semantics `3802 -> Versions/3802`, `31001 -> Versions/32023`;
- G2 original 32023 donor request-memory dialect and mapped functions;
- Golden 3802 static function mapping inside the byte-identical 3802 binary.

Classification: `ORIGINAL_OCLP_DONOR_15_8_VS_15_7_9=BYTE_IDENTITY_PROVEN_FOR_32023_3802_SERVICE`.

## What must be rebased
Producer/runtime evidence tied to Sequoia 15.7.9 is now a historical Golden snapshot, not automatically the current 15.8 producer contract:
- Metal.framework dyld-shared-cache image base/text bytes;
- exact Metal key string VMs and RIP xrefs;
- request-builder xref offsets/dataflow if Metal changed;
- boot-aligned dual-generation runtime counts/PC cohorts;
- G3 driver->compiler->`Metal compositor activated` positive corridor on the 15.8 boot.

Do NOT apply 15.7.9 absolute Metal VMs to 15.8 before revalidation.

## Golden snapshot naming
- `GOLDEN_A = Sequoia 15.7.9 / 24G830`, fully persisted D97AX/D97AY producer snapshot.
- `GOLDEN_B = Sequoia 15.8 / 24H22`, current working system; original donor byte-identical, producer/runtime rebase pending.

## CURRENT ACTION — D97BA V2
Remain in Sequoia 15.8. Do not start Tahoe eligibility bypass and do not run D97AZ again yet.

Run hardened read-only producer rebase wrapper:
`OCLP7_D97BA_V2_GOLDEN_SEQUOIA_15_8_PRODUCER_REBASE_HARDENED_WRAPPER.command`
- wrapper commit `641e3ef6ffb2ebfe5f38e8ff37d60ec2452b7427`;
- wrapper Git blob `13cf5578123134329665322a7a016fabed8e109c`.

Core:
`OCLP7_D97BA_GOLDEN_SEQUOIA_15_8_PRODUCER_REBASE_DYNAMIC_METAL_AND_BOOT3M.command`
- commit `4c3c76b826b50d6b98ff400baac1b65c709508f7`;
- Git blob `b9fd1966c7d88a98284dd5775cacb59036b26e00`.

V2 applies exactly one tooling transform to prefer `processID` in `log show --style json`, then verifies zsh syntax, exactly four embedded Python blocks, Python compile, 15.8/24H22 identity pins, Metal-range-only cache reading and safety markers before execution.

D97BA goals:
1. prove original OCLP donor byte identity again on current 15.8;
2. dynamically locate Metal in the 15.8 dyld shared cache;
3. hash only the current cached Metal text image;
4. recover exact eight-key string/xref census within Metal only and compare xref offsets against GOLDEN_A 15.7.9;
5. inspect the first three minutes of the current 15.8 boot for exact 32023/3802 UUID lanes/PCs;
6. confirm the current positive `Metal compositor activated` corridor when visible in the boot3m log channel;
7. no cache mmap/extraction, debugger attach, system mutation, Root Patch or reboot.

After D97BA, if the primary eight-key offsets/dataflow are unchanged, adapt D97AZ to 15.8 with the rebased absolute Metal VM while preserving its 15.7.9 offset contract. If they changed, rebuild the backslice from the new exact 15.8 xrefs rather than transplanting old addresses.
