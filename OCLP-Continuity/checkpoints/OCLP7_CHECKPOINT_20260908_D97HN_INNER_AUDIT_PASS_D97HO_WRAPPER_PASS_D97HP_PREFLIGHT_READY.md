# OCLP7 CHECKPOINT — 2026-09-08 — D97HN INNER AUDIT PASS / D97HO WRAPPER PASS / D97HP PREFLIGHT READY

## Target
ASUS2 / Tahoe 26.6.2 build 25G82 / Haswell 8086:0412 / SMBIOS MacBookAir6,2.
Current ASUS2 boot is VESA recovery with D97EZ inert.

## D97HN independent inner audit — PASS
D97HN independently audited the portable D97HI inner artifact on the non-target Intel MacBook Pro.

Source/provenance:
- D97HI source diff SHA256 `c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`;
- reconstructed D97GS reference diff SHA256 `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- P1 AST-bounded bytes exact identical to D97GS;
- P3 method/hook/pre-SHA/post-SHA/offset/preimage/postimage exactly once;
- hook order P1 -> P3 -> continuation PASS;
- P2b/AIR00/D34 replay = NO.

Artifact identity:
- inner arch `x86_64`;
- inner executable SHA256 `1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`;
- inner ZIP SHA256 `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`;
- inner ZIP bytes `722927108`;
- built app vs ZIP extracted manifest identical 156/156;
- audit ZIP SHA256 `f561d9531ad7485963e1fd56544bac6b8bca2d4f6b3b3341095f2df2484db5ae`.

Classification:
`D97HN_STATUS=PASS_INDEPENDENT_INNER_AUDIT`
`D97HN_CLASSIFICATION=STATIC_STRUCTURAL_SEMANTIC_PROVEN`.

## D97HO ASUS2 wrapper assembly — PASS
Exact inputs on ASUS2:
- D97GS ZIP SHA256 `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`;
- audited D97HI inner ZIP SHA256 `b0fe14f2f212e87a4f73b5ae210a3fda104518399968b2035b3a4f7616ff3e94`.

D97HO verified/preserved exact D97GS wrapper components:
- launcher PASS;
- DEBUG helper PASS;
- D97DX source patch PASS;
- D97GS source patch PASS.

D97HI nested inner:
- executable SHA256 exact `1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`;
- arch x86_64;
- nested codesign PASS;
- preserved exact after wrapper assembly.

D97HO output:
- `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97HO.app`;
- `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97HO.zip`;
- ZIP SHA256 `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`;
- ZIP bytes `722975756`;
- outer codesign PASS.

Classification:
`D97HO_STATUS=PASS_WRAPPER_ASSEMBLY`
`D97HO_CLASSIFICATION=STATIC_STRUCTURAL_SEMANTIC_PROVEN`.

No Root Patch or reboot occurred.

## Current causal contract
Current measured repair state remains:
- P1 runtime semantic progress PROVEN;
- P2b NOT justified as current next patch;
- P3 serialized-bitcode bridge is the only newly authorized functional delta;
- AIR00/D34 remain unauthorized.

Exact P3-only compiler post-SHA:
`0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.

## CURRENT ACTION — D97HP read-only ASUS2 preflight
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HP_ASUS2_READONLY_PREFLIGHT_D97HO_AND_ACTIVE_P1_PRE_P3.sh`
- commit `51de1da3e8da4808ae0a816cd8eb0884310232ba`.

D97HP must prove simultaneously:
1. current boot VESA and D97EZ inert;
2. exact D97HO ZIP `a1aa24d5... / 722975756` and exact nested provenance/components;
3. active MTLCompilerService exact P1 SHA `a8716ffd...` and exact postimage at 0x3494;
4. active MTLCompiler 32023 exact unmodified pre-P3 SHA `ddabe975...`;
5. P2 still original `+0xD0` and P3 exact preimage `81e100002000` at 0xA1573;
6. corrected metallib layer exact 180/180 and CoreDisplay exact `b848d54e... / 20739 / MTLB`;
7. Haswell kexts installed/loaded;
8. official privileged helper exact SHA/Team.

D97HP is read-only and does not authorize Root Patch itself.

## Restore/direct-patch decision
Do not decide from assumptions. After D97HP PASS, review the exact active P1-only/pre-P3 state and choose between:
- Restore-first -> clean native baseline -> D97HO Root Patch; or
- direct D97HO Root Patch over exact P1-only active state.

No Root Patch, Restore, reboot, acceleration, EFI/NVRAM/framebuffer change, P2b, AIR00 or D34 is authorized before D97HP review.
