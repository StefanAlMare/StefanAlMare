# OCLP7 CHECKPOINT — 2026-09-06 — D97BW tooling guard; sparse-mirror v2 ready

## Entering state
- Target remains Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current machine state remains unpatched Tahoe VESA with `-igfxvesa`; no active Root Patch.
- Native Tahoe Metal remains cache-resident/authoritative; legacy `13.2.1-24/Versions/A/Metal` remains forbidden.
- No Root Patch or accelerated reboot is authorized.

## Retained producer/adapter closure
- Shared generation accessor: `0x7FF80F5E16C3..0x7FF80F5E1778`.
- Default-environment accessor-wide suppression of legacy 3802 is SEMANTIC PROVEN; explicit bypass is `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`.
- Exact selective adapter semantics remain: preserve only exact 3802; every other input executes Tahoe's original floor unchanged.
- Exact patch window: `0x7FF80F5E1719..0x7FF80F5E1726`, 13-byte preimage `3d187d0000b9177d00000f4cc1`, no incoming branch into the window.
- D97BV safe cave: executable `__TEXT` inter-section zero padding `0x7FF80F47E560..0x7FF80F47E630`, length 208, outside all Mach-O sections, with zero function-start/branch-target/RIP-target hits.
- D97BV site bytes: `3dda0e00007406e93bcee9ff90`.
- D97BV cave bytes: `3d187d0000b9177d00000f4cc1e9b4311600`.

## D97BW returned terminal output
D97BW read-only identity gates passed:
- OS `26.6.2 / 25G82`;
- native service SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- native cached Metal `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

Exact segment inventory was recovered:
- `__TEXT`: VM `0x7FF80F47D000`, fileoff `0xF47D000`, filesize `0x2EB15A`;
- `__DATA_CONST`: VM `0x7FF84119DCD0`, fileoff `0x27D91CD0`, filesize `0x6F820`;
- `__DATA`: VM `0x7FF843D590C0`, fileoff `0x2A94D0C0`, filesize `0xCD00`;
- `__DATA_DIRTY`: VM `0x7FF84384F510`, fileoff `0x2A443510`, filesize `0x4938`;
- `__LINKEDIT`: VM `0x7FF880000000`, fileoff `0x2AEFC000`, filesize `0x99F0000`.

D97BW then stopped before any segment copy with:
`FAIL=RECONSTRUCT_SIZE_UNSAFE:881770496`.

This is a collector guard, not a reconstruction negative. The large apparent size is caused by shared-cache fileoffs retained in native Mach-O load commands. Actual segment payload is about 157 MiB, while the highest declared file end is `0x348EC000` / 881,770,496 bytes.

Classification:
`D97BW_RESULT=PARTIAL_PASS_READONLY_TOOLING_COMPACT_BUFFER_SIZE_GUARD`.

No system/cache/source mutation, Root Patch or reboot occurred.

## Corrected reconstruction strategy
Do not rebase Mach-O load commands yet. The most conservative next test is a temporary sparse mirror:
1. create an apparent-size sparse file matching the highest original cache fileoff;
2. clone only the Mach-O header + load commands to file offset zero so standalone parsers can see the Mach-O header;
3. write every declared segment at its unchanged original shared-cache fileoff;
4. preserve every load command byte unchanged;
5. validate `file`, `otool -l`, `otool -L`, load-command data bounds and native Metal4 strings;
6. create a second sparse mirror and apply only the already-audited D97BV site+cave bytes;
7. prove all differences are confined to the exact site and cave ranges;
8. delete both temporary Apple binaries before packaging; report ZIP contains TXT+JSON only.

This strategy avoids inventing fileoff rebasing semantics and is strictly more conservative than compact reconstruction.

## D97BW v2 artifact
`OCLP7_D97BW_v2_native_metal_sparse_mirror.sh`
- bytes `21700`;
- SHA256 `273ad9b6fcc9c7cdcc1175627e70eaabaa026c4c1ccd8ad79cf33e4e4b561ceb`.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.
Run only D97BW v2 and return its ZIP.

No Root Patch and no accelerated reboot are authorized.
