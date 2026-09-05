# OCLP7 CHECKPOINT — D97BI Metallib PASS / Metal.framework 13.2.1-25 blocker

Date: 2026-09-05 EEST

## Runtime state
- Tahoe 26.6.2 / 25G82 booted in VESA.
- D97BG Tahoe-ready wrapper is in use.
- User performed Root Patch Restore before this attempt.
- Temporary hosts override made `dortania.github.io` unavailable while other networking remained available.

## Metallib result — PASS
Root Patcher output proved:
- remote MetallibSupportPkg manifest fetch failed as intended;
- b9df76 entered local fallback;
- loose match `26.6` was checked;
- exact local folder `26.6.2-25G82` was found;
- Root Patcher reported `Patcher is capable of patching`.

Classification:
`D97BH_25G82_LOCAL_METALLIB_FALLBACK_RUNTIME=PASS`

## New blocker — PROVEN
Root Patcher then mounted `Universal-Binaries.dmg`, entered preflight for MacBookAir6,2, and failed with:
`Failed to find .../payloads/Universal-Binaries/13.2.1-25/System/Library/Frameworks/Metal.framework`

Exact Golden b9df76 `metal_3802.py` constructs:
`"Metal.framework": f"13.2.1-{self._xnu_major}"`
for the Metal 3802 Common Extended patchset.
On Darwin 25 this becomes `13.2.1-25`.

Historical project builder had already identified the same Tahoe incompatibility and used `13.2.1-24` on Tahoe because `13.2.1-25` does not exist in the PatcherSupportPkg payload.

Classification:
`B9DF76_TAHOE_25_METAL_FRAMEWORK_SOURCE_13_2_1_25=PROVEN_MISSING`
`TAHOE_25_METAL_FRAMEWORK_DONOR_13_2_1_24=HISTORICALLY_IDENTIFIED_REQUIRED_REDIRECT`

## Safe execution property
Exact b9df76 `PatcherSupportPkgMount._mount_universal_binaries_dmg()` mounts `Universal-Binaries.dmg` at the temporary payload path using `hdiutil attach ... -shadow <overlay>`.
Therefore the mounted Universal-Binaries workspace is writable via its shadow file without changing the embedded/signed `Universal-Binaries.dmg` or signed OCLP application.

## Current action
While the current OCLP process/session still owns the mounted Universal-Binaries workspace:
1. locate the mounted temporary `payloads/Universal-Binaries` root;
2. verify `13.2.1-24/System/Library/Frameworks/Metal.framework` exists;
3. create a workspace-only symbolic alias `13.2.1-25 -> 13.2.1-24`;
4. verify the exact previously-missing `13.2.1-25/.../Metal.framework` now resolves;
5. rerun manual Root Patch in the same OCLP session;
6. return complete output.

Do not modify the signed inner OCLP, its embedded DMG, Golden, or EFI. Do not reboot yet.