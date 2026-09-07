# OCLP7 CHECKPOINT — D97GT source exact; only D97DX DEBUG-helper build artifact drift; D97GU ready

Date: 2026-09-08 EEST

## Entering authority
D97GR closed the current MTLCompilerService NULL-call cause as exact historical P1 selector bridge missing. D97GS was designed as a D97DX-derived P1-only build on the authorized Intel iMac.

Initial D97GS execution stopped before any source insertion or build because full `git diff` SHA was `12a397b06951070ec41df8a67af1d008106f351b081ebdc09ce8333adb4647b8`, not expected D97DX source diff `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`.

Classification at that moment: guarded build stop, no semantic evidence, no source mutation by D97GS.

## D97GT read-only drift audit
Returned archive:
`OCLP7_D97GT_D97DX_SOURCE_DRIFT_AUDIT_20260908_014508.zip`.

HEAD remains exact:
`b9df76ebdf3e768b37c1cc980e8444aa837c623e`.

Tracked changed files were:
1. `OpenCore-Patcher-GUI.spec`;
2. `opencore_legacy_patcher/support/metallib_handler.py`;
3. `opencore_legacy_patcher/sys_patch/patchsets/detect.py`;
4. `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`;
5. `ci_tooling/privileged_helper_tool/com.dortania.opencore-legacy-patcher.privileged-helper`.

The four intended D97DX source sections are byte-for-byte patch-identical to the exact embedded D97DX source patch:
- `OpenCore-Patcher-GUI.spec` section SHA `7670eda6a22c69924b9506abc04a83f8a2082284dffa1a40fcfe9ea0da55d30f` MATCH;
- `metallib_handler.py` section SHA `6ef47724a9bc56f2c17becaac6220911547226e74c6a925687fcfb3fbf760d30` MATCH;
- `detect.py` section SHA `7baa89d6852e280a90fe0327036b2e8bdf5d514bc999bfb915d674f301ba4781` MATCH;
- `metal_3802.py` section SHA `81b77f8e78e6a682432a0156bacd3fe87b8e2a4c4f18932725a5ad2a43f7ced7` MATCH.

The exact expected embedded D97DX source patch was found at:
`~/Desktop/OpenCore-Patcher-Tahoe-D97DX.app/Contents/Resources/OCLP7_D97DX_SOURCE.patch`
with SHA `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`.

The entire expected-vs-current patch delta is only the tracked binary DEBUG helper section.

Current DEBUG helper SHA:
`993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`.

This equals the exact D97DX DEBUG helper deliberately compiled during the earlier D97DX build and already audited as valid.

HEAD/original helper file SHA256:
`772d2246825f9f1c471007b1b9bf151e20cac8522911e3cb4705524543be55be`.

Untracked `sys_patch_dict-25G82.py` remains expected build support state and is not part of the tracked source diff.

## Classification
`D97GT_D97DX_SOURCE_DRIFT_HYPOTHESIS=NEGATIVE`.

`D97GT_D97DX_FOUR_SOURCE_SECTIONS=EXACT_PASS`.

`D97GT_EXTRA_TRACKED_CHANGE=KNOWN_D97DX_DEBUG_HELPER_BUILD_ARTIFACT_ONLY`.

The first D97GS stop was a guard/tooling false negative caused by conflating the intentionally compiled tracked DEBUG helper with source drift.

## D97GU deterministic preparation
Do not global-reset the worktree.

D97GU may restore only the exact DEBUG helper tracked path after proving:
- current helper SHA is exact D97DX DEBUG helper `993bf7...`;
- the four source-only diff is exact D97DX `c8b45...`;
- no other tracked drift exists.

Before one-path restore, D97GU backs up the exact DEBUG helper to Desktop. It then executes only:
`git checkout HEAD -- ci_tooling/privileged_helper_tool/com.dortania.opencore-legacy-patcher.privileged-helper`

Afterward it requires:
- restored helper SHA exact HEAD `772d2246...`;
- tracked changed set exactly the four D97DX source files;
- source-only diff SHA exact `c8b45...`;
- `sys_patch.py` pristine.

D97GU helper:
`OCLP-Continuity/artifacts/OCLP7_D97GU_IMAC_PREPARE_EXACT_D97DX_SOURCE_BASE.sh`
- commit `e827dc765cae459c1a1299f831b9199a65327590`;
- Git blob `4020579e59faef9feacb833342dfb0eae4f2048f`.

## Current action
Run D97GU on Intel iMac. If PASS, rerun the unchanged D97GS helper. No ASUS2 action, Root Patch, or reboot is authorized yet.
