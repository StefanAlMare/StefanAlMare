# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER is the current execution/causal authority. If older current-action wording conflicts, this file and its current checkpoint win.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HE_V2_FRONTIER_COLLECTOR_READY.md`
- commit `3d0fbfe9481caaeef4c026dec4b1b4964d0624a7`.

Immediate runtime predecessor:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HE_POST_P1_ACCEL_NO_GUI_VESA_RECOVERY_FRONTIER_PENDING.md`
- commit `52125fed156f25c9f08ef611e7876793eab5e42a`.

Earlier decisive predecessors:
- D97HD active P1 snapshot VESA PASS + D97EW live capture gate PASS / acceleration authorized — `f5c342197210248a47469a7e6ec709c26ab66e9c`;
- D97HC exact pre-reboot patched-volume audit PASS — `c809157e3773a17a149a8cba322bde0fc724c5cb`;
- D97GS P1-only Root Patch PASS — `c702ca47f20a036f2201799d05c1723441eb8a88`;
- D97GY clean post-Restore baseline PASS — `dd4fcfd0b37f858b60c6c30ddcc1ba5b3645b63a`;
- D97GR exact historical P1 reconstruction PASS / startup NULL-call cause causally closed — `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`;
- D97GN old 12/12 MTLCompilerService NULL-call frontier — `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`;
- D97GM corrected-metallib semantic progress — `b28469abf0363ab7f0877b63c22465c1694d41b6`.

## Target
Tahoe `26.6.2 / 25G82` on Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, with stable hardware-accelerated usable GUI.
Framebuffer baseline: 3/3/3.

Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.

## Durable architecture / method
Required architecture:
`Tahoe-native Metal / Metal4 ABI -> selective legacy compiler ingress -> audited adapter(s) -> legacy compiler/backend -> Haswell driver -> image`.

Historical accepted compiler baseline:
`P1 + P2b + P3 + AIR00 + D34`.

Current rule: do **not** replay all five blindly. Patch only the earliest measured failed module. P1 is installed and live; runtime evidence must identify the new frontier before P2b/P3/AIR00/D34 can return.

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
Corrected local 25G82 source is exact 180 real metallibs.
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

D97GP/D97GR proved cause: legacy service selector compared 31001 while runtime requested 32023. Exact P1 produces selector compare 32023 and historical post-SHA:
`a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.

Classification:
`OLD_MTLCOMPILERSERVICE_NULL_CALL_CAUSE=MISSING_P1_SELECTOR_BRIDGE_CAUSALLY_CLOSED`.

## Clean Restore-first / D97GS closure
User deliberately restored old D97DX Root Patch first and rebooted VESA before D97GS.

D97GS P1-only Root Patch PASS on clean base.
D97HC pre-reboot audit PASS proved underlying System exact P1 + corrected metallibs 180/180.
D97HD post-VESA-reboot audit PASS proved active snapshot exact P1 + corrected metallibs 180/180 + Haswell kexts loaded + official helper exact.
D97EW persistent collector live gate PASS before accelerated test.

## Authoritative post-P1 accelerated test
Accelerated boot changed only:
- `-igfxvesa` inert/commented;
- `-ocmcd97ez` active.

Unchanged:
- framebuffer 3/3/3;
- `-ocmcdiag`, `-ocmcd97bv`, `-ocmcd97eh` retained;
- `igfxfw=2` OFF;
- `rps-control=1` OFF;
- Max Pixel Clock Override OFF;
- no unrelated Root Patch/EFI/NVRAM change.

### Runtime outcome
No usable GUI/image appeared. User followed permanent recovery rule and is back in VESA with D97EZ inert.

The current VESA recovery boot is NOT authoritative evidence for the failed accelerated boot; the immediately preceding accelerated boot is authoritative.

Classification:
`D97HE_ACCEL_BOOT_GUI=NEGATIVE_NO_IMAGE`.

### WindowServer accelerated crash
User supplied WindowServer crash report:
- launch `2026-09-08 03:35:27.3200 +0300`;
- crash `2026-09-08 03:35:43.5056 +0300`;
- EXC_CRASH/SIGABRT;
- COREANIMATION code 4;
- `spec=PBGRAXb_Xc`;
- fatal reason `Compilation failed due to an interrupted connection: XPC_ERROR_CONNECTION_INTERRUPTED. This error occurred after multiple retries.`;
- fatal compositor frame `CA::OGL::MetalContext::create_pipeline_state(...)+6896`;
- path continues through QuartzCore and SkyLight Metal compositor.

WindowServer binary images include GPUCompiler 32023 libraries and AppleIntelHD5000GraphicsMTLDriver.

Classifications:
`D97HE_WINDOWSERVER_METAL_COMPOSITOR=REACHED`
`D97HE_WINDOWSERVER_XPC_INTERRUPTED=PROVEN`.

WindowServer is downstream. It does NOT decide whether P1 failed or moved MTLCompilerService deeper.

## Current unresolved question
Does post-P1 MTLCompilerService still die with the old exact signature:
- RIP=0;
- r15=32023;
- `MTLConnectionCtx::MTLConnectionCtx(int)+56`?

Until the service crash evidence is read:
`D97HE_P1_RUNTIME_EFFECT=UNKNOWN`.

If the old signature is absent and a deeper compiler frame appears, P1 is runtime semantic progress. Map the new earliest failed module before considering any later historical patch.

## D97HE v1 tooling note
First D97HE collector commit `6ea8974bb24f01c681b8e2523025eeb1dc1d655f` was NOT run. Static review caught two tooling bugs before execution: multiple historical D97EW matches could be emitted, and shell time-window values with spaces were unquoted. It is superseded.

## CURRENT ACTION — D97HE v2 READ-ONLY FRONTIER COLLECTION ONLY
Run:
`OCLP-Continuity/artifacts/OCLP7_D97HE_POST_P1_ACCEL_RECOVERY_FRONTIER_COLLECTOR.sh`
- corrected commit `4af65c99950c95e1f709e4d930213bb934ad3ed9`;
- Git blob `d7aad0b44f53dfaff7ce9d0a770bd38255c0ad37`.

D97HE v2 must:
1. verify current VESA recovery and D97EZ inert;
2. select only the newest D97EW run with accelerated bootargs;
3. preserve D97EW tuple evidence;
4. collect MTLCompilerService + WindowServer IPS in the accelerated window;
5. parse RIP/r15/faulting frames and count the old RIP0+ctx56 signature;
6. collect bounded unified logs;
7. package evidence to Desktop.

No new Root Patch, accelerated boot, EFI/NVRAM/framebuffer mutation, or P2b/P3/AIR00/D34 replay is authorized until D97HE v2 is reviewed.
