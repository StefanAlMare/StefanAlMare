# OCLP7 CHECKPOINT — 2026-09-06 — D97CF true single-Metal still identical Objective-C SIGSEGV

Authority: extends `OCLP7_CHECKPOINT_20260906_D97CF_SINGLE_METAL_OVERRIDE_SCRIPT_READY.md` and closes its discriminator.

## Machine / safety state
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- Native Tahoe Metal/Metal4 ABI remains authoritative.
- D97BV is not applied and remains unauthorized.
- No Root Patch, installation, local/source compilation, accelerated boot or reboot authorized.

## Returned evidence
User returned:
- `OCLP7_D97CF_SINGLE_METAL_FRAMEWORK_OVERRIDE_20260906_041903.zip`
  - bytes `118754`
  - SHA256 `0a8d8c80521ccfefaa0419b4c5261e2b280488f9f74187954b29d1f2bd3cd7fc`
- packaged TXT
  - bytes `337523`
  - SHA256 `2ea845e8d0826dbfd850c9c6293565963f46a772d9c190cf542730a85e07b338`
- packaged JSON
  - bytes `382613`
  - SHA256 `e8718f1822ba2494574984763bb3c3df8e5a221b1a112eb34b26bf35248bfb07`.

Terminal paste `Text lipit(6).txt` was also returned; the packaged TXT/JSON are authoritative for exact D97CF result identity.

## D97CF transform / harness closure
- exact `ipsw --slide` source SHA256 `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`;
- exact proven page-aligned SLIDE transform SHA256 `068ec08cff3d279ce1a700695162d0eda19ab8f5b956b8a91e60c9009d155de2`, bytes `5735232`;
- transform PASS;
- file/otool parsers PASS;
- temporary framework target sign/verify PASS;
- cold baseline PASS;
- positive libbz2 DYLD_INSERT control PASS;
- no system/cache/install/compile/root-patch/reboot mutation;
- temp Apple binaries cleaned; `TEMP_REMAINING_FILE_COUNT=0`;
- collection ZIP completed.

## Framework override result
D97CF launched the proven cold host with:
- `DYLD_FRAMEWORK_PATH=<temp>/Frameworks`;
- canonical `DYLD_INSERT_LIBRARIES=/System/Library/Frameworks/Metal.framework/Versions/A/Metal`.

Dyld honored the framework override.

Observed exact discriminator state:
- `OVERRIDE_HONORED=True`;
- `TEMP_LOADED=True`;
- `NATIVE_LOADED=False`;
- `NATIVE_CACHE_MAPPING=False`;
- `SINGLE_METAL=True`;
- `METAL_PATH_COUNT=1`;
- unique loaded Metal path set contains only the temporary framework Metal;
- unique loaded Metal UUID set contains only native-derived UUID `5D64FA80-29CE-32AA-BAB6-4E5034132C0B`.

Authoritative marker:
`D97CF_TRUE_SINGLE_METAL=PASS`.

## Runtime frontier
Despite true single-Metal state, runtime result is identical to D97CD/D97CE:
- process RC `-11` SIGSEGV;
- temporary Metal all segments mapped and target loaded;
- final relevant dyld line:
  `mprotect ... to read-write (Metal)`;
- `RW_SEEN=True`;
- `POST_RW_LINES=0`.

Printed classification:
`D97CF_FRAMEWORK_OVERRIDE_CLASSIFICATION=SINGLE_METAL_IDENTICAL_RW_MARKER_THEN_SIGSEGV`.

Therefore:
- `D97CF_DUPLICATE_METAL_IS_SUFFICIENT_CAUSE_OF_CURRENT_OBJC_SIGSEGV=NEGATIVE`;
- simultaneous native-cache Metal + standalone Metal is not sufficient to explain the current crash;
- D97CE full slide-info resolution plus D97CF true single-Metal override together leave the same Objective-C registration/fixup boundary unresolved.

## Causal frontier after D97CF
The strongest current boundary is no longer dyld validation, segment mapping, cache-slide resolution, or duplicate-Metal coexistence.

The remaining crash occurs after dyld makes the reconstructed Metal image writable for Objective-C processing and before any later dyld marker is printed. The next diagnostic should localize the actual SIGSEGV instruction/stack inside dyld/libobjc/objective-C registration/fixup processing rather than applying another speculative binary repair.

Preferred next evidence class:
- exact fault PC;
- crashing thread backtrace;
- loaded image + slide mapping sufficient to symbolize the PC;
- fault address/register state if safely obtainable;
- preserve the exact proven true-single-Metal framework override geometry/harness.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.

Design/run a bounded ASUS2-only crash-localization diagnostic using the exact D97CF single-Metal setup, preferably LLDB launch/catch-SIGSEGV if available, with fail-closed fallback if debugger launch is unavailable. Do not alter Metal semantics or apply D97BV merely to obtain the stack.

No Root Patch, installation, source/local compilation, accelerated boot or reboot authorized.
