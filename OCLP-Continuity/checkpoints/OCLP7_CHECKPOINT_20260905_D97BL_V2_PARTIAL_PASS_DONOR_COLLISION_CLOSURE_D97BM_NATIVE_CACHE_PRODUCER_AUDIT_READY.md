# OCLP7 CHECKPOINT — D97BL v2 partial pass; donor collision closure; D97BM native-cache producer audit ready

Date: 2026-09-05 EEST

## Entering state
- Target remains Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current system is unpatched Tahoe VESA after sealed/saved snapshot restore.
- D97BK proved the D97BJ accelerated failure was NOT kernel panic; userspace and WindowServer were reached, then launchd performed controlled shutdown after Metal4 Objective-C superclass failures caused by the full legacy `13.2.1-24/Metal.framework` overlay.
- No Root Patch or accelerated reboot is authorized.

## Returned D97BL v2 evidence bundle
User returned:
`OCLP7_D97BL_STATIC_HYBRID_AUDIT_20260905_134001.zip`

Identity:
- bytes `143866`;
- SHA256 `426b5bccbaf525626007e90d695466cf7afbedf90b6c075e5076b3e083bf1a23`.

The collector verified:
- macOS `26.6.2 / 25G82`;
- current Root Patch absent;
- active VESA boot args include `-igfxvesa`;
- exact `Universal-Binaries.dmg` path `/Users/alex/Developer/OpenCore-Legacy-Patcher-D97BJ-b9df76-Tahoe25G82/Universal-Binaries.dmg`;
- DMG bytes `641964544`;
- DMG SHA256 `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`;
- read-only DMG mount with public OCLP passphrase succeeded.

## Collector v2 tooling defects
The returned collector is **not** classified as a full PASS because two read-only reporting defects occurred after useful evidence collection:
1. collision-analysis embedded Python raised `UnboundLocalError` because `lines += ...` inside the nested function incorrectly created a local binding;
2. native Tahoe `Metal.framework/Versions/A/Metal` was probed as an ordinary filesystem file, but on Tahoe this image is supplied by dyld shared cache, so the attempted direct `shasum/strings/nm` path was absent.

The script continued and packaged the remaining evidence because it did not fail-close on those two reporting errors.

Classifications:
- `D97BL_V2_COLLECTOR_FULL_PASS=NO`;
- `D97BL_V2_COLLECTOR_RESULT=PARTIAL_PASS_WITH_READONLY_TOOLING_DEFECTS`;
- no source mutation, system mutation, Root Patch or reboot occurred.

## Exact Metal.framework per-file collision closure
The returned manifests are sufficient to reconstruct the collision census deterministically.

### Native Tahoe on-disk Metal.framework
The regular-file manifest contains 18 files: resources, signatures and native `MTLCompilerService.xpc`. It contains **no ordinary `Versions/A/Metal` binary** because the native Metal image is supplied through dyld shared cache.

Native Tahoe service:
- path `Versions/A/XPCServices/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService`;
- SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- universal `x86_64 + arm64e`;
- UUID `022C1750-8735-389A-A8BA-A8A67F54235D`;
- visible selector path string only `/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/MTLCompiler`;
- raw immediate counts in the binary: `3802=5`, `31001=0`, `32023=1`; these raw counts are not by themselves semantic selector claims, but they are consistent with a modern service no longer carrying the legacy 31001 branch.

### Donor `12.5-3802-23/Metal.framework`
Manifest contains exactly 4 regular files, all inside `MTLCompilerService.xpc`:
- `_CodeSignature/CodeResources`;
- `Info.plist`;
- `MacOS/MTLCompilerService`;
- `version.plist`.

All four collide with native Tahoe paths and all four have different hashes. There are zero donor-only files.

Legacy service binary:
- SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- x86_64;
- UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`;
- visible paths for both `/Versions/3802/MTLCompiler` and `/Versions/32023/MTLCompiler`;
- raw immediate counts `3802=1`, `31001=1`, `32023=0`, matching the previously proven original selector design.

Therefore the 12.5 donor can be bounded to an XPC-service replacement without touching the main Metal binary.

### Donor `13.2.1-24/Metal.framework`
Manifest contains exactly 2 regular files:
- `Versions/A/Metal`, SHA256 `b9b6fd7ee445b0060c8dbbdd878b5a3f6f5d172865432fa4302f72f6bdb41c2f`;
- `Versions/A/MetalOld.dylib`, SHA256 `5ba827f9c3c5d0018222d615e7118e1e8db511ba0ea66e8b4df7f4b50a9107db`.

Against the on-disk Tahoe manifest both appear donor-only only because Tahoe's native Metal executable is cache-resident. Installing donor `Versions/A/Metal` creates an on-disk image at the canonical path and therefore shadows the native shared-cache Metal image.

The donor `Versions/A/Metal` is a small reexport shim that reexports `MetalOld.dylib`; it removes the Tahoe Metal4 surface from the installed-root resolution path. This exactly explains D97BK.

Classification:
`D97BL_13_2_1_24_METAL_AND_METALOLD_INSTALL=FORBIDDEN_TAHOE_NATIVE_CACHE_SHADOW`.

## Legacy private compiler payload closure
### 3802 lane
`12.7.6-3802/MTLCompiler.framework/Versions/3802/MTLCompiler`:
- SHA256 `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- links to GPUCompiler `Versions/3802` libraries;
- links to canonical `/System/Library/Frameworks/Metal.framework/Versions/A/Metal` with compatibility version `1.0.0`.

### 32023 lane
`14.2 Beta 1/MTLCompiler.framework/Versions/32023/MTLCompiler`:
- SHA256 `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- links to GPUCompiler `Versions/32023` libraries and `libMTLCompilerHelper.dylib`;
- links to canonical Metal with compatibility version `1.0.0`.

These compiler payloads can coexist conceptually with a native Tahoe Metal outer image; exact installed-root/private-framework collision closure remains subject to the D97BM/D97BN static gate before any Root Patch.

## Historical-source closure — important non-repetition rule
The returned historical source proves the earlier Tahoe custom architecture already avoided the full Metal.framework overwrite:
- for Tahoe, `Metal 3802 Common` overwrote only `.../Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc` from `12.5-3802-23`;
- the full `12.5-3802-23/Metal.framework` merge was skipped on Tahoe;
- the full `13.2.1-<xnu>/Metal.framework` merge in Common Extended was also skipped on Tahoe;
- private MTLCompiler/GPUCompiler payloads remained merged;
- exact Tahoe metallib handling was present.

The same historical source contains the accepted compiler adapters:
- P1 legacy service selector bridge;
- P2b request-layout bridge;
- P3 serialized-bitcode path;
- AIR00 0/0 -> internal AIR 2.6 fallback;
- D34 call-site equivalent reset.

Thus a plain return to `native Tahoe Metal + legacy XPC/private compilers + true-five` would substantially reproduce an already-tested historical state that reached MTLCompilerService but did not yield usable GUI. Spending another Root Patch/recovery cycle merely to recreate that state is rejected.

Classification:
`D97BL_PLAIN_TRUE_FIVE_HYBRID_REBOOT_REPETITION=REJECTED_NO_NEW_CAUSAL_INFORMATION`.

## Producer-normalization direction
D97AV previously established that P1 is a downstream compatibility shim and masks an upstream `llvmVersion` producer difference. Preferred architecture, if exact Tahoe producer audit confirms it, is to normalize the Tahoe-native Metal request at the producer boundary and retain the original legacy selector semantics.

Golden producer contract is already closed:
- primary request builder function `0x7FF80D370756..0x7FF80D370C28` on Golden;
- `[ABI arg1/RDI + 0x20]` signed dword -> `llvmVersion`;
- `[ABI arg2/RSI + 0x08]` -> `requestType`;
- `[arg2 + 0x18]` -> timeout;
- `[arg2 + 0x70]` gates sandboxTokens;
- original service selector maps `3802 -> 3802`, `31001 -> 32023`.

D97BL therefore advances to an exact 25G82 native-shared-cache producer audit before designing any installable native-Metal overlay.

## D97BM prepared
Prepared read-only collector:
`OCLP7_D97BM_tahoe_native_metal_producer_and_metal4_audit.sh`.

It will:
1. pin current Tahoe `26.6.2 / 25G82`, unpatched VESA state and native service SHA;
2. parse exact local dyld shared caches without mmap or system mutation;
3. locate exact native Tahoe Metal and IOGPU cache images;
4. hash the exact native Metal `__TEXT`;
5. recover all eight XPC request keys and their Metal-owned RIP-relative xrefs;
6. identify the smallest primary eight-key request-builder cluster;
7. parse Metal `LC_FUNCTION_STARTS` and disassemble the exact containing function(s);
8. back-slice `llvmVersion`, `requestType`, and timeout setter value sources;
9. record exact native `_MTL4*` and IOGPU Metal4 class-string presence from cache-resident image segments;
10. inventory `dyld_shared_cache_util` availability for a later bounded native-image reconstruction method;
11. make no source/system/cache mutation, no Root Patch and no reboot.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.

Run only `OCLP7_D97BM_tahoe_native_metal_producer_and_metal4_audit.sh` and return its generated TXT+JSON ZIP.

After D97BM, compare exact Tahoe producer source/layout against the already-proven Golden producer contract. Only then design a bounded native-Tahoe-Metal producer adapter and a synthetic patch-root closure audit. No Root Patch or accelerated reboot is authorized.