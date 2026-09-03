# OCLP7 CHECKPOINT — D97AH CMP PROBE PASS; ASUS2 AUDIT V2 NEXT

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_GITHUB_BUILD_RELEASE_PASS_ASUS2_AUDIT_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests/audits stay on ASUS2; GitHub only for major compile/build/package. Never auto Root Patch or reboot.

D97AH source/build/private-release identities are unchanged from the previous checkpoint. Authoritative v5 build remains workflow/run/job `349436422 / 33769927671 / 100697248264`, head `d04ddd28c784a0b30c6629feeface10804d5d591`, app ZIP `751494634` bytes / SHA256 `d917185eea69829b9b0d3be47a0fd85a3795dea781c77ebfea6acb1ae84f6a48`, packaged executable `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64. Live `/Applications/OpenCore-Patcher.app` remains exact D97AG.

## ASUS2 private-release audit attempt 1
Attempt 1 proved PASS through exact release binding, all seven asset identities/checksum sets, exact ZIP reassembly/CRC/safe-member audit, exact packaged executable identity, reports ZIP safe-member/file-set/checksum audit. It then stopped because wrapper v1 invoked literal `/bin/cmp`, which does not exist. The failure label `REPORT_AND_APP_EXECUTABLE_DIFFER` is tooling-only because `cmp` itself could not launch. No verified ZIP was retained and no source/application/system/Golden/Root Patch/reboot mutation occurred.

Classification retained: `D97AH_ASUS2_AUDIT_ATTEMPT1=TOOLING_FALSE_FAILURE_CMP_ABSOLUTE_PATH_NO_MUTATION`.

## ASUS2 cmp capability/path probe — PASS
Bounded read-only ASUS2 probe directly proved:

```text
/bin/cmp: EXISTS=NO
/usr/bin/cmp: EXISTS=YES
/usr/bin/cmp: REGULAR_FILE=YES
/usr/bin/cmp: EXECUTABLE=YES
/usr/bin/cmp: Mach-O universal x86_64 + arm64e
/usr/bin/cmp: LIPO=PASS
command -v cmp=/usr/bin/cmp
whence -a cmp=/usr/bin/cmp
type -a cmp=cmp is /usr/bin/cmp
/usr/bin/which -a cmp=/usr/bin/cmp
```

Probe mutation ledger:

```text
SOURCE_MUTATION=NO
INSTALLED_APP_MUTATION=NO
SYSTEM_TARGET_MUTATION=NO
GOLDEN_MUTATION=NO
ROOT_PATCH=AUTO-NO
SNAPSHOT_MUTATION=NO
REBOOT=AUTO-NO
```

Therefore the prerequisite from the previous checkpoint is satisfied: there is a valid executable `cmp` at a different absolute path, `/usr/bin/cmp`.

## Corrected ASUS2 audit wrapper v2
A new public wrapper was created without GitHub execution/testing:

```text
PATH=OCLP7_D97AH_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT_V2.command
COMMIT=85b5f8b3487cc940918dc446890b959daa7cc4ed
GIT_BLOB=c5a91b5d50a82b17cc4ea2a60303934182540fb0
```

The v2 wrapper pins wrapper v1 commit `d926fbb736198409931e6bee13aeb3da896dcd73` / blob `7f11298c46a43c15d2ac1a77d80fd05d4e1e2f08`, requires `/usr/bin/cmp` executable and `/bin/cmp` absent, then selects exactly one complete v1 line:

`/bin/cmp -s "$REPORT_EXE" "$APP_EXE" || fail "REPORT_AND_APP_EXECUTABLE_DIFFER"`

and replaces only that line in a private temp copy with:

`/usr/bin/cmp -s "$REPORT_EXE" "$APP_EXE" || fail "REPORT_AND_APP_EXECUTABLE_DIFFER"`.

It requires exact pre/post line cardinality, writes only the temporary patched wrapper, runs `zsh -n` locally on ASUS2, and then executes the full original private-release audit from the beginning. No OCLP source or installed application is modified by this wrapper.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
ASUS2 STOP. Do not deploy, Root Patch or reboot.

Run exactly one bounded ASUS2-only execution of the public-commit-pinned v2 audit wrapper. Audit its public wrapper blob and local zsh parse first. Then allow v2 to pin/verify v1, perform only the exact temporary `/bin/cmp` -> `/usr/bin/cmp` line transform, locally parse the patched v1 wrapper, and rerun the complete private-release artifact/reassembly/report audit from the beginning.

Required final evidence includes explicit `D97AH_REPORT_AND_APP_EXECUTABLE_BYTE_IDENTITY=PASS`, all report content gates, exact verified Desktop ZIP retention, `D97AH_ASUS2_PRIVATE_RELEASE_ARTIFACT_AUDIT=PASS`, and outer/v2 PASS. Printed PASS alone is insufficient; return complete terminal output for assistant audit.

No `/Applications` mutation, no OCLP launch, no Root Patch, no snapshot mutation and no reboot. Only after a complete audit v2 PASS is returned and accepted may a separate D97AG->D97AH backup/deploy/open/STOP action be authorized.
