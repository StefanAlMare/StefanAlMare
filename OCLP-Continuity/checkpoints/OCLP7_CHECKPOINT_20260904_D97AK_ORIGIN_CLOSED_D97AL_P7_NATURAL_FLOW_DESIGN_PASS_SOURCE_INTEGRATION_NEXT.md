# OCLP7 CHECKPOINT — 2026-09-04 — D97AK origin closed; D97AL P7 natural-flow design PASS; source integration next

## Authority and carry-forward
Target remains ASUS2 Tahoe `26.6.2 / 25G82`, Intel Haswell, SMBIOS `MacBookAir6,2`. Permanent execution contract remains unchanged: routine/small work on ASUS2, GitHub only for major compile/build/package, Golden immutable/read-only, Root Patch and reboot manual-only and separately authorized. Accepted functional baseline remains exactly P1+P2b+P3+AIR00+D34; P6/P7 remain retained with runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

D97AH application/root-patch state remains unchanged. Current root-patched MTLCompiler 32023 remains exact A4F postimage `1636896` bytes / SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e` / LC_UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`. Current VESA boot identity remains `kern.boottime sec=1788466673` / 2026-09-03 23:17:53 EEST.

## D97AK full-image diagnostic-origin audit — PASS
D97AK was strict read-only and reverified exact A4F SHA/UUID and current VESA boot identity. It disassembled 197824 full-image instructions and located each of the five simulator-limit literals exactly once.

Exact literal/xref result:
- buffers: one literal, one direct xref at image `0x9D6C8`;
- samplers: one literal, one direct xref at `0x9D6EE`;
- textures: one literal, one direct xref at `0x9D712`;
- constant-buffer bindings: one literal, one direct xref at `0x9D73A`;
- interpolated inputs: one literal, one direct xref at `0x9D75D`.

Every xref owner is the same function: `MTLSimCompiler::validSimulatorMetadata(llvm::Module*)` at `0x7FFB162C7132`. No additional origin was found:

```text
ADDITIONAL_DIRECT_STRING_XREF_COUNT=0
TOTAL_INDIRECT_STRING_POINTER_XREF_COUNT=0
EXTERNAL_DIRECT_INTERIOR_ENTRY_COUNT=0
EXTERNAL_DIRECT_LATE_REGION_ENTRY_COUNT=0
EXTERNAL_RIP_VALIDATOR_REFERENCE_COUNT=0
EXTERNAL_RIP_LATE_REGION_REFERENCE_COUNT=0
RAW_ABSOLUTE_LATE_POINTER_TOTAL=0
D97AK_DIAGNOSTIC_ORIGIN=ONLY_KNOWN_UNREACHABLE_DIRECT_XREFS_ZERO_STATIC_EXTERNAL_LATE_ENTRY
D97AK_A4F_FULL_IMAGE_DIAGNOSTIC_ORIGIN_AND_EXTERNAL_ENTRY_AUDIT=PASS
```

Classification: the static alternative-origin/external-entry hypothesis is NEGATIVE for exact A4F. Combined with D97AJ, there is no statically resolved internal bypass, alternate message xref, direct outside entry, RIP-relative outside entry or raw absolute pointer path explaining the A4F diagnostic after the artificial D97AD terminal.

## D97AL P7 natural-flow source + synthetic design audit — FULL PASS
D97AL was strict read-only. It verified exact local source identity:

```text
BRANCH=alex-tahoe-25G82-custom
HEAD=4143b7077a9a4e5aa41ec7a06c0888597eda9b06
HELPERS_SHA256=6c4c396975c646c60895b0beb4780cb7fb3f88bc7be05016218df9b000f09d8c
SYSPATCH_SHA256=93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69
METAL_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
```

Current active patch order is exactly:
`selector -> control -> P6 -> P7 -> D97AD -> D97AF`.

Current exact helper segment identities include:
- D97AD segment SHA `bb66b1d5d883251431d5a7fa7bc42c0cc9bcb15ec77c74506bb2eae5bf987a12`;
- D97AF/D97AH segment SHA `fea34f69735ac244a064b55b58e4b95a6972e270f282d6d4f4d1fbecefd0503a`.

D97AL then performed only synthetic/in-memory reversal:
1. A4F UUID -> D5CE reconstructs exact D97AD SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`;
2. all six exact D97AD terminal postimages were reversed to their P7 preimages;
3. shared exit stub `0xF80..` was reversed to exact zero P7 preimage;
4. resulting SHA is exact historical P7:
   `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`.

Exact six restored P7 windows are:
- candidate `0x9D6BD`: `8b8d10feffff83f941`;
- buffer-index `0x9D3CC`: `488d3599640200b91e000000`;
- sampler-index `0x9D40B`: `488d359764020083fa10`;
- nested-argument-buffer `0x9D514`: `488d35cc63020031c0`;
- early return `0x9D1EB`: `4489f04881c488030000`;
- early unwind `0x9D7FE`: `488dbd20feffffe8c45c0100`.

## Frozen P7 natural-flow provenance identity
New UUID is frozen for the natural-flow experiment:

`0FC4C627-2A5D-491B-8101-00CAAA7116B7`

A4F remains permanently bound to the D97AD-instrumented 28/28 cohort and must never be reused.

Applying only the new LC_UUID to exact P7 changes exactly 16 bytes at `0xAB0..0xABF` and produces deterministic final identity:

```text
P7_NATURAL_FLOW_PRE_SHA256=6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda
P7_NATURAL_FLOW_UUID=0FC4C627-2A5D-491B-8101-00CAAA7116B7
P7_NATURAL_FLOW_EXPECTED_POST_SHA256=e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9
P7_TO_NEW_UUID_DIFFERING_BYTE_COUNT=16
P7_TO_NEW_UUID_DIFF_MIN=0xAB0
P7_TO_NEW_UUID_DIFF_MAX=0xABF
P7_TO_NEW_UUID_UUID_ONLY_DIFF=PASS
```

Classification: `D97AL_P7_NATURAL_FLOW_SYNTHETIC_DESIGN=STATIC_PROVEN`.

## Source transition authorized for local integration only
The next source transition must change one experimental variable: remove D97AD terminal instrumentation while retaining selector/control/P6/P7.

Required transition:
1. remove exactly one active call to `patch_mtl_compiler_tahoe_d97ad_pre_d97_validator_whole_stage_exit_classifier` from `sys_patch.py`;
2. keep the D97AD helper definition dormant for rollback/history;
3. retarget the existing privileged UUID-stamp transaction preimage from exact D97AD SHA to exact P7 SHA;
4. retarget A4F to frozen P7-natural-flow UUID `0FC4C627-2A5D-491B-8101-00CAAA7116B7`;
5. retarget expected post-SHA to `e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9`;
6. preserve D97AG xattr backend, fatal boundary and D97AH `/usr/bin/chflags` correction unchanged;
7. preserve selector/control/P6/P7 and `metal_3802.py` byte-identical.

A method/call phase rename to D97AM is allowed only if mechanically exact and audited; it must not change transaction semantics.

## CURRENT SINGLE NEXT ACTION
Run one identity-pinned, fail-closed local ASUS2 source integrator implementing only the transition above. It must verify exact preimage file hashes/branch/HEAD/git status, build and AST/compile-audit both candidate source files before mutation, create recoverable backups, use compare-and-swap/atomic replacement with rollback, then prove exact active order `selector -> control -> P6 -> P7 -> natural-flow UUID stamp`, D97AD call count zero, D97AD helper definition retained dormant, and metal unchanged.

STOP after source integration. No local major build. No installed-app/system-target/Golden mutation. No Root Patch. No reboot. After assistant audit of the local source result, sync exact source for a GitHub-only major build/package.
