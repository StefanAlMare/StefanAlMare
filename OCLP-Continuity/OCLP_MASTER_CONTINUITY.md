# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HE_HISTORICAL_MISSELECTION_INVALID_D97HF_EXACT_0335_READY.md`
- commit `d7691224526b3b35c4607f15d43bccfa8372d5f9`.

Immediate predecessors:
- first post-P1 accelerated no-GUI / VESA recovery frontier pending — `52125fed156f25c9f08ef611e7876793eab5e42a`;
- D97HD active P1 VESA snapshot PASS + D97EW live gate PASS / acceleration authorization — `f5c342197210248a47469a7e6ec709c26ab66e9c`;
- D97HC exact pre-reboot audit PASS — `c809157e3773a17a149a8cba322bde0fc724c5cb`;
- D97GS P1-only Root Patch PASS — `c702ca47f20a036f2201799d05c1723441eb8a88`;
- D97GY clean Restore baseline PASS — `dd4fcfd0b37f858b60c6c30ddcc1ba5b3645b63a`;
- D97GR exact P1 reconstruction / old NULL-call cause causally closed — `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`;
- D97GN old 12/12 `RIP=0 / r15=32023 / MTLConnectionCtx+56` frontier — `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`.

## Target / invariants
Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, framebuffer 3/3/3.

Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.
Golden Sequoia immutable/read-only.

Durable architecture:
`Tahoe native Metal / Metal4 ABI -> selective legacy compiler ingress -> audited adapter(s) -> legacy compiler/backend -> Haswell driver -> image`.

Historical compiler baseline:
`P1 + P2b + P3 + AIR00 + D34`.
Do NOT replay it wholesale. Only the earliest measured failed module may return.

## Settled live state before first post-P1 acceleration
D97GS/D97HC/D97HD prove active snapshot exact P1 service:
`a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`
with postimage `81fe177d0000` at `0x3494`.

Corrected metallibs are active 180/180 exact; CoreDisplay:
- SHA `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- bytes 20739;
- MTLB.

Haswell Azul/HD5000 kexts loaded. Official OCLP helper exact. D97EW live VESA gate PASS.

## First post-P1 accelerated boot — authoritative current runtime event
Only two boot-arg states changed:
- `-igfxvesa` inert;
- `-ocmcd97ez` active.

All else remained at measured baseline; optional `igfxfw=2`, `rps-control=1`, Max Pixel Clock Override stayed OFF.

Outcome:
- no usable image/GUI;
- user correctly hard-cycled, restored VESA and made D97EZ inert;
- current recovery boot is NOT the failed accelerated boot.

Authoritative WindowServer report:
- launch `2026-09-08 03:35:27.3200 +0300`;
- crash `2026-09-08 03:35:43.5056 +0300`;
- COREANIMATION code 4;
- `CA::OGL::MetalContext::create_pipeline_state(...)+6896`;
- `Compilation failed due to an interrupted connection: XPC_ERROR_CONNECTION_INTERRUPTED. This error occurred after multiple retries.`
- WindowServer loaded GPUCompiler 32023 libraries and `AppleIntelHD5000GraphicsMTLDriver`.

Classifications:
`POST_P1_ACCEL_GUI=NEGATIVE_NO_IMAGE`
`WINDOWSERVER_METAL_COMPOSITOR=REACHED`
`WINDOWSERVER_XPC_INTERRUPTED=PROVEN`
`P1_RUNTIME_EFFECT=UNKNOWN_PENDING_CURRENT_MTLCOMPILERSERVICE`.

WindowServer is downstream; it cannot determine whether P1 moved MTLCompilerService deeper.

## D97HE uploaded ZIP — INVALID for current post-P1 boot
Uploaded `OCLP7_D97HE_POST_P1_ACCEL_FRONTIER_20260908_034912.zip` was inspected.

D97HE selected historical D97EW run:
`20260907T205125Z-322` = 2026-09-07 23:51:25 local, old corrected ACCEL2.

Historical tuple evidence in that run:
- set_id_mode calls 58;
- exact224 seen/adapted 20;
- passthrough successes 38;
- captured count 8.

The only MTLCompilerService reports copied are historical from 7 September 23:41/23:51. Their old `RIP=0 / r15=32023 / MTLConnectionCtx+56` signature is expected historical evidence and MUST NOT classify the current 03:35 post-P1 boot.

Classification:
`D97HE_CURRENT_BOOT_CLASSIFICATION=INVALID_HISTORICAL_MISSELECTION`
`D97HE_OLD_SIGNATURE_RESULT=DISCARDED_FOR_CURRENT_BOOT`.

No P2b/P3/AIR00/D34 inference may be made from D97HE.

## Current action — D97HF exact 03:35 collector only
Run:
`OCLP-Continuity/artifacts/OCLP7_D97HF_POST_P1_EXACT_0335_FRONTIER_COLLECTOR.sh`
- commit `2c7251f8a1d74e33cd2a26940f9ac325d1072186`;
- blob `848974fb7b3fd8f285e744085149e32362c56d7f`.

D97HF is bounded to exact local window:
`2026-09-08 03:34:00 +0300` through `03:39:30 +0300`.

It must:
1. require current VESA recovery + D97EZ inert;
2. require active service still exact P1 SHA;
3. inventory D97EW runs 00:33–00:41 UTC only as evidence, not authority;
4. search DiagnosticReports/Retired/user reports;
5. select MTLCompilerService and WindowServer IPS strictly by embedded `captureTime` in the exact current window;
6. parse RIP/r15/fault frames and count old ctx56 signature;
7. capture exact-window unified log;
8. package evidence on Desktop only.

No new accelerated boot, Root Patch, EFI/NVRAM/framebuffer experiment, or P2b/P3/AIR00/D34 replay is authorized until D97HF is reviewed.
