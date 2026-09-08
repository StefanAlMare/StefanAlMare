# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER is the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HD_ACTIVE_SNAPSHOT_PASS_D97EW_LIVE_GATE_PASS_ACCELERATION_AUTHORIZED.md`
- commit `f5c342197210248a47469a7e6ec709c26ab66e9c`.

Immediate predecessors:
- D97HD active P1 snapshot VESA PASS — checkpoint `f2c484266737c2adc9163f1d58a6fcc49c36cd78`;
- D97HC pre-reboot patched-volume audit PASS — `c809157e3773a17a149a8cba322bde0fc724c5cb`;
- D97GS P1-only Root Patch PASS + D97HB tooling false negative — `c702ca47f20a036f2201799d05c1723441eb8a88`;
- D97GY clean post-Restore baseline PASS / D97GS reauthorized — `dd4fcfd0b37f858b60c6c30ddcc1ba5b3645b63a`;
- D97HA official helper restoration PASS — `132bba39a18c8658c8948b73b7776cc9510c46a5`;
- D97GZ exact official helper source locator PASS — `741ddb3f82136f2df0b92b807786f6740a8d4124`;
- D97GV independent D97GS artifact audit PASS — `72812a82b3a94bfe0dd42c55401834e97d237ffb`;
- D97GS P1-only build PASS — `bfbb78a8acb75bf4b06ebda31fb130924e137cfc`;
- D97GR exact historical P1 reconstruction PASS / NULL-call cause causally closed — `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`;
- D97GP current service pre-P1 / 32023 compiler exports PASS — `eec9dfd358f77130bfe87510bd3fee97d163a412`;
- D97GN 12/12 MTLCompilerService NULL indirect-call frontier — `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`;
- D97GM corrected-metallib semantic progress — `b28469abf0363ab7f0877b63c22465c1694d41b6`.

## Current ASUS2 authority
Target:
- macOS Tahoe `26.6.2 / 25G82`, x86_64;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- normal framebuffer baseline 3/3/3.

Live VESA state now proven:
- active MTLCompilerService exact P1 SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- active P1 postimage at `0x3494` = `81fe177d0000` PASS;
- corrected metallibs active exact 180/180, missing 0, different 0;
- active CoreDisplay exact SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, bytes 20739, MTLB;
- AppleIntelFramebufferAzul and AppleIntelHD5000Graphics installed and loaded;
- official helper exact SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team ID `S74BDJXQMD`;
- D97EW persistent collector installed and live-tested PASS.

Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.

## Clean Restore-first sequencing — settled
The user explicitly chose Restore/Revert of the prior D97DX Root Patch first, followed by a VESA reboot, before installing D97GS. This avoided stacking a new Root Patch over the old D97DX snapshot.

D97GY final PASS proved the clean native baseline:
- native Tahoe MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`, UUID `022C1750-8735-389A-A8BA-A8A67F54235D`, arches `x86_64 arm64e`;
- native CoreDisplay metallib SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`, bytes 24128, MTLB;
- Haswell AuxKC Data kexts removed/not loaded;
- corrected local MetallibSupportPkg preserved with 180 metallibs, zero bad magic;
- official helper exact SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`, Team ID `S74BDJXQMD`.

Classification:
`D97GY_RESTORE_REBOOT=STRUCTURAL_SEMANTIC_PASS`.

## D97GS exact P1-only artifact authority
Exact audited D97GS artifact:
- ZIP SHA256 `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`;
- ZIP bytes `722879148`;
- source diff SHA256 `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- inner x86_64 SHA256 `5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e`;
- launcher SHA256 `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c`;
- DEBUG helper SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- all four D97DX base source sections byte-identical;
- only new functional source section is additive `sys_patch.py` P1 hook;
- no P2b/P3/AIR00/D34 replay.

P1 contract:
- legacy service pre-SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- unique preimage `81fe19790000` at offset `0x3494`;
- postimage `81fe177d0000`;
- only bytes `0x3496` and `0x3497` change;
- exact post-SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

## D97GS manual Root Patch — PASS
On the clean restored base, manual D97GS Root Patch completed successfully.

Transcript proved:
- exact local 25G82 MetallibSupportPkg selected;
- Metal 3802 Common / Common Extended installed;
- corrected `.metallibs` patchset installed;
- Monterey GVA/OpenCL installed;
- Intel Haswell patchset installed;
- Modern Wireless patchset installed;
- D97GS exact P1 hook reached;
- exact P1 historical identity PASS with SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- Auxiliary Kernel Collection rebuilt;
- `Patching complete` reached.

Classification:
`D97GS_P1_ROOTPATCH=PASS`.

## D97HC — exact pre-reboot audit PASS
D97HC proved the complete newly patched underlying System volume before reboot:
- exact P1 service SHA `a8716ffd...`;
- bytes 85520;
- P1 postimage `81fe177d0000` at offset `0x3494` PASS;
- metallibs exact 180, missing 0, different 0;
- patched CoreDisplay exact `b848d54e... / 20739 / MTLB`;
- official helper exact.

Classification:
`D97HC_PATCHED_P1=STRUCTURAL_SEMANTIC_PASS_PRE_REBOOT`.

## D97HD — live active-snapshot VESA PASS
After the authorized VESA reboot, D97HD proved the new snapshot is live exactly as intended:
- bootargs still VESA with D97EZ inert;
- active service exact P1 SHA `a8716ffd...`;
- active postimage exact;
- active metallibs 180/180 exact;
- active CoreDisplay exact `b848d54e... / 20739 / MTLB`;
- Haswell Azul + HD5000Graphics installed and loaded;
- official helper exact.

Final classifications:
`D97HD_STATUS=PASS_ACTIVE_SNAPSHOT_VESA`
`D97HD_ACTIVE_P1=STRUCTURAL_SEMANTIC_PASS`
`D97HD_ACTIVE_METALLIBS=180_OF_180_EXACT`
`D97HD_HASWELL_AUXKC=LOADED_PASS`
`D97HD_VESA_BOOT=PASS`.

## D97EW — persistent capture live gate PASS
Exact D97EW source authority:
- commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- Git blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`.

Current revalidation:
- installer `D97EW_INSTALL_STATUS=PASS`;
- LaunchDaemon `com.oclp.d97ew.capture` running;
- active run `/Users/Shared/OCLP-D97EW-Capture/20260908T003113Z-2712`;
- repeated ticks prove service `present`, captured_count `0`, set_id_mode_calls `0`, route `PASS`;
- live IORegistry proves `D97ELRouteStatus=PASS`, `D97ESCapturedCount=0`, `D97ELSetIdModeCallCount=0`.

Classification:
`D97EW_LIVE_VESA_GATE=PASS`
`D97EW_PERSISTENT_CAPTURE=READY_FOR_ACCELERATED_BOOT`.

## Current method / replay rule
Historical accepted compiler baseline remains:
`P1 + P2b + P3 + AIR00 + D34`.

Current rule: do **not** replay all five blindly. P1 is now live and the next accelerated runtime evidence must determine whether P2b or another module is required. P2b/P3/AIR00/D34 remain forbidden until measured necessity.

Evidence vocabulary:
REACHED / CONTROL-FLOW PROVEN / SEMANTIC PROVEN / STRUCTURAL-SEMANTIC PROVEN / STATIC-MAPPED-PROVEN / NEGATIVE / INCONCLUSIVE / UNKNOWN.

Durable architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy compiler ingress -> audited adapter(s) -> legacy compiler path -> Haswell driver -> image`.

Permanent prohibitions:
- no legacy main Metal shadow / MetalOld;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no wholesale true-five replay without measured necessity;
- no global `set_id_mode` mask;
- preserve `ipc_control_port_options=0` and `-amfipassbeta`;
- no unrelated T2/Haswell boot-variable experiments;
- Golden Sequoia immutable/read-only.

## Settled causal facts retained
- D97BV/D97DT selective true-3802 ingress CLOSED PASS.
- D97EZ exact `0x224 -> 0x24` adapter CLOSED PASS; corrected ACCEL2 proved 58/58 set_id_mode successes.
- systemic old metallib stub defect corrected; corrected local source is exact 180/180.
- D97GM proved corrected real metallibs produced semantic progress and moved the frontier from native Metal validation abort to MTLCompilerService death.
- D97GN: 12/12 crashes `RIP=0`, `r15=32023`, return frame `MTLConnectionCtx+56 / 0x3448`.
- D97GP: legacy service selected 31001 while runtime request is 32023; exact MTLCompiler 32023 exports all required MTLCodeGenService symbols.
- D97GR: exact two-byte P1 reconstruction gives historical SHA `a8716ffd...`; NULL-call cause causally closed.

## CURRENT ACTION — FIRST POST-P1 ACCELERATED BOOT AUTHORIZED
Accelerated boot is authorized now with **exactly two boot-arg state changes**:
- make `-igfxvesa` inert/commented;
- activate `-ocmcd97ez`.

Keep unchanged:
- `-ocmcdiag` active;
- `-ocmcd97bv` active;
- `-ocmcd97eh` active;
- framebuffer 3/3/3;
- `igfxfw=2` OFF;
- `rps-control=1` OFF;
- Max Pixel Clock Override OFF;
- no Root Patch/Restore;
- no other EFI/NVRAM/device-property changes.

Expected bootargs:
`-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 #-igfxvesa -ocmcdiag #-ocmcd97bvcave -ocmcd97bv -ocmcd97eh -ocmcd97ez`

If accelerated boot has no image, apply the permanent recovery rule: hard cycle, restore VESA (`-igfxvesa` active, D97EZ inert), boot VESA, and analyze the immediately preceding accelerated boot using persistent D97EW evidence. Never classify the recovery boot as the failed accelerated boot.
