# OCLP7 CHECKPOINT — 2026-09-04 — D97AM Root Patch FULL PASS; accelerated boot next

## Authority and carry-forward
Target remains ASUS2 Tahoe `26.6.2 / 25G82`, Intel Haswell, SMBIOS `MacBookAir6,2`. Routine/small work remains ASUS2-only; GitHub only for major compile/build/package. Golden Sequoia remains immutable/read-only. Root Patch and reboot remain manual-only and separately authorized. Accepted functional baseline remains exactly P1+P2b+P3+AIR00+D34; P6/P7 remain retained with runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

Previous checkpoint: `OCLP7_CHECKPOINT_20260904_D97AM_DEPLOY_OPEN_FULL_PASS_ROOT_PATCH_NEXT.md`.

## Exact installed app before Root Patch
D97AM exact deploy/open remains FULL PASS. Live `/Applications/OpenCore-Patcher.app` executable before Root Patch was:

```text
BYTES=6596496
SHA256=fbcb69e946583beca9793aac7aa722c774b1167965fcddb5a65b757f79d953a3
ARCH=x86_64
```

Fresh exact-path PID `2980` was proven after deploy. D97AH backup remains `/Applications/OpenCore-Patcher.app.D97AH-before-D97AM-20260904-020713`; older D97AG backup remains `/Applications/OpenCore-Patcher.app.D97AG-before-D97AH-20260903-200708`.

## D97AM manual Root Patch — FULL PASS
The complete returned Root Patch output was audited as raw evidence, not by final marker alone.

Root patch environment and patchset preflight passed:
- exact local metallib `26.6.2-25G82` found;
- Root Patching capability passed;
- root volume mounted elevated;
- Universal-Binaries.dmg mounted;
- preflight completed;
- Metal 3802, extended metallibs, Monterey GVA/OpenCL, Intel Haswell and Modern Wireless patchsets installed through normal OCLP flow.

### Functional lineage
The active compiler path executed as expected:

```text
P1 selector: 31001 -> 32023 verified
P2b request layout: request+0xD0 -> request+0x110 verified
P3 serialized-bitcode path verified
AIR00 verified
D34 verified
D81P_TRUE_FIVE_FINAL_MTL_SHA=6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01
P6_REQUEST_DIALECT_CALLSITE_PORTS=PASS
P7_RAW88_A8_READ_PORTS=PASS
P7_COMMITTED_MTL_SHA=6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda
```

The complete log contains **zero occurrences of `D97AD`**. Therefore the retired terminal classifier did not run.

### Exact D97AM natural-flow transaction
Raw transaction evidence:

```text
D97AM_TARGET_METADATA_POLICY=MODE_OWNER_FLAGS_XATTRS_PRESERVE_EXACT|ACL_NONE_REQUIRED|TIMES_ALLOWED_TO_CHANGE
D97AM_TARGET_FLAGS_PRE=524288
D97AM_TARGET_XATTRS_PRE=[]
D97AM_TARGET_ACL_PRE=NONE
D97AM_LC_UUID_BUILD_STAMP_PRE_SHA=6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda
D97AM_LC_UUID_BUILD_STAMP_OLD=D5CE0008-587C-3861-971A-4BAEFB7B9C5B
D97AM_LC_UUID_BUILD_STAMP_NEW=0FC4C627-2A5D-491B-8101-00CAAA7116B7
D97AM_LC_UUID_BUILD_STAMP_OFFSET=0xAB0
D97AM_LC_UUID_BUILD_STAMP_POST_SHA=e7739c155b5f6f091a1b8d25cee77549655f7944f2f8baaba7a2b431eca3eea9
D97AM_LC_UUID_ATOMIC_SAME_VOLUME_RENAME=PASS
D97AM_TARGET_METADATA_PRESERVE_EXACT=PASS
D97AM_LC_UUID_BUILD_STAMP=PASS
D97AM_RUNTIME_PROVENANCE=NOT_YET_TESTED
D97AM_DIRECT_RUNTIME_TEXT_BYTE_READ=NOT_PERFORMED
```

This exactly matches the D97AL/D97AM synthetic design and packaged-app audit.

### Downstream root-patch completion
After D97AM transaction:
- patchset information written;
- RSR monitor path handled normally;
- auto-patch/update/rsr-monitor/os-caching plist checks completed;
- new Auxiliary Kernel Collection built;
- Auxiliary Kernel Collection usage forced;
- APFS snapshot created;
- root volume unmounted;
- `Patching complete` reached;
- OCLP requested reboot.

The raw Root Patch log contains no `FAIL`, traceback, exception or error marker.

## Classification
`D97AM_ROOT_PATCH=FULL_PASS`.

This proves the exact root-patch transaction and snapshot completion. It does **not** yet prove runtime provenance, exact runtime text bytes, accelerated GUI success, WindowServer stability or functional success.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
The next bounded ASUS2 action is the **first D97AM accelerated/root-patched boot**.

User is authorized to reboot manually into the normal accelerated/root-patched configuration. No additional patching or source/app mutation is authorized before that boot.

If a usable accelerated GUI appears, do not intentionally fall back to VESA; observe whether the desktop remains usable and then return with that fact and any obvious symptoms.

If no usable image appears, follow the permanent recovery rule exactly: hard restart/power-cycle, boot VESA recovery, then return from VESA. The accelerated boot immediately preceding that VESA recovery is the authoritative runtime evidence window.

On return, first establish exact reboot chronology (`last reboot` / `kern.boottime`) before collecting or interpreting logs. Do not mix current VESA records into the accelerated D97AM evidence window.

No further Root Patch is authorized during this sequence.