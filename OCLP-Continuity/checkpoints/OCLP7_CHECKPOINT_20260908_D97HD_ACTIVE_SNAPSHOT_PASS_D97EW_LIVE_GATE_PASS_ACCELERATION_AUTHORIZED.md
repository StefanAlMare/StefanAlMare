# OCLP7 CHECKPOINT — 2026-09-08 — D97HD ACTIVE-SNAPSHOT PASS / D97EW LIVE-GATE PASS / ACCELERATION AUTHORIZED

## Platform
ASUS2 / macOS Tahoe 26.6.2 build 25G82 / Haswell 8086:0412 / SMBIOS MacBookAir6,2.

## D97HD active snapshot VESA PASS
After clean Restore-first sequencing, D97GS P1-only Root Patch, pre-reboot D97HC PASS and VESA reboot, D97HD proved the live active snapshot is exact:
- boot remains VESA; D97EZ inert;
- active MTLCompilerService SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- active P1 postimage at 0x3494 `81fe177d0000` PASS;
- corrected metallibs exact 180/180, missing 0, different 0;
- active CoreDisplay exact SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, bytes 20739, MTLB;
- AppleIntelFramebufferAzul and AppleIntelHD5000Graphics installed and loaded;
- official helper exact SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team ID `S74BDJXQMD`.

Classification:
`D97HD_STATUS=PASS_ACTIVE_SNAPSHOT_VESA`
`D97HD_ACTIVE_P1=STRUCTURAL_SEMANTIC_PASS`
`D97HD_ACTIVE_METALLIBS=180_OF_180_EXACT`
`D97HD_HASWELL_AUXKC=LOADED_PASS`
`D97HD_VESA_BOOT=PASS`.

## D97EW persistent capture revalidation PASS
D97EW exact installer identity:
- source commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- Git blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`.

Reinstallation/revalidation output:
- `D97EW_INSTALL_STATUS=PASS`;
- capture script SHA256 `bc818d5b26f337404945c5118b34d264505351ea0ca307f760c24e6a3260b017`;
- plist SHA256 `a2b5f2ed8d0c2c0ee49b437dffdf04e82f155cb2e20eea32b8d93b67d2881280`;
- LaunchDaemon `com.oclp.d97ew.capture` running, PID 2712;
- active run `/Users/Shared/OCLP-D97EW-Capture/20260908T003113Z-2712`.

Live VESA gate, ticks 18..27 repeatedly exact:
- service `present`;
- captured_count `0`;
- set_id_mode_calls `0`;
- route `PASS`.

Live IORegistry exact:
- `D97ELRouteStatus = PASS`;
- `D97ESCapturedCount = 0`;
- `D97ELSetIdModeCallCount = 0`.

Classification:
`D97EW_LIVE_VESA_GATE=PASS`
`D97EW_PERSISTENT_CAPTURE=READY_FOR_ACCELERATED_BOOT`.

## First post-P1 accelerated boot authorization
Accelerated boot is now authorized with only the intended boot-arg delta:
- `-igfxvesa` -> inert/commented;
- `#-ocmcd97ez` -> active `-ocmcd97ez`.

Keep unchanged:
- `-ocmcdiag` active;
- `-ocmcd97bv` active;
- `-ocmcd97eh` active;
- framebuffer baseline 3/3/3;
- `igfxfw=2` OFF;
- `rps-control=1` OFF;
- Max Pixel Clock Override OFF;
- no Root Patch/Restore;
- no other EFI/NVRAM/device-property changes.

Expected accelerated bootargs:
`-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 #-igfxvesa -ocmcdiag #-ocmcd97bvcave -ocmcd97bv -ocmcd97eh -ocmcd97ez`

## Recovery rule
If accelerated boot has no image:
1. hard cycle;
2. restore VESA by reactivating `-igfxvesa` and making D97EZ inert again;
3. boot VESA recovery;
4. do not classify the VESA recovery boot as the failed accelerated boot;
5. authoritative evidence is the immediately preceding accelerated boot, including D97EW persistent evidence under `/Users/Shared/OCLP-D97EW-Capture`.

The measured post-P1 accelerated runtime frontier must determine whether P2b or another module is next. Do not replay P2b/P3/AIR00/D34 until runtime evidence requires it.
