# OCLP7 CHECKPOINT — D97AH ROOT PATCH FULL PASS; ACCELERATED BOOT READY

Date: 2026-09-03 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AH_DEPLOY_OPEN_PASS_ROOTPATCH_READY.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 retained with runtime sufficiency NEGATIVE. Golden Sequoia immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests remain ASUS2-only; GitHub only for major compile/build/package. Root Patch/reboot are manual-only and separately authorized.

D97AH exact installed app before Root Patch: `/Applications/OpenCore-Patcher.app`, executable `6596544` bytes / SHA256 `207b4e0e0c6fa6229f5539cad70d4e06cf3472a6ad59079f8b48f30495ef7acf`, x86_64. Exact retained D97AG backup: `/Applications/OpenCore-Patcher.app.D97AG-before-D97AH-20260903-200708`, executable SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628`.

## Manual D97AH Root Patch — FULL PASS
The complete ASUS2 Root Patch output was audited raw, not accepted from the final generic PASS alone.

Preflight and patchset:
- exact local metallib `26.6.2-25G82` found;
- Root Patching possible;
- root volume mounted elevated;
- preflight completed;
- patchset for `MacBookAir6,2` applied, including Metal 3802, Monterey GVA/OpenCL, Intel Haswell and Modern Wireless;
- AuxKC target kexts handled.

Accepted functional lineage passed again:

```text
P1 selector 31001 -> 32023 verified
P2b request+0xD0 -> request+0x110 verified
P3 serialized-bitcode path verified
AIR00 verified
D34 CallsiteEquivalentReset+PreBackendMarker verified
D81P_TRUE_FIVE_FINAL_MTL_SHA=6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01
P6_REQUEST_DIALECT_CALLSITE_PORTS=PASS
P7_RAW88_A8_READ_PORTS=PASS
D97AD_PRE_D97_VALIDATOR_WHOLE_STAGE_EXIT_CLASSIFIER=PASS
D97AD_COMMITTED_MTL_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755
```

## D97AH corrected D97AF LC_UUID transaction — PROVEN COMPLETE
The real privileged Root Patch path reached the D97AF metadata/UUID method and completed the transaction that D97AG previously could not pass because of `/bin/chflags`.

Exact evidence:

```text
D97AF_TARGET_METADATA_POLICY=MODE_OWNER_FLAGS_XATTRS_PRESERVE_EXACT|ACL_NONE_REQUIRED|TIMES_ALLOWED_TO_CHANGE
D97AF_TARGET_FLAGS_PRE=524288
D97AF_TARGET_XATTRS_PRE=[]
D97AF_TARGET_ACL_PRE=NONE
D97AF_LC_UUID_BUILD_STAMP_PRE_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755
D97AF_LC_UUID_BUILD_STAMP_OLD=D5CE0008-587C-3861-971A-4BAEFB7B9C5B
D97AF_LC_UUID_BUILD_STAMP_NEW=A4F456DF-7447-49BF-AC4F-102D90023A1E
D97AF_LC_UUID_BUILD_STAMP_OFFSET=0xAB0
D97AF_LC_UUID_BUILD_STAMP_POST_SHA=a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e
D97AF_LC_UUID_ATOMIC_SAME_VOLUME_RENAME=PASS
D97AF_TARGET_METADATA_PRESERVE_EXACT=PASS
D97AF_LC_UUID_BUILD_STAMP=PASS
```

Because the D97AH packaged method differs from D97AG only by the two exact method-local `/bin/chflags` -> `/usr/bin/chflags` tokens, and the real transaction now proceeds through final same-volume atomic rename, exact metadata restoration and final UUID/postimage verification, the previous hard-coded tool-path blocker is eliminated in the real Root Patch path. The entire corrected transaction, including the previously unreachable staged-write/restore/commit portion, completed successfully.

Strongest supported classification:
- `D97AH_REAL_ROOTPATCH_CORRECTED_CHFLAGS_TRANSACTION=PROVEN_COMPLETE`;
- `D97AF_ATOMIC_TARGET_RENAME=PROVEN_REACHED_AND_PASS`;
- `D97AF_LC_UUID_BUILD_STAMP_COMMIT=PROVEN_PASS`;
- `D97AF_TARGET_METADATA_PRESERVE_EXACT=PROVEN_PASS`.

Do not overclaim runtime provenance yet. The Root Patch output itself explicitly retains:

```text
D97AF_RUNTIME_PROVENANCE=NOT_YET_TESTED
D97AF_DIRECT_RUNTIME_TEXT_BYTE_READ=NOT_PERFORMED
```

## Downstream Root Patch completion — PASS
After the D97AH transaction, patching continued normally rather than through an exception path:
- patchset information written to Root Volume;
- RSRMonitor handling completed;
- launchd plists checked/installed;
- new Auxiliary Kernel Collection built;
- AuxKC usage forced;
- APFS snapshot creation reached;
- root volume unmounted;
- `Patching complete` printed only after the successful transaction and downstream completion;
- OCLP requested reboot.

Therefore:

`D97AH_ROOT_PATCH=FULL_PASS`

This is materially different from D97AF `INVALID_PARTIAL` and D97AG `FAIL_CLOSED_NEW_TOOL_PATH_DEFECT`.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
Root Patch has been audited and is accepted. The next action is one manual accelerated/root-patched boot.

Reboot is now authorized for this D97AH test only. Follow the permanent VESA rule:
1. reboot into the normal/root-patched D97AH configuration;
2. observe whether a usable accelerated GUI appears;
3. if no usable image appears, hard restart/power-cycle and boot the known VESA recovery configuration;
4. return to ChatGPT from VESA if necessary;
5. do not perform any additional Root Patch, source/app mutation or new diagnostic before reporting the boot chronology/result.

The accelerated boot immediately preceding VESA recovery is the authoritative runtime evidence. The later VESA boot must be excluded from D97AH runtime analysis. On return, first establish exact `last reboot` chronology and whether the accelerated boot produced image/GUI, then audit D97AF runtime provenance/MTLCompilerService evidence from that accelerated boot only.
