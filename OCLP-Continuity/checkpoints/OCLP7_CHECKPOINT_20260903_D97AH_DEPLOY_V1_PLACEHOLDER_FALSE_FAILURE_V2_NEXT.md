# OCLP7 CHECKPOINT — D97AH DEPLOY V1 PLACEHOLDER FALSE FAILURE; V2 NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_ASUS2_AUDIT_V2_PASS_DEPLOY_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests/wrappers remain ASUS2-only; GitHub only for major compile/build/package. Never auto Root Patch or reboot.

D97AH build/delivery/ASUS2 artifact audit v2 remain fully PASS. Exact verified D97AH ZIP remains `/Users/alex/Desktop/OCLP7_D97AH_VERIFIED_RUN33769927671_OpenCore-Patcher.app.zip`, `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`. New D97AH executable remains `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64. Live application remains exact D97AG before successful deployment: `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`, x86_64.

## D97AH deploy wrapper v1 attempt — tooling false failure, no application mutation
ASUS2 ran public wrapper:

```text
PATH=OCLP7_D97AH_ASUS2_EXACT_APP_DEPLOY_OPEN_STOP.command
COMMIT=fe47aa9c06bd416d387e3f64a137b18d471479c1
GIT_BLOB=55304b6e3db1d1d9ab4e86b7e3b9aa154a744567
WRAPPER_SHA256=9e8d15eb78974053ae7a5a831062f2d0ce0d02677037035455088c967f160cab
WRAPPER_BYTES=7779
```

Outer identity and local parse PASS. The wrapper fetched and proved the previously passed D97AG deploy substrate exact:

```text
BASE_COMMIT=fcd817dec08e1ff782316516f7d2432e2b5d51df
BASE_BLOB=e8dca8761903de7f612629ff85ea9ec81bc5d65c
BASE_SHA256=64d7ceb501c8b909b7633a836c371257f1e2c48fd13d4f1f290095b6a4123c96
BASE_BYTES=14858
D97AH_BASE_D97AG_DEPLOY_WRAPPER_IDENTITY_AND_PARSE=PASS
```

All seven pinned old critical lines were present exactly once.

The role-transform code attempted collision-safe renaming via:

```python
placeholder='__OCLP7_PREIMAGE_ROLE_D97AG__'
text=text.replace('D97AF', placeholder)
text=text.replace('D97AG', 'D97AH')
text=text.replace(placeholder, 'D97AG')
```

This placeholder was not actually collision-safe because it itself contained `D97AG`. The second replace transformed the placeholder text before the third replace could restore it. Consequently the expected post-role line `D97AG_EXE_BYTES="6595600"` had cardinality zero and the wrapper stopped with:

```text
D97AH_DEPLOY_IDENTITY_REPLACEMENT_PRE_COUNT=0|D97AG_EXE_BYTES
D97AH_DEPLOY_IDENTITY_REPLACEMENT_CARDINALITY:D97AG_EXE_BYTES="6595600":0
```

Source inspection proves this exception occurred in Python before `out=text.encode(...)`, before `with dst.open('xb')`, before local parse of the derived deploy wrapper and before `/bin/zsh -f "$PATCHED"`. Therefore no derived deploy script was written or executed and no `sudo`, `/Applications` switch, backup, process drain, app open, system target write, Root Patch or reboot occurred.

Classification:

`D97AH_DEPLOY_V1=TOOLING_FALSE_FAILURE_PLACEHOLDER_COLLISION_NO_APPLICATION_MUTATION`.

## Corrected deploy wrapper v2
A new public wrapper was created without GitHub execution/testing:

```text
PATH=OCLP7_D97AH_ASUS2_EXACT_APP_DEPLOY_OPEN_STOP_V2.command
COMMIT=1995889540c75ff59bcc1cae22d959a65a63fa47
GIT_BLOB=47511c55b1712fbb5ed11ca34358c88bc81cd827
```

V2 pins the false-failed v1 wrapper exact by commit/blob/SHA256/bytes, then changes exactly one temporary source line:

```text
placeholder='__OCLP7_PREIMAGE_ROLE_D97AG__'
```

to the neutral collision-free:

```text
placeholder='__OCLP7_PREIMAGE_ROLE_OLD__'
```

It requires exact old/new pre/post cardinality, writes only a private temporary patched copy, locally parses that copy on ASUS2 and then executes the entire pinned v1 flow. All v1 old-substrate, exact identity, semantic marker, rollback, D97AG preimage, D97AH stage/live/open and STOP gates remain unchanged.

## Mutation ledger after v1 false failure

```text
SOURCE_MUTATION=NO
INSTALLED_APP_MUTATION=NO
LIVE_APP_REMAINS=D97AG_EXACT
SYSTEM_TARGET_MUTATION=NO
GOLDEN_MUTATION=NO
ROOT_PATCH=AUTO-NO
REBOOT=AUTO-NO
```

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Do not Root Patch and do not reboot.

Run exactly one bounded ASUS2-only execution of the public-commit-pinned deploy wrapper v2. First prove its public blob and local zsh parse. V2 must then prove the pinned v1 identity, apply exactly the one-line neutral-placeholder correction in temp, parse the corrected v1 and execute the full exact deployment substrate.

Required successful inner evidence includes exact verified D97AH ZIP identity, exact D97AG live preimage, exact D97AH staged/new/live identities, timestamped exact D97AG backup retention, exact-path process drain, atomic switch, fresh exact D97AH process after open, `D97AH_EXACT_APP_DEPLOY_OPEN_STOP=PASS`, v1 outer PASS and v2 PASS. The substrate must restore exact D97AG automatically on a post-switch failure before final exact-open state.

STOP immediately after exact D97AH open/proof. Root Patch remains a separate later manual gate and reboot remains unauthorized.