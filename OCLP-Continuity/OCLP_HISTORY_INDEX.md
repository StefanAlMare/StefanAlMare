# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-07 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current runtime checkpoint: `OCLP7_CHECKPOINT_20260907_D97FJ_WINDOWSERVER_IPS_CORE_DISPLAY_METAL_PIPELINE_FRONTIER.md`.
Current remediation checkpoint: `OCLP7_CHECKPOINT_20260907_D97GA_POST_REVERT_FULL_PASS_CORRECTED_ROOTPATCH_AUTHORIZED.md`.
Permanent database/rules and all incremental checkpoints remain authoritative for deep history.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable baseline / rules
Accepted functional baseline remains exactly `P1 + P2b + P3 + AIR00 + D34`. D22 remains accepted AIR 2.6 / Metal 3.1 semantic proof. D34 cave protected. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired. Permanent method remains module-boundary + semantic evidence + far-frontier, with universal/no-PID coverage where requests vary.

## D97BV / D97DT — selective 3802 runtime closure
Selective true-3802 adapter semantics and runtime delivery CLOSED PASS under exact 25G82.
Exact postimages:
- CAVE `3d187d0000b9177d00000f4cc1e9b4311600`, SHA256 `a1b8d3b2988e622a4ea8e9545816a44abdb5c84e70b4126a3bad15c9f7539045`;
- SITE `3dda0e00007406e93bcee9ff90`, SHA256 `1123dd318a28e66be825763ccb9715b4ef2906fd9cdb6335ed2f53fada489a43`.
Do not retest absent contradiction.

## D97DX — native-Metal-safe Root Patch policy
Architecture retained:
- native Tahoe main Metal authoritative;
- bounded legacy compiler/compatibility lanes;
- Monterey GVA/OpenCL + Haswell drivers;
- no legacy main Metal shadow, MetalOld or true-five replay.
Later metallib work proved the first installed D97DX metallib bytes were invalid because the local source tree had been materialized as metadata stubs.

## D97DZ
Post-Root-Patch VESA check proved D97BV SITE/CAVE still pristine immediately after Root Patch; D97DX itself did not write those native-Metal runtime-adapter bytes.

## D97EB / D97EE
Framebuffer-count experiment 1/1/1 CLOSED NEGATIVE; normal 3/3/3 remains authoritative.

## D97EG-D97EP
Exact `IOAccelSurface::set_id_mode(uint32_t,uint32_t)` observer route/passthrough established.

## D97EQ-D97EX
Evidence-transport problem solved via IORegistry tuple telemetry plus persistent hard-recovery collector under `/Users/Shared/OCLP-D97EW-Capture`.

## D97EY — exact tuple semantic proof
Accelerated evidence proved:
- accepted `mode=0x24` -> Apple return `0`;
- rejected `mode=0x224` -> Apple `0xE00002C2`;
- extra bit `0x200` measured but semantic meaning UNKNOWN.
Checkpoint commit `f2762e713565b1e72498241de639bdd5698c82c6`.

## D97EZ / D97FH — exact set_id_mode adapter closure
D97EZ exact-match rule: only `0x224 -> 0x24`; every other mode untouched; exact Apple return propagated.
Audited 0.0.12 build UUID `3405DFAB-244A-38CA-90EA-79A1A24EEF72`.
D97FH ACTIVE run proved at stable 20 calls:
- exact224 adapted/succeeded `16/16`;
- passthrough succeeded `4/4`;
- failures `0`.
Previous bad-bits blocker CLOSED PASS.
D97FH checkpoint commit `3b882d7428a010a48d4744f290ab97a9232d4b4e`.

## D97FI
Downstream localization after set_id_mode fix proved IntelAccelerator/3 framebuffers, fb0 online, DPCD readability, display publication, then CoreDisplay failures and WindowServer crash.

## D97FJ — exact WindowServer fatal frontier
Two `.ips` reports converged on `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState`:
- Crash A: objc_msgSend path at `GetGPUPass... +599`;
- Crash B: Metal validation abort path at `GetGPUPass... +1720`.
Native CoreDisplay 291.4 UUID `8bfeff75-c8c8-3b5b-afa0-61385199a1bb`; native Metal 373.7 UUID `5d64fa80-29ce-32aa-bab6-4e5034132c0b`.
D97FJ checkpoint commit `c3ef589e7f9ee8688dc6a08c9d4a488aec0fb8c1`.

## D97FK-D97FQ — shared-cache extraction tooling
Standalone filesystem path approach failed because CoreDisplay/Metal are cache-resident.
A minimal wrapper around Apple's `dyld_shared_cache_extract_dylibs_progress` was built on authorized Intel iMac and independently audited:
- x86_64 binary SHA256 `04f0e1aa835f7dcafc3ccf989fe90bf3324b9d173824a7540d0232e9e7464bff`;
- UUID `213B833D-A864-3A3D-97E5-BB4AB8824033`.

## D97FR / D97FS — active dyld cache difference explained
Active cache signature mismatch versus valid Incoming was traced exactly to D97BV's intentional native-Metal SITE/CAVE mutation.
D97FS proved ACTIVE postimages byte-for-byte equal the accepted D97BV design. No mysterious corruption; D97BV remains CLOSED PASS.
D97FS checkpoint commit `f22b93fb0361d7333afaf689e43c3effd4ab0c42`.

## D97FT — exact GPUPass static map
Exact CoreDisplay and Metal images extracted from pristine Incoming matched D97FJ crash UUIDs.
Static mapping proved:
- GPUPass construction flow;
- bootstrap tuple `0xFFFFFFFF / 0xFFFFFFFF / 0x5E` (`BGR10A2Unorm`);
- same mapped tuple/descriptor recipe as Golden;
- Crash A is in GPUPass specialization NSError path;
- Crash B reaches Metal validation-context finalization;
- `validateWithDevice +716` is not a unique predicate.
D97FT checkpoint commit `c9ffb5f30458118c7c97725811f643e926c09802`.

## D97FV — real CoreDisplay metallib recovered
Pinned original package:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Real package CoreDisplay `default.metallib`:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- MetalLib 1.2.7 / `MTLB`;
- contains `GPUPass` with exact two function constants expected by CoreDisplay.

Installed and old local copies were instead 319-byte ASCII metadata stubs. CoreDisplay statically loads that exact installed path. This became the primary causal candidate for the D97FJ crashes.
D97FV checkpoint commit `935387c7a425d1e1b684a7941b801d58568894ac`.

## D97FW — systemic metallib materialization failure
Global package/local/root audit proved:
- real regular metallibs `180`;
- local exact `0`, metadata stubs `180`;
- installed exact `0`, metadata stubs `180`;
- all 180 stub-declared sizes matched their real payload sizes.
D97FW checkpoint commit `41df9c6582227c61e8bfb2e99bf8469829db4830`.

## D97FX — corrected local source reconstruction PASS
Helper authority:
- commit `a02e75e3d4284942fa2112f2964b818a59cc9c7b`;
- blob `b8e9675b16b38575bccfad5cb5c24438531480e7`.

Execution proved:
- original package identity PASS;
- stage regular files `181`;
- real metallibs `180`;
- full-tree identity PASS;
- atomic source swap PASS;
- `180/180` post-swap metallibs exact;
- corrected CoreDisplay `20739` bytes, SHA `b848d54e...`, MetalLib 1.2.7;
- old stub tree backed up;
- no Root Patch/reboot during reconstruction.
D97FX result checkpoint commit `dea61a79025256a5b24d4b1f62a2c88c79d7588d`.

## D97FY — final corrected-source pre-remediation gate PASS
Proved:
- VESA state PASS and D97EZ ACTIVE inert;
- exact original package identity;
- `180/180` corrected local metallibs exact, all direct `MTLB`;
- exact D97DX app/helper/source identities;
- patchdict closure `182 = 180` dynamic MetallibSupportPkg + `2` unchanged 14.6.1 donors;
- official helper exact SHA/team/codesign PASS.
D97FY checkpoint commit `efe286948b322e41f9479f84b9e60027799dddf3`.

## D97FZ initial stop — user EFI token mistake
After APFS Root Patch Restore and reboot, first D97FZ run stopped because `-ocmcd97ez` was still active in EFI. User identified and corrected this manually to inert/commented, then rebooted once more in VESA. No Root Patch was run during the failed gate.
Incident checkpoint commit `07f2e922234dda655cd57b597c791d488c26cad0`.

## D97GA — post-revert full PASS / corrected Root Patch authorized
After the corrected VESA reboot, composed D97FZ + direct micro-gate evidence proved:

Boot:
- Tahoe `25G82`, x86_64;
- VESA active;
- `-ocmcd97ez` inert/commented.

Corrected local source:
- metallib count `180`;
- all local direct `MTLB`;
- corrected CoreDisplay SHA PASS.

Installed root after revert:
- metadata stubs `0`;
- missing `0`;
- direct `MTLB` `179`;
- one valid non-direct-MTLB container.

Unique non-direct-MTLB target:
`/System/Library/Frameworks/QuartzCore.framework/Versions/A/Resources/default.metallib`
- bytes `160202560`;
- SHA256 `45ebcfee208d1428e2834693152ebcf92e985d7714250c2fdc03e52ffec94204`;
- fat Mach-O `CAFEBABE` universal container;
- 19 architectures including an `air64` MetalLib 1.2.9 slice plus AppleGPU slices.
This is structurally valid and not a metadata stub.

Native CoreDisplay restored:
- bytes `24128`;
- SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`;
- MetalLib 1.2.9.

Legacy Haswell root-patched kexts not listed under VESA, consistent with successful revert.

Official helper direct gate:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- TeamIdentifier `S74BDJXQMD`;
- Developer ID signature valid;
- codesign verify PASS.

Classification:
- Root Patch Restore PASS;
- installed metadata-stub layer removed PASS;
- corrected local source PASS;
- official helper PASS;
- corrected D97DX manual Root Patch AUTHORIZED.

D97GA checkpoint commit `0d4bbd4fcddc0ea8cf6f1943b1b0c2e7d233a011`.

## Current causal frontier
Closed/excluded:
- set_id_mode bad-bits rejection;
- D97BV delivery;
- Tahoe-only CoreDisplay GPUPass bootstrap divergence;
- invalid local 25G82 source tree;
- old installed metadata-stub layer after APFS revert.

Pending runtime causal closure:
`corrected real 25G82 metallib layer -> GPUPass specialization/render-pipeline -> accelerated GUI or new downstream frontier`.

## Current action
Remain in VESA.
1. Launch exact outer `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97DX.app`.
2. Run **Root Patch only**; do not run Restore again.
3. If missing MetallibSupportPkg, unexpected donor, or preflight failure appears, STOP and return output.
4. After Root Patch completes, close inner OCLP so outer wrapper restores/verifies official helper.
5. **Do not reboot.**
6. Return complete Root Patch output/status for post-patch payload audit.

Still forbidden until post-patch audit passes: accelerated boot, removal of `-igfxvesa`, active `-ocmcd97ez`, EFI/NVRAM/framebuffer changes, Golden mutation, legacy main Metal shadow, true-five reapplication.