# OCLP7 CHECKPOINT — D97DY / D97DX artifact audit PASS; manual Root Patch authorized

Date: 2026-09-07 EEST

## Entering state
- ASUS2 remains Tahoe 26.6.2 / 25G82 in VESA with `-igfxvesa -ocmcdiag -ocmcd97bv`.
- Active `OCLPMetalCompat.kext` is D97DL 0.0.7, UUID `45EAD92D-43BF-3F42-B37B-EB5007345000`.
- D97DT already closed full D97BV CAVE+SITE runtime delivery PASS in VESA.
- No active Root Patch yet.

## D97DX build report — PASS
Returned report `OCLP7_D97DX_IMAC_RESUME_REPORT.txt` proves:
- exact b9df76 tracked source delta bounded to:
  1. `OpenCore-Patcher-GUI.spec`;
  2. `opencore_legacy_patcher/support/metallib_handler.py`;
  3. `opencore_legacy_patcher/sys_patch/patchsets/detect.py`;
  4. `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`;
- Python 3.13.15 x86_64;
- exact 25G82 patchdict SHA256 `c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`;
- exact Universal-Binaries SHA256 `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`;
- payloads.dmg SHA256 `e7323a6c39d330163924438813746f873e0e8801a2f8776362d9538a2abdcb1b`;
- native-Metal-safe synthesized Tahoe patch dictionary PASS;
- whole `Metal.framework` donor count 0;
- `MetalOld.dylib` count 0;
- main legacy Metal binary install count 0;
- XPC-only legacy Metal ingress PASS;
- private compiler lanes PASS;
- 25G82 metallib count 182;
- explicit SDK DEBUG helper build PASS, x86_64 SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- inner OCLP x86_64 executable SHA256 `986402e0d3a8d56f726b6fca41284fd1bb51631f9e675cd4631a11d29edb7b11`;
- ZIP bytes `722858206`, SHA256 `2f84fcaf39eb6c5a917ebb7b878bf2bef495050981b52fbe41e971fa1fe5cf1a`;
- source diff SHA256 `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- target helper save/restore policy PASS;
- no Root Patch, EFI mutation, or reboot during build.

## D97DY returned local artifact audit
Returned `OCLP7_D97DY_D97DX_LOCAL_ARTIFACT_AUDIT_20260907_015421.txt` proves before collector tooling stop:
- local ZIP SHA and byte size match D97DX build report;
- local inner app executable SHA and x86_64 arch match;
- local DEBUG helper SHA and x86_64 arch match;
- desktop source diff SHA matches embedded source patch SHA exactly;
- inner app codesign PASS;
- DEBUG helper codesign PASS;
- official helper is NOT bundled;
- launcher exact official helper SHA/team pin PASS;
- launcher verifies official helper before swap;
- launcher saves and verifies official helper backup;
- launcher installs DEBUG helper temporarily;
- launcher explicitly restores official helper and post-verifies it;
- launcher has no NVRAM/bless/reboot/shutdown/root-patch automation literal;
- embedded D97DX audit contract PASS.

D97DY then stopped at the optional re-synthesis step with:
`ModuleNotFoundError: No module named 'opencore_legacy_patcher'`.

This is classified as a collector working-directory/PYTHONPATH defect: the preserved venv Python was invoked while cwd was not the OCLP worktree and the worktree was not added to `PYTHONPATH`. It occurred after all artifact identity, codesign, launcher-safety and embedded-audit gates above had already passed.

Classification:
`D97DY_RE_SYNTH_IMPORT_FAILURE=TOOLING_FALSE_NEGATIVE`
`D97DY_BUILD_ARTIFACT_IDENTITY=PASS`
`D97DY_LAUNCHER_SAFETY=PASS`
`D97DY_EMBEDDED_AUDIT_CONTRACT=PASS`.

## Independent source-diff audit in chat
Uploaded source diff identity:
- bytes 36278;
- lines 597;
- SHA256 `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4` exact match to build report.

Changed-file set is exactly the four expected files above.

Direct diff audit proved:
- `OpenCore-Patcher-GUI.spec`: only `target_arch="universal2" -> "x86_64"`;
- `metallib_handler.py`: exact local host-build MetallibSupportPkg check inserted before generic/API path;
- `detect.py`: max host Sequoia -> Tahoe;
- `metal_3802.py` Tahoe wrapper:
  - Common: only `/Metal.framework/Versions/A/XPCServices/MTLCompilerService.xpc` donor + private MTLCompiler/GPUCompiler lanes;
  - Extended: CoreImage/RenderBox/private compiler lanes only; no whole `Metal.framework` donor;
  - 25G82 metallib map contains exactly 139 parent destinations / 182 file entries;
  - no duplicate parent or child keys;
  - 180 entries resolve through `DynamicPatchset.MetallibSupportPkg`, 2 through donor `14.6.1`;
  - added source contains zero `MetalOld.dylib`;
  - added source contains zero `13.2.1-24/Metal.framework`;
  - the only added `Metal.framework` references are the bounded XPCServices path and Metal.framework Resources metallib path.

Pyquick release metadata independently confirms tag `26.6.2-25G82` includes:
- `sys_patch_dict.py` digest `sha256:c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`;
- `MetallibSupportPkg-26.6.2-25G82.pkg` digest `sha256:602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

## Root Patch authorization
D97DX is now the authorized Root Patch vehicle for ASUS2 under these exact constraints:
1. transfer the exact D97DX ZIP/app to ASUS2 locally; no chat upload required;
2. launch the outer `OpenCore-Patcher-Tahoe-D97DX.app`, not the inner app directly;
3. outer launcher must pass its exact official-helper pre-swap identity gate;
4. exact local 25G82 MetallibSupportPkg must be available to the inner patcher; if OCLP reports it missing or tries an unexpected donor path, STOP and return output;
5. user may run manual Root Patch from D97DX;
6. retain `-igfxvesa -ocmcdiag -ocmcd97bv` during Root Patch and post-patch verification;
7. after patch completes, close inner OCLP so outer launcher can explicitly restore and verify the official helper;
8. DO NOT reboot yet; return complete Root Patch output / status for audit first.

Authorized now:
`D97DX_MANUAL_ROOT_PATCH_ON_ASUS2=YES`.

Still NOT authorized:
- removal of `-igfxvesa`;
- accelerated/non-VESA boot;
- reboot after Root Patch before post-patch audit;
- any Golden mutation;
- any legacy main Metal shadow;
- any true-five reapplication.
