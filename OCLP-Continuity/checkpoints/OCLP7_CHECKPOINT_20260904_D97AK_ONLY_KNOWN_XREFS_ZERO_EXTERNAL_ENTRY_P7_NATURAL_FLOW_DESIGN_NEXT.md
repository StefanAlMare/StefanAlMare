# OCLP7 CHECKPOINT — D97AK only known xrefs / zero external entry; P7 natural-flow design next

Date: 2026-09-04 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260904_D97AJ_INTERPRETATION_CORRECTED_D97AK_THEN_P7_NATURAL_FLOW.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 are retained but runtime sufficiency is NEGATIVE. Golden Sequoia remains immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine/small work remains ASUS2-local; GitHub only for major compile/build/package. Root Patch/reboot remain manual-only and separately authorized.

Current D97AH application remains live. Current root-patched MTLCompiler 32023 remains exact D97AF/A4F instrumented postimage: `1636896` bytes / SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e` / LC_UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`.

D97AH accelerated boot remains `NEGATIVE_NO_USABLE_GUI`. D97AF runtime diagnostic provenance remains PROVEN 28/28 for the A4F/32023 sender cohort.

## D97AK exact full-image audit — PASS
Wrapper identity and parse passed. Current VESA boot identity remained `kern.boottime sec=1788466673`. Exact A4F file SHA/UUID passed again.

D97AK disassembled the full A4F executable (`197824` instructions) and audited the entire image for diagnostic-string origin and alternative entry paths.

### Exact five diagnostic literals
Each of the five simulator-limit strings occurs exactly once in the A4F executable:
- buffers literal file offset `0xC3949`;
- samplers literal file offset `0xC3989`;
- textures literal file offset `0xC39CA`;
- constant-buffer literal file offset `0xC3A0B`;
- interpolated-input literal file offset `0xC3A5C`.

`EXACT_FIVE_LITERAL_UNIQUENESS=PASS`.

### Exhaustive code xrefs
Each literal has exactly one direct code xref, all owned by `MTLSimCompiler::validSimulatorMetadata(llvm::Module*)`:
- buffers -> image offset `0x9D6C8`;
- samplers -> `0x9D6EE`;
- textures -> `0x9D712`;
- constant buffers -> `0x9D73A`;
- interpolated inputs -> `0x9D75D`.

Aggregate:

```text
ADDITIONAL_DIRECT_STRING_XREF_COUNT=0
TOTAL_INDIRECT_STRING_POINTER_XREF_COUNT=0
```

There are no alternate code origins for these five exact diagnostics anywhere else in A4F.

### External-entry/address-taken audit
D97AK found:

```text
EXTERNAL_DIRECT_INTERIOR_ENTRY_COUNT=0
EXTERNAL_DIRECT_LATE_REGION_ENTRY_COUNT=0
EXTERNAL_RIP_VALIDATOR_REFERENCE_COUNT=0
EXTERNAL_RIP_LATE_REGION_REFERENCE_COUNT=0
RAW_ABSOLUTE_LATE_POINTER_TOTAL=0
```

Therefore there is no statically recoverable external direct branch/call, RIP-relative address-taken reference, or raw absolute pointer into the late region `0x9D6C5..0x9D77F`.

Authoritative classification:

`D97AK_DIAGNOSTIC_ORIGIN=ONLY_KNOWN_UNREACHABLE_DIRECT_XREFS_ZERO_STATIC_EXTERNAL_LATE_ENTRY`

`D97AK_A4F_FULL_IMAGE_DIAGNOSTIC_ORIGIN_AND_EXTERNAL_ENTRY_AUDIT=PASS`

No source/app/system/Golden/snapshot mutation occurred; no service launch, Root Patch or reboot occurred.

## Combined D97AJ + D97AK consequence
The A4F-instrumented image is now statically exhausted for the relevant contradiction:
1. D97AJ resolved the full reachable CFG from normal `validSimulatorMetadata` entry and found zero bypass around the artificial D97AD exit110 terminal;
2. D97AK found no alternative xref for the exact diagnostics and no external/static late-region entry.

Do not infer that natural donor/P7 flow is impossible. D97AD `110..114` are terminal project diagnostics that deliberately replace normal donor code. The instrumented A4F image is therefore no longer the right substrate for observing natural donor continuation.

## Natural-flow decision — authoritative
The next experiment is P7 natural-flow, not “remove only 110”.

Required state:
- remove the ENTIRE D97AD whole-stage classifier from the active patch flow;
- restore all six D97AD terminal windows to their exact P7 preimages;
- restore/clear the shared D97AD exit-stub cave to its exact P7 preimage;
- prove exact P7 MTLCompiler SHA256 `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda` before provenance stamping;
- keep P1/P2b/P3/AIR00/D34/P6/P7 otherwise unchanged for this first natural-flow experiment so D97AD removal is the only functional-variable change;
- never reuse A4F.

New frozen provenance UUID for the future P7 natural-flow image:

`0FC4C627-2A5D-491B-8101-00CAAA7116B7`

This UUID is reserved exclusively for the future exact P7-natural-flow postimage and must not label any D97AD-instrumented image.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
Do not mutate source yet. First run one bounded read-only ASUS2 source/design audit (`D97AL`) against the canonical local source branch/HEAD. It must:
1. verify exact branch/HEAD and relevant source-file identities;
2. identify the active D97AD helper definition/call and D97AF LC_UUID stamp helper/call cardinality/order;
3. prove the exact source transformation needed to remove D97AD from the active patch flow without altering P1/P2b/P3/AIR00/D34/P6/P7;
4. verify D97AF transaction logic can be retargeted from D97AD preimage SHA to exact P7 SHA and from A4F to the new frozen UUID;
5. reconstruct an offline synthetic P7 natural-flow binary and prove the exact P7 SHA before stamp, then compute the deterministic new-UUID postimage SHA;
6. make no source/system/app/Golden mutation and STOP.

Only after D97AL is audited may a small local source edit be authorized. Any subsequent major compilation/build/package remains GitHub-only. Root Patch and reboot remain unauthorized.