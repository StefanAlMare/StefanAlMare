# OCLP7 CHECKPOINT — D97GY Restore baseline PASS except residual DEBUG helper; D97GZ locator next

Date: 2026-09-08 EEST

## Entering state
User intentionally performed Root Patch Restore/Revert and rebooted ASUS2 back into VESA before applying D97GS, to avoid stacking the P1-only patch over the previous D97DX snapshot.

## D97GY post-Restore VESA evidence
Read-only D97GY proved the system/root restore itself is clean:
- macOS `26.6.2 / 25G82`;
- VESA active; D97EZ inert;
- native Tahoe MTLCompilerService restored exactly:
  - SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
  - UUID `022C1750-8735-389A-A8BA-A8A67F54235D`;
  - universal `x86_64 arm64e`;
- native CoreDisplay metallib restored exactly:
  - SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`;
  - bytes `24128`;
  - `MTLB`;
- Haswell AuxKC Data kexts removed and not loaded;
- corrected local 25G82 MetallibSupportPkg survived:
  - `180` metallibs;
  - CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
  - bytes `20739`;
  - zero bad magic.

Thus the APFS/System restore baseline is `STRUCTURAL_SEMANTIC_PASS`.

## Residual helper state — real, not collector false negative
D97GY stopped at the official-helper gate. Manual read-only inspection then proved the active helper is NOT the official OCLP helper.

Active path:
`/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper`

Observed:
- SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- this is the exact D97DX/D97GS DEBUG helper identity;
- Mach-O thin `x86_64`;
- ad-hoc signature;
- `TeamIdentifier=not set`;
- `codesign --verify --strict` returns 0.

Expected official helper:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- Team ID `S74BDJXQMD`.

Classification:
- `D97GY_SYSTEM_RESTORE_BASE=STRUCTURAL_SEMANTIC_PASS`;
- `D97GY_OFFICIAL_HELPER_RESTORATION=FAIL_REAL_RESIDUAL_DEBUG_HELPER`;
- `D97GY_OVERALL=PARTIAL_PASS_BLOCKED_ON_HELPER_STATE`.

This must NOT be mislabeled a tooling false negative.

## Safety consequence
Do not run D97GS Root Patch yet. Restore only the official helper state first. No additional Restore/reboot/EFI/NVRAM/framebuffer change is justified.

## Next
D97GZ must read-only locate the exact official-helper backup created by the D97DX outer launcher before it swapped in the DEBUG helper. It should also inspect the exact reused D97DX/D97GS launcher for backup/restore path strings. No helper replacement is authorized until an exact candidate with official SHA + Team ID is found.
