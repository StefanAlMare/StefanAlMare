# OCLP D97BG — TrueNAS transport archive identity

Batch: `20260904T235946Z-dv7f4ac88f-0cefde2f`

Reader path:
`ChatGPT-Inbox/Arhive/2026-09-05/20260904T235946Z-dv7f4ac88f-0cefde2f/OpenCore-Patcher.zip`

Reader manifest identity:
- filename: `OpenCore-Patcher.zip`
- bytes: `737786335`
- SHA256: `ed6b80f1b25418211f8ea91545ac9a84d96421cf3cc42ff190db4f5f16c40523`

Classification:
`TRUENAS_OCLP_ZIP_TRANSPORT_IDENTITY=PINNED`

Important distinction:
- this SHA256 identifies the ZIP archive only;
- it does not by itself prove the SHA256 of the embedded `OpenCore-Patcher.app` executable or `Info.plist`;
- the already-proven reference app executable SHA256 remains `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- the already-proven reference app Info.plist SHA256 remains `6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`.

Tooling status at capture time:
- TrueNAS ChatGPT Reader is installed/enabled for the user;
- current assistant runtime exposes the Reader manifest but not the Reader plugin namespace or ZIP raw bytes;
- ChatGPT Files conversation/library search also does not expose this ZIP as a materializable file;
- therefore inner archive audit is `INCONCLUSIVE_TOOLING`, not negative identity evidence.

Current engineering route is unaffected: use the proven official b9df76 OCLP 2.5.0 app unchanged, with the target-specific Tahoe developer-marker bypass on ASUS2 Haswell; user handles copying and manual Root Patch.
