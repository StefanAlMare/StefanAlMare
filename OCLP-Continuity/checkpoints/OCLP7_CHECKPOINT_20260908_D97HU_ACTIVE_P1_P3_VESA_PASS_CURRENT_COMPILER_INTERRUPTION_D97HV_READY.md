# OCLP7 CHECKPOINT — 2026-09-08 — D97HU ACTIVE P1+P3 VESA PASS / CURRENT COMPILER INTERRUPTION / D97HV READY

## D97HU active snapshot — FULL PASS
User ran exact `OCLP7_D97HU_ASUS2_POST_VESA_REBOOT_ACTIVE_P1_P3_AUDIT.sh` after the authorized VESA reboot.

Environment:
- macOS `26.6.2 / 25G82`;
- `-igfxvesa` active;
- D97EZ inert;
- no EFI/NVRAM/framebuffer changes.

Active P1:
- `MTLCompilerService` SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- bytes `85520`;
- postimage `81fe177d0000 @ 0x3494` PASS.

Active P3-only MTLCompiler 32023:
- SHA256 `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- bytes `1636896`;
- UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- P2 remains exact original `418b81d0000000 @ 0x9A8CD` — no P2b;
- P3 exact postimage `81c900002000 @ 0xA1573`.

Active metallib layer:
- local source count `180`;
- active exact `180`, missing `0`, different `0`;
- CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, bytes `20739`, magic `MTLB`.

Haswell / AuxKC:
- Azul and HD5000 both present in AuxKC;
- `kmutil check --collection aux --load-info` RC `0`;
- in this VESA boot both are reported `loaded=1`, `unloaded=0`;
- IOKit counts: `IntelAccelerator=1`, `IntelFramebuffer=1`, `display0=2`, `AppleBacklight=4`.

Permanent interpretation: loaded/unloaded and IOKit state under `-igfxvesa` are INFORMATIONAL, not a gate. D97HQ previously proved the same VESA policy can have both Haswell kexts explicitly unloaded; D97HU proves they may also be loaded while VESA remains active. Therefore `-igfxvesa` must not be equated with kernel absence of the Haswell stack.

Official helper:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- Team `S74BDJXQMD`;
- PASS.

D97HO artifact remains exact:
- ZIP SHA256 `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- bytes `722975756`.

Final D97HU classification:
`D97HU_STATUS=PASS_ACTIVE_P1_P3_VESA`
`D97HU_CLASSIFICATION=STRUCTURAL_SEMANTIC_PASS_ACTIVE_SNAPSHOT`
`D97HU_ACTIVE_P1=EXACT`
`D97HU_ACTIVE_P3=EXACT_P3_ONLY`
`D97HU_P2B_REPLAY=NO`
`D97HU_AIR00_REPLAY=NO`
`D97HU_D34_REPLAY=NO`
`D97HU_ACTIVE_METALLIBS=180_OF_180_EXACT`.

Report:
`/Users/alex/Desktop/OCLP7_D97HU_POST_VESA_ACTIVE_P1_P3_20260908_144116/D97HU_REPORT.txt`.

## Current-boot WindowServer compiler interruption — free runtime evidence
In the SAME current VESA boot, WindowServer launched `2026-09-08 14:25:56.6519 +0300` and crashed `14:26:07.0357 +0300`.

Observed:
- WindowServer 600.00, MacBookAir6,2, 25G82;
- COREANIMATION code 4;
- `spec=PBGRAXb_Xc`;
- `Compilation failed due to an interrupted connection: XPC_ERROR_CONNECTION_INTERRUPTED` after multiple retries;
- crash path includes `CA::OGL::MetalContext::create_pipeline_state(...)+6896` and SkyLight Metal compositor;
- loaded images include GPUCompiler 32023 libraries and `AppleIntelHD5000GraphicsMTLDriver`.

Classification:
- Metal compositor compiler path `REACHED`;
- XPC interruption `CONTROL-FLOW PROVEN`;
- this is NOT an accelerated test because `-igfxvesa` is active;
- exact semantic effect of P3 remains `UNKNOWN` until the current-boot MTLCompilerService IPS frontier is inspected.

## D97HV — current action before D97EW
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HV_CURRENT_P1_P3_VESA_COMPILER_FRONTIER_COLLECTOR.sh`
- creation commit `01de20bcaff4f916183dd8144216bc7a660d3c28`;
- exact git blob `491a73071449a130bc1fdc4d48ad946e51d22ec0`;
- bytes `12224`.

D97HV is read-only with respect to Root Patch/Restore/EFI/NVRAM/framebuffer and does not reboot or accelerate. It writes evidence only to Desktop.

It verifies current P1+P3 identities, binds to the current boot from `kern.boottime`, copies only current-boot `MTLCompilerService` and `WindowServer` IPS reports, and classifies:
- old startup NULL-call signature;
- post-P1 `StringMapImpl/collectUsedGlobalVariables/getOrInsertNamedMetadata/addMsaaPositionInfo/MTLCompilerBuildRequestWithOptions` family;
- backend compile path;
- `MTLSimCompiler::validSimulatorMetadata`;
- current WindowServer XPC/pipeline state;
- unified log for the same boot.

Possible D97HV P3 runtime classifications:
- `P3_MOVED_POST_P1_STRINGMAP_FRONTIER`;
- `P3_DID_NOT_MOVE_POST_P1_STRINGMAP_FRONTIER`;
- `P3_MIXED_CURRENT_BOOT_FRONTIER`;
- `INCONCLUSIVE_NO_MTL_IPS_CURRENT_BOOT`.

## Current execution rule
Do NOT reboot.
Do NOT change boot-args.
Do NOT accelerate.
Do NOT run D97EW yet.
Run exact D97HV first and review its output/evidence. Only after D97HV classification do we revalidate/repair D97EW and decide whether to authorize the first accelerated P1+P3 boot.
