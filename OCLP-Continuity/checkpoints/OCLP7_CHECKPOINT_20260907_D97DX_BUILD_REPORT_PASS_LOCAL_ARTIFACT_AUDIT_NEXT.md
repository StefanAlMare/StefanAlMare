# OCLP7 CHECKPOINT — D97DX build report PASS; local artifact audit next

Date: 2026-09-07 EEST

## Returned iMac D97DX report
User returned `OCLP7_D97DX_IMAC_RESUME_REPORT.txt` after running the pinned D97DX resume build on the authorized Intel iMac build host.

The returned report proves:
- exact existing D97DU tracked source delta remained bounded to:
  - `OpenCore-Patcher-GUI.spec`
  - `opencore_legacy_patcher/support/metallib_handler.py`
  - `opencore_legacy_patcher/sys_patch/patchsets/detect.py`
  - `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`
- Python `3.13.15` x86_64 PASS;
- exact Pyquick 25G82 patchdict SHA256 `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`;
- exact Universal-Binaries SHA256 `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`;
- generated payloads.dmg SHA256 `e7323a6c39d330163924438813746f873e0e8801a2f8776362d9538a2abdcb1b`;
- Python syntax PASS;
- synthesized Tahoe 25G82 Metal3802 dictionary PASS;
- whole Metal.framework donor count `0`;
- `MetalOld.dylib` count `0`;
- main legacy Metal binary install count `0`;
- XPC-only legacy Metal ingress PASS;
- private compiler lanes PASS;
- exact 25G82 metallib entry count `182`;
- explicit macOS SDK resolved at `MacOSX26.5.sdk`;
- Foundation/Security SDK header gates PASS;
- DEBUG privileged helper built x86_64-only, SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- inner application x86_64-only, executable SHA256 `986402e0d3a8d56f726b6fca41284fd1bb51631f9e675cd4631a11d29edb7b11`;
- target helper save/restore policy PASS;
- official helper is not bundled;
- expected target official helper SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- source diff SHA256 `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- final ZIP bytes `722858206`;
- final ZIP SHA256 `2f84fcaf39eb6c5a917ebb7b878bf2bef495050981b52fbe41e971fa1fe5cf1a`;
- `D97DX_BUILD_STATUS=PASS`.

No Root Patch, EFI mutation, system-root mutation, or reboot occurred during the build.

## Classification
`D97DX_BUILD_REPORT=PASS`
`D97DX_NATIVE_METAL_SAFE_POLICY=PASS`
`D97DX_BUILD_ARTIFACT_LOCAL_IDENTITY_REPORTED=PASS`

The 722 MB ZIP is too large to upload through chat. Therefore do not require the user to upload the ZIP.

## Next action
Perform a bounded LOCAL iMac artifact audit that:
- verifies the exact ZIP SHA/size and CRC integrity without extracting the full archive;
- verifies the on-disk app and selective ZIP members against the reported hashes;
- verifies x86_64 architectures;
- verifies the embedded D97DX audit and source patch identities;
- verifies that no official helper is bundled;
- verifies wrapper target-side official-helper fail-closed save/restore semantics;
- emits only a small TXT report for upload.

User should also return the small `OCLP7_D97DX_b9df76_NATIVE_METAL_SAFE.patch` file for independent textual source audit.

Still NOT authorized:
- Root Patch;
- removal of `-igfxvesa`;
- accelerated boot;
- reboot into a new root-patched/accelerated configuration.
