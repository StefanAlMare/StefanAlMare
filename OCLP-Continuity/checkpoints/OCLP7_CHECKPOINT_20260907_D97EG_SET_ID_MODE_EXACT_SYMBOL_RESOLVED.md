# OCLP7 D97EG — exact set_id_mode symbol resolved

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.

## Context
D97EE/D97EF closed framebuffer-count tuning as a solution. 1/1/1 applied, but four `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` events and WindowServer SIGSEGV persisted.

Current VESA recovery remains active. No accelerated boot, Root Patch, or functional set_id_mode mutation is authorized.

## Exact read-only symbol audit returned by ASUS2
Bundle search:
- `/System/Library/Extensions/IOAcceleratorFamily2.kext` exists.
- Prior assumed standalone executable path `/System/Library/Extensions/IOAcceleratorFamily2.kext/Contents/MacOS/IOAcceleratorFamily2` is absent on this Tahoe installation, consistent with the implementation living in a kernel collection rather than as a directly readable standalone file.

Exact symbol candidate search returned from:
`/Library/Extensions/AppleIntelHD5000Graphics.kext/Contents/MacOS/AppleIntelHD5000Graphics`

```
(undefined) external __ZN14IOAccelSurface11set_id_modeEjj (dynamically looked up)
```

Therefore the exact imported C++ symbol required by the legacy Haswell accelerator driver is:

`__ZN14IOAccelSurface11set_id_modeEjj`

Demangled semantic target:

`IOAccelSurface::set_id_mode(uint32_t id, uint32_t mode)`

This resolves the prior ambiguity with external NootedGreen work, which routes `IOAccelLegacySurface::set_id_mode`; ASUS2/Haswell imports `IOAccelSurface::set_id_mode` specifically.

## Meaning
- The legacy Haswell driver is not the provider of the method; it imports the method dynamically.
- The implementation is supplied by the IOAccelerator stack loaded from the Tahoe kernel collection.
- The exact method name/signature is now proven from the installed Haswell driver itself.
- Functional masking remains unauthorized until the original call values and original IOReturn are observed.

## External methodological orientation only
A contemporary NootedGreen compatibility branch has a related `set_id_mode` observer/fix and classifies mode bits using:
- candidate bad mask `0xff8073c0`;
- complementary candidate good mask `0x007f8c3f`.

Its hardware context is TGL/RPL, not Haswell, and its functional masking must NOT be transplanted without ASUS2 measurement.

## Next diagnostic architecture
Derive a new OCLPMetalCompat diagnostic revision from exact D97DL 0.0.7 with a second, independent observer path for the exact target:
`__ZN14IOAccelSurface11set_id_modeEjj`.

Requirements:
- explicit new boot-arg gate;
- Tahoe 25G82 + Haswell gates retained;
- original `id` and `mode` passed unchanged to Apple;
- original return value preserved unchanged;
- bounded logging only, ideally <=32 calls per boot;
- record `id`, `mode`, original `IOReturn`, `mode & 0xff8073c0`, and `mode & 0x007f8c3f`;
- no bit stripping, no return coercion, no framebuffer mutation;
- build locally on authorized Intel iMac 9900K;
- static and binary audit before deployment;
- first deployment boot VESA only;
- accelerated diagnostic boot requires separate authorization after observer route/load PASS.

## Current baseline / prohibitions
Restore normal 0x0A260006 3/3/3 framebuffer baseline before any future accelerated test. Keep VESA until explicitly authorized.

Still forbidden:
- any set_id_mode functional mask before measurement;
- another unchanged accelerated boot;
- retaining 1/1/1 as production;
- another Root Patch;
- legacy main Metal shadow;
- global forced-3802;
- true-five reapplication;
- Golden mutation.
