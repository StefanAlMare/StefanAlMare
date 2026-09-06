# OCLP7 CHECKPOINT — 2026-09-06 — D97CT compile/audit PASS; D97CU EFI replacement ready

Authority: supersedes the D97CR/D97CS observation-channel frontier for current execution state.

## Runtime state entering D97CT
- ASUS2 remains Tahoe `26.6.2 / 25G82`, Haswell, VESA with `-igfxvesa`, no Root Patch.
- D97CO `OCLPMetalCompat.kext` 0.0.1 is currently deployed and runtime-loaded.
- `-ocmcdiag` is active.
- D97CR proved the exact D97CO kext loads, but unified-log markers were absent; this is classified observation-channel INCONCLUSIVE, not hook-negative.
- D97CS proved the standard Lilu plugin IOKit lifecycle is alive: `ioreg -r -c OCLPMetalCompat` returned an active service with `IOMatchedAtBoot=Yes` and `VersionInfo=DBG-001-2026-09-06`.

Classifications retained:
- `D97CR_D97CO_KEXT_RUNTIME_LOAD=PROVEN`;
- `D97CR_UNIFIED_LOG_MARKER_CHANNEL=INCONCLUSIVE`;
- `D97CS_OCLPMETALCOMPAT_IOKIT_LIFECYCLE=RUNTIME_PROVEN`;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

## D97CT design
D97CT keeps the same observe-only `_cs_validate_page` route but replaces early-log dependence with persistent state:
- Apple original `_cs_validate_page` is always called first;
- callback only reads target page bytes and stores results in atomics;
- no page/data mutation;
- asynchronous `thread_call` publishes state onto the live `OCLPMetalCompat` IORegistry service;
- expected properties include `D97CTRouteStatus`, site/cave seen counts, site preimage status, cave 18/208 zero status, Apple validated/tainted/nx values and publisher ticks.

Runtime gates remain exact:
- `-ocmcdiag`;
- Tahoe only;
- exact `kern.osversion=25G82`;
- Haswell CPU;
- main `/dyld_shared_cache_x86_64h` only;
- exact D97CN page offsets `0xF5E1000` and `0xF47E000`.

## First D97CT compile attempt — tooling-negative only
The first source used invalid C++ brace initialisation for C11 `_Atomic` globals and failed with 17 `illegal initializer type '_Atomic(uint32_t)'` errors. Lilu itself built successfully. No runtime conclusion was drawn.

The source was corrected to the MacKernelSDK/Lilu-compatible form `_Atomic(uint32_t) value = ATOMIC_VAR_INIT(0);`; delayed publisher scheduling was also aligned with Lilu's `nanoseconds_to_absolutetime + mach_absolute_time` pattern.

## Returned D97CT v2 build
Returned ZIP: `OCLP7_D97CT_IMAC_BUILD_20260906_190411.zip`.
- bytes `53555`;
- SHA256 `1e32326568f22abfc42020de0530babb8459a72557fc789f2143869012e1125f`.

Build evidence:
- pinned Lilu 1.7.3 build `RC=0` / `BUILD SUCCEEDED`;
- plugin build `RC=0` / `BUILD SUCCEEDED`;
- build errors `0`;
- six warnings are non-functional build-system/toolchain warnings.

Source identity:
- source SHA256 `74a0ba83e7da9875ed150b9413f2716fda1e81fd47d74a8d2911eae7fae0a561`;
- source inside ZIP is byte-identical to authorized D97CT v2 source.

Manifest audit:
- every entry in `SHA256SUMS.txt` matches independently; mismatch count `0`.

Compiled kext:
- Bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.2`;
- thin x86_64;
- Mach-O UUID `CD3FA6F8-E0AA-3FBD-AE66-B73C089385C0`;
- executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`;
- built Info.plist SHA256 `b386aded0a0d2a4490916f32236e22c2c38056638546c546153a5d7371ea4d8d`;
- CodeResources SHA256 `6686de10a28a2fe11b36cbb86dcbacc827cfc4ea116b4dabf1845e5aee629e9b`;
- Lilu dependency `1.7.3`;
- ad-hoc signature.

Independent binary/source audit:
- original D97BV 13-byte preimage occurs exactly once as comparison data;
- D97BV site replacement bytes absent;
- D97BV cave replacement bytes absent;
- no `vm_map_write_user`, `orgVmMapWriteUser`, `findAndReplace`, `vmProtect`, `injectPayload`, `injectSegment` or `const_cast`;
- no assignment through validation-page pointer;
- no memcpy/lilu_os_memcpy write to validation data/page;
- all expected D97CT IORegistry property strings are present;
- exact build/path/bootarg gate strings are present.

Authoritative classifications:
- `D97CT_LOCAL_COMPILE_AND_MANIFEST_AUDIT=PASS`;
- `D97CT_SOURCE_IDENTITY=PASS`;
- `D97CT_COMPILED_PERSISTENT_IOREG_OBSERVE_ONLY=PASS`;
- `D97CT_NO_FUNCTIONAL_D97BV_MUTATION=PASS`.

## Audited deploy artifact
`OCLP7_D97CT_AUDITED_DEPLOY_20260906.zip`
- SHA256 `d033c3195fa9bd098e4e1d080c59d09609269c7691d5ac6399c74fecc9cdee1e`;
- manifest SHA256 `b8e70324a76d9f2e6b461b152aa8a324656b42b55d2c033d42bd0100e7f7a655`;
- executable remains exact SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`.

## CURRENT ACTION
ASUS2 remains running the old D97CO in the current boot. Do not reboot yet.

Next bounded step is D97CU: identity-pinned replacement of only `EFI/OC/Kexts/OCLPMetalCompat.kext` from D97CO 0.0.1 to audited D97CT 0.0.2.

D97CU must:
- require current config SHA256 `52233a7815ef0accee2a44d06b44c75e9fcfd4aada831c4b343e7579e8fdc13b`;
- require old D97CO executable SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b`;
- require new D97CT package/executable identities;
- preserve config.plist byte-for-byte;
- preserve `-igfxvesa -ocmcdiag`;
- keep a backup of old D97CO kext;
- perform no Root Patch and no reboot.

After D97CU report PASS, one VESA boot with D97CT may be authorized and IORegistry persistent state collected. Functional D97BV byte writes remain unauthorized.