# OCLP7 CHECKPOINT — D97FU CoreDisplay metallib local payload stub reclassification

Date: 2026-09-07 EEST

## Entering authority
- Current runtime checkpoint remains D97FJ.
- Current static checkpoint entering D97FU is D97FT.
- D97FT mapped the earliest captured negative to the CoreDisplay `GPUPass` specialization NSError path and a parallel downstream native Metal validation-context abort.
- D97FT next action was static inspection of exact installed 25G82 `CoreDisplay.framework/Versions/A/Resources/default.metallib`.

## D97FU direct ASUS2 result
System path:
`/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib`

Observed exact identity:
- bytes `319`;
- SHA256 `b073e3e1089c2c3f5cf5af43dca30a1237db1d2a1ae6b0d5c2d4fabd5353cd52`;
- `file` classifies it as `ASCII text`.

Its contents are not Metal-library bytes. They are metadata text:
- `Name : default.metallib`;
- `UTI : public.data`;
- `Kind : Document`;
- `Owner : root (0)`;
- `Group : wheel (0)`;
- `Mode : -rw-r--r-- (0100644)`;
- `Size : 20739`;
- `Unverified CRC-32 : 3256354880`.

Local 25G82 MetallibSupportPkg tree path:
`/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82/System/Library/Frameworks/CoreDisplay.framework/Versions/A/Resources/default.metallib`

Observed exact identity there is the SAME:
- bytes `319`;
- SHA256 `b073e3e1089c2c3f5cf5af43dca30a1237db1d2a1ae6b0d5c2d4fabd5353cd52`;
- ASCII text;
- same metadata payload.

The previously expected real CoreDisplay metallib SHA256:
`b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`
was NOT found at the system or local-tree CoreDisplay path in this probe.

## Interpretation / correction
The local-tree and installed CoreDisplay `default.metallib` are not valid binary `.metallib` payloads. They are metadata-manifest text describing a regular file whose recorded size is 20,739 bytes.

External package-format documentation confirms `Owner`, `Mode`, `Size`, and `Unverified CRC-32` are package/BOM metadata fields, supporting classification of the 319-byte object as a metadata stub rather than a real Metal library.

This exposes a prior proof-scope error:
- D97DX did prove exact 25G82 package-selection/runtime-map execution and copy/install activity.
- D97DX did NOT prove that every source metallib payload in the local 25G82 tree was a valid binary metallib.
- For CoreDisplay/default.metallib specifically, D97FU now proves the installed/local source payload is invalid as a Metal library.

Therefore reclassify:
- `D97DX_EXACT_25G82_METALLIB_MAP_SELECTION=PASS` remains valid;
- `D97DX_COREDISPLAY_DEFAULT_METALLIB_BINARY_IDENTITY=INVALIDATED_BY_D97FU`;
- `D97FU_SYSTEM_COREDISPLAY_DEFAULT_METALLIB=METADATA_STUB_NEGATIVE`;
- `D97FU_LOCAL_TREE_COREDISPLAY_DEFAULT_METALLIB=METADATA_STUB_NEGATIVE`;
- broad claims that all 182 local metallib payloads are bad are NOT authorized without sampling/proof.

## Causal significance
This finding is highly relevant to D97FT because the earliest captured negative is CoreDisplay `GPUPass` specialization. A missing/invalid CoreDisplay metallib payload is now a concrete upstream candidate for that specialization failure.

However, direct causality is not yet SEMANTIC PROVEN because CoreDisplay's runtime library-loading path and possible alternate source/fallback must still be mapped/observed.

Classification:
- `COREDISPLAY_METALLIB_STUB_CAUSAL_CANDIDATE=STRONG`;
- `COREDISPLAY_METALLIB_STUB_CAUSAL_PROOF=UNPROVEN`.

## CURRENT ACTION — RECOVER ORIGINAL REAL 25G82 PAYLOAD READ-ONLY
Remain in VESA. No Root Patch, no reboot, no EFI/NVRAM/framebuffer changes.

Locate the original `MetallibSupportPkg-26.6.2-25G82.pkg` by exact package identity if still present locally. Extract only the CoreDisplay `default.metallib` from the original package into temporary space and verify:
- actual bytes and file type;
- actual size (metadata says 20,739 bytes);
- SHA256;
- GPUPass presence/metadata.

If the original package is absent, recover the real 25G82 CoreDisplay metallib from another authoritative local source (e.g. installer/restore asset) read-only. Do not overwrite the current system payload until the recovered binary is independently audited and causal design is closed.