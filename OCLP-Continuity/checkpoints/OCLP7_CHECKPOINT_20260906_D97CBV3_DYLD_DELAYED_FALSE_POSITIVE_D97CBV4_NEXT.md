# OCLP7 CHECKPOINT — 2026-09-06 — D97CB-v3 cold host valid; dyld delayed-state parser false positive; D97CB-v4 next

## Entering / safety state
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- Native Tahoe Metal remains authoritative; legacy main Metal shadow remains forbidden.
- No Root Patch or accelerated reboot authorized.

## Returned D97CB-v3 evidence
User returned complete Terminal paste `Text lipit(3).txt`.
Local mounted-file identity:
- bytes `118929`;
- SHA256 `c8f3d4317fa1e4ad605fffd249f6abb18301df358d36be39f3f5502ae6529e2a`.

No ZIP exists because collector stopped fail-closed during the cold-host baseline gate.

## Structural remap reconfirmed
D97CB-v3 again reproduced exact D97CB atomic remap and reached:
- `D97CB_ATOMIC_REMAP_STRUCTURAL=PASS`;
- `D97CB_VM_ADDRESS_PRESERVATION=PASS`;
- `D97CB_SECTION_FILEOFF_REMAP=PASS`;
- `D97CB_SYMTAB_N_SECT_REMAP=PASS`;
- `D97CB_DIFF_DOMAIN=PASS`.

Exact retained facts:
- RAW Metal SHA256 `89032654dd427ffed1c5b3722fbddabd2ed333b429c15db25ca15af13b2f5210`;
- native `__text` SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a`;
- Metal4 counts unchanged;
- 5 exact section fileoff rewrites;
- 3652 exact symtab `n_sect` remaps;
- pre-sign diff `40655`, outside audited domains `0`;
- post order `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`;
- all segment and section VM addresses preserved;
- `__DATA_CONST` flags `0x10`;
- `file`/`otool -l`/`otool -L` PASS.

Unsigned and ad-hoc-signed remapped images both again pass `dlopen_preflight`, while actual Python-child `dlopen` returns `RC=-11` (SIGSEGV). This is retained as a later runtime frontier but is not standalone-loadability proof because Python already has native Metal loaded.

## Cold host creation now works
D97CB-v3 fixed the prior Python `copy2/copystat/chflags` failure by using `shutil.copyfile()` + `chmod`.
The copied `/usr/bin/true`:
- had its copied Apple signature removed;
- was ad-hoc signed successfully;
- strict verification PASS;
- baseline process exit `0`.

Thus the host construction itself is valid.

## Critical D97CB-v3 tooling correction — closure print is not final loaded state
The baseline trace printed many dylibs, including:
- `/usr/lib/libbz2.1.0.dylib`;
- `/System/Library/Frameworks/Metal.framework/Versions/A/Metal`.

But later in the same trace dyld explicitly logged:
- `move loaded to delayed: libbz2.1.0.dylib`;
- `move loaded to delayed: Metal`;
with no later corresponding `move delayed to loaded` for either before process exit.

Apple dyld source `DyldRuntimeState.cpp` confirms these messages are actual state transitions:
- `move loaded to delayed` pushes the loader into `delayLoaded`;
- `move delayed to loaded` is the reverse promotion.

Therefore D97CB-v3's simple substring gate:
`if '/Metal.framework/' in ctrl_out: FAIL=COLD_HOST_PRELOADS_METAL`
was a false positive. Metal was present in the prebuilt/delayed closure trace but final state was delayed, not actively loaded.

The same issue invalidates the old baseline condition that mere textual presence of `libbz2` means it is preloaded.

Authoritative classifications:
- `D97CBV3_COLD_HOST_COPY_AND_ADHOC_SIGN=PASS`;
- `D97CBV3_COLD_HOST_BASELINE_EXIT=PASS`;
- `D97CBV3_BASELINE_METAL_FINAL_STATE=DELAYED_STATIC_RUNTIME_TRACE_PROVEN`;
- `D97CBV3_BASELINE_BZ2_FINAL_STATE=DELAYED_STATIC_RUNTIME_TRACE_PROVEN`;
- `D97CBV3_FAIL_COLD_HOST_PRELOADS_METAL=TOOLING_FALSE_POSITIVE`;
- `D97CBV3_REMAP_STANDALONE_LOADABILITY=NOT_YET_PROVEN`.

No positive-control `DYLD_INSERT_LIBRARIES` test and no remapped-Metal cold injection were executed after the false-positive stop.
D97BV was not applied.

## CURRENT ACTION — D97CB-v4
Remain unpatched in Tahoe VESA.
Run only `OCLP7_D97CB_v4_dyld_final_state_cold_host.sh`:
- bytes `34857`;
- SHA256 `fa0e6fc5825a260be3c638bdb177c63378abd3adf44b08d0683a99d1e383a0be`.

D97CB-v4 must reproduce the identical Metal remap and only change dyld trace interpretation:
1. parse direct image lines as provisional `loaded`;
2. apply `move loaded to delayed` and `move delayed to loaded` transitions in order;
3. baseline requires final Metal state != loaded and final libbz2 state != loaded;
4. positive-control injection requires final `libbz2.1.0.dylib=loaded` with exit 0;
5. only then inject signed remapped Metal;
6. classify target explicit path observation, target final state, system Metal final state and process exit independently;
7. only explicit target final-loaded + exit 0 authorizes D97BV re-audit/application;
8. target final-loaded + failure is a later init/runtime frontier and must stop without D97BV;
9. delete all transient binaries and package TXT/JSON only.

No Root Patch, installation, or accelerated reboot authorized.
