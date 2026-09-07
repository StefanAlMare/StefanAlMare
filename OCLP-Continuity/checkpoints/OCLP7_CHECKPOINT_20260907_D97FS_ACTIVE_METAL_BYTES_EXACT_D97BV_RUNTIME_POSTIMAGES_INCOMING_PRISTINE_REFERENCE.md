# OCLP7 CHECKPOINT — D97FS active Metal bytes are exact D97BV runtime postimages; Incoming is pristine extraction reference

Date: 2026-09-07 EEST

## Entering authority
- ASUS2: Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.
- D97FJ remains the strongest accelerated fatal frontier: `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState -> native Metal validateWithDevice`.
- Current machine remains in VESA recovery; no reboot, Root Patch, EFI, NVRAM or framebuffer change is authorized.
- D97FR proved the active Cryptex main x86_64h cache has an invalid embedded code signature while the same-sized `Cryptexes/Incoming/OS` cache is signature-valid.
- D97DZ had previously proved that immediately after D97DX Root Patch, the D97BV SITE and CAVE bytes in the active shared cache were still pristine.
- D97DT had previously proved runtime delivery of the exact D97BV SITE/CAVE postimages by OCLPMetalCompat.

## Returned D97FS artifact
Archive:
`OCLP7_D97FS_CACHE_MAP_20260907_195458.zip`

Direct independent audit:
- bytes `1525842`;
- SHA256 `f694969d4c9c4cb33ee8e1b0b1b28c4af0b01283da029fb3a4a9ce43a2f5aa52`;
- ZIP CRC PASS.

The archive contains active/incoming 64 KiB headers, active/incoming dyld `.map` and `.atlas`, and 8-page windows around both known differing regions.

Relevant identity observations from the returned package:
- Tahoe build `25G82`, x86_64;
- D97FS active full-cache SHA256 at collection time: `1202b89e51dc4ac5c741715f4c522241c04e24604f57ec2eaa3e19b84955d0bc`;
- Incoming full-cache SHA256: `d89b4880cea9c52e0deb397be7cf584691a186f86996be5c73e3e50f6dcec094`;
- active and Incoming first-64-KiB cache headers are identical;
- active and Incoming `.map` are byte-identical;
- active and Incoming `.atlas` are byte-identical.

The active full-cache SHA is not treated as a permanent static identity because D97BV page mutation is lazy/runtime-bound and D97DT already proved SITE can be pending before its mapped validation event. Exact site/cave postimages are the authoritative discriminator.

## Exact dyld mapping
The main cache mapping containing these offsets begins at:
- file offset `0`;
- VM `0x7FF800000000`.

The cache map identifies native Tahoe:
`/System/Library/Frameworks/Metal.framework/Versions/A/Metal`
with `__TEXT` beginning at VM `0x7FF80F47D000`.

Therefore the observed active-vs-Incoming differences map as follows:
- CAVE region file offset `0xF47E560` -> VM `0x7FF80F47E560` -> native `Metal.__TEXT +0x1560`;
- SITE region file offset `0xF5E1719` -> VM `0x7FF80F5E1719` -> native `Metal.__TEXT +0x164719`.

Thus the modified bytes are in native Tahoe Metal `__TEXT`, not CoreDisplay.

## Exact byte identity against D97BV design
D97BV previously specified:
- SITE replacement `3dda0e00007406e93bcee9ff90`;
- SITE SHA256 `1123dd318a28e66be825763ccb9715b4ef2906fd9cdb6335ed2f53fada489a43`;
- CAVE replacement `3d187d0000b9177d00000f4cc1e9b4311600`;
- CAVE SHA256 `a1b8d3b2988e622a4ea8e9545816a44abdb5c84e70b4126a3bad15c9f7539045`.

D97FS direct byte extraction proves ACTIVE contains exactly those same replacements:
- ACTIVE CAVE 18 bytes = `3d187d0000b9177d00000f4cc1e9b4311600`, exact D97BV CAVE SHA PASS;
- INCOMING CAVE 18 bytes = all zero, exact pristine preimage;
- ACTIVE SITE 13 bytes = `3dda0e00007406e93bcee9ff90`, exact D97BV SITE SHA PASS;
- INCOMING SITE 13 bytes = `3d187d0000b9177d00000f4cc1`, exact Tahoe original preimage.

## Structural semantics
Constants:
- `0xEDA = 3802`;
- `0x7D17 = 32023`;
- `0x7D18 = 32024`.

Pristine Tahoe SITE performs the original `cmp 32024 / mov 32023 / cmovl` floor.

Active D97BV SITE:
- compares EAX to exact `3802`;
- exact `3802` branches to the original continuation and preserves EAX=3802;
- every non-3802 value jumps to the CAVE;
- CAVE executes the exact original Tahoe floor semantics and rejoins original continuation.

Therefore the active cache modification is exactly the bounded selective-3802 preservation adapter previously accepted under D97BV, with no non-3802 semantic drift in the proven scope.

## Provenance closure
D97DZ proved SITE/CAVE remained pristine after D97DX Root Patch.
D97DT proved OCLPMetalCompat runtime mutation to the exact D97BV SITE/CAVE postimages.
D97FS now finds those exact postimages in the active cache while Incoming retains the pristine originals.

Classifications:
- `D97FS_MODIFIED_IMAGE=NATIVE_TAHOE_METAL` = STATIC-MAPPED/PROVEN;
- `D97FS_ACTIVE_SITE_EQUALS_D97BV_POSTIMAGE` = STRUCTURAL PROVEN;
- `D97FS_ACTIVE_CAVE_EQUALS_D97BV_POSTIMAGE` = STRUCTURAL PROVEN;
- `D97FS_INCOMING_SITE_EQUALS_TAHOE_PREIMAGE` = STRUCTURAL PROVEN;
- `D97FS_INCOMING_CAVE_EQUALS_ZERO_PREIMAGE` = STRUCTURAL PROVEN;
- `D97FS_ROOT_PATCH_AS_WRITER` = NEGATIVE for these bytes, by D97DZ post-Root-Patch pristine proof;
- `D97FS_D97BV_RUNTIME_ADAPTER_PROVENANCE` = STRUCTURAL-RUNTIME PROVEN by exact D97DT writer/postimage lineage plus D97FS byte identity;
- `D97FS_ACTIVE_CODESIGN_FAILURE_EXPLAINED_BY_INTENTIONAL_D97BV_RUNTIME_TEXT_MUTATION` = PROVEN for the first rejected page / exact cave mutation;
- `D97FS_CACHE_CORRUPTION_HYPOTHESIS` = REJECTED for these mapped differences.

This does not prove that D97BV causes the current CoreDisplay pipeline failure. D97BV remains CLOSED PASS for selective 3802 delivery. The accelerated fatal frontier remains D97FJ.

## Next action
Use the signature-valid `Cryptexes/Incoming/OS/.../dyld_shared_cache_x86_64h` as the pristine exact-25G82 extraction source with the already audited D97FN extractor.

Extract exact CoreDisplay and Metal from Incoming into temporary user-space storage, verify UUIDs against the D97FJ IPS identities, and statically map:
- `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState +599`;
- `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState +1720`;
- `F_NymriCY` and adjacent render-pipeline descriptor/device calls.

Do not repeat an accelerated boot until the descriptor/device validation boundary is statically resolved enough to justify a bounded observer/adapter design.