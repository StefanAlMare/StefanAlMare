# OCLP7 CHECKPOINT — 2026-09-06 — D97BX preflight/sign PASS; real dlopen mmap-alignment NEGATIVE; real DSC extractor next

## Entering/current machine state
- Target: Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched Tahoe VESA with `-igfxvesa` active and no active Root Patch.
- Native Tahoe Metal / Metal4 remains authoritative.
- Legacy `13.2.1-24/Versions/A/Metal` remains forbidden because it shadows native Metal and removes Tahoe Metal4 superclass ABI.
- No Root Patch or accelerated reboot is authorized.

## D97BX returned evidence
Bundle:
`OCLP7_D97BX_DYLD_LOADABILITY_AND_ADHOC_SIGN_20260906_010046.zip`
- bytes `746802`;
- SHA256 `f25f364bb8bb9fb89f3f289cd217620ccc32ff81631ff354669301fcdf74ca57`.

Inner evidence:
- TXT bytes `1415402`, SHA256 `3dfdc48a6051475cfa4ffeac3c2e300ffe93cd786851f84a752c692ad0d71ff3`;
- JSON bytes `1422429`, SHA256 `6f7e0146059cd3fdd26149ec54ec7e27f96510b17d9ea9467607ba9c55a95452`.

Exact D97BV file offsets in sparse mirror remained:
- site `0xF5E1719`;
- cave `0xF47E560`.

Temporary Apple binaries were deleted before return; report ZIP contains TXT+JSON only.

## Preflight result — original and patched both PASS
Unsigned sparse mirrors:
- original `dlopen_preflight` PASS;
- D97BV-patched `dlopen_preflight` PASS.

After ad-hoc signing:
- original `dlopen_preflight` PASS;
- D97BV-patched `dlopen_preflight` PASS.

Authoritative classifications:
- `D97BX_UNSIGNED_PREFLIGHT_ORIGINAL_PATCHED=PASS`;
- `D97BX_SIGNED_PREFLIGHT_ORIGINAL_PATCHED=PASS`.

The JSON collector summary `SIGNED_PREFLIGHT_BOTH_PASS` is valid only for preflight acceptance; it must NOT be interpreted as successful real loadability.

## Temporary ad-hoc signing — PASS, not the blocker
`codesign --force --sign - --timestamp=none` succeeded on both temporary sparse mirrors.

`codesign --verify --strict --verbose=4` returned success for both, including:
- `valid on disk`;
- `satisfies its Designated Requirement`.

Thus:
`D97BX_ADHOC_SIGN_ORIGINAL_PATCHED=PASS`.

Signing materially densified the sparse file allocation (roughly full apparent-size allocation), but that is a storage/tooling side effect, not the load failure cause.

Permanent current classification:
`D97BX_CODE_SIGNING_IS_CURRENT_BLOCKER=NEGATIVE`.

## Real dlopen result — NEGATIVE identically for original and patched
Real child-process `dlopen` failed for both the unmodified sparse mirror and D97BV-patched sparse mirror, before and after ad-hoc signing.

Representative original failure:
`mmap(addr=0x175428CD0, size=0x0006F820) failed with errno=22`.

Representative patched failure has the same geometry/error class with a different ASLR base.

The failing mapped segment is native shared-cache `__DATA_CONST`, whose VM geometry retains the shared-cache non-page-aligned `...CD0` start.

`errno=22` (`EINVAL`) is consistent with standalone mmap requirements rejecting this shared-cache-optimized segment geometry.

Authoritative classifications:
- `D97BX_REAL_DLOPEN_ORIGINAL_PATCHED=NEGATIVE_IDENTICAL_MMAP_EINVAL`;
- `D97BX_SPARSE_MIRROR_IS_NOT_STANDALONE_LOADABLE=NEGATIVE`.

## D97BV adapter is NOT the loadability regression
Original and D97BV-patched mirrors:
- pass preflight identically;
- sign/verify identically;
- fail real dlopen in the same segment and error class.

Therefore:
`D97BX_D97BV_PATCH_LOADABILITY_REGRESSION=NEGATIVE`.

This preserves all prior D97BV static-semantic conclusions:
- exact 3802 is preserved;
- non-3802 Tahoe behavior is unchanged;
- diff remains bounded to site+cave.

## Structural sparse mirror remains useful but is not a deployable dylib
D97BW-v2 structural PASS remains valid for:
- byte identity;
- load-command inspection;
- Metal4 surface preservation;
- bounded patch proof.

D97BX adds the important limitation that simply mirroring shared-cache segments at their declared cache geometry does not reconstruct a real standalone dyld-loadable dylib.

Do not manually tweak one `__DATA_CONST` vmaddr/fileoff in isolation. A proper DSC extraction must rebuild all standalone Mach-O segment/file/linkedit/fixup relationships coherently.

## Real extractor frontier
The next action is to use a real dyld shared-cache extractor that exports one image as a standalone Mach-O.

Preferred candidate after current public-source audit:
- `blacktop/ipsw`, release `v3.1.713` observed/pinned for this lane;
- command family supports extracting one dylib from a DSC (`ipsw dyld extract <DSC> <DYLIB>`), avoiding whole-cache extraction;
- release checksum manifest asset SHA256 `97be6afeac03aa4df0379b9224f9cbec750fb4ac56424daa7c1c66abb3d36334`.

Use only a pinned prebuilt binary downloaded transiently to `/private/tmp` and verified against the pinned release checksum manifest. Do not install it and do not compile locally.

Exact source DSC:
`/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h`.

Exact target image:
`/System/Library/Frameworks/Metal.framework/Versions/A/Metal`.

## D97BY prepared and pinned
Collector:
`OCLP7_D97BY_real_dsc_single_image_export.sh`
- bytes `21501`;
- SHA256 `ff41518400a85054cf7c7205ae9154efb5ec52ba7118fb538df5f63b94ea4968`.

Generator validation:
- zsh syntax PASS;
- checksum-parser Python heredoc compile PASS;
- main audit Python heredoc compile PASS.

D97BY behavior:
1. downloads only pinned `blacktop/ipsw` v3.1.713 release assets to `/private/tmp`;
2. first verifies exact checksum-manifest SHA above, then derives and verifies the exact macOS x86_64 (or manifest-backed universal fallback) tarball SHA;
3. performs no Homebrew/MacPorts/install and no local compilation;
4. exports only target Metal twice: normal and `--slide` variant;
5. audits standalone segment page geometry, install-name/dependencies, Metal4 counts, native `__text` byte identity, unsigned and ad-hoc-signed child `dlopen_preflight` and real child `dlopen`;
6. proceeds to D97BV only if an unmodified real export is actually child-dlopen-loadable;
7. before patching, re-audits exact 13-byte preimage, 208-byte cave, section/header separation and exact native `__text` identity;
8. proves bounded patch diff, tests unsigned and signed patched child dlopen;
9. deletes extractor, archives, all Apple binaries and all temp copies before ZIP creation;
10. packages TXT+JSON only.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.

Run only `OCLP7_D97BY_real_dsc_single_image_export.sh` and return its ZIP/console result.

No installation, no local compilation, no Root Patch and no accelerated reboot are authorized.

GitHub Actions compile/build/package remains suspended until explicit user confirmation that quota is unblocked.