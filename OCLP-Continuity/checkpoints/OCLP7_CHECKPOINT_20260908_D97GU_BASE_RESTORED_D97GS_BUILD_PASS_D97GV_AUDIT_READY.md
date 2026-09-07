# OCLP7 CHECKPOINT — D97GU exact D97DX base restored; D97GS P1-only build PASS; D97GV audit next

Date: 2026-09-08 EEST

## Entering authority
D97GR causally closed the current MTLCompilerService NULL-call frontier as missing historical P1 selector bridge. D97GT then proved the Intel-iMac worktree had no source drift: all four D97DX source sections remained byte-identical to the audited D97DX patch; the only extra tracked change was the exact D97DX DEBUG helper build artifact.

## D97GU — deterministic source-base preparation PASS
User ran exact D97GU helper on the authorized Intel iMac.

Proven before restoration:
- current tracked DEBUG helper SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9` = exact D97DX DEBUG helper build artifact;
- four-source-only diff SHA256 `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4` = exact audited D97DX source diff;
- tracked changes were exactly the four D97DX source files plus the DEBUG helper artifact.

D97GU:
- backed up the exact DEBUG helper build artifact to Desktop;
- restored only that single tracked helper path from HEAD;
- restored helper SHA256 `772d2246825f9f1c471007b1b9bf151e20cac8522911e3cb4705524543be55be`;
- did not reset/checkout any source path globally.

After restoration:
- tracked changes exactly the four D97DX source files;
- four-source diff remained exact SHA256 `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- `sys_patch.py` remained pristine.

Classification:
`D97GU_D97DX_SOURCE_BASE=EXACT_RESTORED`
`D97GU_ONLY_BUILD_ARTIFACT_CLEANED=PASS`.

## D97GS — P1-only D97DX-derived build PASS
User reran the unchanged exact D97GS build helper on the Intel iMac.

Pre-build source gate:
- exact D97DX source-base diff SHA256 `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4` PASS;
- changed-source set before insertion exactly four D97DX files.

D97GS source insertion:
- adds only `opencore_legacy_patcher/sys_patch/sys_patch.py` as a fifth changed source file;
- P1 guard contract PASS;
- exact required build/model/pre-SHA/post-SHA/preimage/postimage/offset/hook tokens each present exactly once;
- no P2b replay;
- no P3 replay;
- no AIR00 replay;
- no D34 replay.

Built inner OCLP:
- x86_64;
- executable SHA256 `5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e`.

Exact D97DX wrapper template provenance:
- D97DX ZIP SHA256 `2f84fcaf39eb6c5a917ebb7b878bf2bef495050981b52fbe41e971fa1fe5cf1a`;
- DEBUG helper SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- base D97DX source patch SHA256 `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- launcher SHA256 `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c`.

Final D97GS artifact:
- outer app `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97GS.app`;
- ZIP `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97GS.zip`;
- ZIP SHA256 `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`;
- ZIP bytes `722879148`;
- source diff SHA256 `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- inner executable SHA256 `5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e`;
- DEBUG helper SHA256 exact D97DX `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- launcher SHA256 exact D97DX `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c`;
- P1 pre-SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- P1 post-SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- build performed no Root Patch, no system-root mutation, no EFI/NVRAM/framebuffer mutation, no reboot.

Classification:
`D97GS_BUILD=PASS`
`D97GS_P1_ONLY_NEW_FUNCTIONAL_DELTA=PASS`.

This is a build result, not yet an authorization to Root Patch ASUS2.

## Next — D97GV independent artifact audit
Before any ASUS2 mutation, run only the independent read-only D97GV audit on Intel iMac.

D97GV must prove:
1. exact D97GS ZIP SHA/bytes;
2. exact D97DX base ZIP provenance;
3. exact DEBUG helper and launcher identity retained;
4. exact D97GS inner executable identity/arch/codesign;
5. exact D97DX base source patch retained inside D97GS;
6. all four base D97DX diff sections are byte-identical in the D97GS source patch;
7. the only new source section is `sys_patch.py` and is additive P1-only;
8. exact P1 build/model/pre-SHA/post-SHA/offset/two-byte-write guards remain present;
9. no P2b/P3/AIR00/D34 replay and no new legacy main-Metal shadow.

No ASUS2 Root Patch or accelerated boot is authorized until D97GV passes and is classified.