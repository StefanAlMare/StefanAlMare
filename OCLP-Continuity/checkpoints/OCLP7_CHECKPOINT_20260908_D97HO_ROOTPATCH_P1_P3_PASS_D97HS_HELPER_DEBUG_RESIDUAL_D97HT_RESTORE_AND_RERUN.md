# OCLP7 CHECKPOINT — 2026-09-08 — D97HO Root Patch P1+P3 PASS / D97HS helper residual only

## Scope
ASUS2 Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.

## D97HO Root Patch — execution PASS
User ran exact D97HO on the clean/native state previously proven by D97HR.
Root Patch output showed:
- patcher capable of patching;
- exact local MetallibSupportPkg 26.6.2-25G82 used;
- Metal 3802 Common, Metal 3802 Common Extended, Metal 3802 .metallibs, Monterey GVA, Monterey OpenCL, Intel Haswell, Modern Wireless Common installed;
- corrected metallib payload applied across the target set;
- Haswell kexts installed with AuxKC support;
- D97GS P1 applied and exact historical identity PASS: `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- D97HI P3 applied and exact P3-only identity PASS: `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`;
- new Auxiliary Kernel Collection built;
- `Patching complete`;
- reboot requested, but not performed.

Classification:
`D97HO_ROOT_PATCH_EXECUTION=PASS`
`P1_EXACT=PROVEN_BY_PATCHER`
`P3_EXACT_P3_ONLY=PROVEN_BY_PATCHER`
`P2B_AIR00_D34=NOT_REPLAYED`

## D97HS first run — partial PASS, stopped only at helper gate
D97HS proved before stopping:
- 25G82;
- `-igfxvesa` active;
- D97EZ inert;
- active booted snapshot still native Tahoe;
- active native MTLCompilerService exact SHA `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- active native CoreDisplay exact SHA `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`, bytes 24128;
- active legacy 32023 absent, as expected pre-reboot.

D97HS then found active privileged helper:
`993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`
with no TeamIdentifier.
This is the exact known D97GS/D97HO DEBUG helper, not a new unknown binary.

Therefore:
`D97HS_FAIL=INFRASTRUCTURE_HELPER_RESIDUAL_ONLY`
`D97HS_P3_STATUS=NOT_INVALIDATED`
`REBOOT=NO`

## Corrective action
Reuse the previously proven D97HA official-helper-only restore workflow:
- active debug helper must match exact `993bf7...`;
- official source must match exact `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a` and Team `S74BDJXQMD`;
- replace only `/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper`;
- no Root Patch, no Restore, no EFI/NVRAM/framebuffer mutation, no reboot.

After official helper restoration, rerun exact D97HS from commit `dcfc861b9bd23a8ac00d7d07c43f4166ea402f18`, blob `dd71dbd1149a6c96b3e754ff500f029f536bdef5`.

D97HS must then proceed to prove on the underlying System volume:
- exact P1;
- exact MTLCompiler 32023 P3-only SHA `0066a944...`;
- P2 original +0xD0, no P2b;
- exact P3 postimage;
- corrected metallibs 180/180;
- Haswell kexts present in new AuxKC.

No reboot until D97HS full PASS.
