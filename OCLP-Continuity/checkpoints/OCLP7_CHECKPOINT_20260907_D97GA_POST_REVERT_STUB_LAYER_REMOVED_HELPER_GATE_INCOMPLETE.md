# OCLP7 CHECKPOINT — D97GA post-revert stub layer removed; helper gate incomplete

Date: 2026-09-07 EEST

## Entering authority
- D97FY final pre-Root-Patch gate PASS.
- User performed manual D97DX Root Patch Revert/Restore and rebooted back to VESA.
- First D97FZ attempt stopped because `-ocmcd97ez` was accidentally still active; user corrected EFI config by making D97EZ inert and rebooted again with no other intended change.

## Second D97FZ returned state
System:
- macOS 26.6.2 / 25G82;
- x86_64;
- boot args retain `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`;
- D97EZ token is inert as `#-ocmcd97ez`.

Classification:
- `D97GA_VESA_STATE=PASS`;
- `D97GA_D97EZ_ACTIVE_MODE=INERT_PASS`.

## Corrected local source after reboot
D97FZ proved:
- local metallib count `180`;
- all local metallibs have `MTLB` magic;
- corrected CoreDisplay local SHA remains exact expected `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`.

Classification:
- `D97GA_CORRECTED_LOCAL_SOURCE_PERSISTENCE=PASS`.

## Installed root after APFS revert
D97FZ proved across the same 180 mapped target paths:
- corrected-package exact: `0`;
- MTLB files: `179`;
- metadata stubs: `0`;
- missing: `0`;
- other non-stub: `1`.

Most important causal fact:
- all `180/180` metadata stubs previously proven by D97FW are gone after revert.

CoreDisplay installed native file:
- present;
- bytes `24128`;
- SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`;
- `MetalLib executable (MacOS), version 1.2.9`;
- not a metadata stub.

Legacy Haswell kexts were not listed by `kmutil showloaded` under this VESA post-revert boot, consistent with revert/no active Root Patch and not itself a failure.

Classifications:
- `D97GA_APFS_REVERT_REMOVED_STUB_LAYER=SEMANTIC_PROVEN`;
- `D97GA_INSTALLED_METADATA_STUB_COUNT=0`;
- `D97GA_NATIVE_COREDISPLAY_METALLIB_RESTORED=SEMANTIC_PROVEN`;
- exact identity/meaning of the one `OTHER_NONSTUB` mapped path remains UNKNOWN pending read-only identification.

## D97FZ helper-gate interruption
D97FZ reached header:
`===== OFFICIAL PRIVILEGED HELPER =====`
then returned to shell without printing helper identity or final `D97FZ_STATUS` lines.

Therefore:
- D97FZ did NOT complete final gate;
- corrected Root Patch remains NOT AUTHORIZED yet;
- root/stub-layer portion is nevertheless positively established before the interruption.

Most likely failure locus is within the helper identity extraction/verification sequence; exact reason remains UNKNOWN until direct read-only helper inspection.

## CURRENT ACTION
Do not Root Patch yet.
Run a read-only micro-gate that:
1. lists and hashes `/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper`;
2. runs `codesign -dv --verbose=4` and `codesign --verify --strict` without `set -e` so return codes are visible;
3. extracts TeamIdentifier if available;
4. identifies the single installed `.metallib` target that is neither MTLB nor metadata stub.

If official helper identity matches expected SHA `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a` and Team `S74BDJXQMD`, and the one non-MTLB installed file is a legitimate native baseline object, corrected Root Patch can be separately authorized.