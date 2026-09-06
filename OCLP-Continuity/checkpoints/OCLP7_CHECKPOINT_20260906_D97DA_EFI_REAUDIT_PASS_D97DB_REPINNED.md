# OCLP7 CHECKPOINT — 2026-09-06 — D97DA EFI re-audit PASS; D97DB repinned

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97CY_COMPILE_AUDIT_PASS_DEPLOY_READY.md` for current execution.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- VESA only; `-igfxvesa` and `-ocmcdiag` retained.
- No active Root Patch.
- D97CY `OCLPMetalCompat.kext` 0.0.3 is compile/audit PASS and remains undeployed.
- Audited D97CY package SHA256 `405c9f53986bd8efac9f905cc25bc24bdea0ac44860cf1a6e6a0feb55a4c4402`.
- D97CY executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`.
- D97BV functional page write remains unauthorized.

## D97DA full current-EFI re-audit
Returned report: `OCLP7_D97DA_CURRENT_EFI_FULL_REAUDIT_20260906_200508.txt`.

Classification: `D97DA_CURRENT_EFI_FULL_REAUDIT=PASS_READ_ONLY`.

Host:
- macOS `26.6.2 / 25G82`;
- Darwin `25.6.0`, x86_64.

Current active config:
- `/Volumes/EFI/EFI/OC/config.plist`;
- SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- `plutil -lint` PASS.

OpenCore core files are unchanged from prior audit:
- `BOOTx64.efi` SHA256 `19fa90b921fef5d29f2ce1f2cb8fd38aded259d7f4a1fa1615c27f7e970f6474`;
- `OpenCore.efi` SHA256 `59ef0baced497b17ad2e43ee3626ba03ff9f59fb2d4f41188eb9d1737640db6a`.

Boot args:
`-v debug=0x100 keepsyms=1 -amfipassbeta #amfi=0x80 #-lilubetaall hbfx-ahbm=55 foclegacy=1 -btlfxboardid ipc_control_port_options=0 -igfxvesa -ocmcdiag`

Required runtime boot-arg state:
- `-igfxvesa` PRESENT;
- `-ocmcdiag` PRESENT;
- `-liluuseroff` ABSENT;
- `-liluslow` ABSENT;
- `-liluoff` ABSENT.

Kernel/Add:
- count `37`;
- Lilu unique index `0`, enabled, version `1.7.3`;
- AMFIPass unique index `4`, enabled, version `1.4.1`;
- OCLPMetalCompat unique index `5`, enabled, `MinKernel=25.0.0`, `MaxKernel=25.99.99`;
- WhateverGreen unique index `30`, enabled, version `1.7.1`;
- KDKlessWorkaround unique index `31`, enabled, version `1.0.0`.

Current EFI OCLPMetalCompat identity remains exact D97CT 0.0.2:
- bundle ID `com.oclpmetalcompat.OCLPMetalCompat`;
- version `0.0.2`;
- Info.plist SHA256 `b386aded0a0d2a4490916f32236e22c2c38056638546c546153a5d7371ea4d8d`;
- executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`.

Relevant kext executable identities:
- Lilu `e3f00df5aca98c70363489292514f088ae3b667417c9c5afdd33799ff09390bd`;
- WhateverGreen `2b4189a7255c7dc50e9dad9c7cde15d998e1146438c519df2456829285c91b35`;
- AMFIPass `4c35bc196d35c69b5f9dca83fe733801211c7828716f51585c7f5450039ca884`;
- KDKlessWorkaround `c9154217439bdaabff3d3e81f52e54ac2c54d05f7037422ac378db0f4bc8b3c3`.

Existing D97CO backup remains present:
`/Volumes/EFI/EFI/OC/Kexts/OCLPMetalCompat.kext.D97CO-20260906_192422.bak`.

UEFI/ACPI inventory:
- 10 UEFI driver entries enumerated; all configured files present;
- 11 ACPI Add entries enumerated; all configured files present;
- SecureBootModel `Disabled`;
- RequestBootVarRouting `true`;
- Kernel DisableIoMapper `false`;
- AppleXcpmCfgLock `false`;
- AppleCpuPmCfgLock `false`.

## Tooling note
D97DA printed `UUID=24` for several kexts because the `otool` awk field extraction was incorrect. This is a collector-format defect only and is not treated as UUID evidence. Exact executable SHA256 values remain authoritative for this re-audit.

## D97DB repinned replacement
The prior D97CZ script is invalid for the current EFI because it was pinned to config SHA `cc2ac81...` and OCLPMetalCompat index `2`.

Prepared replacement:
- `OCLP7_D97DB_D97CY_EFI_REPLACE_REPINNED.sh`;
- SHA256 `39c4819608d7a5c05cedcdd9de0a06839a123b6d131bfc4e91230fe79e71b839`;
- `bash -n` PASS.

D97DB is pinned to:
- current config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`;
- unique OCLPMetalCompat Kernel/Add index `5`;
- current D97CT executable SHA256 `a1a6f32f4a951fd786222a317386135f0938494aca6b1eff39553299a512961b`;
- new D97CY executable SHA256 `4a24180004b2b4d76972e811643742529334ca95f655dc834c65bf780c9c1f77`;
- audited D97CY package SHA256 `405c9f53986bd8efac9f905cc25bc24bdea0ac44860cf1a6e6a0feb55a4c4402`;
- Lilu `1.7.3` at index `0`;
- `-igfxvesa` and `-ocmcdiag` present.

D97DB modifies only `EFI/OC/Kexts/OCLPMetalCompat.kext`, backs up D97CT, does not modify `config.plist`, does not Root Patch, and does not reboot.

## CURRENT ACTION
On ASUS2 only:
1. keep the active EFI mounted at `/Volumes/EFI`;
2. place audited `OCLP7_D97CY_AUDITED_DEPLOY_20260906.zip` and `OCLP7_D97DB_D97CY_EFI_REPLACE_REPINNED.sh` in `~/Downloads`;
3. run D97DB once;
4. return the generated Desktop D97DB report to ChatGPT;
5. do not reboot until that report is audited.

No Root Patch, accelerated boot, functional shared-cache mutation, or D97BV page write is authorized.
