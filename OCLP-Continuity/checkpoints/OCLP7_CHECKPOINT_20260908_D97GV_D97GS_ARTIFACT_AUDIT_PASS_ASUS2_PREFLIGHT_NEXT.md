# OCLP7 CHECKPOINT — D97GV D97GS P1-only artifact audit PASS; ASUS2 preflight next

Date: 2026-09-08 EEST

## Entering authority
D97GR causally closed the current MTLCompilerService RIP=0 failure as the missing historical P1 selector bridge. D97GS was then built on the exact D97DX source base with P1 as the only new functional source delta.

## D97GU
D97GU restored only the tracked DEBUG helper build artifact in the Intel-iMac worktree to exact HEAD after first proving:
- the four D97DX source files remained exact;
- source-only D97DX diff SHA256 `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- DEBUG helper build artifact SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- no other tracked drift.

Final D97GU state:
`D97GU_D97DX_SOURCE_BASE=EXACT_RESTORED`
`D97GU_STATUS=PASS`.

## D97GS build
D97GS build completed on the authorized Intel iMac:
- status `BUILD_PASS`;
- outer ZIP SHA256 `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`;
- ZIP bytes `722879148`;
- source diff SHA256 `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- inner executable SHA256 `5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e`;
- DEBUG helper SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- launcher SHA256 `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c`;
- P1 pre-SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- P1 post-SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- no Root Patch/system/EFI/NVRAM/framebuffer mutation/reboot during build.

## D97GV independent artifact audit
D97GV independently proved:
- D97GS ZIP identity exact;
- D97DX ZIP comparator identity exact;
- D97GS and D97DX DEBUG helpers exact same audited SHA;
- D97GS retains exact D97DX base source patch SHA;
- D97GS new source patch exact SHA;
- D97GS inner executable exact build SHA and x86_64;
- D97GS/D97DX launcher exact same SHA;
- codesign PASS;
- base source section count 4, D97GS section count 5;
- all four D97DX source sections byte-for-byte exact in D97GS;
- `sys_patch.py` is the only new source section;
- `sys_patch.py` has zero removed lines and 83 added lines;
- exact P1 method/build/model/pre/post SHA/pre/post bytes/offset/two-byte write/post-diff guards each occur exactly once;
- no P2b/P3/AIR00/D34 replay in the new source delta;
- P1 contract file exact.

Final classifications:
`D97GV_D97GS_ARTIFACT_IDENTITY=PASS`
`D97GV_D97DX_BASE_SECTIONS_EXACT=PASS`
`D97GV_P1_ONLY_SOURCE_DELTA=STATIC_STRUCTURAL_SEMANTIC_PROVEN`
`D97GV_STATUS=PASS_READONLY_AUDIT`.

D97GV audit ZIP:
- SHA256 `5f4b96edcf719ed29779ef8b79e89b1d4066a7b51dfd964990dd428b37b3ae66`;
- bytes `1445783413`.

## Consequence
D97GS is structurally authorized for transfer to ASUS2 as a P1-only Root Patch vehicle, subject to an ASUS2 read-only preflight that must verify:
1. exact D97GS ZIP identity after transfer;
2. Tahoe 25G82 x86_64;
3. active VESA recovery / D97EZ inert;
4. current active MTLCompilerService remains exact pre-P1 SHA before patch;
5. corrected local 25G82 MetallibSupportPkg remains present/valid;
6. extracted D97GS wrapper/helper/inner/source identities match the audited artifact.

No Root Patch is authorized until that ASUS2 preflight passes.
No accelerated boot is authorized.
