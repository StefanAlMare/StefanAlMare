# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER is the current execution/causal authority. If older current-action wording conflicts, this file and its current checkpoint win.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HE_POST_P1_ACCEL_NO_GUI_VESA_RECOVERY_FRONTIER_PENDING.md`
- commit `52125fed156f25c9f08ef611e7876793eab5e42a`.

Immediate predecessors:
- D97HD active P1 snapshot VESA PASS + D97EW live capture gate PASS / acceleration authorized — `f5c342197210248a47469a7e6ec709c26ab66e9c`;
- D97HC exact pre-reboot patched-volume audit PASS — `c809157e3773a17a149a8cba322bde0fc724c5cb`;
- D97GS P1-only Root Patch PASS / D97HB tooling false negative — `c702ca47f20a036f2201799d05c1723441eb8a88`;
- D97GY clean post-Restore baseline PASS — `dd4fcfd0b37f858b60c6c30ddcc1ba5b3645b63a`;
- D97HA official helper restoration PASS — `132bba39a18c8658c8948b73b7776cc9510c46a5`;
- D97GV independent D97GS artifact audit PASS — `72812a82b3a94bfe0dd42c55401834e97d237ffb`;
- D97GR exact historical P1 reconstruction PASS / startup NULL-call cause causally closed — `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`;
- D97GN old 12/12 MTLCompilerService NULL-call frontier — `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`;
- D97GM corrected-metallib semantic progress — `b28469abf0363ab7f0877b63c22465c1694d41b6`.

## Target
- macOS Tahoe `26.6.2 / 25G82`, x86_64;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- stable hardware-accelerated usable GUI;
- normal framebuffer baseline 3/3/3.

Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.

## Durable architecture / method
Required architecture:
`Tahoe-native Metal / Metal4 ABI -> selective legacy compiler ingress -> audited adapter(s) -> legacy compiler/backend -> Haswell driver -> image`.

Historical accepted compiler baseline remains:
`P1 + P2b + P3 + AIR00 + D34`.

Current rule: do **not** replay all five blindly. Patch only the earliest measured failed module. P1 is now installed and live; runtime evidence must identify the new frontier before P2b/P3/AIR00/D34 can return.

Evidence vocabulary:
REACHED / CONTROL-FLOW PROVEN / SEMANTIC PROVEN / STRUCTURAL-SEMANTIC PROVEN / STATIC-MAPPED-PROVEN / NEGATIVE / INCONCLUSIVE / UNKNOWN.

Permanent prohibitions:
- no legacy main Metal shadow / MetalOld;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no wholesale true-five replay without measured necessity;
- no global `set_id_mode` mask;
- preserve `ipc_control_port_options=0` and `-amfipassbeta`;
- no unrelated T2/Haswell boot-variable experiments;
- Golden Sequoia immutable/read-only.

## Settled foundational facts
### Selective 3802 / set_id_mode
- D97BV/D97DT selective true-3802 ingress CLOSED PASS.
- D97EZ exact `0x224 -> 0x24` adapter CLOSED PASS; corrected ACCEL2 previously proved 58/58 set_id_mode successes.

### Metallib repair
Old 25G82 local/installed dynamic metallibs were metadata stubs. Exact corrected local source is 180 real metallibs.
Corrected CoreDisplay metallib:
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- bytes `20739`;
- magic `MTLB`.

D97GM proved corrected real metallibs moved the fatal frontier from old native Metal validation aborts to MTLCompilerService failure.

### Old pre-P1 compiler failure
D97GN old accelerated evidence: 12/12 MTLCompilerService crashes converged on:
- RIP=0;
- r15=32023;
- return frame `MTLConnectionCtx::MTLConnectionCtx(int)+56`, image offset `0x3448`.

D97GP/D97GR proved cause: legacy MTLCompilerService selector compared 31001 while runtime requested 32023. Exact P1 changes only bytes 0x3496/0x3497, producing selector compare 32023 and historical post-SHA:
`a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

Classification:
`OLD_MTLCOMPILERSERVICE_NULL_CALL_CAUSE=MISSING_P1_SELECTOR_BRIDGE_CAUSALLY_CLOSED`.

## Clean Restore-first / D97GS installation closure
User deliberately restored old D97DX Root Patch first and rebooted VESA before D97GS to avoid stacking snapshots.

D97GY clean baseline PASS proved native Tahoe restored, Haswell root-patch kexts absent, corrected local metallib source preserved, official helper exact.

Exact audited D97GS P1-only artifact:
- ZIP SHA256 `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`;
- bytes `722879148`;
- source diff SHA256 `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- inner x86_64 SHA256 `5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e`;
- only new functional source delta is exact P1 hook;
- no P2b/P3/AIR00/D34 replay.

Manual D97GS Root Patch PASS:
- exact local corrected MetallibSupportPkg selected;
- bounded Metal 3802 compiler/private-framework structure installed;
- corrected metallibs installed;
- Monterey GVA/OpenCL installed;
- Haswell patchset installed;
- D97GS P1 hook exact post-SHA PASS;
- AuxKC rebuilt;
- `Patching complete` reached.

D97HC pre-reboot audit PASS proved underlying System exact P1 + 180/180 metallibs.
D97HD post-VESA-reboot audit PASS proved active snapshot exact P1 + 180/180 metallibs + Haswell kexts loaded + official helper exact.

## D97EW persistent capture gate
D97EW LaunchDaemon is installed on Data volume and is independent of WindowServer.
Live VESA revalidation immediately before accelerated boot:
- service `present`;
- `captured_count=0`;
- `set_id_mode_calls=0`;
- `route=PASS`;
- LaunchDaemon running.

Thus persistent accelerated-boot evidence capture was ready before the test.

## Authoritative post-P1 accelerated test
Accelerated boot configuration changed only:
- `-igfxvesa` -> inert/commented;
- `#-ocmcd97ez` -> active `-ocmcd97ez`.

Kept unchanged:
- framebuffer 3/3/3;
- `-ocmcdiag`, `-ocmcd97bv`, `-ocmcd97eh` retained;
- `igfxfw=2` OFF;
- `rps-control=1` OFF;
- Max Pixel Clock Override OFF;
- no Root Patch/Restore or unrelated EFI/NVRAM change.

### Runtime outcome
No usable GUI/image appeared. User followed permanent recovery rule and returned to VESA, with D97EZ inert again.

Classification so far:
`D97HE_ACCEL_BOOT_GUI=NEGATIVE_NO_IMAGE`.

The current VESA recovery boot is **not** authoritative runtime evidence for the failed accelerated boot. The immediately preceding accelerated boot is authoritative.

### WindowServer crash from accelerated boot
User supplied crash report:
- WindowServer 600.00;
- launch `2026-09-08 03:35:27.3200 +0300`;
- crash `2026-09-08 03:35:43.5056 +0300`;
- EXC_CRASH / SIGABRT;
- COREANIMATION code 4;
- `spec=PBGRAXb_Xc`;
- reason: `Compilation failed due to an interrupted connection: XPC_ERROR_CONNECTION_INTERRUPTED. This error occurred after multiple retries.`;
- fatal frame `CA::OGL::MetalContext::create_pipeline_state(...)+6896`;
- compositor path continues through QuartzCore and SkyLight Metal compositor.

WindowServer binary images include GPUCompiler 32023 libraries and `AppleIntelHD5000GraphicsMTLDriver`, proving the accelerated Metal compositor/Haswell user-space corridor was reached.

Classifications:
`D97HE_WINDOWSERVER_METAL_COMPOSITOR=REACHED`
`D97HE_WINDOWSERVER_XPC_INTERRUPTED=PROVEN`.

Crucial distinction: WindowServer is downstream. This report alone cannot determine whether P1 failed or moved MTLCompilerService deeper.

## Current unresolved question
Does the post-P1 accelerated MTLCompilerService still die with the old exact signature:
- RIP=0;
- r15=32023;
- `MTLConnectionCtx::MTLConnectionCtx(int)+56`?

Until MTLCompilerService crash evidence is read:
`D97HE_P1_RUNTIME_EFFECT=UNKNOWN`.

If old signature disappears and a deeper compiler frame appears, P1 is runtime semantic progress and the new earliest failed module must be mapped. Only then can P2b or another historical module be considered.

## CURRENT ACTION — D97HE READ-ONLY FRONTIER COLLECTION ONLY
Run:
`OCLP-Continuity/artifacts/OCLP7_D97HE_POST_P1_ACCEL_RECOVERY_FRONTIER_COLLECTOR.sh`
- commit `6ea8974bb24f01c681b8e2523025eeb1dc1d655f`;
- Git blob `9c2a8afdb6611149bf28108b346d01cce8c6e195`.

D97HE must:
1. verify current VESA recovery and D97EZ inert;
2. identify authoritative accelerated D97EW run by exact bootargs;
3. preserve D97EW tuple evidence;
4. collect MTLCompilerService + WindowServer IPS in accelerated window;
5. parse RIP/r15/faulting frames and count old RIP0+ctx56 signature;
6. collect bounded unified logs;
7. package evidence to Desktop.

No new Root Patch, accelerated boot, EFI/NVRAM/framebuffer mutation, or P2b/P3/AIR00/D34 replay is authorized until D97HE is reviewed.
