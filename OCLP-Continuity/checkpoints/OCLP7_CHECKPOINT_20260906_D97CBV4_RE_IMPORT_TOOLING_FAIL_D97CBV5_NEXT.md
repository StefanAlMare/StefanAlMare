# OCLP7 CHECKPOINT — 2026-09-06 — D97CB-v4 remap/host construction PASS; embedded Python missing `re`; D97CB-v5 next

## Safety state
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa` active and no Root Patch.
- No Root Patch or accelerated reboot authorized.

## Returned D97CB-v4 evidence
User returned pasted Terminal log `Text lipit(4).txt`.
Mounted-file identity used for persistence:
- bytes `14516`;
- SHA256 `42f5f436a54d4c144fdbb2db8c15fb0ffb97cc3559d9bb707c30e9e2ab7d0002`.

Collector did not reach packaging because embedded Python stopped before the final-state baseline parser ran.

## Target remap reconfirmed
D97CB-v4 again reproduced the exact D97CB atomic standalone-layout remap and reached:
- `D97CB_ATOMIC_REMAP_STRUCTURAL=PASS`;
- `D97CB_VM_ADDRESS_PRESERVATION=PASS`;
- `D97CB_SECTION_FILEOFF_REMAP=PASS`;
- `D97CB_SYMTAB_N_SECT_REMAP=PASS`;
- `D97CB_DIFF_DOMAIN=PASS`.

Retained exact facts:
- RAW Metal SHA256 `89032654dd427ffed1c5b3722fbddabd2ed333b429c15db25ca15af13b2f5210`;
- native `__text` SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a`;
- exact native Metal4 counts preserved;
- 5 section fileoff rewrites;
- 3652 symtab `n_sect` remaps;
- pre-sign diff count `40655`, outside audited domains `0`;
- post order `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`;
- all segment/section VM addresses preserved;
- `__DATA_CONST` flags `0x10`;
- `file`/`otool -l`/`otool -L` PASS.

Unsigned and ad-hoc-signed remapped images again pass `dlopen_preflight`; actual Python child `dlopen` remains `RC=-11` (SIGSEGV), with no earlier explicit dyld validation rejection. Standalone loadability remains `NOT_YET_PROVEN` because Python already has native Metal loaded.

## Cold host construction PASS
The copied `/usr/bin/true` host:
- copyfile-based content copy succeeded;
- copied Apple signature removal PASS;
- ad-hoc sign PASS;
- strict verify PASS.

Thus the prior `copy2/copystat/chflags` defect is closed.

## D97CB-v4 tooling failure
V4 introduced final-state parsing with `re.compile(...)` but embedded Python import line was:
`import collections,hashlib,json,os,shutil,struct,subprocess,sys`
with no `re` import.

Exact stop:
`NameError: name 're' is not defined`.

This occurred before baseline final-state parsing, positive-control injection, remapped-Metal cold injection, or any D97BV application.

Classification:
- `D97CBV4_REMAP=STRUCTURAL_RECONFIRMED_PASS`;
- `D97CBV4_COLD_HOST_CONSTRUCTION=PASS`;
- `D97CBV4_FINAL_STATE_PARSER=TOOLING_FAIL_MISSING_RE_IMPORT`;
- `D97CBV4_REMAP_STANDALONE_LOADABILITY=NOT_YET_PROVEN`.

## CURRENT ACTION — D97CB-v5
Remain unpatched in Tahoe VESA.
Run only `OCLP7_D97CB_v5_import_re_fix.sh`:
- bytes `34860`;
- SHA256 `da11102ded1340feab06f7e611bb7610f1d56d22805ac2e84c9c00c6e138878e`.

V5 is intentionally identical to D97CB-v4 except that embedded Python imports `re` and labels/temporary paths advance to v5.

Required continuation:
1. reproduce the exact atomic remap;
2. construct the same ad-hoc `/usr/bin/true` cold host;
3. parse final loaded/delayed state correctly;
4. require baseline Metal/libbz2 not final-loaded;
5. require libbz2 positive-control injection final-loaded with exit 0;
6. only then inject the signed remapped Metal and record explicit target path, target final state, system Metal final state and process exit;
7. only target final-loaded + exit 0 may authorize D97BV re-audit/application;
8. target final-loaded + process failure is a later init/runtime frontier and stops without D97BV.

No Root Patch, installation, or accelerated reboot authorized.
