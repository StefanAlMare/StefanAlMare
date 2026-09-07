# OCLP7 CHECKPOINT — D97GE corrected Root Patch preboot STRUCTURAL-SEMANTIC PASS; VESA reboot authorized

Date: 2026-09-07 EEST

## Entering authority
- ASUS2 Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- D97GA closed APFS Root Patch Restore PASS and authorized corrected D97DX Root Patch.
- User then executed exact outer D97DX Root Patch using the corrected local 25G82 MetallibSupportPkg source.
- Corrected Root Patch transcript ended normally at `Patching complete` / reboot prompt with no preflight or installation error.
- Current running boot remains VESA; no reboot has occurred after corrected Root Patch.

## Corrected Root Patch execution transcript — PASS
The transcript proves:
- exact local metallib `26.6.2-25G82` found and API fallback skipped;
- patcher capable of patching;
- preflight PASS;
- exact corrected local path used:
  `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`;
- Metal 3802 Common and Common Extended installed;
- Metal 3802 `.metallibs` patchset installed;
- CoreDisplay `default.metallib` explicitly overwritten;
- Monterey GVA and OpenCL installed;
- Intel Haswell patchset installed;
- `AppleIntelFramebufferAzul.kext` and `AppleIntelHD5000Graphics.kext` received AuxKC support;
- Haswell GL/MTL/VA/userspace bundles installed;
- Auxiliary Kernel Collection rebuilt and forced;
- root volume unmounted;
- `Patching complete` reached.

Classification:
`D97GB_CORRECTED_ROOTPATCH_EXECUTION=PASS`.

## D97GC/D97GD metallib post-patch audit
D97GC first stopped on a parser false negative when snapshot device `disk1s8s1` was not normalized to System volume `disk1s8`. No mount or mutation occurred.

D97GD corrected that parser and mounted `/dev/disk1s8` read-only. It then proved the critical corrected payload boundary byte-for-byte:
- `D97GD_PATCHED_METALLIB_EXACT=180`;
- `D97GD_PATCHED_METALLIB_MISSING=0`;
- `D97GD_PATCHED_METALLIB_DIFFERENT=0`;
- `D97GD_PATCHED_METADATA_STUB=0`.

Exact patched CoreDisplay identity:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- magic `4d544c42` = `MTLB`;
- identity PASS.

Therefore the original systemic metallib materialization defect is closed on the newly patched System volume before reboot.

Classification:
- `D97GE_180_DYNAMIC_METALLIBS=STRUCTURAL_SEMANTIC_PROVEN_EXACT`;
- `D97GE_COREDISPLAY_GPUPASS_PAYLOAD=STRUCTURAL_SEMANTIC_PROVEN_EXACT`;
- `D97GE_METADATA_STUB_COUNT=0`.

## D97GD driver-path false negative explained
D97GD then expected the two Haswell `.kext` bundles under the mounted System volume `/System/Library/Extensions` and stopped when `AppleIntelFramebufferAzul.kext` was absent there.

Exact OCLP AuxKC source logic proves this expectation was wrong on Ventura+ when `skip_root_kmutil_requirement` is active:
- for `.kext` installs whose declared patch directory is `/System/Library/Extensions`, `add_auxkc_support()` redirects installation to the Data-volume `/Library/Extensions`;
- Apple kexts receive `OSBundleRequired=Auxiliary`;
- AuxKC instructions then reference `/Library/Extensions/<kext>`.

Thus D97GD's driver-presence failure is TOOLING FALSE NEGATIVE and does not invalidate its earlier metallib proof.

## D97GE exact Haswell/AuxKC micro-gate — PASS
Current post-patch Data-volume objects:

### AppleIntelFramebufferAzul.kext
- path `/Library/Extensions/AppleIntelFramebufferAzul.kext`;
- CFBundleIdentifier `com.apple.driver.AppleIntelFramebufferAzul`;
- `OSBundleRequired=Auxiliary`;
- observed size 2,158,592 bytes.

### AppleIntelHD5000Graphics.kext
- path `/Library/Extensions/AppleIntelHD5000Graphics.kext`;
- CFBundleIdentifier `com.apple.driver.AppleIntelHD5000Graphics`;
- `OSBundleRequired=Auxiliary`;
- observed size 880,640 bytes.

AuxKC instructions contain both exact paths:
- `/Library/Extensions/AppleIntelFramebufferAzul.kext`, cdHash `2ff735e07267c204691742c7cf82ec1a1b83ed50`;
- `/Library/Extensions/AppleIntelHD5000Graphics.kext`, cdHash `7ce1571e4451ba51eb80af996f2b600e7b811fbd`;
- match count `2`;
- team ID blank as expected for the patched/ad-hoc AuxKC entries.

Classification:
`D97GE_HASWELL_AUXKC_DATA_KEXTS=STRUCTURAL_SEMANTIC_PROVEN`.

## Haswell userspace bundles on patched System volume — PASS
Read-only mounted System volume `/dev/disk1s8` contains:
- `AppleIntelHD5000GraphicsGLDriver.bundle` with x86_64 Mach-O payloads;
- `AppleIntelHD5000GraphicsMTLDriver.bundle` with x86_64 `AppleIntelHD5000GraphicsMTLDriver`, `libigdmd.dylib`, `libMTLIntelCompilerPlugin.dylib`;
- `AppleIntelHD5000GraphicsVADriver.bundle` x86_64;
- `AppleIntelHSWVA.bundle` x86_64;
- `AppleIntelGraphicsShared.bundle` with x86_64 shared libraries.

Classification:
`D97GE_HASWELL_USERSPACE_BUNDLES=STRUCTURAL_PROVEN`.

## Official privileged helper — PASS
Exact helper after corrected Root Patch:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- TeamIdentifier `S74BDJXQMD`;
- codesign verification PASS.

Classification:
`D97GE_OFFICIAL_HELPER_IDENTITY=PASS`.

## Composite preboot classification
By composition of corrected Root Patch transcript + D97GD + D97GE:
- corrected Root Patch execution PASS;
- 180/180 dynamic MetallibSupportPkg targets byte-for-byte exact;
- zero missing/different/stub metallibs;
- exact CoreDisplay real GPUPass payload installed;
- Haswell kexts correctly redirected to Data volume and enrolled in AuxKC;
- Haswell userspace bundles present on patched System volume;
- official privileged helper restored and exact.

Therefore:
`D97GE_CORRECTED_ROOTPATCH_PREBOOT=STRUCTURAL_SEMANTIC_PASS`.

This does NOT yet prove runtime acceleration or GUI success.

## Causal frontier
The old D97FJ common-cause model is now repaired preboot:
`metadata-stub metallib layer -> invalid/missing GPUPass -> specialization/descriptor failure -> Metal validation abort`.

Preboot repair is STRUCTURAL-SEMANTIC PROVEN. Runtime causal closure remains pending.

## Authorization
AUTHORIZED NOW:
`D97GE_VESA_REBOOT_AFTER_CORRECTED_ROOTPATCH=YES`.

Required next sequence:
1. reboot once with current EFI unchanged;
2. remain VESA (`-igfxvesa` active);
3. keep D97EZ ACTIVE mode inert/commented (`#-ocmcd97ez`);
4. no EFI/NVRAM/framebuffer change;
5. after VESA return, audit the active booted snapshot: exact 180 metallib identities/CoreDisplay identity, Haswell Data kext/AuxKC state, helper identity, and relevant loaded-state observations;
6. only after that postboot VESA gate passes may an accelerated boot be separately authorized.

Still NOT authorized:
- accelerated boot;
- disabling `-igfxvesa`;
- active `-ocmcd97ez`;
- EFI/NVRAM/framebuffer changes before postboot gate;
- Golden mutation;
- legacy main Metal shadow;
- true-five reapplication.