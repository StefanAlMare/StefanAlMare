# OCLP7 CHECKPOINT — D97BJ official privileged helper restored; accelerated boot authorized

Date: 2026-09-05 EEST

## Entering state
- Tahoe 26.6.2 / 25G82 is root-patched successfully with D97BJ.
- `D97BJ_TAHOE_25G82_ROOT_PATCH_EXECUTION=PASS`.
- Before reboot, the custom DEBUG privileged helper remained installed unexpectedly after D97BJ application exit.

## Helper cleanup finding
Initial post-patch verification showed:
- no `OpenCore-Patcher` processes running;
- installed system helper SHA256 was DEBUG helper:
  `a1b4189d01b3107c753a290491dfbca7dc5ba64b5279f71daf901aa74c9d7f87`;
- therefore automatic wrapper cleanup/restore did not restore the official helper.

This did not invalidate the completed Root Patch. It was a post-run helper cleanup issue and reboot remained blocked until the official helper was restored.

## Exact official helper recovery
A verified official restore asset was found at:
`/Applications/OpenCore-Patcher.app/Contents/Resources/official-privileged-helper`

Source verification:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- `codesign --verify --strict` PASS;
- TeamIdentifier `S74BDJXQMD`.

It was copied to:
`/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper`
with owner `root:wheel` and mode `4755`.

Final installed helper verification:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- TeamIdentifier `S74BDJXQMD`;
- classification `OFFICIAL_HELPER_RESTORED=PASS`.

## Classifications
- `D97BJ_POST_RUN_DEBUG_HELPER_LEFT_INSTALLED=PROVEN`;
- `D97BJ_OFFICIAL_HELPER_RESTORE_SOURCE_IDENTITY=PASS`;
- `D97BJ_SYSTEM_OFFICIAL_HELPER_RESTORED=PASS`;
- `D97BJ_PRE_ACCELERATED_BOOT_SAFETY_GATE=PASS`.

## CURRENT ACTION
User is authorized to manually reboot into the normal accelerated/root-patched Tahoe configuration.

If a usable accelerated GUI appears, record that directly.
If no usable image/GUI appears, hard restart/power-cycle and boot the established VESA recovery configuration. Then analyze only the immediately preceding accelerated diagnostic boot per `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

Do not Root Patch again before evaluating this accelerated boot.
