# OCLP7 CHECKPOINT — 2026-09-06 — D97BV adapter FULL PASS; D97BW-v2 sparse standalone structural PASS; D97BX loadability next

## Entering / current state
- Target: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current machine remains unpatched Tahoe VESA; `-igfxvesa` active; no active Root Patch.
- Native Tahoe Metal remains cache-resident/authoritative.
- Full legacy `13.2.1-24/Metal.framework` remains forbidden because it shadows native Metal and removes Tahoe `_MTL4*` superclass ABI.
- No Root Patch or accelerated reboot is authorized.

## Retained upstream causal closure
Shared generation accessor: `0x7FF80F5E16C3..0x7FF80F5E1778`.
Under default/current environment, 3802 is suppressed before selector/XPC:
- primary path floors values `<32024` to `32023`, therefore `3802 -> 32023`;
- lazy fallback floors to at least `32023` or `32024`;
- only explicit nondefault bypass is `MTL_FORCE_MTLCOMPILER_LLVM_VERSION`; current/default override global is zero.

Classification retained:
`D97BT_DEFAULT_ENV_ACCESSOR_WIDE_3802_SUPPRESSION=SEMANTIC_PROVEN`.

This is consistent with D97AA runtime: 12/12 observed failing Tahoe requests delivered `llvmVersion=32023`, 3802=0.

## D97BV returned bundle — FULL PASS
Bundle:
`OCLP7_D97BV_TEXT_INTERSECTION_PADDING_CAVE_PREFLIGHT_20260906_001956.zip`
- bytes `2574`;
- SHA256 `c39198d603664b921f57abd0d09d24ad7fc1d08c2da8f44677c86de93301cbfd`.

Exact native Metal identity remained:
- cache image start `0x7FF80F47D000`;
- cached `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

### Exact patch site
Accessor floor window:
- VM `0x7FF80F5E1719..0x7FF80F5E1726`;
- exact 13-byte preimage `3d187d0000b9177d00000f4cc1`;
- complete instructions: compare 32024, load 32023, conditional move;
- no incoming direct branch target enters the middle of the window.

### Safe executable inter-section cave
D97BV found exactly one high-value padding region:
- VM `0x7FF80F47E560..0x7FF80F47E630`;
- length `208` bytes;
- all zero bytes;
- inside executable `__TEXT` segment;
- outside every Mach-O section and outside header/load commands;
- function-start hits: 0;
- direct branch-target hits: 0;
- decoded RIP-relative-target hits: 0.

Classification:
`D97BV_EXECUTABLE_UNSECTIONED_TEXT_CAVE_208B=STATIC_PROVEN_SAFE_UNDER_AUDITED_REFERENCE_MODEL`.

### Exact selective adapter
Site bytes:
`3dda0e00007406e93bcee9ff90`

Cave bytes:
`3d187d0000b9177d00000f4cc1e9b4311600`

Semantics:
- exact input `3802` bypasses Tahoe floor and remains `3802`;
- every non-3802 input executes Tahoe original floor semantics exactly.

Truth-table included 0, 1, 3802, 3902, 32022, 32023, 32024, 32025 and `0xffffffff`; only 3802 intentionally differs from native Tahoe.

Classification:
`D97BV_SELECTIVE_3802_PRESERVE_ADAPTER_NO_NON3802_SEMANTIC_DRIFT=STATIC_SEMANTIC_PROVEN`.

Do not replace this with global `32023->31001`, Golden offset transplantation, global force-3802 or threshold lowering.

## D97BW v1 tooling stop
First reconstruction collector stopped before reconstruction because of a conservative allocation guard:
`FAIL=RECONSTRUCT_SIZE_UNSAFE:881770496`.
This was due to large shared-cache-native segment `fileoff` values, not invalid Metal structure. No mutation occurred.

## D97BW-v2 returned bundle — structural FULL PASS
Bundle:
`OCLP7_D97BW_V2_NATIVE_METAL_SPARSE_MIRROR_20260906_003847.zip`
- bytes `4811`;
- SHA256 `180cc1e9a28c6c6a763c695305e47a05798c1d2e46c65b650c4ebbe6e4a21707`.
- inner TXT SHA256 `c4ccea417e412f0f1c07a9d62cf15e8ab58bf5c29dd690469be6f4b22bb54085`;
- inner JSON SHA256 `d07953a0f8bac305673f5c64c71fc11ec077f6946be4470de62035aa8c718242`.

D97BW-v2 created only temporary sparse files under `/private/tmp`, deleted them before return, and included no Apple binary in the report ZIP.

### Sparse native standalone mirror
Declared apparent size:
- `881770496` bytes (`840.921875 MiB`).

Actual allocated space:
- `176193536` bytes (`168.03125 MiB`).

Segment bytes actually written:
- `165003186` bytes.

Reconstruction retained original load-command/fileoff geometry and cloned only Mach header + load commands at file offset 0 so standalone parsers could locate the Mach-O header. No load-command rebasing was performed.

Native `__TEXT` range in standalone sparse mirror retained exact SHA256:
`bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

All recorded load-command data ranges were in apparent-file bounds, including exports trie, symtab, strings, indirect symbols, function starts and data-in-code.

External structural tools:
- `/usr/bin/file` RC 0: `Mach-O 64-bit dynamically linked shared library x86_64`;
- `otool -l` RC 0;
- `otool -L` RC 0 and native install-name/dependencies parsed correctly.

Classification:
`D97BW_V2_SPARSE_STANDALONE_STRUCTURAL=PASS`.

### Native Metal4 surface retained
Exact string counts in reconstructed original and patched copies were identical:
- `_MTL4CommandQueue` 82;
- `_MTL4CommandBuffer` 103;
- `_MTL4CommandAllocator` 49;
- `_MTL4RenderCommandEncoder` 79;
- `_MTL4ComputeCommandEncoder` 97;
- `_MTL4MachineLearningCommandEncoder` 38.

Thus native Metal4 surface is preserved by reconstruction and patch.

### D97BV patch applied to temporary sparse copy
File offsets:
- cave fileoff `256370016` (`0xF47E560`);
- site fileoff `257824537` (`0xF5E1719`).

Exact bytes:
- original site `3d187d0000b9177d00000f4cc1`;
- patched site `3dda0e00007406e93bcee9ff90`;
- original cave 18 zero bytes;
- patched cave `3d187d0000b9177d00000f4cc1e9b4311600`.

Diff audit:
- total differing bytes: `23`;
- differing bytes outside allowed site+cave: `0`.

External structural tools on patched copy:
- `file` RC 0;
- `otool -l` RC 0;
- `otool -L` RC 0.

Classification:
`D97BW_V2_PATCHED_SPARSE_STRUCTURAL=PASS`.
`D97BW_V2_D97BV_DIFF_BOUNDED_TO_SITE_AND_CAVE=STATIC_PROVEN`.

### Code signature status
`codesign -dvvv --strict` returned RC 1 for both temporary reconstructed original and patched sparse copy: `code object is not signed at all`.
This does not invalidate structural reconstruction but means loadability/trust must be audited before any installation plan.

## What is now proven
1. upstream default-environment 3802 suppression mechanism is semantically proven;
2. a selective 3802-only adapter with no non-3802 semantic drift is statically proven;
3. exact executable padding for its trampoline exists and is reference-safe under the audited static model;
4. exact native 25G82 Metal can be reconstructed locally as a sparse standalone mirror that passes `file`, `otool -l`, `otool -L` and load-command-bounds checks;
5. patching that mirror changes only the intended site+cave and retains exact native Metal4 surface.

## What is NOT yet proven
- dyld can actually preflight/load the reconstructed standalone mirror;
- a suitable signing/trust state for the reconstructed/modified binary;
- root-path installation behavior when a standalone `Versions/A/Metal` exists alongside the dyld-cache image;
- that the proposed selective legacy service/compiler payload plus native patched Metal constitutes a complete safe Root Patch root.

## CURRENT ACTION — D97BX
Remain unpatched in Tahoe VESA.
Next action must be temporary/local only and must not install anything:
1. rebuild the same sparse original and D97BV-patched copies under `/private/tmp`;
2. test `dlopen_preflight` from a sacrificial child process before actual load;
3. if preflight passes, test actual `dlopen` only in a sacrificial child and capture exit/dlerror without affecting the host session;
4. separately test whether temporary ad-hoc signing is possible/changes preflight, without installing the file;
5. audit sparse allocation before/after signing;
6. delete every temporary Apple binary before return;
7. report only TXT/JSON, no Apple binary.

Do not Root Patch or accelerated-boot yet.
