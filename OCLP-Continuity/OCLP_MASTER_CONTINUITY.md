# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

## Current authoritative checkpoints
Current runtime/failure-localization checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FJ_WINDOWSERVER_IPS_CORE_DISPLAY_METAL_PIPELINE_FRONTIER.md`

Current remediation/execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97GA_POST_REVERT_FULL_PASS_CORRECTED_ROOTPATCH_AUTHORIZED.md`

Previous materialization gates:
- `OCLP7_CHECKPOINT_20260907_D97FY_FINAL_PRE_ROOTPATCH_GATE_PASS_CORRECTED_METALLIB_SOURCE.md`
- `OCLP7_CHECKPOINT_20260907_D97FX_SOURCE_RECONSTRUCTION_PASS_ROOTPATCH_PREFLIGHT_NEXT.md`
- `OCLP7_CHECKPOINT_20260907_D97FV_REAL_COREDISPLAY_METALLIB_RECOVERED_INSTALLED_STUB_PRIMARY_CAUSAL_CANDIDATE.md`
- D97FW global materialization checkpoint commit `41df9c6582227c61e8bfb2e99bf8469829db4830`.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current boot is VESA;
- current boot args retain `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`;
- D97EZ ACTIVE mode is inert/commented as `#-ocmcd97ez`;
- exact D97EZ/OCLPMetalCompat EFI kext remains the audited 0.0.12 build, but ACTIVE behavior is not requested in this boot;
- D97EW persistent evidence collector remains installed;
- normal framebuffer baseline remains 3/3/3;
- Root Patch Restore/Revert has now been semantically closed PASS by D97GA;
- prior invalid metadata-stub metallib layer has been removed from the installed root;
- corrected local MetallibSupportPkg source remains exact;
- corrected manual Root Patch has NOT yet been executed;
- no new T2/Haswell boot variable is authorized;
- Golden remains immutable/read-only.

Never auto Root Patch. Never auto reboot.

## Functional baseline and permanent method
Accepted functional baseline remains exactly:
- P1 selector bridge;
- P2b request-layout bridge `request+0xD0 -> request+0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback producing AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

D22 remains accepted AIR 2.6 / Metal 3.1 semantic proof. D34 cave `0xEF8..0xEFE` remains protected. D50/D68/D82 remain reserve-only; D84 retired.

Mandatory methodology:
- module-boundary + semantic evidence + far-frontier;
- binary search only inside failed module;
- universal/no-PID coverage where requests vary;
- control-flow success is never semantic proof;
- preserve evidence vocabulary: REACHED, CONTROL-FLOW PROVEN, SEMANTIC PROVEN, STRUCTURAL-SEMANTIC PROVEN, STATIC-MAPPED/PROVEN, NEGATIVE, INCONCLUSIVE, UNKNOWN.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no true-five reapplication;
- no global functional masking of `set_id_mode` bits;
- no semantic claim for bit `0x200` beyond measured evidence;
- preserve `ipc_control_port_options=0` and `-amfipassbeta`;
- no unrelated T2/Haswell boot-variable experiments at this frontier.

## Settled runtime facts before metallib remediation
### D97BV / D97DT
Selective true-3802 runtime delivery CLOSED PASS under exact 25G82.
Exact postimages:
- CAVE `3d187d0000b9177d00000f4cc1e9b4311600`;
- SITE `3dda0e00007406e93bcee9ff90`.
D97FS later proved active-cache differences are exactly these intentional D97BV postimages.

### D97DX architecture
Native-Metal-safe patch policy remains accepted:
- bounded legacy `MTLCompilerService.xpc` only;
- private compiler lanes/CoreImage/RenderBox compatibility;
- Monterey GVA/OpenCL;
- Haswell drivers;
- no legacy main Metal shadow;
- no MetalOld;
- no true-five replay.
The previous D97DX execution itself is reclassified semantically invalid only for the metallib payload bytes because the local source tree contained metadata stubs.

### D97EB / D97EE
1/1/1 framebuffer experiment CLOSED NEGATIVE; 3/3/3 remains authoritative.

### D97EY -> D97FH
Measured exact rejection was `mode=0x224` versus accepted `0x24`; D97EZ exact adapter translates only `0x224 -> 0x24` and passes all other modes untouched.
D97FH ACTIVE run proved 16/16 exact-224 adaptations succeeded plus 4/4 passthrough calls succeeded. Prior set_id_mode bad-bits blocker is CLOSED PASS for measured traffic.

## D97FJ / D97FT fatal frontier
D97FJ two WindowServer crashes converged on:
`CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState -> native Metal render-pipeline/device validation`.

D97FT exact static mapping proved:
- exact Tahoe CoreDisplay/Metal identities from pristine Incoming cache;
- GPUPass function construction path;
- bootstrap tuple `0xFFFFFFFF / 0xFFFFFFFF / 0x5E` (`BGR10A2Unorm`);
- same bootstrap tuple/descriptor recipe in working Golden;
- Crash A enters GPUPass specialization error-report path;
- Crash B reaches Metal validation-context finalization/abort;
- `validateWithDevice +716` is the return after `__MTLMessageContextEnd`, not a unique predicate.

Pure Tahoe-vs-Haswell CoreDisplay bootstrap divergence is therefore not the leading hypothesis.

## D97FV / D97FW metallib failure discovery
Exact original package:
`/Users/alex/Downloads/MetallibSupportPkg-26.6.2-25G82.pkg`
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Real CoreDisplay package payload:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- MetalLib 1.2.7 / `MTLB`;
- contains GPUPass plus exact two function constants expected by CoreDisplay.

Old local and installed CoreDisplay copies were 319-byte ASCII metadata stubs.
Global D97FW audit proved the issue was systemic:
- real regular `.metallib` total `180`;
- local exact `0`, metadata stubs `180`;
- installed exact `0`, metadata stubs `180`.

Primary causal model became:
`invalid installed metallib layer -> invalid/missing GPUPass library/function -> specialization error and/or invalid render descriptor -> Metal validation abort -> WindowServer death`.
Runtime causality is still not closed until one corrected-payload ACTIVE test.

## D97FX corrected local source
D97FX reconstructed the entire local 25G82 source tree from the exact original package via staged identity check and atomic swap.
Proven:
- regular files `181`;
- real metallibs `180`;
- local full-tree identity PASS;
- `180/180` exact metallibs;
- corrected CoreDisplay SHA exact and direct `MTLB` magic;
- old stub source retained at `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82.D97FX_STUB_BACKUP_20260907_212451`.

## D97FY final pre-remediation gate
D97FY proved before Restore:
- corrected local source exact;
- all 180 dynamic metallibs direct `MTLB`;
- D97DX artifact/helper/source identity PASS;
- patchdict closure `182 = 180` dynamic MetallibSupportPkg entries + `2` unchanged 14.6.1 donors;
- official helper exact SHA/team PASS;
- VESA state PASS;
- D97EZ ACTIVE mode inert.

## D97GA post-revert semantic closure
User executed Root Patch Restore through exact D97DX outer wrapper, then rebooted to VESA. A user-corrected EFI mistake had temporarily left `-ocmcd97ez` active; after changing it to inert/commented and rebooting once, post-revert evidence showed:

### Corrected local source
- local metallib count `180`;
- all local direct `MTLB`;
- corrected CoreDisplay SHA PASS.

### Installed root after revert
Across all 180 dynamic metallib target paths:
- metadata stubs `0`;
- missing `0`;
- direct `MTLB` `179`;
- one other valid non-stub container.

The unique non-direct-MTLB target is:
`/System/Library/Frameworks/QuartzCore.framework/Versions/A/Resources/default.metallib`
- bytes `160202560`;
- SHA256 `45ebcfee208d1428e2834693152ebcf92e985d7714250c2fdc03e52ffec94204`;
- fat Mach-O magic `CAFEBABE`;
- 19 architectures including an `air64` MetalLib 1.2.9 slice and multiple AppleGPU slices.
This is a structurally valid universal Metal library container, not a stub.

Native CoreDisplay after revert:
- bytes `24128`;
- SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`;
- MetalLib 1.2.9;
- therefore native Tahoe payload restored.

Legacy Haswell root-patched kexts were not listed under post-revert VESA, as expected before corrected Root Patch.

Official privileged helper direct micro-gate:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- TeamIdentifier `S74BDJXQMD`;
- Developer ID signature valid;
- codesign verify PASS.

Classification:
- `D97GA_ROOT_PATCH_RESTORE=PASS`;
- `D97GA_INSTALLED_STUB_LAYER_REMOVED=PASS`;
- `D97GA_CORRECTED_LOCAL_SOURCE=PASS`;
- `D97GA_OFFICIAL_HELPER_IDENTITY=PASS`;
- `D97GA_D97DX_CORRECTED_MANUAL_ROOT_PATCH=AUTHORIZED`.

## Current causal frontier
Closed/excluded:
- set_id_mode `0x224` rejection;
- D97BV delivery;
- Tahoe-only CoreDisplay GPUPass bootstrap divergence;
- invalid local 25G82 metallib source tree;
- old installed metadata-stub metallib layer after APFS revert.

Pending causal closure:
`corrected real 25G82 metallib layer -> GPUPass specialization/render-pipeline path -> accelerated GUI or new downstream frontier`.

## Execution-lane authority
User explicitly authorized local compilation on the home Intel iMac because GitHub Actions quota/execution is blocked. Do not retry GitHub Actions compilation during this quota-limited period.

## CURRENT ACTION — CORRECTED MANUAL ROOT PATCH
Remain in the current VESA boot. No EFI/NVRAM/framebuffer/bootarg changes.

Authorized exact sequence:
1. Launch outer `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97DX.app`.
2. Run **Root Patch only**; do NOT run Restore again.
3. If OCLP reports missing MetallibSupportPkg, unexpected donor path, or preflight failure, STOP and return output.
4. Let D97DX consume the corrected local 25G82 source.
5. After Root Patch completes, fully close the inner OCLP so the outer wrapper restores/verifies the official privileged helper.
6. **DO NOT REBOOT.**
7. Return complete Root Patch output/status for a post-patch payload identity audit.

Still forbidden until post-patch audit passes:
- reboot after corrected Root Patch;
- removal of `-igfxvesa`;
- active `-ocmcd97ez`;
- accelerated/non-VESA boot;
- EFI/NVRAM/framebuffer changes;
- Golden mutation;
- legacy main Metal shadow;
- true-five reapplication.