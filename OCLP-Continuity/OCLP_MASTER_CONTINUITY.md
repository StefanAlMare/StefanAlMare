# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

## Current authoritative checkpoints
Runtime/failure localization:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97FJ_WINDOWSERVER_IPS_CORE_DISPLAY_METAL_PIPELINE_FRONTIER.md`

Current remediation/execution authority:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97GE_CORRECTED_ROOTPATCH_PREBOOT_STRUCTURAL_SEMANTIC_PASS_VESA_REBOOT_AUTHORIZED.md`
- commit `c89b84767823b8893578fff62084d10c9a889dcb`.

Previous remediation gates:
- D97GA post-revert full PASS / corrected Root Patch authorized — commit `0d4bbd4fcddc0ea8cf6f1943b1b0c2e7d233a011`;
- D97FY corrected-source final preflight PASS — commit `efe286948b322e41f9479f84b9e60027799dddf3`;
- D97FX source reconstruction PASS — commit `dea61a79025256a5b24d4b1f62a2c88c79d7588d`;
- D97FV real CoreDisplay metallib recovered — commit `935387c7a425d1e1b684a7941b801d58568894ac`;
- D97FW global metallib materialization failure — commit `41df9c6582227c61e8bfb2e99bf8469829db4830`.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current running boot remains VESA;
- boot args retain `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`;
- D97EZ ACTIVE mode remains inert/commented as `#-ocmcd97ez`;
- exact audited D97EZ/OCLPMetalCompat 0.0.12 remains in EFI;
- D97EW persistent collector remains installed;
- normal framebuffer baseline remains 3/3/3;
- corrected Root Patch has now been executed successfully but has NOT yet been rebooted into;
- no EFI/NVRAM/framebuffer changes are authorized before the postboot VESA gate;
- Golden remains immutable/read-only.

Never auto Root Patch. Never auto reboot.

## Functional baseline / permanent method
Accepted functional baseline remains exactly:
- P1 selector bridge;
- P2b request-layout bridge `request+0xD0 -> request+0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback producing AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

D22 remains accepted AIR 2.6 / Metal 3.1 semantic proof. D34 cave remains protected. D50/D68/D82 reserve-only; D84 retired.

Methodology remains:
- module-boundary + semantic evidence + far-frontier;
- binary search only inside failed module;
- universal/no-PID coverage where requests vary;
- never equate control flow with semantic proof;
- evidence vocabulary remains REACHED / CONTROL-FLOW PROVEN / SEMANTIC PROVEN / STRUCTURAL-SEMANTIC PROVEN / STATIC-MAPPED-PROVEN / NEGATIVE / INCONCLUSIVE / UNKNOWN.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- no legacy main Metal shadow;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no true-five reapplication;
- no global `set_id_mode` mask;
- no semantic claim for bit `0x200` beyond measured evidence;
- preserve `ipc_control_port_options=0` and `-amfipassbeta`;
- no unrelated T2/Haswell boot-variable experiment at this frontier.

## Settled runtime facts before metallib remediation
### D97BV / D97DT
Selective true-3802 delivery is CLOSED PASS on exact 25G82. D97FS later proved active-cache differences are exactly the intentional D97BV SITE/CAVE runtime postimages.

### D97EB / D97EE
1/1/1 framebuffer experiment CLOSED NEGATIVE. Normal 3/3/3 remains authoritative.

### D97EY -> D97FH
Exact measured failure was `set_id_mode mode=0x224` vs accepted `0x24`. D97EZ only maps exact `0x224 -> 0x24`, all other modes exact passthrough. D97FH ACTIVE run proved 16/16 adapted + 4/4 passthrough successes, zero failures. Old bad-bits blocker CLOSED PASS.

## D97FJ / D97FT fatal frontier
Two WindowServer crashes converged on:
`CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState -> native Metal render-pipeline validation`.

D97FT proved:
- exact Tahoe CoreDisplay/Metal images;
- GPUPass construction flow;
- bootstrap tuple `0xFFFFFFFF / 0xFFFFFFFF / 0x5E` (`BGR10A2Unorm`);
- same mapped bootstrap recipe in working Golden;
- Crash A enters GPUPass specialization error-report path;
- Crash B reaches Metal validation-context finalization/abort;
- `validateWithDevice +716` is not a unique predicate.

Pure Tahoe-vs-Haswell CoreDisplay bootstrap divergence is not the leading hypothesis.

## D97FV / D97FW — systemic metallib defect discovered
Pinned original package:
`/Users/alex/Downloads/MetallibSupportPkg-26.6.2-25G82.pkg`
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Real package CoreDisplay `default.metallib`:
- bytes `20739`;
- SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- MetalLib 1.2.7 / `MTLB`;
- contains GPUPass and exact two function constants expected by CoreDisplay.

Old local/install copies were metadata-text stubs. D97FW proved system-wide:
- 180 real regular metallibs in package;
- old local exact `0`, metadata stubs `180`;
- old installed exact `0`, metadata stubs `180`.

Primary common-cause model became:
`metadata-stub metallib layer -> invalid/missing GPUPass -> specialization/descriptor failure -> Metal validation abort -> WindowServer death`.

## D97FX / D97FY — corrected source
D97FX reconstructed the full local `26.6.2-25G82` tree byte-for-byte from the pinned package, preserving old stub tree backup.
D97FY then revalidated:
- `180/180` dynamic metallibs exact;
- all direct `MTLB`;
- exact CoreDisplay SHA;
- exact D97DX app/helper/source identities;
- patchdict closure `182 = 180` dynamic MetallibSupportPkg + `2` unchanged `14.6.1` donors;
- VESA state and official helper PASS.

## D97GA — APFS Root Patch Restore PASS
After Restore and VESA reboot, old installed stub layer was gone:
- metadata stubs `0`;
- native CoreDisplay restored as MetalLib 1.2.9, bytes `24128`, SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`;
- unique non-direct-MTLB QuartzCore path proved valid fat Mach-O Metal library container;
- official helper exact/codesign PASS.

Corrected D97DX Root Patch then authorized.

## D97GB — corrected Root Patch execution PASS
Manual exact D97DX Root Patch transcript proves:
- exact local `26.6.2-25G82` source selected;
- preflight PASS;
- Metal 3802 Common/Common Extended installed;
- all `.metallibs` patchset processed including CoreDisplay;
- Monterey GVA/OpenCL installed;
- Intel Haswell patchset installed;
- AuxKC support added for `AppleIntelFramebufferAzul.kext` and `AppleIntelHD5000Graphics.kext`;
- Haswell GL/MTL/VA/userspace bundles installed;
- AuxKC built and forced;
- `Patching complete` reached with no error.

Corrected Root Patch has not yet been rebooted into.

## D97GC / D97GD — corrected patched System volume metallibs proven
D97GC first stopped on snapshot-device parser false negative (`disk1s8s1`). D97GD normalized to `disk1s8` and mounted it read-only.

D97GD proved byte-for-byte on the newly patched System volume:
- `PATCHED_METALLIB_EXACT=180`;
- missing `0`;
- different `0`;
- metadata stubs `0`;
- CoreDisplay bytes `20739`;
- CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- CoreDisplay magic `MTLB`;
- exact CoreDisplay identity PASS.

Thus the original metallib materialization defect is repaired preboot and the GPUPass payload is structurally exact.

D97GD then stopped on a second audit assumption: it expected Haswell `.kext` files on System volume.

## D97GE — Haswell AuxKC closure / corrected Root Patch preboot PASS
Exact OCLP source proves that on Ventura+ with AuxKC support, `.kext` files declared for `/System/Library/Extensions` are deliberately redirected to Data-volume `/Library/Extensions` and marked `OSBundleRequired=Auxiliary`.

Live D97GE gate proved:
- `/Library/Extensions/AppleIntelFramebufferAzul.kext` present, bundle id correct, `OSBundleRequired=Auxiliary`;
- `/Library/Extensions/AppleIntelHD5000Graphics.kext` present, bundle id correct, `OSBundleRequired=Auxiliary`;
- both exact paths present in AuxKC build instructions, match count `2`;
- Haswell userspace bundles present on the read-only patched System volume: GLDriver, MTLDriver, VADriver, HSWVA, GraphicsShared, all with x86_64 Mach-O payloads;
- official privileged helper exact SHA/team/codesign PASS.

Composite classification:
`D97GE_CORRECTED_ROOTPATCH_PREBOOT=STRUCTURAL_SEMANTIC_PASS`.

This proves preboot structure/identity, not accelerated runtime success.

## Current causal frontier
Closed/excluded:
- set_id_mode bad-bits rejection;
- D97BV delivery;
- Tahoe-only CoreDisplay bootstrap divergence;
- invalid local 25G82 source tree;
- old installed stub layer;
- corrected patched-volume metallib identity uncertainty;
- Haswell AuxKC placement/enrollment uncertainty.

Pending runtime closure:
`corrected real metallib layer -> GPUPass specialization/render-pipeline -> accelerated GUI or new downstream frontier`.

## Current action — VESA reboot, then D97GF
AUTHORIZED:
`D97GE_VESA_REBOOT_AFTER_CORRECTED_ROOTPATCH=YES`.

Required exact sequence:
1. reboot once with EFI unchanged;
2. remain VESA (`-igfxvesa` active);
3. D97EZ ACTIVE remains inert/commented (`#-ocmcd97ez`);
4. no EFI/NVRAM/framebuffer changes;
5. after return, run `OCLP-Continuity/artifacts/OCLP7_D97GF_POSTBOOT_VESA_CORRECTED_ROOTPATCH_GATE.sh`;
6. D97GF must prove the active snapshot has all 180 exact corrected metallibs, exact CoreDisplay identity, preserved Haswell Data-kext/AuxKC state, official helper identity and VESA boot boundary;
7. only after D97GF PASS may an accelerated boot be separately authorized.

Still NOT authorized before D97GF PASS:
- disabling `-igfxvesa`;
- enabling `-ocmcd97ez`;
- accelerated boot;
- EFI/NVRAM/framebuffer changes;
- Golden mutation;
- legacy main Metal shadow;
- true-five reapplication.
