# OCLP7 CHECKPOINT — 2026-09-08 — D97HM PORTABLE D97HI INNER BUILD PASS / D97HN AUDIT NEXT

## Build host
Portable Intel MacBook Pro build host:
- macOS 15.7.9 / 24G830;
- Intel Core i9-9880H / x86_64;
- Xcode SDK 26.2;
- Python 3.13.15 x86_64.

## D97HM result
D97HM corrected only the prior regex-based P1 audit methodology by reconstructing exact D97GS in a temporary worktree and comparing the AST-bounded `_d97gs_apply_p1_selector_bridge` FunctionDef source bytes.

Exact results:
- current D97HI source diff SHA256 `c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2` PASS;
- exact D97GS source patch SHA256 `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- reconstructed D97GS diff exact same SHA PASS;
- P1 AST source range bytes pre/post = 3466/3466;
- P1 AST SHA pre/post = `387311b011ffec5931f439a1911c19032e26689e648fd6b074bc121d42d573a1`;
- `D97HM_P1_AST_BYTE_IDENTICAL=PASS`;
- `D97HM_P1_FUNCTION_PRESERVED_EXACT=PASS`;
- P3 method/hook/pre-SHA/post-SHA/offset/preimage/postimage counts all 1;
- hook order P1 -> P3 -> continuation PASS;
- `D97HM_P3_SOURCE_CONTRACT=STATIC_STRUCTURAL_SEMANTIC_PROVEN`;
- Universal-Binaries SHA exact `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`;
- payloads.dmg SHA `7772bd83c1a30676bdac9b7f5374acf9bf78c885c1cfc7b30385910272005393`.

## Built D97HI inner artifact
Build completed successfully.

Exact identities:
- inner executable x86_64;
- inner executable SHA256 `1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`;
- source diff SHA256 `c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`;
- portable ZIP `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97HI-INNER.zip`;
- ZIP SHA256 `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`;
- ZIP bytes `722927108`.

Functional classification:
`D97HI_STATUS=BUILD_PASS_PORTABLE_INNER`
`D97HI_NEW_FUNCTIONAL_DELTA=P3_ONLY`
`D97HI_P1_BASE=PRESERVED_EXACT`
`D97HI_P2B_REPLAY=NO`
`D97HI_AIR00_REPLAY=NO`
`D97HI_D34_REPLAY=NO`
`D97HI_P1_POST_SHA256=a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`
`D97HI_P3_POST_SHA256=0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.

No Root Patch, EFI/NVRAM/framebuffer mutation or reboot occurred.

## Current action
Before any transfer to ASUS2 or wrapper assembly, perform independent D97HN audit of:
1. current source diff exact identity;
2. P1 exact AST byte identity against reconstructed D97GS;
3. P3-only contract and forbidden P2b/AIR00/D34 absence;
4. portable inner app architecture/codesign/executable SHA;
5. portable ZIP SHA/bytes and extraction identity.

No ASUS2 transfer, wrapper assembly, Root Patch or reboot is authorized until D97HN PASS is reviewed.
