# OCLP7 CHECKPOINT — D97FR ACTIVE DYLD CACHE LOCALLY MODIFIED / INCOMING VALID REFERENCE

Date: 2026-09-07 EEST
Machine: ASUS2
System: macOS Tahoe 26.6.2 / 25G82 x86_64
Mode: VESA recovery; read-only investigation

## Context
D97FQ attempted to extract the active Cryptex OS x86_64h dyld shared cache using the audited Apple `dsc_extractor.bundle` wrapper. The Apple extractor rejected the active cache with:

`Error: dyld shared cache code signature for page 62590 is incorrect.`

`Error: shared cache failed validity check for file at .../Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h`

This checkpoint records the subsequent direct comparison between the active cache and the `Cryptexes/Incoming/OS` copy.

## Exact paths
Active:
`/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h`

Incoming reference:
`/System/Volumes/Preboot/Cryptexes/Incoming/OS/System/Library/dyld/dyld_shared_cache_x86_64h`

## Size identity
Both files are exactly:
`888668160` bytes.

## Signature state
Active cache:
- `codesign --verify --verbose=4` -> `invalid signature (code or signature have been modified)`.

Incoming cache:
- `valid on disk`;
- `satisfies its Designated Requirement`.

Therefore the Apple extractor's rejection of the active cache is not a wrapper artifact; the active cache fails its embedded CodeDirectory validation while the Incoming counterpart validates.

## Whole-file SHA256
Active:
`fad818e7cf66504dc304edcfd3d8fcfd4c9f11b99544fcebd226053a6e322f5e`

Incoming:
`d89b4880cea9c52e0deb397be7cf584691a186f86996be5c73e3e50f6dcec094`

## First measured byte differences
`cmp -l` shows the first modified bytes beginning at decimal file offset `256370017`.

First differences include:
- 256370017 active octal 75 vs incoming 0
- 256370018 active octal 30 vs incoming 0
- 256370019 active octal 175 vs incoming 0
- additional differences through the same region
- a later difference sequence begins near 257824539

## Page 62590 direct proof
Page size: `4096` bytes.
Page index: `62590`.
Page base offset: `256368640` decimal (`0x0f47e000`).

SHA256 of page 62590:
- Active: `aa0100e1a73637835627eabaa5698c5b03af35a33357b3cd9879cf5c0ba572e0`
- Incoming: `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140`

The first measured byte difference at offset 256370017 lies inside page 62590, exactly the page reported by Apple's extractor validator.

## Classification
- Active main x86_64h dyld cache signature failure: SEMANTIC PROVEN.
- Active and Incoming main cache differ byte-for-byte: SEMANTIC PROVEN.
- Page 62590 differs between Active and Incoming: SEMANTIC PROVEN.
- Apple's D97FQ extractor rejection is correctly explained by active-cache mutation, not wrapper malfunction: STRUCTURAL-SEMANTIC PROVEN for the observed validation path.
- Incoming cache is a valid signed reference copy: SEMANTIC PROVEN.
- Exact agent/process that modified the active cache: UNKNOWN.
- Whether the modified offsets belong to CoreDisplay, Metal, another image, metadata, or signature-adjacent content: UNKNOWN pending offset-to-image mapping.
- Whether the active cache mutation is intentionally caused by D97DX/root patching: UNPROVEN at this checkpoint.

## Implication for the current CoreDisplay frontier
Do not use the pristine Incoming CoreDisplay as a semantic substitute for the active runtime until we map the modified active-cache offsets to image ownership.

The immediate next task is static/read-only:
1. map active file offsets `256370017` and `257824539` to the owning image/segment using the exact 25G82 cache metadata/map;
2. if CoreDisplay/Metal are not affected, extract from the valid Incoming cache and use that image for static mapping;
3. if CoreDisplay/Metal are affected, obtain the active patched image bytes with a validator-bypassing read-only extraction/carving method and compare against Incoming.

No reboot, no Root Patch change, no EFI/NVRAM/framebuffer/bootarg change, no cache repair or replacement is authorized.
