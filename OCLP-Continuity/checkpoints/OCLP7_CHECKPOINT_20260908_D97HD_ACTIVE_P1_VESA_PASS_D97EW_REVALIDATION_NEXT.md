# OCLP7 CHECKPOINT — 2026-09-08 — D97HD ACTIVE P1 VESA PASS / D97EW REVALIDATION NEXT

## Platform
ASUS2 / macOS Tahoe 26.6.2 build 25G82 / Haswell 8086:0412 / SMBIOS MacBookAir6,2.

## Predecessor
D97HC pre-reboot audit proved underlying newly patched System volume contained exact P1 service and corrected metallibs 180/180, while active snapshot remained native Tahoe.

## D97HD post-VESA-reboot active-snapshot audit
D97HD helper identity:
- artifact `OCLP-Continuity/artifacts/OCLP7_D97HD_ASUS2_POST_VESA_REBOOT_ACTIVE_SNAPSHOT_AUDIT.sh`;
- commit `43dc468dc82293eeb3b4daf1182eaee641715e68`;
- blob `7efaeceaab73a22ca47985c53b2b4fe9c49a7c04`.

Live output proved:
- VESA boot args active; D97EZ inert/commented;
- active MTLCompilerService SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- active service bytes `85520`;
- exact P1 postimage at `0x3494`: `81fe177d0000`;
- P1 postimage match PASS;
- local corrected MetallibSupportPkg count `180`;
- active metallib exact `180`, missing `0`, different `0`;
- active CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, bytes `20739`, magic `MTLB`;
- AppleIntelFramebufferAzul and AppleIntelHD5000Graphics installed and loaded;
- loaded kext runtime versions report 18.0.8 with UUIDs `FA074475-16C7-3503-92E0-7BE42DD78F75` and `1BCC06E9-8026-3D04-8750-E563E55583A6`;
- bundle plist short versions displayed 18.8.4; this does not override the loaded-kext runtime version evidence;
- official privileged helper exact SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team ID `S74BDJXQMD`.

Final outputs:
- `D97HD_STATUS=PASS_ACTIVE_SNAPSHOT_VESA`;
- `D97HD_ACTIVE_P1=STRUCTURAL_SEMANTIC_PASS`;
- `D97HD_ACTIVE_METALLIBS=180_OF_180_EXACT`;
- `D97HD_HASWELL_AUXKC=LOADED_PASS`;
- `D97HD_VESA_BOOT=PASS`.

## Classification
`D97HD_ACTIVE_P1_VESA=STRUCTURAL_SEMANTIC_PASS`.

This closes the VESA validation of the P1-only Root Patch. No P2b/P3/AIR00/D34 replay is justified yet.

## Next gate before first accelerated boot
Revalidate the already-designed D97EW persistent IORegistry collector in the current VESA session because it must survive a no-image accelerated boot and VESA recovery.

D97EW authority:
- installer `OCLP-Continuity/artifacts/OCLP7_D97EW_PERSISTENT_IOREG_CAPTURE_INSTALL.sh`;
- pinned commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`;
- output base `/Users/Shared/OCLP-D97EW-Capture`.

Required VESA live-test state before acceleration:
- service present;
- captured_count=0;
- set_id_mode_calls=0;
- route=PASS.

Only after D97EW live revalidation PASS may the first post-P1 accelerated boot be authorized.

## Planned accelerated delta after D97EW PASS
Change only boot-arg activation state:
- `-igfxvesa` -> inert/commented `#-igfxvesa`;
- `#-ocmcd97ez` -> active `-ocmcd97ez`.
Keep unchanged:
- `-ocmcdiag`;
- `-ocmcd97bv`;
- `-ocmcd97eh`;
- framebuffer 3/3/3;
- `igfxfw=2` OFF;
- `rps-control=1` OFF;
- Max Pixel Clock Override OFF;
- `ipc_control_port_options=0` and `-amfipassbeta` preserved.

If accelerated boot has no image, follow permanent VESA recovery rule: hard cycle, restore VESA, boot recovery session, and treat the preceding accelerated boot as authoritative evidence. D97EW output under `/Users/Shared/OCLP-D97EW-Capture` persists across that recovery reboot.
