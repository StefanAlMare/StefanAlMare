# OCLP7 CHECKPOINT — 2026-09-02 — D97AEU replicated image-table tooling failure / D97AEV ready

## Retained facts
Selected accelerated boot remains 2026-09-02 00:10; VESA 00:12 excluded. D97AEQ remains authoritative for 28/28 normal exit(1), zero signals/missing exits and zero classifier exits 110–114. D97AES proved all runtime simulator diagnostics came from MTLCompiler 32023 path/UUID; 3802 is NEGATIVE. D97AET proved the x86_64h Cryptex dyld shared cache contains the 32023 path and not the 3802 path; cache execution remains UNKNOWN.

## D97AEU run audit
The pinned D97AEU wrapper/core identities passed and visible filesystem identities remained exact:
- selector-only MTLCompilerService SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- filesystem D97AD MTLCompiler 32023 SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`;
- filesystem LC_UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.

Cache discovery found main x86_64h cache plus `.01` through `.06` subcaches. Each parseable cache header exposes the same replicated `imagesText` table (`IMAGES_TEXT_COUNT=3626`). The target path `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler` appeared seven times with exactly the same logical image identity:
- table image UUID `D2265480-60EB-3526-BAF7-2D6596149186`;
- load address `0x7FFD03141000`;
- text size `0xCE239`;
- same target path.

The target load address lies in the `.05` executable mapping (`0x7FFD00000000..0x7FFD201C0000`).

D97AEU stopped at `CACHED_IMAGE_HIT_CARDINALITY_FAIL:7` before reading any discriminator bytes. Therefore:
- `D97AEU_BYTE_COMPARISON_RESULT=NOT_REACHED`;
- no cache-vs-filesystem byte conclusion is permitted;
- no Root Patch/reboot/system/source mutation occurred.

## Tooling classification
The seven hits are replicated table records of one logical cached image, not seven distinct cached MTLCompiler images. The parser's raw-hit cardinality requirement is therefore a tooling false failure.

Also, the shared-cache image-table UUID is not assumed to equal the filesystem LC_UUID. A cache-built/optimized image identity must be recorded separately. This distinction is tooling/provenance hygiene, not evidence that runtime executes cached text.

## D97AEV replacement wrapper
Artifact: `OCLP7_D97AEV_LOGICAL_CACHE_IMAGE_DEDUP_UUID_SAFE_WRAPPER.command`
- commit `b8350946e307ec2df253ffb795b31c2104034372`;
- blob `1060f611b3fec7fc66f80d7674d2fb06a2cdfe6d`.

D97AEV pins the original D97AEU core and applies exactly three parser-only transforms:
1. retain the previous safe relaxation of cached `__TEXT.fileoff == 0` while preserving `__TEXT.vmaddr == image_load`;
2. deduplicate raw `imagesText` hits by logical `(cache UUID, load address, text size, path)` and require exactly one logical identity;
3. record cache image UUID / cached Mach-O LC_UUID / filesystem LC_UUID separately instead of requiring cache UUID == filesystem UUID.

All six D97AD pre/post byte discriminator windows, shared stub, D34/AIR00/P6/P7 retained windows and all read-only safety anchors are unchanged.

## CURRENT SINGLE NEXT ACTION
Run D97AEV only and return the complete report. The decisive result remains the cached bytes at all six D97AD classifier sites versus exact P7 preimages and D97AD postimages. Cache containment or cache byte identity alone must not be promoted to runtime-cache execution without separate runtime provenance.

No Root Patch or reboot. D82 remains reserve-only. Patch8 remains unauthorized.
