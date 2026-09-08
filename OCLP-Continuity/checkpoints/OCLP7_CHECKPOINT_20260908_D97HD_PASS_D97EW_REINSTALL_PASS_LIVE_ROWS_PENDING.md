# OCLP7 CHECKPOINT — 2026-09-08 — D97HD PASS / D97EW REINSTALL PASS / LIVE ROWS PENDING

## Current ASUS2 state
- Tahoe 26.6.2 / 25G82, x86_64, Haswell 8086:0412, SMBIOS MacBookAir6,2.
- Active snapshot in VESA is exact D97GS P1 state.
- D97HD returned full PASS:
  - active MTLCompilerService SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
  - P1 postimage `81fe177d0000` at 0x3494 PASS;
  - active corrected metallibs 180/180 exact, missing 0, different 0;
  - active CoreDisplay exact `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, bytes 20739, MTLB;
  - Haswell Azul/HD5000 kexts installed and loaded;
  - official OCLP privileged helper exact.

Classification:
`D97HD_STATUS=PASS_ACTIVE_SNAPSHOT_VESA`.

## D97EW reinstall/live safety net
Exact D97EW installer authority:
- commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`.

Current reinstall output:
- plist lint OK;
- `D97EW_INSTALL_STATUS=PASS`;
- capture SHA256 `bc818d5b26f337404945c5118b34d264505351ea0ca307f760c24e6a3260b017`;
- plist SHA256 `a2b5f2ed8d0c2c0ee49b437dffdf04e82f155cb2e20eea32b8d93b67d2881280`;
- output base `/Users/Shared/OCLP-D97EW-Capture`;
- launchd label `com.oclp.d97ew.capture`;
- no reboot / EFI mutation / Root Patch.
- installer printed latest run path `/Users/Shared/OCLP-D97EW-Capture/20260908T003113Z-2712` but did not print summary.tsv rows.

Interpretation:
- installation itself PASS;
- live semantic gate (`service`, `captured_count`, `set_id_mode_calls`, `route`) not yet proven from this invocation because the summary rows were absent from stdout;
- likely benign RunAtLoad + kickstart race, but do not infer PASS without reading the newest run directly.

## Current authorization
Accelerated boot remains NOT YET AUTHORIZED until the newest D97EW run is read and proves the expected VESA idle state:
- service present;
- captured_count 0;
- set_id_mode_calls 0;
- route PASS.

After that PASS only, authorize one accelerated boot with:
- `-igfxvesa` disabled/inert;
- `-ocmcd97ez` active;
- optional iGPU properties all OFF;
- framebuffer 3/3/3 unchanged.
