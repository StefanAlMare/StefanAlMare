# OCLP7 CHECKPOINT — 2026-09-02 — D97AET 32023 cache containment / byte-compare next

## Retained runtime facts
Selected accelerated boot remains `2026-09-02 00:10`; VESA recovery `00:12` excluded. D97AEQ remains authoritative for 28/28 normal `exit(1)`, zero signals/missing exits, and zero D97AD classifier exits 110–114. D97AES proved every one of the 33 simulator-diagnostic records across all 28 service PIDs has sender path `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler` and sender UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`; 3802 is NEGATIVE for this cohort.

## D97AET visible identity — PASS
D97AET reverified:
- selector-only MTLCompilerService SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- visible root-patched MTLCompiler 32023 D97AD SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`;
- visible 32023 LC_UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- visible D97AD candidate `exit110` postimage at image/file offset `0x9D6BD`: `6a6e5fe9bb38f6ff90`.

## Historical PC/backtrace result
For the 33 historical 32023 diagnostic records, unified-log JSON supplied only one same-image frame per record. Sender/image offsets were:
- `0x9FFEE`, count 5;
- `0xA5F81`, count 28.

Both are outside `validSimulatorMetadata` (`0x9D132..0x9D830`). No historical frame lies inside the validator and no frame directly proves control flow beyond the visible D97AD `exit110` site.

Classification:
- `D97AET_HISTORICAL_BACKTRACE_VALIDATOR_CONTROL_FLOW=INCONCLUSIVE`;
- `D97AET_RUNTIME_32023_CONTROL_FLOW_BEYOND_VISIBLE_EXIT110_SITE=NOT_PROVEN_BY_AVAILABLE_BACKTRACE_OFFSETS`.

This does not weaken D97AER's static result that the visible 32023 late simulator-limit message xrefs lie after REL+`0x58B`; it only means the archived backtrace channel reports the logging/formatter sender PC rather than the originating validator callsite.

## dyld shared-cache containment — STATIC PROVEN
D97AET found two filesystem aliases of the same x86_64h Cryptex cache (same size `888668160` and mtime `2026-08-06 22:12:43`):
- `/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h`;
- `/System/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h`.

Both contain the exact path string `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`; neither contains the 3802 path string. `dyld_shared_cache_util` is not installed.

Authoritative classification:
- `D97AET_DYLD_SHARED_CACHE_CONTAINS_32023_PATH=STATIC_PROVEN`;
- `D97AET_DYLD_SHARED_CACHE_CONTAINS_3802_PATH=NEGATIVE`;
- `D97AET_RUNTIME_EXECUTED_FROM_SHARED_CACHE=UNKNOWN`.

Presence in the cache alone is not proof that the observed MTLCompilerService processes executed cached text.

## Exact byte discriminator available
The D97AD transition authority supplies exact P7 preimages and D97AD postimages for all six classifier sites. Most decisive candidate site at image offset `0x9D6BD`:
- P7/pre-D97AD bytes: `8b8d10feffff83f941`;
- D97AD bytes: `6a6e5fe9bb38f6ff90`.

If the dyld shared-cache 32023 image is parsed and its bytes at the same image offset are read directly, this provides a byte-level discriminator between cached pre-D97AD text and the root-patched D97AD filesystem text. The same comparison should be performed for all six sites plus the shared stub and retained functional patch sites where practical.

## CURRENT SINGLE NEXT ACTION
Create/run D97AEU, a read-only dyld shared-cache byte mapper. It must:
1. reverify visible service and D97AD 32023 identities;
2. enumerate the x86_64h cache and any subcache siblings read-only;
3. parse the current Apple dyld-cache header/mappings and image-text table to locate the exact cached MTLCompiler 32023 image by path and UUID;
4. translate image-relative offsets to cache-file offsets;
5. read and compare cached bytes at all six D97AD classifier sites against exact P7 preimages and D97AD postimages, plus shared-stub and selected retained-patch sites;
6. report cache image UUID/load address/mapping/file provenance and refuse ambiguity;
7. make no claim that runtime executes the cache solely from cache byte identity.

No source/system/Golden mutation, service launch, runtime instrumentation, Root Patch or reboot. D82 remains reserve-only. Patch8 remains unauthorized.
