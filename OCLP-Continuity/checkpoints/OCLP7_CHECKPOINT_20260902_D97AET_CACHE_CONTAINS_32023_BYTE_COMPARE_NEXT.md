# OCLP7 CHECKPOINT — 2026-09-02 — D97AET 32023 cache containment / byte-compare next

## Retained runtime facts
Selected accelerated boot remains `2026-09-02 00:10`; VESA recovery `00:12` excluded. D97AEQ remains authoritative for 28/28 normal `exit(1)`, zero signals/missing exits, and zero D97AD classifier exits 110–114. D97AES proved every one of the 33 simulator-diagnostic records across all 28 service PIDs has sender path `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler` and sender UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`; 3802 is NEGATIVE for this cohort.

## D97AET visible identity — PASS
D97AET reverified selector-only MTLCompilerService SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, visible root-patched MTLCompiler 32023 D97AD SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`, LC_UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`, and exact D97AD candidate `exit110` bytes `6a6e5fe9bb38f6ff90` at image offset `0x9D6BD`.

## Historical PC/backtrace result
For the 33 historical 32023 diagnostic records, sender/image offsets were only `0x9FFEE` (5) and `0xA5F81` (28), both outside `validSimulatorMetadata` (`0x9D132..0x9D830`). No archived frame directly proves control flow beyond the visible D97AD terminal.

Classification: historical validator control-flow is INCONCLUSIVE; traversal past `exit110` is NOT PROVEN by available backtrace offsets.

## dyld shared-cache containment — STATIC PROVEN
D97AET found the x86_64h Cryptex dyld cache through two filesystem aliases with the same size/mtime. The cache contains the exact 32023 MTLCompiler path and not the 3802 path. `dyld_shared_cache_util` is absent.

Classification:
- cache contains 32023 path = STATIC PROVEN;
- cache contains 3802 path = NEGATIVE;
- runtime executed from cache = UNKNOWN.

## Exact byte discriminator
At image offset `0x9D6BD`:
- P7/pre-D97AD bytes: `8b8d10feffff83f941`;
- D97AD bytes: `6a6e5fe9bb38f6ff90`.

The D97AD transition authority also supplies exact pre/post byte windows for all six classifier sites.

## D97AEU artifact — ready
Core artifact `OCLP7_D97AEU_READONLY_DYLD_CACHE_32023_BYTE_IDENTITY_MAP.command`:
- commit `411f8f46f0096d714fe065fa091c1890f7edcc98`;
- blob `a412a6115c429d90b34895571927e9b39783c11a`.

The core parses the Apple dyld-cache mapping and image-text tables read-only, locates cached MTLCompiler 32023 by exact path/UUID, translates image offsets to cache-file offsets, and compares all six D97AD sites, the shared exit stub, selected D34/AIR00/P6/P7 sites, and historical sender-PC windows against the visible filesystem image.

A pre-run review found one unnecessarily strict parser assertion requiring cached `__TEXT.fileoff == 0`. Since shared-cache Mach-O load-command file offsets may be cache-relative, this is a tooling assumption unrelated to VM/image-offset byte identity.

Safe wrapper `OCLP7_D97AEU_CACHE_MACHO_FILEOFF_SAFE_WRAPPER.command`:
- commit `41c38d56b772e849ecfdb7101613420d12abd9a9`;
- blob `860bedfe9b4151d475e4fad59f3e34f78d5defeb`.

The wrapper pins the core identity, changes exactly one line so only `__TEXT.vmaddr == cached image load address` is required, proves exactly one changed source line, retains all read-only/byte-discriminator anchors, parses zsh, then executes the fixed core. It does not alter any cache bytes, system files, source files, services, Root Patch state or boot state.

## CURRENT SINGLE NEXT ACTION
Run the pinned D97AEU safe wrapper only and return its complete report. The key discriminator is whether cached bytes at all six classifier sites match P7/pre-D97AD or D97AD postimages. Even if cache bytes are pre-D97AD, runtime cache execution must still be labeled separately and not inferred from containment alone.

No Root Patch or reboot. D82 remains reserve-only. Patch8 remains unauthorized.
