# OCLP7 D97FD — D97EZ 0.0.12 independent build audit PASS / VESA deployment authorized

Date: 2026-09-07 EEST
Target: ASUS2 Tahoe 26.6.2 / 25G82 / Haswell 8086:0412 / MacBookAir6,2

## Returned local build artifact
User returned exact archive:
`OCLP7_D97EZ_IMAC_BUILD_20260907_160935.zip`

Observed archive identity:
- bytes `154432`;
- SHA256 `c21d21c423879973f2ec1595f16046f8db7757486fb1d75b5a873c7705f3c4e6`;
- ZIP CRC test PASS;
- 21 files, 5 directories;
- no symlinks;
- no AppleDouble / `__MACOSX` / `.DS_Store` metadata entries.

This exactly matches the build terminal output returned by the user.

## Frozen package manifest audit
`package/SHA256SUMS.txt` contains 20 payload entries, excluding itself.

Independent verification result:
- all 20 hashes PASS;
- no mismatch;
- manifest SHA256 `f041bc196767ca8c0c4a0ae33b0091a424f3fc56f70bca0e95e7d62bee58a8ac` as reported by the build helper.

Key payload hashes independently rechecked:
- D97DL base source SHA256 `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`;
- D97EH generator SHA256 `fed0d21e974a70a3dacad9e86261ecde28dc5f2fbb8f2e4c8c94bf08102a1144`;
- D97EL generator Git blob `16fdcd6de0de7681a2abdf4c30716fb81a0d0f3e`;
- D97ES generator Git blob `dc7e244c3734f5dd0cd6f24d6d8c43da76d41fad`;
- D97EZ generator Git blob `3bf728b999e2163af77742686d7ce9aaac04e8fb`;
- D97EH generated source SHA256 `2d93b4bc09cd4259e027808547ea003820139f2c2d48b7591c8ea5ccfe038a2d`;
- D97EL generated source SHA256 `3a103b84ae8c18c7259c672dff9dd5c0f11d04d88554c8da8e60c5c0c04b9003`;
- D97ES generated source SHA256 `8184610aca1f2e651e6526e45c05d00a96055711c985571bc34c703ba7f6a8d0`;
- D97EZ generated source SHA256 `35e596e7067eba65bb544cb34a109289485320292cbe97953882da18d0f2a74a`.

## Independent deterministic lineage regeneration
Using only the packaged pinned base/generators, the audit independently regenerated:
- D97DL -> D97EH;
- D97EH -> D97EL;
- D97EL -> D97ES;
- D97ES -> D97EZ.

All four regenerated outputs are byte-identical to the packaged generated sources.

D97EZ generator independently reports:
- input SHA256 `8184610aca1f2e651e6526e45c05d00a96055711c985571bc34c703ba7f6a8d0`;
- output SHA256 `35e596e7067eba65bb544cb34a109289485320292cbe97953882da18d0f2a74a`;
- status PASS.

Classification: exact lineage and deterministic-generation PASS.

## Source semantic audit
Independent audit of packaged `OCLP7_D97EZ_GENERATED.cpp` proves:
- exact original input captured via `originalMode = mode`;
- exact classifier `originalMode == 0x00000224U`;
- exact conditional translation `(functionalActive && exact224) ? 0x00000024U : originalMode`;
- all non-`0x224` modes exact passthrough;
- Apple original invoked exactly once with `(that, id, passedMode)`;
- exact Apple IOReturn returned unchanged;
- no `mode &=` broad mutation;
- no `~0x200` / `~0x00000200` mask;
- no return coercion;
- global/no-PID exact224/other/adapt/passthrough counters present;
- explicit `-ocmcd97ez` gate present;
- first-eight original-mode storage preserved;
- first-eight `D97EZxxPassedMode` telemetry present;
- exact translation constants `0x224` and `0x24` each occur once in source logic.

Classification: SOURCE SEMANTIC PASS; broad mask ABSENT.

## Build log audit
Packaged `D97EZ_XCODEBUILD.log` independently checked:
- `BUILD SUCCEEDED` count = 2;
- `BUILD FAILED` count = 0;
- error-line count = 0;
- warning-line count = 6.

Warnings are build-system/toolchain warnings only:
- Lilu deployment target 10.6 below current Xcode supported range;
- script phases without declared outputs;
- unused `-stdlib=libc++` at link;
- duplicate `-lkmod` ignored.

No warning demonstrates a D97EZ source, ABI, link, or packaging failure.

## Compiled D97EZ identity
Independent artifact inspection:
- Mach-O 64-bit x86_64;
- filetype `MH_KEXT_BUNDLE`;
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.12`;
- Lilu dependency `1.7.3`;
- executable bytes `83616`;
- executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`;
- Info.plist SHA256 `2ba171f88df0d0c4f1c82b3f3d69403d93b06843ea7f79ae7c5f2cc58c7c8899`;
- LC_UUID independently parsed as `3405DFAB-244A-38CA-90EA-79A1A24EEF72`.

## Binary/disassembly semantic audit
Packaged `llvm-objdump` / `otool` / `nm` evidence independently inspected.

`patchedSetIdMode` binary behavior:
1. preserves original `that`, `id`, `mode` into stack locals;
2. compares original mode to immediate `0x224`;
3. tests the functional-requested state;
4. only if both functional-active and exact-224, loads immediate `0x24` as passedMode;
5. otherwise reloads originalMode unchanged;
6. immediately before Apple call restores:
   - `rdi = original that`;
   - `esi = original id`;
   - `edx = selected passedMode`;
7. performs one indirect call through resolved original `set_id_mode`;
8. stores exact Apple return;
9. only after Apple returns computes diagnostic `badBits` and `goodBits` from original mode;
10. stores original mode and passed mode separately in first-eight telemetry;
11. returns exact stored Apple IOReturn.

No binary evidence of broad mode masking or return coercion was found.

Classification: STATIC/BINARY EXACT-MATCH ADAPTER PASS.

## D97EY relationship
D97EY remains the decisive measured semantic input:
- captured accepted class: mode `0x24`, badBits `0`, goodBits `0x24`, Apple success;
- captured rejected class: mode `0x224`, badBits `0x200`, goodBits `0x24`, Apple `kIOReturnBadArgument`;
- semantic name of bit `0x200` remains UNKNOWN.

D97EZ therefore remains an experimental exact boundary translation, not a universal semantic claim and not a global mask.

## Classification
- `D97FD_ZIP_IDENTITY=PASS`
- `D97FD_ZIP_CRC=PASS`
- `D97FD_PACKAGE_MANIFEST=PASS`
- `D97FD_LINEAGE_REGEN=PASS`
- `D97FD_SOURCE_SEMANTIC=PASS`
- `D97FD_BUILD_LOG=PASS`
- `D97FD_MACHO_IDENTITY=PASS`
- `D97FD_BINARY_EXACT_MATCH_SEMANTICS=PASS`
- `D97FD_D97EZ_0012_INDEPENDENT_BUILD_AUDIT=PASS`
- `D97FD_VESA_DEPLOYMENT_AUTHORIZED=YES`
- `D97FD_VESA_REBOOT_AUTHORIZED=NO_PENDING_ACTIVE_EFI_IDENTITY`
- `D97FD_ACCELERATED_BOOT_AUTHORIZED=NO`
- `D97FD_D97EZ_FUNCTIONAL_ACTIVE_AUTHORIZED=NO`
- `D97FD_ROOT_PATCH_AUTHORIZED=NO`

## CURRENT ACTION — D97EZ VESA-FIRST DEPLOYMENT
On ASUS2 while remaining in current VESA recovery:
1. keep a backup of the currently active audited D97ES 0.0.11 kext;
2. replace only active EFI `EFI/OC/Kexts/OCLPMetalCompat.kext` with independently audited D97EZ 0.0.12;
3. do not change `Kernel -> Add -> BundlePath`;
4. keep existing VESA boot args unchanged and DO NOT add `-ocmcd97ez` yet;
5. keep `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh` active and `#-ocmcd97bvcave` inert;
6. do not Root Patch, change framebuffer state, add T2/Haswell variables, or reboot yet;
7. verify active EFI D97EZ identity before any reboot.

Required active-EFI identity:
- version `0.0.12`;
- executable SHA256 `356b51931d4458e359a253f264db1292e0d045b83684341b8e9be5464ea24b2c`;
- UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72` x86_64.

After exact active-EFI identity PASS, exactly one VESA validation reboot may be separately authorized. Accelerated boot and functional `-ocmcd97ez` remain forbidden until D97EZ LATENT VESA behavior is proven.
