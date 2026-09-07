# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER is the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97GY_RESTORE_BASE_PASS_DEBUG_HELPER_RESIDUAL_D97GZ_LOCATOR_READY.md`
- commit `f0335052f6b8de8a1bd2c6b776b747f149d1b156`.

Immediate predecessors:
- D97GW live ASUS2 preflight PASS / D97GS initially authorized before the user chose clean Restore-first sequencing — `40fd4789f7ca430d54d475dce5d193ad19644430`;
- D97GV independent D97GS artifact audit PASS — `72812a82b3a94bfe0dd42c55401834e97d237ffb`;
- D97GS P1-only build PASS — `bfbb78a8acb75bf4b06ebda31fb130924e137cfc`;
- D97GR exact historical P1 reconstruction PASS / NULL-call cause causally closed — `05cf8b0f5a3e44a24b787ab92010cb2ec1f37419`;
- D97GP current service pre-P1 / 32023 compiler exports PASS — `eec9dfd358f77130bfe87510bd3fee97d163a412`;
- D97GN 12/12 MTLCompilerService NULL indirect-call frontier — `5afdc48b4d9eeae3f713ac99fdeb0592ab543731`;
- D97GM corrected-metallib semantic progress — `b28469abf0363ab7f0877b63c22465c1694d41b6`.

## Current ASUS2 authority — AFTER CLEAN RESTORE + VESA REBOOT
User explicitly chose Restore/Revert first, then reboot VESA, before applying D97GS, to avoid stacking a new Root Patch over the prior D97DX snapshot.

D97GY proved the APFS/System restore baseline itself is clean:
- macOS Tahoe `26.6.2 / 25G82`, x86_64;
- Haswell `8086:0412`, SMBIOS `MacBookAir6,2`;
- VESA active; D97EZ inert;
- native Tahoe MTLCompilerService restored exact:
  - SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
  - UUID `022C1750-8735-389A-A8BA-A8A67F54235D`;
  - architectures `x86_64 arm64e`;
- native CoreDisplay metallib restored exact:
  - SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`;
  - bytes `24128`;
  - magic `MTLB`;
- Haswell AuxKC Data kexts removed and not loaded;
- corrected local MetallibSupportPkg source survived:
  - path `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`;
  - metallib count `180`;
  - CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
  - bytes `20739`;
  - zero bad magic.

Classification:
`D97GY_SYSTEM_RESTORE_BASE=STRUCTURAL_SEMANTIC_PASS`.

### Current blocking residual state — privileged helper
Manual inspection proved the active privileged helper is NOT official OCLP; it is exact DEBUG helper:
- path `/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper`;
- SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- thin `x86_64`;
- ad-hoc signature;
- `TeamIdentifier=not set`;
- `codesign --verify --strict` PASS.

Expected official helper:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- Team ID `S74BDJXQMD`.

This is a REAL residual wrapper/helper state, not a collector false negative.

Classification:
`D97GY_OFFICIAL_HELPER_RESTORATION=FAIL_REAL_RESIDUAL_DEBUG_HELPER`
`D97GY_OVERALL=PARTIAL_PASS_BLOCKED_ON_HELPER_STATE`.

## D97GS artifact remains ready but is TEMPORARILY NOT AUTHORIZED
D97GS P1-only artifact remains independently audited and unchanged:
- ZIP SHA256 `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`, bytes `722879148`;
- source diff SHA256 `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- inner x86_64 SHA256 `5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e`;
- exact D97DX launcher/debug-helper provenance retained;
- all four D97DX base source sections byte-identical;
- only new source section is additive `sys_patch.py` P1 hook;
- no P2b/P3/AIR00/D34 replay.

However:
`D97GS_MANUAL_P1_ONLY_ROOT_PATCH_ON_ASUS2=NOT_AUTHORIZED_UNTIL_OFFICIAL_HELPER_RESTORED`.

## Current method / replay rule
Historical compiler baseline remains exactly:
`P1 + P2b + P3 + AIR00 + D34`.

Current rule: do not replay all five blindly. Patch only the earliest measured failed module. Current measured compiler failure justifies P1 only. P2b/P3/AIR00/D34 may return only if a later measured post-P1 frontier requires them.

Evidence vocabulary: REACHED / CONTROL-FLOW PROVEN / SEMANTIC PROVEN / STRUCTURAL-SEMANTIC PROVEN / STATIC-MAPPED-PROVEN / NEGATIVE / INCONCLUSIVE / UNKNOWN.

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
- Golden Sequoia immutable/read-only;
- never auto Root Patch;
- never auto reboot;
- never modify EFI/NVRAM automatically.

## Settled causal facts retained
- D97BV/D97DT selective true-3802 ingress CLOSED PASS.
- D97EZ exact `0x224 -> 0x24` adapter CLOSED PASS; corrected ACCEL2 proved 58/58 set_id_mode successes.
- systemic old metallib stub defect was corrected; corrected local source is exact 180/180.
- D97GM proved corrected real metallibs produced semantic progress and moved the frontier from native Metal validation abort to MTLCompilerService death.
- D97GN: 12/12 crashes `RIP=0`, `r15=32023`, return frame `MTLConnectionCtx+56 / 0x3448`.
- D97GP: current legacy service expected by D97DX originally had selector compare 31001 while runtime request is 32023; 32023 MTLCompiler itself is exact and exports all four required MTLCodeGenService symbols.
- D97GR: exact P1 two-byte selector bridge reconstruction gives historical SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`; current NULL-call cause causally closed.

## CURRENT ACTION — D97GZ READ-ONLY OFFICIAL HELPER BACKUP LOCATOR
Run only:
`OCLP-Continuity/artifacts/OCLP7_D97GZ_ASUS2_READONLY_OFFICIAL_HELPER_BACKUP_LOCATOR.sh`

Authority:
- commit `19d8d3efed756a71249feadb1f4a8e03ae56a835`;
- Git blob `db89ea39cf4193df65dece24ad5b9fdd1e87eef9`.

D97GZ must:
1. reconfirm active exact DEBUG helper identity;
2. inspect the exact reused D97DX/D97GS launcher for helper backup/restore path evidence;
3. search likely persistent locations for an exact official-helper SHA match;
4. require Team ID `S74BDJXQMD` for a full candidate PASS;
5. perform NO helper replacement and NO Root Patch/Restore/reboot.

If an exact official SHA+Team backup is found, design a single-helper deterministic restore only. Until then: no D97GS Root Patch and no reboot.
