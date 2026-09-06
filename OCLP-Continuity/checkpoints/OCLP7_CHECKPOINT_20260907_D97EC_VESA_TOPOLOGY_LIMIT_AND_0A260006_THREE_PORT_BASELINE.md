# OCLP7 CHECKPOINT — D97EC VESA topology limit; 0x0A260006 three-port baseline confirmed

Date: 2026-09-07 EEST

## Entering state
- ASUS2 Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.
- D97DX native-Metal-safe Root Patch installed.
- First accelerated boot failed through repeated WindowServer SIGSEGV during CoreDisplay/IOAccelerator display initialization; user recovered in VESA.
- D97EB closed kernel panic / legacy-main-Metal / pre-WindowServer MTLCompilerService as immediate failure classes and moved frontier to Tahoe CoreDisplay/WindowServer <-> legacy Haswell framebuffer/IOAccelerator semantics.

## D97EC returned VESA topology
Returned file: `OCLP7_D97EC_FRAMEBUFFER_TOPOLOGY.txt`
SHA256: `aa25e053f10bd6190685f8edd54760b986e1320616f0aaa93002f60b8aec70d6`

Current VESA IORegistry proves:
- IGPU visible as Intel HD Graphics 4400, PCI device-id 0x0412;
- WhateverGreen semantic framebuffer patching properties are injected:
  - framebuffer-patch-enable = 1;
  - framebuffer-con2-enable = 1;
  - framebuffer-con2-type = 0x00000800 (HDMI);
  - framebuffer-cursormem = 0x00900000 encoded as `00009000`;
- AAPL,ig-platform-id appears as `ffffffff` in VESA, as expected from `-igfxvesa` runtime suppression;
- only `IONDRVFramebuffer/.Display_boot` is attached in VESA;
- no `AppleIntelFramebuffer@0/@1/@2` and no live `AppleIntelFramebufferAzul` class nodes exist in VESA;
- one internal `IODisplayConnect/display0` is present at 1366x768.

Therefore VESA IORegistry CANNOT reveal the live accelerated AppleIntelFramebuffer topology. Empty AppleIntelFramebuffer sections are an expected methodological limit, not evidence that accelerated framebuffer registration is absent.

## Static EFI baseline recovered
The project baseline config whose IGPU DeviceProperties match D97EC runtime-injected properties has:
- AAPL,ig-platform-id = `0600260a` = 0x0A260006;
- device-id = `12040000` = 0x0412;
- framebuffer-con2-enable = 1;
- framebuffer-con2-type = `00080000` = HDMI;
- framebuffer-cursormem = `00009000`;
- framebuffer-patch-enable = 1;
- enable-max-pixel-clock-override = 1;
- igfxfw = 2;
- rps-control = 1.

WhateverGreen's documented Azul table defines 0x0A260006 as a mobile Haswell framebuffer with:
- PipeCount = 3;
- PortCount = 3;
- FBMemoryCount = 3;
- connector 0: LVDS, bus 0x00, pipe 8;
- connector 1: DP, bus 0x05, pipe 9;
- connector 2: DP, bus 0x04, pipe 9.
The project override changes connector 2 type to HDMI only.

Therefore the accelerated D97EB observation `GPU: FB: 3 of 3 opened` is EXPECTED for platform 0x0A260006 and is not, by itself, evidence of malformed EFI topology.

## D97EB refined interpretation
D97EB repeated twice:
1. FB1 receives a valid 1366x768 mode;
2. FB2 and FB3 receive mode 0/depth 0, fail IOFBGetDisplayModeInformation, and produce `capabilities with no devices`;
3. CoreDisplay reports `GPU: FB: 3 of 3 opened`;
4. IOAcceleratorFamily2 reports four `Surface mode contains bad bits` messages;
5. CoreDisplay reports `Setting offline display 0x00000000 main in AddCGXDisplayDeviceToDeviceList`;
6. WindowServer exits by SIGSEGV (namespace=2/code=11), is respawned, and repeats the same failure sequence.

Since 3 FBs are normal for 0x0A260006, the causal frontier is narrowed further to Tahoe CoreDisplay handling of inactive/offline legacy Haswell framebuffer/display semantics, not simple accidental extra connector creation.

## Classification
- `D97EC_VESA_LIVE_AZUL_TOPOLOGY=UNOBSERVABLE_BY_DESIGN`
- `D97EC_IGPU_STATIC_BASELINE=0x0A260006`
- `D97EC_0A260006_EXPECTED_PORTCOUNT=3`
- `D97EC_D97EB_THREE_FB_COUNT=MATCHES_PLATFORM_BASELINE`
- `D97EC_SIMPLE_MALFORMED_CONNECTOR_COUNT=NOT_PROVEN`
- `D97EC_COREDISPLAY_OFFLINE_DISPLAY_FRONTIER=ACTIVE`

## Next bounded experiment candidate
Do NOT repeat the same accelerated boot unchanged.
A high-value one-variable diagnostic is to keep 0x0A260006 and all existing connector bytes, but temporarily reduce the logical framebuffer count vector from 3/3/3 to 1/1/1 using WhateverGreen semantic overrides:
- framebuffer-pipecount = 1;
- framebuffer-portcount = 1;
- framebuffer-memorycount = 1.
This preserves connector 0 (internal LVDS) and tests whether Tahoe WindowServer/CoreDisplay survives when inactive external FB1/FB2 are no longer enumerated. It is diagnostic only, reversible, and would provide new causal information.

Before applying, current active EFI DeviceProperties should be re-read/pinned to ensure no drift from the known baseline. No Root Patch repetition is required.

Still forbidden:
- unchanged accelerated reboot repetition;
- legacy main Metal shadow;
- true-five reapplication;
- global LLVM forcing;
- Golden mutation.
