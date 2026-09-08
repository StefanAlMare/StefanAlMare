# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER is the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HC_PRE_REBOOT_AUDIT_PASS_VESA_REBOOT_AUTHORIZED.md`
- commit `c809157e3773a17a149a8cba322bde0fc724c5cb`.

Immediate predecessors:
- D97GS P1-only Root Patch PASS + D97HB tooling false negative checkpoint — `c702ca47f20a036f2201799d05c1723441eb8a88`;
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

Boot-safety baseline for the next boot:
- `-igfxvesa` ACTIVE;
- `#-ocmcd97ez` INERT;
- `-ocmcdiag -ocmcd97bv -ocmcd97eh` retained;
- `ipc_control_port_options=0` retained;
- `-amfipassbeta` retained;
- `igfxfw=2`, `rps-control=1`, Enable Max Pixel Clock Override all OFF;
- no EFI/NVRAM/framebuffer changes.

Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.

## Clean Restore-first sequencing — settled
The user explicitly chose Restore/Revert of the prior D97DX Root Patch first, followed by a VESA reboot, before installing D97GS. This avoided stacking a new Root Patch over the old D97DX snapshot.

D97GY final PASS proved the clean native baseline:
- native Tahoe MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`, UUID `022C1750-8735-389A-A8BA-A8A67F54235D`, arches `x86_64 arm64e`;
- native CoreDisplay metallib SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`, bytes 24128, MTLB;
- Haswell AuxKC Data kexts removed/not loaded;
- corrected local MetallibSupportPkg preserved with 180 metallibs, zero bad magic;
- local corrected CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, bytes 20739;
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

## D97HB tooling false negative
D97HB passed all gates through successful read-only mounting of underlying System volume, then failed only because it invoked nonexistent `/usr/bin/mount` instead of `/sbin/mount`.

Classification:
`D97HB_POST_MOUNT_RESULT=INCONCLUSIVE_TOOLING_FALSE_NEGATIVE`.
No semantic Root Patch failure was demonstrated.

## D97HC — exact pre-reboot audit PASS
D97HC corrected the mount utility path and proved the complete pre-reboot state.

### Current active snapshot before reboot
Still native Tahoe, exactly as expected:
- service SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- CoreDisplay SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`;
- CoreDisplay bytes 24128.

### Official helper
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- Team ID `S74BDJXQMD`;
- codesign PASS.

### Newly patched underlying System volume
Read-only mount proved:
- exact P1 MTLCompilerService SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- bytes 85520;
- P1 postimage `81fe177d0000` at offset `0x3494` PASS;
- metallibs exact 180;
- missing 0;
- different 0;
- patched CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- CoreDisplay bytes 20739, MTLB.

Final classifications:
`D97HC_STATUS=PASS_PRE_REBOOT_AUDIT`
`D97HC_PATCHED_P1=STRUCTURAL_SEMANTIC_PASS_PRE_REBOOT`
`D97HC_PATCHED_METALLIBS=180_OF_180_EXACT`
`D97HC_OFFICIAL_HELPER=RESTORED_PASS`.

## Current method / replay rule
Historical accepted compiler baseline remains:
`P1 + P2b + P3 + AIR00 + D34`.

Current rule: do **not** replay all five blindly. Patch only the earliest measured failed module. P1 is now installed and must be measured at runtime before considering P2b/P3/AIR00/D34.

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

## CURRENT ACTION — SINGLE VESA REBOOT AUTHORIZED
A single reboot is authorized now, **VESA only**.

Keep unchanged:
- `-igfxvesa` active;
- D97EZ inert/commented;
- framebuffer 3/3/3;
- optional iGPU properties OFF;
- no EFI/NVRAM/framebuffer edits.

After reboot, do not accelerate yet. Run only the read-only D97HD active-snapshot audit:
`OCLP-Continuity/artifacts/OCLP7_D97HD_ASUS2_POST_VESA_REBOOT_ACTIVE_SNAPSHOT_AUDIT.sh`
- commit `43dc468dc82293eeb3b4daf1182eaee641715e68`.

D97HD must prove after the VESA reboot:
- active MTLCompilerService exact P1 SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` + exact postimage;
- active corrected metallibs 180/180 exact;
- active CoreDisplay exact `b848d54e... / 20739 / MTLB`;
- AppleIntelFramebufferAzul and AppleIntelHD5000Graphics are installed and loaded;
- official helper still exact;
- VESA remains active and D97EZ remains inert.

No accelerated boot is authorized until D97HD PASS.
