# OCLP7 CHECKPOINT — D97GW ASUS2 preflight PASS; D97GS P1-only Root Patch authorized

Date: 2026-09-08 EEST

## Entering authority
D97GV independently audited D97GS and proved:
- exact D97GS ZIP SHA256 `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`, bytes `722879148`;
- exact D97DX wrapper provenance retained;
- exact D97DX four source sections byte-identical;
- only new source section is additive `sys_patch.py` P1 hook;
- P1-only static contract STRUCTURAL-SEMANTIC PROVEN;
- no P2b/P3/AIR00/D34 replay;
- no new legacy main-Metal shadow.

## D97GW live ASUS2 preflight
User ran exact D97GW helper in VESA. Proven:
- macOS `26.6.2 / 25G82`, x86_64;
- bootargs retain active `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh` and inert `#-ocmcd97ez`;
- `D97GW_VESA_GATE=PASS`;
- current active MTLCompilerService SHA256 `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`, exact pre-P1 service;
- corrected local CoreDisplay metallib exact SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`, bytes `20739`, magic `MTLB`;
- local corrected metallib count `180`;
- bad magic count `0`;
- local metallib source PASS;
- transferred D97GS ZIP exact SHA/bytes PASS;
- extracted launcher SHA256 `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c`;
- inner x86_64 executable SHA256 `5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e`;
- DEBUG helper SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- source patch SHA256 `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- transferred artifact PASS;
- `D97GW_STATUS=PASS_READONLY_PREFLIGHT`.

## Authorization
Authorized now:
`D97GS_MANUAL_P1_ONLY_ROOT_PATCH_ON_ASUS2=YES`.

Exact constraints:
1. use only the exact D97GS outer app extracted by D97GW or the exact audited D97GS outer app;
2. keep current VESA bootargs unchanged during Root Patch;
3. run Root Patch manually from inner OCLP launched by the outer wrapper;
4. D97GS must log application of the exact P1 selector bridge and exact post-SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
5. require normal `Patching complete` with no error;
6. close inner OCLP so outer wrapper restores/verifies official privileged helper;
7. DO NOT reboot after Root Patch;
8. DO NOT remove `-igfxvesa`;
9. DO NOT activate D97EZ;
10. audit the newly patched underlying System volume read-only before any reboot.

Still forbidden:
- P2b/P3/AIR00/D34 replay;
- any EFI/NVRAM/framebuffer change;
- accelerated boot;
- automatic reboot;
- legacy main Metal shadow / MetalOld.

## Next
After Root Patch completion and outer-wrapper helper restoration, run a read-only post-patch pre-reboot audit to prove:
- underlying patched System volume MTLCompilerService exact P1 SHA;
- selector postimage exact;
- corrected 180/180 metallib layer remains intact;
- active current VESA snapshot remains distinct/pre-P1 until reboot;
- official helper restored exact.
