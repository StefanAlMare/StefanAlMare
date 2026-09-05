# OCLP7 CHECKPOINT — 2026-09-06 — D97BY real DSC export succeeds; native __text/Metal4 preserved; real dlopen blocked first by missing SG_READ_ONLY; D97BZ next

## Entering / safety state
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- Native Tahoe Metal remains authoritative; full legacy main Metal remains forbidden.
- No Root Patch or accelerated reboot authorized.

## Returned D97BY evidence
Bundle:
`OCLP7_D97BY_REAL_DSC_SINGLE_IMAGE_EXPORT_20260906_012127.zip`
- bytes `748714`;
- SHA256 `c2517f1a3758fcbdabe0ab033a7bc7f07385aadf6f13f9369bb1cecb10fd2b53`;
- TXT bytes `1418984`, SHA256 `33835943e2bf117c945b064aa626dd4339db5a7d44ae9e18cf838c38df7c84c4`;
- JSON bytes `1422292`, SHA256 `3fcd4a1413b330249da185ce1ad073423e91f2b7e3cc2e77603893e9dbdb84e2`.

ZIP contains only package directory + TXT + JSON; no Apple binary or extractor binary is present.
D97BY transient cleanup reported `TEMP_REMAINING_FILE_COUNT=0` before packaging.

Collector packaging-order note: the copied inner TXT ends after cleanup and therefore does not contain the final post-copy `D97BY_COLLECTION_COMPLETE` echo. The uploaded ZIP itself and its contents prove packaging completed. Treat this as a report-copy ordering defect only, not target evidence.

## Pinned extractor provenance
D97BY verified:
- `blacktop/ipsw` release `v3.1.713`;
- `checksums.txt` SHA256 `97be6afeac03aa4df0379b9224f9cbec750fb4ac56424daa7c1c66abb3d36334`;
- selected asset `ipsw_3.1.713_macOS_x86_64.tar.gz`;
- asset SHA256 `7f5719d0a2a53996fca4dba4826aa015a6ddecfbba822a21e92400a80da7f1ab`;
- transient `ipsw` executable SHA256 `d02498ccd0a88e0afc461cbfd5f4a9df34a6194386595226b10a9a46fe078d6a`.

No installation and no local compilation occurred.

## Real single-image export — RAW and --slide both PASS extraction
Exact DSC:
`/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h`.
Exact image:
`/System/Library/Frameworks/Metal.framework/Versions/A/Metal`.

Both export modes returned RC 0:
- RAW output bytes `5722944`, SHA256 `89032654dd427ffed1c5b3722fbddabd2ed333b429c15db25ca15af13b2f5210`;
- SLIDE output bytes `5722944`, SHA256 `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`.

Both compact outputs have the same segment geometry:
- `__TEXT`: VM `0x7FF80F47D000`, fileoff `0x0`, filesize `0x2EC000`;
- `__DATA_CONST`: VM `0x7FF84119DCD0`, fileoff `0x2EC000`, filesize `0x70000`;
- `__DATA`: VM `0x7FF843D590C0`, fileoff `0x35C000`, filesize `0xD000`;
- `__DATA_DIRTY`: VM `0x7FF84384F510`, fileoff `0x369000`, filesize `0x5000`;
- `__LINKEDIT`: VM `0x7FF880000000`, fileoff `0x36E000`, filesize `0x207340` (declared/padded output segment `0x208000`).

Thus the exporter compacts file offsets but retains shared-cache VM addresses.

## Exact native code and Metal4 preservation
For both RAW and SLIDE:
- extracted `__text` relative offset `0x1630`;
- size `0x20B9F1`;
- SHA256 `2d58f84edd3ff6e93427f2204c0fb481204320aaf2708df784dd14039ee4dd3a`;
- `EXACT_NATIVE=True` against exact local Tahoe cache `__text`.

Metal4 string counts remain exactly the known native counts:
- `_MTL4CommandQueue` 82;
- `_MTL4CommandBuffer` 103;
- `_MTL4CommandAllocator` 49;
- `_MTL4RenderCommandEncoder` 79;
- `_MTL4ComputeCommandEncoder` 97;
- `_MTL4MachineLearningCommandEncoder` 38.

Classification:
`D97BY_REAL_EXPORT_NATIVE___TEXT_AND_METAL4_PRESERVATION=STATIC_PROVEN`.

## Preflight/signing are not the blocker
For RAW and SLIDE:
- unsigned `dlopen_preflight` PASS;
- temporary ad-hoc `codesign --force --sign -` PASS;
- strict codesign verification PASS;
- signed `dlopen_preflight` PASS.

Therefore signing/trust is again not the current first blocker.

## Real dlopen — exact first dyld rejection
Real child-process `dlopen` fails identically for:
- RAW unsigned;
- RAW ad-hoc signed;
- SLIDE unsigned;
- SLIDE ad-hoc signed.

Exact dyld error:
`__DATA_CONST segment missing SG_READ_ONLY flag`.

The current process already has native `/System/Library/Frameworks/Metal.framework/Versions/A/Metal` loaded, but dyld still evaluates the explicit temp path and rejects the exported Mach-O on this metadata validation.

Authoritative classifications:
- `D97BY_REAL_EXPORT_RAW_AND_SLIDE=PASS`;
- `D97BY_UNSIGNED_AND_SIGNED_PREFLIGHT_RAW_SLIDE=PASS`;
- `D97BY_ADHOC_SIGN_RAW_SLIDE=PASS`;
- `D97BY_REAL_DLOPEN_RAW_SLIDE=NEGATIVE_IDENTICAL_MISSING_SG_READ_ONLY`;
- `D97BY_SLIDE_OPTION_LOADABILITY_IMPROVEMENT=NEGATIVE`;
- `D97BY_CODE_SIGNING_IS_FIRST_BLOCKER=NEGATIVE`.

No D97BV patch was applied because no original extracted baseline was real-dlopen loadable. This obeyed the pre-reboot/static gate.

## Exporter implementation relevance
Audited public source shows `go-macho File.Export()` creates a compact segment offset map and `optimizeLoadCommands()` remaps segment file offsets/filesizes and section offsets. It preserves segment VM addresses and does not add `SG_READ_ONLY` to `__DATA_CONST` in the shown path.

Therefore D97BY's rejection is consistent with the reverse-engineering exporter output and is independent of D97BV.

## What is NOT yet proven
Do not yet claim that setting `SG_READ_ONLY` makes the extracted Metal deployable.
The compact export still has shared-cache VM sub-page residues (`__DATA_CONST ...DCD0`, `__DATA ...90C0`, `__DATA_DIRTY ...F510`). dyld may expose another standalone-layout requirement after the flag gate.
Do not alter VM addresses/section addresses yet; doing so could break x86_64 RIP-relative cross-segment semantics.

## CURRENT ACTION — D97BZ
Remain unpatched in Tahoe VESA.

Next transient test must:
1. reproduce only the RAW real export using the same pinned/verified `ipsw` release;
2. inspect and record every `LC_SEGMENT_64` flags word;
3. create one temp metadata-only variant setting only `SG_READ_ONLY (0x10)` on `__DATA_CONST`;
4. prove the binary diff before signing is confined to that 32-bit load-command flags field;
5. test unsigned preflight + real child dlopen;
6. ad-hoc sign the metadata-fixed copy, strict-verify, and repeat preflight + real child dlopen;
7. if and only if this produces a real-dlopen loadable original baseline, re-audit D97BV site/cave in that exact variant before patching;
8. otherwise stop at the next exact dyld error; do not automatically realign/move segments;
9. delete extractor + Apple binaries; package TXT/JSON only.

No Root Patch, installation, or accelerated reboot authorized.
