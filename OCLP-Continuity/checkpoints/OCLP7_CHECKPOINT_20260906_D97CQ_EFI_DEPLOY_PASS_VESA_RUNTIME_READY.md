# OCLP7 CHECKPOINT — 2026-09-06 — D97CQ audited EFI deploy PASS; D97CO VESA runtime ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97CO_LOCAL_COMPILE_AUDIT_PASS_DEPLOY_READY.md` for current execution state.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- System remains unpatched VESA; no active Root Patch.
- D97CO compiled observe-only kext is identity-audited and contains no functional D97BV page-write payload.
- Functional D97BV shared-cache mutation remains unapplied and unauthorized.

## D97CQ returned deployment report
Returned report: `OCLP7_D97CQ_EFI_DEPLOY_20260906_173443.txt`.

Target config:
- `/Volumes/EFI/EFI/OC/config.plist`;
- expected pre-deploy SHA256 `2f9330d17dfc702c2201b86612fc701fabf1e3a13c38d2f90e1507c2eef93a7f`;
- actual pre-deploy SHA256 exact match PASS;
- plist validation PASS.

Existing EFI gates:
- Lilu version `1.7.3` PASS;
- boot args before deploy retained `-igfxvesa`;
- `-ocmcdiag` was absent before deploy.

Audited D97CO package:
- package `OCLP7_D97CO_AUDITED_DEPLOY_20260906.zip`;
- expected/actual ZIP SHA256 `e062ef672c003d2d6ff11508d1f4cd5e43b94c45ec7de1c9919358cbd0a9fad7` PASS;
- expected/actual executable SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b` PASS;
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- Lilu dependency `1.7.3`;
- `AUDITED_PACKAGE_GATE=PASS`.

Prepared config:
- existing `Kernel -> Add` count `36`;
- new D97CO entry index `36`;
- BundlePath `OCLPMetalCompat.kext`;
- Enabled `true`;
- boot args after preparation preserve `-igfxvesa` and add `-ocmcdiag`;
- prepared plist validation PASS.

Backup/deploy:
- backup `/Volumes/EFI/EFI/OC/config.plist.D97CQ-20260906_173443.bak`;
- backup SHA256 `2f9330d17dfc702c2201b86612fc701fabf1e3a13c38d2f90e1507c2eef93a7f`, exact pre-deploy identity.

Post-deploy audit:
- active config plist validation PASS;
- deployed executable SHA256 `6b3534cb524a3e222fbfc70f87d4ad614c1b80091b9bcb105e831b00d00b219b` exact PASS;
- final config SHA256 `52233a7815ef0accee2a44d06b44c75e9fcfd4aada831c4b343e7579e8fdc13b`;
- final Kernel/Add index `36`;
- final BundlePath `OCLPMetalCompat.kext`;
- final Enabled `true`;
- final boot args preserve `-igfxvesa` and include `-ocmcdiag`.

Authoritative classification:
`D97CQ_D97CO_IDENTITY_PINNED_EFI_DEPLOY=PASS`.

No Root Patch occurred. No reboot occurred during deployment. No system or dyld shared-cache mutation occurred.

## CURRENT ACTION
The next experiment is now authorized as **one VESA diagnostic boot only** using the already-deployed D97CO observe-only plugin.

Required invariants for that boot:
- retain `-igfxvesa`;
- retain `-ocmcdiag`;
- no Root Patch;
- no functional D97BV mutation;
- no accelerated boot intent.

After the VESA boot, collect runtime evidence for:
- `D97CO_ROUTE_CS_VALIDATE_PAGE`;
- `D97CO_SITE_SEEN`;
- `D97CO_CAVE_SEEN`;
- Apple's `validated`, `tainted`, and `nx` values logged for the two exact pages.

Only if the runtime timing/provenance and preimage state pass may a separately-authorized functional D97BV page-write build be designed.
