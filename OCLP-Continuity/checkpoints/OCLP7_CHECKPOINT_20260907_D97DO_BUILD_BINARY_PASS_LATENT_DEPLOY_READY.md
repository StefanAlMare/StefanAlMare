# OCLP7 CHECKPOINT — 2026-09-07 — D97DO 0.0.8 build/binary PASS; LATENT deploy ready

## Entering ASUS2 authority
- Tahoe 26.6.2 / 25G82;
- Haswell 8086:0412, SMBIOS MacBookAir6,2;
- VESA only, no Root Patch;
- active EFI D97DL OCLPMetalCompat 0.0.7;
- D97DL executable SHA256 `29e4c5997d76ab980ccfa35175b5bc58c06d3f6363d80822e2ad18406d12658e`;
- D97DL UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`;
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- boot args contain `-igfxvesa -ocmcdiag` and contain neither `-ocmcd97bvcave` nor `-ocmcd97bv`.

D97DN already proved D97DL LATENT runtime PASS with zero SITE/CAVE writes, route/build PASS and CAVE natural validated-all evidence.

## Why D97DO exists
Pre-write review identified that D97DL's CAVE-ready state is global to the kext. Before allowing a cross-page SITE -> CAVE branch, propagation of the CAVE-modified validation page between userspace processes/address spaces must be measured directly.

D97DO is therefore a diagnostic CAVE-only successor. It deliberately removes SITE functional mutation capability.

## D97DO 0.0.8 safety design
- Apple original `_cs_validate_page` first;
- exact 25G82 / Haswell / main x86_64h / target page / Apple validation / zero-preimage gates retained;
- only diagnostic boot arg `-ocmcd97bvcave` can request a write;
- full functional `-ocmcd97bv` is explicitly blocked;
- exact SITE replacement bytes are absent from source and binary;
- no SITE write target exists;
- exact CAVE replacement is compiled once;
- CAVE write can happen at most once per boot via atomic CAS;
- writer must have `proc_selfpid() > 0`;
- writer PID is recorded;
- later callbacks never rewrite CAVE;
- propagation PASS/NEGATIVE is classified only on a callback from a different userspace PID.

Because SITE remains native, the CAVE payload is inert in D97DO.

## Correct source authority
Byte-exact source is concatenation in order of Git blobs:
1. part1 `5308074eb75d76531eef19481ded76b641c3f301`;
2. part2 `fac28701be3acae370866483b94d04d620d41916`;
3. part3 `54861bd997619551e64c264f9e02b1d4e66c13b2`.

Returned reconstructed source:
- bytes `25693`;
- SHA256 `4607658c5a7d1967d7b0ae1b507f0e160ba2201aed6fe5b4a9a936a263cb520a`.

The earlier documented reconstructed SHA `7da66e31...` was incorrect and has been superseded in the static audit. Exact fragment blob identities and concatenation order were enforced by the build helper, and returned package source was independently hashed.

## Returned D97DO build
`OCLP7_D97DO_IMAC_BUILD_20260907_000350.zip`
- bytes `60111`;
- SHA256 `01900232f6c77fe72cad6759d2a1a1c851e772ced0d4e036f66fa3f0fba96d36`;
- manifest mismatches 0;
- Lilu build PASS;
- D97DO build PASS;
- compiler errors 0;
- warnings 6, non-functional build/toolchain only.

Compiled D97DO:
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.8`;
- UUID `5CE5E9F9-9D18-33C0-8A03-18237D949A6A`;
- executable SHA256 `45cc67efcc656e1085d7c34f707d4e00b71406d45d74edfa4e01823d2e89bfe4`;
- Info.plist SHA256 `bf1fbf140a05bd5291257c25bf69aba0a16c1480d57cc02b776298b57265e365`;
- Lilu dependency 1.7.3.

Binary proof:
- exact CAVE replacement count = 1;
- exact SITE replacement count = 0;
- required CAVE-only/propagation markers present;
- generic broad patching surfaces absent.

Audited LATENT package:
- `OCLP7_D97DO_AUDITED_LATENT_DEPLOY_20260907.zip`;
- SHA256 `c336816e5b87b7af7d4960d6024cc5a31e3188bd901ab35bc649c54169ca560b`;
- bytes `23935`.

## Classifications
- `D97DO_BUILD=PASS`;
- `D97DO_MANIFEST_AUDIT=PASS`;
- `D97DO_SOURCE_IDENTITY=PASS`;
- `D97DO_BINARY_IDENTITY=PASS`;
- `D97DO_SITE_MUTATION_CAPABILITY=ABSENT_BINARY_PROVEN`;
- `D97DO_CAVE_REPLACEMENT_BINARY_COUNT=1`;
- `D97DO_SITE_REPLACEMENT_BINARY_COUNT=0`;
- `D97DO_CAVE_ONE_SHOT_WRITE=STATIC_PROVEN`;
- `D97DO_CROSS_PID_PROPAGATION_CLASSIFIER=STATIC_PROVEN`;
- `D97DO_FULL_FUNCTIONAL_ARG_BLOCKED=STATIC_PROVEN`;
- `D97DO_BUILD_BINARY_AUDIT=PASS`.

## CURRENT ACTION — D97DP
Deploy D97DO 0.0.8 over current D97DL 0.0.7 in LATENT mode only.

D97DP must:
- verify exact config/D97DL/Lilu identities;
- require `-igfxvesa -ocmcdiag`;
- require both `-ocmcd97bvcave` and `-ocmcd97bv` absent;
- verify exact audited D97DO package/source/executable;
- verify SITE replacement absent and CAVE replacement present;
- replace only `EFI/OC/Kexts/OCLPMetalCompat.kext`;
- backup D97DL;
- preserve config byte-identically;
- no Root Patch;
- no reboot.

After D97DP, return report before reboot.

Still not authorized until D97DP audit:
- adding `-ocmcd97bvcave`;
- first CAVE write;
- adding `-ocmcd97bv`;
- SITE mutation;
- Root Patch;
- accelerated boot.
