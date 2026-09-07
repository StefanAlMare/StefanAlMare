# OCLP7 D97EH — observer-only set_id_mode source/build ready

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412.
Build host: authorized Intel iMac 9900K.

## Resolved runtime target
Read-only ASUS2 audit proved:
- `IOAcceleratorFamily2.kext` bundle id: `com.apple.iokit.IOAcceleratorFamily2`;
- CFBundleVersion: `487.4.3`;
- current VESA `kmutil showloaded` does not list IOAcceleratorFamily2/AppleIntelHD5000Graphics, consistent with accelerator being inactive in VESA;
- legacy Haswell `AppleIntelHD5000Graphics` dynamically imports exact symbol:
  `__ZN14IOAccelSurface11set_id_modeEjj`.

Therefore D97EH targets exactly:
`IOAccelSurface::set_id_mode(uint32_t id, uint32_t mode)`.

## Observer-only design
D97EH derives deterministically from exact D97DL source SHA256:
`f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`.

New observer is independently gated by:
`-ocmcd97eh`.

When `com.apple.iokit.IOAcceleratorFamily2` loads, D97EH routes only:
`__ZN14IOAccelSurface11set_id_modeEjj`.

For the first 32 calls it logs:
- call number;
- id;
- original mode;
- `mode & 0xFF8073C0` diagnostic candidate bad-bits mask;
- `mode & 0x007F8C3F` complementary good-bits mask;
- original Apple IOReturn.

Critical invariant:
- original Apple function is called with exactly `(that, id, mode)`;
- mode is not masked or modified;
- Apple return is returned unchanged;
- no framebuffer mutation;
- D97BV SITE/CAVE logic is preserved unchanged.

## GitHub authority
Generator:
`OCLP-Continuity/artifacts/OCLP7_D97EH_SOURCE_GENERATOR.py`
- SHA256 `fed0d21e974a70a3dacad9e86261ecde28dc5f2fbb8f2e4c8c94bf08102a1144`
- commit `ce73ee2e09edb5d907adf64243251c513fff085a`.

Intel iMac builder:
`OCLP-Continuity/artifacts/OCLP7_D97EH_IMAC_BUILD.sh`
- local prepared SHA256 `74a4da97d621b0e0494c134f12a1e09dcfc03aa18481b3475e7c53b22cb49fc1`
- commit `cd11fae42ff63b527c997b25abd15c167fdeea35`.

Builder pins:
- D97DL authority commit `72dbc5f29aedf4f8190700de9f1c2c45f949b56f`;
- Lilu `0515f40b7f2a096adc85e832a4c6104fbd07f936` (1.7.3 lineage);
- FeatureUnlock `201bd45766207e6cc10cd40a8ac1f9c6216f9acb`;
- MacKernelSDK `05094e5e88cec7caedbfb35e8449ed0db94bf95b`;
- output plugin version `0.0.9`, x86_64.

## Current action
Run only the exact D97EH builder on the Intel iMac build host.
Return the generated `OCLP7_D97EH_IMAC_BUILD_<timestamp>.zip` for independent source/binary audit.

Not yet authorized:
- ASUS2 deployment;
- adding `-ocmcd97eh` to target boot args;
- removing `-igfxvesa`;
- accelerated boot;
- any functional set_id_mode masking;
- another Root Patch.
