# OCLP7 CHECKPOINT — 2026-09-08 — D97HP PARTIAL PASS / AZUL LOAD STATE INCONCLUSIVE / D97HQ READY

## D97HP returned evidence
ASUS2 remains Tahoe 26.6.2 / 25G82 in VESA with D97EZ inert.

D97HP proved before its stop:
- `D97HP_VESA_GATE=PASS`;
- exact D97HO ZIP SHA256 `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`, bytes `722975756`;
- `D97HP_D97HO_ARTIFACT=PASS_EXACT`;
- active P1 service SHA exact `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- P1 postimage `81fe177d0000 @ 0x3494` PASS;
- active MTLCompiler 32023 exact pre-P3 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- P2 remains original `418b81d0000000 @ 0x9A8CD`, no P2b;
- P3 remains unapplied exact preimage `81e100002000 @ 0xA1573`;
- corrected active metallibs exact `180/180`, missing `0`, different `0`.

D97HP then stopped:
`D97HP_STATUS=FAIL`
`D97HP_REASON=AZUL_NOT_LOADED`.

## Classification
This does NOT invalidate the userspace/compiler base and does NOT by itself prove a Haswell driver regression.

Historical D97HD, also under VESA, reported both AppleIntelFramebufferAzul and AppleIntelHD5000Graphics as loaded. Therefore VESA alone is not an explanation for the current `AZUL_NOT_LOADED` result.

Current classification:
`D97HP_USERSPACE_P1_PRE_P3_BASE=STRUCTURAL_SEMANTIC_PASS`
`D97HP_METALLIB_LAYER=180_OF_180_EXACT`
`D97HP_HASWELL_LOAD_STATE=INCONCLUSIVE`
`D97HP_RESTORE_DECISION=DEFERRED`
`D97HP_DIRECT_D97HO_DECISION=DEFERRED`.

Do not Root Patch or Restore from this result alone.

## Current action — D97HQ
Run read-only AuxKC/load-state audit:
`OCLP-Continuity/artifacts/OCLP7_D97HQ_ASUS2_READONLY_AUXKC_HASWELL_STATE_AUDIT.sh`
- commit `eb6cdadc1ce00ee65d87417ce99eb946a4271617`;
- Git blob `b77a65026f0eece6d88f09e58f98430041c61619`.

D97HQ separates:
1. kext bundles present on disk;
2. `kmutil showloaded --collection aux --show all` presence;
3. explicit AUX loaded state;
4. explicit AUX unloaded state;
5. all-collection load information;
6. `kmutil check --collection aux --load-info` consistency;
7. standard on-disk AuxKC presence/inspection;
8. IOKit evidence for Intel framebuffer/accelerator/display services;
9. exact official privileged helper identity/team/codesign.

D97HQ is read-only: no kext load/unload, no Root Patch/Restore, no EFI/NVRAM/framebuffer mutation, no reboot.
