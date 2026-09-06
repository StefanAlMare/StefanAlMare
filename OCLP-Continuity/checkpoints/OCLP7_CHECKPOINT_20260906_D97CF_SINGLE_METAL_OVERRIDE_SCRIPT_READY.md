# OCLP7 CHECKPOINT — 2026-09-06 — D97CF single-Metal framework override script ready

Authority: extends `OCLP7_CHECKPOINT_20260906_D97CE_SLIDE_IDENTICAL_OBJC_SIGSEGV_DUPLICATE_METAL_NEXT.md` without changing its D97CE technical conclusions.

## State
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- Native Tahoe Metal remains authoritative; legacy main Metal shadow remains forbidden.
- D97BV is not applied and remains unauthorized pending a new signed-cave audit.
- No Root Patch, installation, source/local compilation, accelerated boot or reboot authorized.

## D97CE retained closure
D97CE proved full `ipsw --slide` changes `88012` bytes / `43909` 8-byte chunks, heavily in Objective-C/data metadata, but page-aligned SLIDE Metal reproduces exactly the D97CD Objective-C frontier:
- target final loaded;
- native shared-cache Metal final loaded;
- final target marker `makeSegmentsReadWrite`;
- zero dyld lines after marker;
- process RC `-11` SIGSEGV.

Thus `D97CE_SLIDE_ADVANCES_BEYOND_D97CD=NEGATIVE` and full slide-info resolution is insufficient at this boundary.

## D97CF purpose
Discriminate the active duplicate-Metal confounder. D97CD/D97CE simultaneously load:
1. temporary standalone native-derived Metal;
2. native Tahoe Metal from shared cache;
with the same native UUID and Objective-C class universe.

D97CF creates the already-proven page-aligned SLIDE Metal only under `/private/tmp/Frameworks/Metal.framework/Versions/A/Metal`, signs that exact temporary binary, and launches the proven ad-hoc `/usr/bin/true` cold host with:
- `DYLD_FRAMEWORK_PATH=<temp>/Frameworks`;
- `DYLD_INSERT_LIBRARIES=/System/Library/Frameworks/Metal.framework/Versions/A/Metal`.

The canonical path is deliberately requested so dyld itself must decide whether the framework override can replace the shared-cache image.

## Fail-closed interpretation
D97CF records every loaded Metal UUID/path and separately detects native shared-cache Metal mapping.

It may declare `D97CF_TRUE_SINGLE_METAL=PASS` only if:
- temporary framework Metal is actually mapped/loaded;
- canonical native cache Metal is absent;
- no native-cache Metal mapping line exists;
- the unique loaded Metal path set contains only the temporary framework target.

If shared-cache override is disallowed by current dyld/developer-mode policy, result is `FRAMEWORK_OVERRIDE_NOT_HONORED`; no ObjC causal inference is permitted.

If true single-Metal is achieved:
- identical `makeSegmentsReadWrite -> SIGSEGV` makes duplicate Metal insufficient as current cause;
- advancement beyond that marker supports duplicate/native+standalone interaction as causal at this frontier;
- exit 0 is the strongest positive result.

## Script identity
Run only:
`OCLP7_D97CF_single_metal_framework_override.sh`
- bytes `24782`;
- SHA256 `83d473e2ec5f872e85268b305bb138059ea2fad87f4f1e1360858b90aa54c62e`;
- shell syntax PASS;
- embedded Python compile PASS.

The script uses exact proven SLIDE SHA256 `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`, exact D97CD geometry, exact 20 section-fileoff rewrites, `__LINKEDIT +0x3000`, six LINKEDIT payload-field shifts, 3652 `n_sect` remaps, and the already-proven cold-host + libbz2 control.

All Apple binaries remain temporary and are deleted before TXT/JSON-only packaging. D97BV remains absent.

## CURRENT ACTION
Remain unpatched in VESA. Run only the exact D97CF script above and return its ZIP/output.
