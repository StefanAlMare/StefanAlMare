# OCLP7 D97DO 0.0.8 — independent build/binary audit

Date: 2026-09-07 EEST

## Returned build
`OCLP7_D97DO_IMAC_BUILD_20260907_000350.zip`
- bytes: `60111`;
- SHA256: `01900232f6c77fe72cad6759d2a1a1c851e772ced0d4e036f66fa3f0fba96d36`.

## Manifest / build
- manifest entries: 8;
- manifest mismatches: 0;
- Lilu xcodebuild PASS;
- D97DO xcodebuild PASS;
- compiler errors: 0;
- warnings: 6, all non-functional toolchain/build-system warnings.

Host/toolchain:
- macOS 26.6.2 / 25G83;
- Intel Core i9-9900K;
- Xcode 26.5 (17F42);
- Apple clang 21.0.0;
- Lilu 1.7.3.

## Source identity
The build verified exact Git blob identities:
- part1 `5308074eb75d76531eef19481ded76b641c3f301`;
- part2 `fac28701be3acae370866483b94d04d620d41916`;
- part3 `54861bd997619551e64c264f9e02b1d4e66c13b2`.

Reconstructed source in returned package:
- bytes `25693`;
- SHA256 `4607658c5a7d1967d7b0ae1b507f0e160ba2201aed6fe5b4a9a936a263cb520a`.

The earlier static-audit reconstructed SHA was stale/incorrect and has been corrected in GitHub. This does not invalidate the returned build because exact fragment blob identities and concatenation order were enforced, and the package source was independently hashed.

## Compiled D97DO
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.8`;
- thin x86_64 KEXTBUNDLE;
- UUID `5CE5E9F9-9D18-33C0-8A03-18237D949A6A`;
- executable SHA256 `45cc67efcc656e1085d7c34f707d4e00b71406d45d74edfa4e01823d2e89bfe4`;
- built Info.plist SHA256 `bf1fbf140a05bd5291257c25bf69aba0a16c1480d57cc02b776298b57265e365`;
- CodeResources SHA256 `6686de10a28a2fe11b36cbb86dcbacc827cfc4ea116b4dabf1845e5aee629e9b`;
- Lilu dependency `1.7.3`;
- ad-hoc signature.

## CAVE-only binary proof
Exact CAVE replacement:
`3d187d0000b9177d00000f4cc1e9b4311600`
- executable occurrence count: 1.

Exact SITE replacement:
`3dda0e00007406e93bcee9ff90`
- executable occurrence count: 0.

Source independent counts:
- `SiteReplacement`: 0;
- `mutablePage + SiteInPage`: 0;
- `mutablePage + CaveInPage`: 1;
- `writeExact(`: 2 total = one definition + one call site;
- cave-only bootarg check: 1;
- full functional bootarg check: 1;
- `proc_selfpid()`: 1;
- atomic CAS: 1.

Required binary markers present:
- `D97DOCaveOnlyBootArg`;
- `D97DOFullFunctionalBootArg`;
- `D97DOFunctionalMode`;
- `D97DOSiteWriteBlocked`;
- `D97DOCaveWritePhase`;
- `D97DOCavePropagation`;
- `D97DOCaveWritePid`;
- `D97DOCavePropagationPid`;
- `-ocmcd97bvcave`;
- `-ocmcd97bv`.

Forbidden generic patching surfaces absent:
- `vm_map_write_user`;
- `orgVmMapWriteUser`;
- `findAndReplace`;
- `findAndReplaceWithMask`;
- `injectPayload`;
- `injectSegment`;
- `vmProtect`.

## Functional semantics
D97DO is deliberately not a full D97BV functional adapter.
- full `-ocmcd97bv` is blocked;
- SITE write capability is absent from source and binary;
- only `-ocmcd97bvcave` can request mutation;
- only CAVE page can be written;
- CAVE write is one-shot per boot via atomic phase claim;
- writer must be a userspace PID;
- write requires exact build/path/page/Apple-validation/zero-preimage gates;
- postimage and retained 208-byte tail-zero are verified;
- propagation classification occurs only on a later callback from a different userspace PID.

Because SITE remains native, the injected CAVE payload is inert: no D97BV branch can target it in this build.

## Classifications
`D97DO_BUILD=PASS`
`D97DO_MANIFEST_AUDIT=PASS`
`D97DO_SOURCE_IDENTITY=PASS`
`D97DO_BINARY_IDENTITY=PASS`
`D97DO_SITE_REPLACEMENT_BINARY_COUNT=0`
`D97DO_CAVE_REPLACEMENT_BINARY_COUNT=1`
`D97DO_SITE_MUTATION_CAPABILITY=ABSENT_BINARY_PROVEN`
`D97DO_CAVE_ONE_SHOT_WRITE=STATIC_PROVEN`
`D97DO_CROSS_PID_PROPAGATION_CLASSIFIER=STATIC_PROVEN`
`D97DO_FULL_FUNCTIONAL_ARG_BLOCKED=STATIC_PROVEN`
`D97DO_BUILD_BINARY_AUDIT=PASS`

## Authorization boundary
Safe next step: deploy D97DO 0.0.8 to ASUS2 in LATENT mode only, with both `-ocmcd97bvcave` and `-ocmcd97bv` absent, verify runtime identity and zero writes, then separately arm the CAVE-only probe.

Not authorized by this artifact alone:
- adding `-ocmcd97bvcave`;
- any CAVE write;
- adding `-ocmcd97bv`;
- SITE mutation;
- Root Patch;
- accelerated boot.
