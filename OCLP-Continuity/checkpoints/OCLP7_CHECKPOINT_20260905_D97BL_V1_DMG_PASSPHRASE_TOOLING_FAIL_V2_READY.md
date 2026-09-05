# OCLP7 CHECKPOINT — D97BL v1 DMG passphrase tooling failure; v2 ready

Date: 2026-09-05 EEST

## Entering state
- Target remains Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current machine state remains unpatched Tahoe VESA after snapshot restore.
- D97BL architecture remains Tahoe-native Metal4 + selective legacy 3802 hybrid.
- No Root Patch or accelerated reboot is authorized.

## D97BL v1 collector result
User ran `OCLP7_D97BL_static_hybrid_audit.sh`.

The collector correctly verified:
- macOS `26.6.2 / 25G82`;
- current root patch absent;
- boot args include `-igfxvesa`;
- exact `Universal-Binaries.dmg` located at `/Users/alex/Developer/OpenCore-Legacy-Patcher-D97BJ-b9df76-Tahoe25G82/Universal-Binaries.dmg`;
- bytes `641964544`;
- SHA256 `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`.

It then failed only at the DMG mount step because the collector invoked `hdiutil attach` without the PatcherSupportPkg passphrase, causing an interactive password prompt and `Authentication error`.

No source mutation, system mutation, Root Patch or reboot occurred.

Classification:
`D97BL_V1_DMG_MOUNT_FAILURE=TOOLING_ONLY_MISSING_PUBLIC_PASSPHRASE`.

## Exact b9df76 mount semantics
Exact b9df76 `opencore_legacy_patcher/sys_patch/utilities/dmg_mount.py` mounts Universal-Binaries.dmg with:
- `/usr/bin/hdiutil attach`;
- `-noverify`;
- explicit mountpoint;
- `-nobrowse`;
- shadow overlay in normal OCLP use;
- `-passphrase "password"`.

Thus the Universal-Binaries.dmg passphrase is literally `password`; it is part of public OCLP source and is not a user credential.

Classification:
`B9DF76_UNIVERSAL_BINARIES_DMG_PASSPHRASE=password`.

## D97BL v2 collector
Prepared `OCLP7_D97BL_static_hybrid_audit_v2.sh`.

Only the DMG mount logic is changed from v1: it now uses the public OCLP passphrase and remains read-only for this audit:
`hdiutil attach -readonly -noverify <DMG> -mountpoint <MNT> -nobrowse -passphrase "password"`.

All intended static-hybrid audit steps remain unchanged.

## CURRENT ACTION
User runs only `OCLP7_D97BL_static_hybrid_audit_v2.sh` in the current unpatched Tahoe VESA state and returns the generated ZIP.

No Root Patch authorized. No accelerated reboot authorized. Golden remains immutable/read-only.