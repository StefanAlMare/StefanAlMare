# OCLP7 CHECKPOINT — D97EN — D97EL 0.0.10 INDEPENDENT BUILD AUDIT PASS

Date: 2026-09-07 EEST

## Scope
Independent audit of user-returned Intel iMac local build artifact:
`OCLP7_D97EL_IMAC_BUILD_20260907_123115.zip`.

This checkpoint authorizes VESA-first deployment only. Accelerated boot remains separately gated.

## ZIP identity / integrity
- bytes: `61617`
- SHA256: `b0d8c265a239f8051a4b505a4ce5649f874c95e8e26671bd586b62dd11705181`
- ZIP CRC/test: PASS

## Build report
Build report states:
- host required Intel iMac;
- plugin version `0.0.10`;
- D97BV preserved;
- D97EH observer semantics preserved;
- telemetry only;
- exact symbol `__ZN14IOAccelSurface11set_id_modeEjj`;
- observer bootarg `-ocmcd97eh`;
- mode mutation NO;
- return coercion NO;
- registration behavior change NO;
- Xcode 26.3 / build 17C529;
- D97EH generator PASS;
- D97EL generator PASS;
- deterministic generation PASS;
- static telemetry-only audit PASS;
- binary marker audit PASS.

## Generator authority
D97EL telemetry generator:
- commit `1fb87c18169a9bd1b74c2b3ff67badc77449c1d4`
- Git blob `16fdcd6de0de7681a2abdf4c30716fb81a0d0f3e`
- packaged SHA256 `659eb459a25865fc06c4157c117ace9dd6c0b7eaca764622b36909b358b164bc`

D97EH generator packaged SHA256:
`fed0d21e974a70a3dacad9e86261ecde28dc5f2fbb8f2e4c8c94bf08102a1144`.

## Generated source
`OCLP7_D97EL_kern_start.cpp`:
- bytes `26688`
- SHA256 `3a103b84ae8c18c7259c672dff9dd5c0f11d04d88554c8da8e60c5c0c04b9003`

Independent source audit:
- exact original call exists once:
  `FunctionCast(patchedSetIdMode, orgSetIdMode)(that, id, mode)`;
- exact `return ret;` exists once;
- candidate masks are read-only diagnostics only:
  `mode & 0xFF8073C0U`, `mode & 0x007F8C3FU`;
- no `patchedMode`;
- no `mode &=`;
- no `return kIOReturnSuccess`;
- registration anchor remains exact:
  `lilu.onKextLoadForce(&kextIOAcceleratorFamily2);`.

D97EL-only source delta versus reconstructed exact D97EH is telemetry only:
- atomic observer-request state;
- callback and target-callback counters;
- last callback index / kext load index;
- route-state publication;
- IORegistry publication of D97EL state.
No observer functional semantics changed.

## Independent lineage proof
Reverse only the D97EL generator substitutions from packaged D97EL source:
- reconstructed D97EH SHA256 = `2d93b4bc09cd4259e027808547ea003820139f2c2d48b7591c8ea5ccfe038a2d` (exact D97EH authority).

Then reverse only the D97EH generator substitutions:
- reconstructed D97DL SHA256 = `f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2` (exact D97DL authority).

Therefore D97BV and the prior observer semantics are preserved exactly outside the declared telemetry additions.

## Manifest integrity
Every entry in packaged `SHA256SUMS.txt` validates exactly:
- build report;
- generated source;
- Xcode log;
- CodeResources;
- kext executable;
- Info.plist;
- D97EL generator;
- D97EH generator.

The previous self-hash manifest bug is absent in this package.

## Kext identity
`OCLPMetalCompat.kext`:
- CFBundleIdentifier `com.oclpmetalcompat.OCLPMetalCompat`
- version `0.0.10`
- arch `x86_64`
- UUID `1A19441E-9937-3FBF-995D-9CC282E89089`
- executable SHA256 `7aa86d2484c6f252f7a77704117cebb6e14afa96bf2d98bb2523644fd86926ac`
- Info.plist SHA256 `f6e31e96d1bc83e8dcb0bfa1ee1657bb04201e15a9c7ab33a0419ed397131d70`

Mach-O is x86_64 kext bundle. LC_UUID independently matches the build report.

## Independent binary semantic audit
Disassembly of `patchedSetIdMode` proves:
1. original `that`, `id`, `mode` are saved immediately;
2. `orgSetIdMode` is resolved;
3. immediately before indirect Apple call:
   - saved `that` -> `rdi`;
   - saved `id` -> `esi`;
   - saved `mode` -> `edx`;
4. Apple original is called with those exact values;
5. returned `eax` is saved;
6. only after return are diagnostic masks computed;
7. final return reloads original return value.

Disassembly of `processD97EHKext` independently proves:
- generic callback count increments first;
- last callback index and current target loadIndex are recorded;
- target-only callback count increments only on index match;
- exact symbol route is attempted via `routeMultipleLong`;
- route state stores `1` on PASS and `2` on NEGATIVE;
- failure still clears patcher error as D97EH did.

Binary strings contain:
- `-ocmcd97eh`;
- all D97EL IORegistry property names;
- exact set_id_mode symbol;
- `D97EH_SET_ID_MODE` marker.

## Classification
- `D97EN_ZIP_INTEGRITY=PASS`
- `D97EN_MANIFEST_INTEGRITY=PASS`
- `D97EN_D97EL_SOURCE=PASS`
- `D97EN_LINEAGE_TO_D97EH=EXACT`
- `D97EN_LINEAGE_TO_D97DL=EXACT`
- `D97EN_OBSERVER_PASSTHROUGH=PASS`
- `D97EN_TELEMETRY_ONLY_DELTA=PASS`
- `D97EN_BINARY_AUDIT=PASS`
- `D97EN_BUILD_AUDIT=PASS`
- `D97EN_VESA_DEPLOYMENT_AUTHORIZED=YES`
- `D97EN_ACCELERATED_BOOT_AUTHORIZED=NO`

## Next action
On ASUS2, remain on normal 3/3/3 baseline and VESA boot args.
Manually replace active EFI `OCLPMetalCompat.kext` 0.0.9 with audited D97EL 0.0.10 while retaining a backup.
Keep active:
- `-igfxvesa`
- `-ocmcdiag`
- `-ocmcd97bv`
- `-ocmcd97eh`
Keep `#-ocmcd97bvcave` inert.

Before reboot, verify active EFI identity against:
- version `0.0.10`
- executable SHA256 `7aa86d2484c6f252f7a77704117cebb6e14afa96bf2d98bb2523644fd86926ac`
- UUID `1A19441E-9937-3FBF-995D-9CC282E89089`

Then one VESA reboot may be authorized after identity PASS.
After VESA boot inspect IORegistry D97EL telemetry. Accelerated boot requires separate authorization only if route status is conclusively PASS.
