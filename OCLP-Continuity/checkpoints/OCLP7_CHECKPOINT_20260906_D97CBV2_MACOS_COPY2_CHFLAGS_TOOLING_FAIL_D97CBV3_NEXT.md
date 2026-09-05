# OCLP7 CHECKPOINT — 2026-09-06 — D97CB-v2 remap still structural PASS; macOS copy2/chflags tooling failure; D97CB-v3 next

## Entering / safety state
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- No Root Patch or accelerated reboot authorized.

## Returned D97CB-v2 Terminal evidence
User-returned pasted Terminal log:
- bytes `13995`;
- SHA256 `fb053fe50bf85a803bcad582f7d1e6995ca0f14c4ca468c5de75e76b22a46d7b`.
- Packaging was not reached; no ZIP exists for this run.

## D97CB-v2 remap result retained
The exact D97CB atomic remap again passed all structural gates before the cold-host harness:
- RAW native `__text` exact identity PASS;
- native Metal4 count surface unchanged;
- five section file offsets remapped exactly;
- exactly 3652 symtab `n_sect` values remapped with the persisted D97CA distribution;
- pre-sign diff count `40655`;
- pre-sign diff outside audited domains `0`;
- post order `__TEXT,__DATA_CONST,__DATA_DIRTY,__DATA,__LINKEDIT`;
- `SG_READ_ONLY` retained on `__DATA_CONST`;
- every segment and section VM address preserved;
- `file`, `otool -l`, `otool -L` PASS.

Markers reached again:
- `D97CB_ATOMIC_REMAP_STRUCTURAL=PASS`;
- `D97CB_VM_ADDRESS_PRESERVATION=PASS`;
- `D97CB_SECTION_FILEOFF_REMAP=PASS`;
- `D97CB_SYMTAB_N_SECT_REMAP=PASS`;
- `D97CB_DIFF_DOMAIN=PASS`.

Unsigned and signed remapped images again passed `dlopen_preflight`. Actual Python-child `dlopen` again returned `RC=-11`, meaning child termination by SIGSEGV, not a Python exception and not an explicit dyld validation error. Because that Python process already carries native Metal, standalone loadability remains `NOT_YET_PROVEN`.

## Exact D97CB-v2 tooling failure
Cold-host creation used `shutil.copy2('/usr/bin/true', HOST)`. On macOS Python 3.13, `copy2()` calls `copystat()`, which attempts to copy BSD file flags via `chflags`. The temp destination rejected that operation:
`PermissionError: [Errno 1] Operation not permitted: '/private/tmp/.../cold_true'`.

This is a macOS metadata-copy tooling defect only. It occurred after all remap structural gates and does not invalidate the remap.

Authoritative classifications:
- `D97CBV2_ATOMIC_REMAP_STRUCTURAL=PASS_RECONFIRMED`;
- `D97CBV2_REMAP_UNSIGNED_SIGNED_PREFLIGHT=PASS_RECONFIRMED`;
- `D97CBV2_REMAP_CHILD_DLOPEN=SIGSEGV_NEGATIVE_RECONFIRMED`;
- `D97CBV2_COLD_HOST_COPY2_CHFLAGS=TOOLING_NEGATIVE`;
- `D97CBV2_REMAP_STANDALONE_LOADABILITY=NOT_YET_PROVEN`.

## CURRENT ACTION — D97CB-v3
Run only `OCLP7_D97CB_v3_macos_safe_cold_host.sh`:
- bytes `32508`;
- SHA256 `24f0b52509530700daa64eb2c9a2fcd882671acb4a4ff8b5f6570443c66918c1`.

D97CB-v3 is byte-for-byte identical in Metal transformation logic to D97CB-v2. The only intentional harness change is:
- replace `shutil.copy2('/usr/bin/true', HOST)` with `shutil.copyfile('/usr/bin/true', HOST)` followed by explicit `chmod(0755)`.
This copies file contents only and avoids BSD metadata/file-flag propagation.

The cold-host protocol remains unchanged:
1. copied `/usr/bin/true` must have its copied signature removed and be ad-hoc signed/strict verified;
2. baseline must exit 0 with no Metal and no libbz2 in dyld trace;
3. positive-control injection of `/usr/lib/libbz2.1.0.dylib` must exit 0 and be visible, proving `DYLD_INSERT_LIBRARIES` is honored;
4. only then inject signed remapped Metal and classify target-not-observed vs target-mapped-then-failed vs target-mapped-and-exit-0;
5. only target-mapped-and-exit-0 authorizes D97BV re-audit/application.

No installation, Root Patch, or accelerated reboot authorized.
