# OCLP7 D97FK — static dump method INCONCLUSIVE / dyld shared cache extraction required

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, MacBookAir6,2

## Input authority
- D97FH closed the measured `IOAccelSurface::set_id_mode` bad-bits rejection with exact `0x224 -> 0x24` adaptation.
- D97FI localized the next downstream failure to CoreDisplay / framebuffer metadata / device construction.
- Existing WindowServer `.ips` analysis identified the common fatal function as `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState`.

## D97FK collection result
User collected and returned:
`OCLP7_D97FK_COREDISPLAY_STATIC_20260907_173623.zip`.

The requested standalone paths for Tahoe system frameworks do not exist:
- `/System/Library/Frameworks/CoreDisplay.framework/Versions/A/CoreDisplay` -> No such file;
- `/System/Library/Frameworks/Metal.framework/Versions/A/Metal` -> No such file.

Therefore all attempted CoreDisplay standalone `nm`, `otool`, `llvm-objdump`, Objective-C and strings outputs contain only file-not-found errors and no usable code or metadata.

The Haswell driver does exist standalone and was identified successfully:
- `/System/Library/Extensions/AppleIntelHD5000GraphicsMTLDriver.bundle/Contents/MacOS/AppleIntelHD5000GraphicsMTLDriver`;
- Mach-O x86_64;
- UUID `D5CF0007-37A7-35CF-BB5E-A6BAAA145AD2`;
- SHA256 `7fa9e4d882916d7bff700cf23b4be62cfb82c1dbf92b5482b231b6c23657df42`.

## Interpretation
The failure of this collection is methodological, not a negative result about CoreDisplay or Metal.

On modern macOS, system frameworks such as CoreDisplay/Metal may be represented through the dyld shared cache rather than as ordinary standalone Mach-O files. Consequently the exact Tahoe 25G82 images must be extracted from the active x86_64 dyld shared cache before static disassembly/mapping.

Classification:
- `D97FK_COREDISPLAY_STANDALONE_PATH=ABSENT`
- `D97FK_METAL_STANDALONE_PATH=ABSENT`
- `D97FK_CORE_STATIC_DUMP=INCONCLUSIVE_METHOD`
- `D97FK_HASWELL_DRIVER_IDENTITY=PASS`
- `D97FK_DYLD_CACHE_EXTRACTION_REQUIRED=YES`
- `D97FK_RUNTIME_REBOOT_AUTHORIZED=NO`
- `D97FK_EFI_ROOTPATCH_BOOTARG_CHANGE_AUTHORIZED=NO`

Do not treat empty/error-only CoreDisplay dump files as evidence against the `GetGPUPassRenderPipelineState` frontier.

## Current action
Remain in VESA. Perform only read-only discovery/extraction of exact Tahoe 25G82 x86_64 dyld shared cache images for CoreDisplay and Metal. No reboot, EFI modification, Root Patch, framebuffer change, or bootarg change.
