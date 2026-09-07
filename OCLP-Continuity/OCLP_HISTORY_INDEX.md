# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-07 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Current runtime checkpoint: `OCLP7_CHECKPOINT_20260907_D97FJ_WINDOWSERVER_IPS_CORE_DISPLAY_METAL_PIPELINE_FRONTIER.md`.
Current remediation checkpoint: `OCLP7_CHECKPOINT_20260907_D97GE_CORRECTED_ROOTPATCH_PREBOOT_STRUCTURAL_SEMANTIC_PASS_VESA_REBOOT_AUTHORIZED.md`.
Permanent database/rules and all incremental checkpoints remain authoritative for deep history.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable baseline / rules
Accepted functional baseline remains `P1 + P2b + P3 + AIR00 + D34`. D22 AIR 2.6 / Metal 3.1 semantic proof remains accepted. D34 cave protected. D50/D68/D82 reserve-only; D84 retired. Golden Sequoia immutable/read-only. Permanent method: module-boundary + semantic evidence + far-frontier; binary search only inside failed module; control-flow success is not semantic proof.

## D97BV / D97DT — selective true-3802 closure
Selective true-3802 delivery CLOSED PASS. Exact accepted runtime postimages are the D97BV CAVE/SITE postimages; D97FS later mapped active-cache differences exactly to them.

## D97EB / D97EE — framebuffer experiment
1/1/1 CLOSED NEGATIVE. Normal 3/3/3 remains authoritative.

## D97EY -> D97FH — set_id_mode blocker closed
Exact measured rejection: `mode=0x224` vs accepted `0x24`; extra bit `0x200` semantic meaning UNKNOWN.
D97EZ 0.0.12 maps only exact `0x224 -> 0x24`; all other modes exact passthrough.
D97FH ACTIVE run: 16/16 adapted successes + 4/4 passthrough successes, zero failures. Prior bad-bits blocker CLOSED PASS.

## D97FI / D97FJ — downstream CoreDisplay fatal frontier
After set_id_mode closure, GPU/IntelAccelerator/framebuffer initialization progressed but WindowServer still failed.
Two D97FJ `.ips` reports converged on `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState` and native Metal render-pipeline validation.

## D97FK-D97FS — exact cache/static mapping
A minimal audited wrapper around Apple's dyld shared-cache extractor recovered exact CoreDisplay/native Metal from pristine Incoming cache.
D97FS proved active cache mutation is exactly the intentional D97BV runtime SITE/CAVE adapter, not corruption.

## D97FT — exact GPUPass static map
Static mapping proved:
- GPUPass specialization path;
- bootstrap tuple `0xFFFFFFFF / 0xFFFFFFFF / 0x5E` (`BGR10A2Unorm`);
- same mapped tuple/descriptor recipe in working Golden;
- Crash A is in GPUPass specialization NSError handling;
- Crash B reaches Metal validation-context finalization;
- exact underlying Metal validation predicate remained UNKNOWN.

## D97FV — real CoreDisplay metallib recovered
Pinned original `MetallibSupportPkg-26.6.2-25G82.pkg`:
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Real package CoreDisplay `default.metallib`:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- MetalLib 1.2.7 / `MTLB`;
- contains GPUPass and exact two function constants expected by CoreDisplay.

Installed and old local copies were instead ASCII metadata stubs.
D97FV checkpoint commit `935387c7a425d1e1b684a7941b801d58568894ac`.

## D97FW — systemic metallib materialization failure
Global package/local/root audit proved:
- real regular metallibs `180`;
- local exact `0`, metadata stubs `180`;
- installed exact `0`, metadata stubs `180`;
- all stub-declared sizes matched their real payload sizes.
Checkpoint commit `41df9c6582227c61e8bfb2e99bf8469829db4830`.

## D97FX — corrected source reconstruction PASS
Exact package tree reconstructed into `/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82` with staged full-tree identity and atomic swap.
Proven `180/180` exact real metallibs and corrected CoreDisplay exact identity. Old stub tree retained as backup.
Result checkpoint commit `dea61a79025256a5b24d4b1f62a2c88c79d7588d`.

## D97FY — final corrected-source preflight PASS
Proved:
- VESA and D97EZ-inert state;
- original package exact;
- `180/180` corrected local metallibs exact and direct `MTLB`;
- exact D97DX app/helper/source identities;
- patchdict closure `182 = 180` dynamic MetallibSupportPkg + `2` unchanged 14.6.1 donors;
- official helper exact/codesign PASS.
Checkpoint commit `efe286948b322e41f9479f84b9e60027799dddf3`.

## D97FZ initial stop — EFI token mistake
First post-Restore gate stopped because user had accidentally left `-ocmcd97ez` active. User corrected EFI to inert/commented and rebooted VESA. No Root Patch was executed during the failed gate.
Incident checkpoint commit `07f2e922234dda655cd57b597c791d488c26cad0`.

## D97GA — APFS Restore full PASS
Composed D97FZ + direct micro-gate proved:
- old metadata-stub layer removed;
- corrected local source survived;
- native CoreDisplay restored as MetalLib 1.2.9 (`24128` bytes, SHA `daee638d...`);
- QuartzCore unique non-direct-MTLB target is valid fat Mach-O Metal library container;
- official helper exact/codesign PASS.
Corrected D97DX Root Patch authorized.
Checkpoint commit `0d4bbd4fcddc0ea8cf6f1943b1b0c2e7d233a011`.

## D97GB — corrected Root Patch execution PASS
Exact D97DX transcript proves:
- exact local `26.6.2-25G82` source selected;
- preflight PASS;
- Metal 3802 Common/Common Extended installed;
- `.metallibs` patchset installed including CoreDisplay;
- Monterey GVA/OpenCL installed;
- Intel Haswell patchset installed;
- AuxKC support added for Azul/HD5000 kexts;
- Haswell GL/MTL/VA/userspace bundles installed;
- AuxKC rebuilt/forced;
- patching complete without error.
Checkpoint commit `45480db8db7726a770e3deac1f2bbbfd6fda28b5`.

## D97GC — parser tooling false negative
First post-patch System-volume audit stopped because snapshot device `disk1s8s1` was not normalized to base System volume `disk1s8`. No mount/mutation occurred. Superseded by D97GD.

## D97GD — corrected System-volume metallib audit
Read-only mount of `/dev/disk1s8` proved:
- corrected dynamic metallibs exact `180`;
- missing `0`;
- different `0`;
- metadata stubs `0`;
- CoreDisplay bytes `20739`;
- CoreDisplay SHA `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- CoreDisplay magic `MTLB`;
- exact CoreDisplay identity PASS.

D97GD then stopped when it incorrectly expected the two Haswell `.kext` files to reside on System volume.

## D97GE — Haswell AuxKC closure / corrected Root Patch preboot PASS
Exact OCLP source proves Ventura+ AuxKC support redirects `.kext` files declared for `/System/Library/Extensions` to Data-volume `/Library/Extensions` and marks them `OSBundleRequired=Auxiliary`.

Live gate proved:
- `AppleIntelFramebufferAzul.kext` present in `/Library/Extensions`, correct bundle ID, `OSBundleRequired=Auxiliary`;
- `AppleIntelHD5000Graphics.kext` present likewise;
- both exact paths present in AuxKC build instructions, match count `2`;
- Haswell GLDriver/MTLDriver/VADriver/HSWVA/GraphicsShared bundles present on patched System volume with x86_64 Mach-O payloads;
- official helper exact SHA/team/codesign PASS.

Composite classification:
`D97GE_CORRECTED_ROOTPATCH_PREBOOT=STRUCTURAL_SEMANTIC_PASS`.
Checkpoint commit `c89b84767823b8893578fff62084d10c9a889dcb`.

## Current causal frontier
Closed/excluded:
- set_id_mode bad-bits rejection;
- D97BV delivery;
- Tahoe-only CoreDisplay bootstrap divergence;
- invalid local 25G82 source;
- old installed stub layer;
- corrected patched-volume metallib identity uncertainty;
- Haswell AuxKC placement/enrollment uncertainty.

Pending runtime closure:
`corrected real metallib layer -> GPUPass specialization/render-pipeline -> accelerated GUI or new downstream frontier`.

## Current action — VESA reboot then D97GF
Authorized now:
`D97GE_VESA_REBOOT_AFTER_CORRECTED_ROOTPATCH=YES`.

Required sequence:
1. reboot once with EFI unchanged;
2. remain VESA with `-igfxvesa` active;
3. keep D97EZ ACTIVE inert/commented `#-ocmcd97ez`;
4. no EFI/NVRAM/framebuffer changes;
5. run `OCLP7_D97GF_POSTBOOT_VESA_CORRECTED_ROOTPATCH_GATE.sh` after return;
6. D97GF must prove active-snapshot `180/180` metallib identity, exact CoreDisplay, AuxKC/Data-kext persistence, official helper and VESA boundary;
7. only after D97GF PASS may accelerated boot be separately authorized.

D97GF helper authority:
- commit `631e47b2fd0619d5b1deb80d404ff9f11e082ad3`;
- blob `238dcba4a84429d7ebcc5553264cf06178809b65`.
