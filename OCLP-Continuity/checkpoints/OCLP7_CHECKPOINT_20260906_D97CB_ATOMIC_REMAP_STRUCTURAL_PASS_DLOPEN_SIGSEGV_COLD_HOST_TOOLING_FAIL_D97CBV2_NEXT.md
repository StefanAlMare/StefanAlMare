# OCLP7 CHECKPOINT — 2026-09-06 — D97CB atomic remap structural PASS; child dlopen SIGSEGV; cold-host control invalid because ipsw preloads Metal; D97CB-v2 next

## Entering / safety state
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- Native Tahoe Metal remains authoritative; legacy main Metal shadow remains forbidden.
- No Root Patch or accelerated reboot authorized.

## Returned D97CB evidence
D97CB did not reach packaging because the cold-host control intentionally failed closed. User returned the complete Terminal log as pasted text.

Log identity:
- bytes `101328`;
- SHA256 `46797ea02b54ffdc728fe3203ec4ebc5c83956e6b2c812827dbf675cc23ee8e8`.

No D97CB ZIP exists. This is a collector/tooling stop after valid target evidence, not a target reconstruction failure.

## Exact source / exporter identity revalidated
D97CB revalidated:
- OS `26.6.2 / 25G82`;
- native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- active `-igfxvesa`;
- pinned `blacktop/ipsw v3.1.713` manifest/asset/binary identities;
- exact RAW Metal SHA256 `89032654dd427ffed1c5b3722fbddabd2ed333b429c15db25ca15af13b2f5210`;
- exact native `__text` rel `0x1630`, size `0x20B9F1`, SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a`;
- exact native Metal4 count surface.

## Atomic segment/file-order remap — structural FULL PASS
D97CB performed the D97CA-proven bounded remap only in a temporary export.

Five file-backed section-offset rewrites were exact:
- `__DATA_DIRTY` section 0: `0x369000 -> 0x35C000`;
- `__DATA_DIRTY` section 1: `0x36D4C0 -> 0x3604C0`;
- `__DATA` section 0: `0x35C000 -> 0x361000`;
- `__DATA` section 1: `0x3605E0 -> 0x3655E0`;
- `__DATA` section 2: `0x364500 -> 0x369500`.

Symtab remap count exactly `3652`, matching D97CA:
- `30->34`: 2236;
- `31->35`: 404;
- `32->36`: 305;
- `33->37`: 127;
- `34->38`: 9;
- `35->30`: 440;
- `36->31`: 25;
- `37->32`: 101;
- `38->33`: 5.

Pre-sign diff:
- total differing bytes `40655`;
- differences outside audited domains `0`.

Post-remap segment order / geometry:
1. `__TEXT`: VM `0x7FF80F47D000`, fileoff `0x0`, size `0x2EC000`;
2. `__DATA_CONST`: VM `0x7FF84119DCD0`, fileoff `0x2EC000`, size `0x70000`, flags `0x10` (`SG_READ_ONLY`);
3. `__DATA_DIRTY`: VM `0x7FF84384F510`, fileoff `0x35C000`, size `0x5000`, sections 30..33;
4. `__DATA`: VM `0x7FF843D590C0`, fileoff `0x361000`, size `0xD000`, sections 34..38;
5. `__LINKEDIT`: VM `0x7FF880000000`, fileoff `0x36E000`.

All segment VM addresses and all section VM addresses remained unchanged.

Collector markers reached:
- `D97CB_ATOMIC_REMAP_STRUCTURAL=PASS`;
- `D97CB_VM_ADDRESS_PRESERVATION=PASS`;
- `D97CB_SECTION_FILEOFF_REMAP=PASS`;
- `D97CB_SYMTAB_N_SECT_REMAP=PASS`;
- `D97CB_DIFF_DOMAIN=PASS`.

External parsers on remapped image:
- `file` RC 0, Mach-O x86_64 dylib;
- `otool -l` RC 0;
- `otool -L` RC 0.

Classification:
`D97CB_ATOMIC_SEGMENT_ORDER_REMAP=STRUCTURAL_STATIC_PROVEN`.

## Child dlopen behavior — far deeper than prior dyld validation, but not yet standalone proof
Unsigned remapped image:
- `dlopen_preflight` PASS;
- actual child `dlopen` process return `RC=-11` (SIGSEGV), with no prior explicit dyld validation error captured.

Ad-hoc-signed remapped image:
- signing PASS;
- strict verify PASS;
- `dlopen_preflight` PASS;
- actual child `dlopen` process return `RC=-11` (SIGSEGV), again no explicit prior dyld validation error captured.

This differs materially from D97BY/D97BZ, where dyld returned explicit metadata/order rejections before load. The remapped binary therefore passes those earlier validation gates and enters a later mapping/init/runtime region.

However the Python child already has native Metal loaded, so SIGSEGV cannot be interpreted as a clean standalone-baseline failure or success. Duplicate/coalesced Objective-C/framework state remains a confounder.

Safe classifications:
- `D97CB_REMAP_UNSIGNED_SIGNED_PREFLIGHT=PASS`;
- `D97CB_REMAP_UNSIGNED_SIGNED_CHILD_DLOPEN=SIGSEGV_NEGATIVE`;
- `D97CB_REMAP_STANDALONE_LOADABILITY=NOT_YET_PROVEN`.

Do not classify the SIGSEGV as D97BV-related; D97BV was not applied.

## Cold-host tooling defect
D97CB attempted to use a transient ad-hoc-signed copy of the pinned `ipsw` executable as a cold host.

Control run itself showed native:
`/System/Library/Frameworks/Metal.framework/Versions/A/Metal`
already in dyld's loaded-image trace, along with Metal-dependent frameworks.

Collector correctly stopped:
`FAIL=COLD_HOST_PRELOADS_METAL`.

No remapped-Metal `DYLD_INSERT_LIBRARIES` cold test was executed after that stop.

Classification:
`D97CB_COLD_HOST_IPSW=TOOLING_INVALID_PRELOADS_NATIVE_METAL`.
This does not invalidate the atomic remap evidence.

## CURRENT ACTION — D97CB-v2 cold-host correction only
Remain unpatched in Tahoe VESA.

D97CB-v2 must reproduce the exact same remap with no semantic/layout changes, then replace only the cold-host harness:
1. copy `/usr/bin/true` to `/private/tmp`;
2. remove its Apple signature from the copy and ad-hoc re-sign the copy;
3. prove baseline host exits 0 and does not preload Metal;
4. prove `DYLD_INSERT_LIBRARIES` is actually honored by injecting a known benign control library not present in baseline, preferred `/usr/lib/libbz2.1.0.dylib`, and require that library path to appear in dyld trace with exit 0;
5. only if control injection is proven, inject the ad-hoc-signed remapped Metal into the same host with `DYLD_PRINT_LIBRARIES`, `DYLD_PRINT_SEGMENTS`, and `DYLD_PRINT_INITIALIZERS`;
6. classify separately: target path mapped, process exit status, and any dyld/initializer failure;
7. only if remapped original target path appears and process exits 0 may D97BV be re-audited/applied to a second temp copy;
8. if target path appears but process crashes, stop and treat that as a later init/runtime frontier; do not apply D97BV;
9. if target path never appears and dyld emits a new validation error, stop at that error;
10. delete every transient Apple/third-party binary before return and package TXT/JSON only.

No Root Patch, installation, or accelerated reboot authorized.
