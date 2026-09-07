# OCLP7 D97FL — exact 25G82 Cryptex dyld shared cache identified / LLDB probe blocked before CoreDisplay lookup

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, x86_64 Haswell 8086:0412

## Input authority
- D97FJ proves the fatal userspace frontier converges on `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState`, with one EXC_BAD_ACCESS path at +599 and one native Metal `validateWithDevice` abort path at +1720.
- D97FK attempted filesystem-static mapping and was inconclusive because Tahoe no longer exposes standalone CoreDisplay/Metal Mach-O files at the legacy framework executable paths.
- Current session remains VESA recovery; no runtime mutation or reboot is authorized.

## D97FL read-only probe evidence
User returned `OCLP7_D97FL_LLDB_20260907_174437.txt`.

System:
- ProductVersion `26.6.2`;
- BuildVersion `25G82`;
- architecture `x86_64`.

LLDB:
- `/Library/Developer/CommandLineTools/usr/bin/lldb`;
- version `lldb-2100.0.17.203`;
- Apple Swift 6.3.3 / clang-2100.1.1.101.

Exact dyld shared-cache family present under Cryptex OS:
`/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h`
with subcaches:
- `.01`;
- `.02`;
- `.03`;
- `.04`;
- `.05`;
- `.06`;
plus `.atlas` and `.map`.

No matching `/System/Library/dyld/dyld_shared_cache_x86_64*` files were found.

Apple extractor bundle exists:
`/usr/lib/dsc_extractor.bundle`

No standalone `dyld_shared_cache_util` or `dyld-shared-cache-extractor` CLI was found by the probe.

## LLDB probe outcome
The shared-cache lookup itself was NOT executed.
LLDB stopped immediately at:
`target create /usr/bin/sleep`
with:
`error: '/usr/bin/sleep' does not exist`

Therefore:
- CoreDisplay was not dlopened;
- image lookup for `GetGPUPassRenderPipelineState` was not attempted;
- no disassembly was produced;
- this is a tooling-target-path blocker, not evidence against LLDB shared-cache symbol access.

## Classification
- `D97FL_EXACT_CRYPTEX_DYLD_CACHE_FAMILY=STATIC_MAPPED`
- `D97FL_DSC_EXTRACTOR_BUNDLE_PRESENT=STATIC_MAPPED`
- `D97FL_LLDB_TOOLCHAIN_PRESENT=PASS`
- `D97FL_CORE_DISPLAY_LLDB_LOOKUP=INCONCLUSIVE_NOT_EXECUTED`
- `D97FL_FATAL_FRONTIER_RECLASSIFICATION=NO_CHANGE`
- `D97FL_RUNTIME_MUTATION=NO`
- `D97FL_REBOOT_AUTHORIZED=NO`

## Current causal frontier
Unchanged from D97FJ:
`successful set_id_mode -> CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState -> native Metal render-pipeline/device validation -> WindowServer fatal failure -> main display offline`.

## Current action
Remain in VESA and retry the LLDB cache probe using the actual local path resolved by `command -v sleep` (expected conventional `/bin/sleep`) rather than hardcoded `/usr/bin/sleep`.

The retry must:
1. verify the resolved target executable exists;
2. launch stopped at entry;
3. call `dlopen` on the CoreDisplay install-name path so dyld can resolve the cache-resident image;
4. list loaded images;
5. lookup `GetGPUPassRenderPipelineState`;
6. disassemble it if symbol access succeeds.

Do not extract the whole shared cache unless this corrected LLDB path also fails. No EFI, Root Patch, framebuffer, NVRAM, bootarg or reboot change is authorized.