# OCLP7 CHECKPOINT — D97AG LIVE APP DEPLOY PASS; MANUAL ROOT PATCH NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT_PASS_DEPLOY_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 remain retained with runtime sufficiency NEGATIVE. Golden Sequoia is immutable/read-only. D50/D68/D82 remain reserve-only; D84 is retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Never auto Root Patch or reboot.

Routine tests and live validation remain ASUS2-only under direct user control. GitHub remains reserved for major compilation/build/package workloads.

## D97AG packaged/runtime pre-deploy proof carried forward
D97AG exact app ZIP: `751494420` bytes, SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`.
Packaged executable: `6596544` bytes, SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, x86_64.
ASUS2 frozen runtime audit passed with `D97AG_RUNTIME_OS_LISTXATTR_AVAILABLE=NO`, backend fingerprint `71959f823a2da72c12e53581c85773ebdfd0100b22a780152bf8c69fe2d56286`, source SHA `d02e98be14d1881202565560198a9eb5b3ec3200057db98c4b0820454dab2019`, empty/text/binary xattr values PASS and `D97AG_EXACT_XATTR_CODE_OBJECT_RUNTIME=PASS`.

## Deploy preflight location false failure — no mutation
First deploy attempt used exact wrapper commit `fcd817dec08e1ff782316516f7d2432e2b5d51df`, blob `e8dca8761903de7f612629ff85ea9ec81bc5d65c`, SHA256 `64d7ceb501c8b909b7633a836c371257f1e2c48fd13d4f1f290095b6a4123c96`, `14858` bytes. It stopped fail-closed at `VERIFIED_ZIP_MISSING_OR_SYMLINK` before any `/Applications` mutation. Recovery state was `NO`; no source/system/Golden/Root Patch/reboot mutation occurred.

A bounded ASUS2 search found the exact verified ZIP in `$HOME/.Trash` with the authoritative `751494420` bytes and SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`. It was restored by exact move to `/Users/alex/Desktop/OCLP7_D97AG_VERIFIED_RUN33696449978_OpenCore-Patcher.app.zip`; pre-move and post-move identities matched exactly. Classification: `D97AG_DEPLOY_FIRST_ATTEMPT=TOOLING_INPUT_LOCATION_FALSE_FAILURE_NO_APPLICATION_MUTATION`.

## D97AG exact live app deployment PASS
The same unchanged deploy wrapper was rerun from exact public commit/blob above and completed with outer RC `0`.

Pre-deploy:
```text
VERIFIED_ZIP_BYTES_ACTUAL=751494420
VERIFIED_ZIP_SHA256_ACTUAL=d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846
STAGED_EXE_BYTES=6596544
STAGED_EXE_SHA256=29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628
STAGED_EXE_ARCHS=x86_64
D97AG_STAGED_APP_IDENTITY=PASS
```

Exact live D97AF preimage was proven before mutation:
```text
LIVE_PRE_BYTES=6595600
LIVE_PRE_SHA256=ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470
LIVE_PRE_ARCHS=x86_64
D97AF_LIVE_PREIMAGE=PASS
```

Exact D97AG was prepared beside live, with executable `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628` / x86_64. Exact old OCLP PID `805` was drained; post-drain exact PID set was `NONE`.

Switch result:
```text
BACKUP_EXE_BYTES=6595600
BACKUP_EXE_SHA256=ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470
LIVE_POST_BYTES=6596544
LIVE_POST_SHA256=29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628
LIVE_POST_ARCHS=x86_64
D97AG_LIVE_APP_IDENTITY=PASS
```

Exact D97AG was opened from `/Applications/OpenCore-Patcher.app`; pre-open exact PID set was `NONE`, fresh exact-path PID was `8877`, and final live executable identity remained `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`.

Final classification:
```text
D97AG_EXACT_APP_DEPLOY_OPEN_STOP=PASS
INSTALLED_APP_MUTATION_STATE=D97AG_DEPLOYED_EXACT_OPENED
D97AF_BACKUP_RETAINED=/Applications/OpenCore-Patcher.app.D97AF-before-D97AG-20260903-165317
SOURCE_MUTATION=NO
SYSTEM_TARGET_MUTATION=NO
GOLDEN_MUTATION=NO
ROOT_PATCH=AUTO-NO
REBOOT=AUTO-NO
```

Deploy report: `/Users/alex/Desktop/OCLP7_D97AG_EXACT_APP_DEPLOY_OPEN_STOP_REPORT_20260903-165317.txt`.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Exact D97AG is live and open. Do not reboot.

Next bounded action is **manual Root Patch from the already-open exact D97AG OCLP**, followed by STOP before any reboot. The user may start Root Patch manually and let OCLP finish its patch operation, but must not press/accept reboot afterward.

Return the complete Root Patch terminal/log output. Audit must explicitly verify the D97AG xattr/LC_UUID step no longer raises the D97AF `os.listxattr` exception, verify D97AD/D97AF/D97AG step ordering and target identities, distinguish any generic `Patching complete` from custom-step success, and inspect snapshot/AuxKC state before authorizing any accelerated reboot.

Reboot remains `NOT_AUTHORIZED` until that returned D97AG Root Patch log is accepted. Golden remains immutable/read-only.