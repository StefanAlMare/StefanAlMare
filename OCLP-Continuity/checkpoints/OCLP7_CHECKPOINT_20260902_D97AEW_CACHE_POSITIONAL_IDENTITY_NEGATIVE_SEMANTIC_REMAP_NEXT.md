# OCLP7 CHECKPOINT — 2026-09-02 — D97AEW cache positional identity NEGATIVE / semantic remap next

## Returned evidence identity
The complete returned D97AEW terminal transcript contains `544` lines / `26237` bytes and has SHA256 `95b6eed0db54da14206f0957b57e6ce01c9030dc9c0a04970780095bbe69435d`.

Outer D97AEW identity passed exactly:
- Git blob `45876fa66e9018053882be7b01eeccabcfe8046b`;
- SHA256 `cdd976be2ee2981aec2d35055e96fc0559f2f3277a9e38d62f2476817ef74394`;
- `D97AEW_WRAPPER_IDENTITY=PASS`;
- live mode `VALIDATE_ONLY=0`.

## Wrapper chain — PASS
D97AEW pinned D97AEV base blob `1060f611b3fec7fc66f80d7674d2fb06a2cdfe6d` and passed:
- one scanner transform;
- post-transform old/new scanner counts `0/1`;
- reversible scanner-only delta;
- `Preboot` safe hits `[]` and real-reboot misses `[]`;
- retained-anchor missing list `[]`;
- fixed-wrapper write, zsh parse and one embedded-Python compile.

D97AEV pinned D97AEU base blob `a412a6115c429d90b34895571927e9b39783c11a` and passed:
- FILEOFF / LOGICAL_HITS / CACHE_UUID transform counts `1/1/1`;
- required-anchor missing list `[]`;
- exact-three-transform proof and fixed zsh parse.

The read-only core completed. `D97AEV_INNER_RC=0` and `D97AEW_INNER_RC=0`. Classification: `D97AEW_RESULT=PASS`.

## Visible filesystem identities — PASS
Target remained Tahoe `26.6.2 / 25G82`.

- visible selector-only MTLCompilerService SHA: `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- visible root-patched MTLCompiler 32023 SHA: `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`;
- visible filesystem LC_UUID: `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- `VISIBLE_IDENTITIES=PASS`.

## Cached 32023 logical identity — STATIC PROVEN
The mapper found the main x86_64h cache plus subcaches `.01`–`.06`; `.atlas` and `.map` were correctly skipped as non-cache metadata.

All seven parseable `imagesText` tables contain one replicated logical 32023 identity:
- raw hits `7`;
- logical identities `1`;
- table and cached-Mach-O LC_UUID `D2265480-60EB-3526-BAF7-2D6596149186`;
- load address `0x7FFD03141000`;
- text size `0xCE239`;
- executable bytes map into subcache `.05`;
- cached Mach-O UUID equals table UUID `YES`;
- cached Mach-O/table UUID equals visible filesystem UUID `NO`.

The seven table records are replicas, not seven distinct images. `CACHED_IMAGE_LOGICAL_DEDUP=PASS`.

## Exact positional byte result — NEGATIVE
The byte reads themselves completed: `CACHE_BYTE_IDENTITY_READ=PASS`.

At the six visible-filesystem D97AD image offsets, the visible file is D97AD `POST` at all six sites, while the cache is neither recorded P7/pre-D97AD nor D97AD postimage:

| Site | Image offset | Cache bytes | Filesystem D97AD bytes | Cache state |
|---|---:|---|---|---|
| CANDIDATE_110 | `0x9D6BD` | `85c07807f3480f2ac0` | `6a6e5fe9bb38f6ff90` | OTHER |
| BUFFER_111 | `0x9D3CC` | `0801752b488b07488b184885` | `6a6f5fe9ac3bf6ff90909090` | OTHER |
| SAMPLER_112 | `0x9D40B` | `55415453504889fb4c8b` | `6a705fe96d3bf6ff9090` | OTHER |
| NESTED_113 | `0x9D514` | `57c0f3480f2ac0f30f` | `6a715fe9643af6ff90` | OTHER |
| EARLY_RETURN_114 | `0x9D1EB` | `dfe899fbffff488b4330` | `6a725fe98d3df6ff9090` | OTHER |
| UNWIND_114 | `0x9D7FE` | `74124889df4883c4085b415e` | `6a725fe97a37f6ff90909090` | OTHER |

Summary: `PRE=0|POST=0|OTHER=6`. The shared exit stub is also OTHER in cache (`4889c65de9035a0b00`) while the visible file contains the D97AD stub (`b8010000020f050f0b`).

All 16 retained functional postimage windows are exact in the visible filesystem file and absent at the same cache image offsets:
- filesystem postimage matches `16/16`;
- cache postimage matches `0/16`.

The historical sender-PC windows at filesystem image offsets `0x9FFEE` and `0xA5F81` also differ cache-versus-filesystem. Candidate cache bytes do not equal candidate filesystem bytes.

Authoritative classification:
- `CACHE_AT_VISIBLE_FS_D97AD_OFFSETS=PRE_0__POST_0__OTHER_6`;
- `CACHE_RETAINED_POSTIMAGES_AT_VISIBLE_FS_OFFSETS=0_OF_16`;
- `CACHE_VISIBLE_FILESYSTEM_POSITIONAL_BYTE_IDENTITY=NEGATIVE`;
- direct fixed-offset cache classification as P7/pre-D97AD or D97AD is invalidated;
- cached semantic location/equivalence of the validator, classifier sites, shared stub and retained functional modules remains `UNKNOWN`.

The result proves that the separately identified cached image cannot be interpreted by blindly transplanting visible-filesystem offsets. It does not prove that the relevant semantics are absent everywhere in the cached image.

## Runtime boundary remains unresolved
The mapper explicitly emitted `RUNTIME_CACHE_EXECUTION_CLAIM=NOT_MADE_BY_THIS_STATIC_MAPPER`.

Therefore it remains UNKNOWN whether the selected accelerated cohort executed:
- cached image UUID `D2265480-60EB-3526-BAF7-2D6596149186`;
- visible filesystem image UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- or another mapped/stale representation.

The historical JSON sender UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B` remains runtime provenance for the diagnostic sender, but must not be silently equated with a proven VM text backing source without a direct mapping proof.

No intervention in the dyld cache is authorized. Cache presence, byte difference and runtime execution remain separate evidence classes.

## Safety result
No OCLP source, system, Golden, root volume, baseline, service or boot state changed. Only reports, pinned downloads and temporary transformed wrappers were written.

- `SOURCE_MUTATION=NO`;
- `SYSTEM_MUTATION=NO`;
- `GOLDEN_MUTATION=NO`;
- `SERVICE_LAUNCH=AUTO-NO`;
- `RUNTIME_INSTRUMENTATION=NO`;
- `ROOT_PATCH=AUTO-NO`;
- `REBOOT=AUTO-NO`;
- `D82_EXECUTION=NO`;
- `PATCH8_AUTO_INTEGRATION=NO`.

Baseline remains exactly P1+P2b+P3+AIR00+D34. Golden remains immutable/read-only. D50/D68/D82 remain reserve-only; D84 retired; Patch8 unauthorized.

## CURRENT SINGLE NEXT ACTION — assistant/GitHub lane
The assistant must design, validate and publish a new identity-pinned read-only semantic cache mapper before asking the user to run anything else.

The mapper must not assume visible-filesystem fixed offsets. It must first compare cached and filesystem Mach-O `__TEXT` section topology, then locate the validator/module boundaries and six classifiers through semantic/unique-anchor evidence, search pre/post patterns across the bounded cached text, and report enough bounded neighborhoods for independent audit. It must keep cache semantic mapping separate from runtime text-backing provenance.

No user action, Root Patch, reboot or runtime mutation is authorized at this checkpoint.
