# OCLP MASTER CONTINUITY

Updated: 2026-09-06 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260906_D97CG_LLDB_HOOK_NEGATIVE_D97CH_EXPLICIT_SIGNAL_READY.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` + `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Mandatory startup order
Before any technical modification:
1. permanent database;
2. permanent working rules;
3. this MASTER;
4. permanent VESA rule;
5. exact checkpoint linked above;
6. retrospective/history as needed.

## Current machine / goal
- Tahoe `26.6.2 / 25G82`;
- Haswell HD4400/4600 `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- current state unpatched VESA, `-igfxvesa` active, no active Root Patch.

End goal: stable hardware acceleration and usable GUI.
Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Durable architecture
Pinned Golden OCLP: `dortania/OpenCore-Legacy-Patcher` commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`, OCLP `2.5.0`.
Golden selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both lanes.
Historical accepted functional lineage: `P1 + P2b + P3 + AIR00 + D34`; D34 cave remains protected.

Current target architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

Permanent prohibitions:
- never shadow Tahoe native Metal with legacy `13.2.1-24/Versions/A/Metal`;
- no global `32023 -> 31001` rewrite;
- no Golden `+0x20` transplant into Tahoe `+0x1C/+0x38` layouts;
- no global `MTL_FORCE_MTLCOMPILER_LLVM_VERSION=3802`;
- no repeat of historical native-Metal + legacy-XPC/private-compilers + unchanged true-five reboot.

Exact target Metallib package remains `MetallibSupportPkg-26.6.2-25G82`, SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

## Native producer / D97BV closure
Native Tahoe Metal cache base `0x7FF80F47D000`; native `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`; native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.
Tahoe Builder A llvmVersion `[arg1+0x1C]`; Builder B `[arg1+0x38]`. Native 3802 and 32023 lanes exist; no 31001.
D97BT proved default-environment accessor-wide 3802 suppression to 32023/32024.

D97BV selective adapter remains static-semantic proven, but D97CD proved codesign inserts `LC_CODE_SIGNATURE` at `0x1560..0x1570`, consuming the first 16 bytes of its old pre-sign cave `0x1560..0x1630`. Remaining `0x1570..0x1630` requires a fresh safety audit. D97BV remains unauthorized.

## Standalone native-Metal reconstruction closure through D97CC
D97BW-v2/BX: sparse mirror is analysis-only.
D97BY: real `ipsw v3.1.713` extraction preserves native `__text`/Metal4; first load rejection missing `SG_READ_ONLY`.
D97BZ: SG_READ_ONLY fixed; next rejection segment VM order.
D97CA: coherent order-remap surface fully enumerated: 0 dyld segment-index rewrites, 0 relocation ordinal rewrites, 5 section fileoffs, 3652 symtab `n_sect`, no chained/split/unknown blockers.
D97CB: atomic order/SG_READ_ONLY/n_sect remap structural PASS.
D97CB-v5: proven cold harness; remapped RAW Metal maps `__TEXT`, then fails sub-page `__DATA_CONST mmap(...CD0) errno=22`.
D97CC: exact 4K page-prefix/LINKEDIT plan statically closed; 20 section fileoffs, `__LINKEDIT +0x3000`, 7 total LINKEDIT metadata updates, section/content VM addresses preserved.

## D97CD — page-aligned mapping FULL PASS; Objective-C frontier
Bundle SHA256 `f1d208d223b516a931daae1ff1f421f60e5e2d633e208a180f24063ee73cd447`.
Transient unsigned page-aligned Metal: bytes `5735232`, SHA256 `0bce7edee6a01d372fab584b5a3022326a8c7c8fd061ff82d33b1b189e0af13c`.
All five standalone Metal segments map successfully. Runtime then reaches `mprotect ... to read-write (Metal.PAGE.adhoc)` and exits `RC=-11` SIGSEGV.

## D97CE — full --slide rebase does NOT advance ObjC frontier
SLIDE Metal SHA256 `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`.
`--slide` changes `88012` bytes / `43909` 8-byte chunks, heavily in Objective-C/data metadata, while load commands, native `__text` and Metal4 remain identical.
Page-aligned SLIDE transform SHA256 `068ec08cff3d279ce1a700695162d0eda19ab8f5b956b8a91e60c9009d155de2` reproduces exactly the D97CD boundary: target loaded, `makeSegmentsReadWrite`, zero dyld lines after marker, RC `-11`.
Classifications:
- `D97CE_SLIDE_ADVANCES_BEYOND_D97CD=NEGATIVE`;
- `D97CE_RAW_CACHE_SLIDE_INFO_IS_SUFFICIENT_CAUSE_OF_CURRENT_OBJC_SIGSEGV=NEGATIVE`.

## D97CF — true single Metal proven; duplicate-Metal cause CLOSED NEGATIVE
Returned bundle SHA256 `0a8d8c80521ccfefaa0419b4c5261e2b280488f9f74187954b29d1f2bd3cd7fc`.
Packaged TXT SHA256 `2ea845e8d0826dbfd850c9c6293565963f46a772d9c190cf542730a85e07b338`; JSON SHA256 `e8718f1822ba2494574984763bb3c3df8e5a221b1a112eb34b26bf35248bfb07`.

D97CF framework override was honored:
- temp framework Metal loaded;
- native shared-cache Metal not loaded;
- no native-cache Metal mapping;
- exactly one loaded Metal path/UUID;
- `D97CF_TRUE_SINGLE_METAL=PASS`.

Runtime remains identical:
- RC `-11` SIGSEGV;
- target all segments mapped and final loaded;
- final dyld marker `mprotect ... to read-write (Metal)`;
- zero dyld lines after marker.

Authoritative classifications:
- `D97CF_FRAMEWORK_OVERRIDE_CLASSIFICATION=SINGLE_METAL_IDENTICAL_RW_MARKER_THEN_SIGSEGV`;
- `D97CF_DUPLICATE_METAL_IS_SUFFICIENT_CAUSE_OF_CURRENT_OBJC_SIGSEGV=NEGATIVE`.

Thus dyld metadata validation, page mapping, cache-slide resolution and duplicate Metal coexistence are all insufficient explanations for the current crash. The active frontier is inside Objective-C image registration/fixup processing reached immediately after `makeSegmentsReadWrite`.

## D97CG — LLDB crash-hook attempt preserves frontier but does not capture PC
Returned bundle `OCLP7_D97CG_SINGLE_METAL_FRAMEWORK_OVERRIDE_20260906_051636.zip`:
- bytes `229595`;
- SHA256 `ec920f5a04e7f03a8ef274659350f1bfe087725c76e44e8e5530b32616582555`.
Packaged TXT: bytes `672235`, SHA256 `0614cad86446e8a5afc21e15ce1f200d97ac5206dc2e2e154028fc042e097525`.
Packaged JSON: bytes `721501`, SHA256 `8735fd2245b2653acc88acb6df3151dd6f0ebc5f124b3547077820e28240bd72`.

Ordinary D97CF frontier reconfirmed exactly: true single Metal, RC `-11`, final target marker `mprotect ... to read-write (Metal)`, zero post-marker dyld lines.
Installed LLDB `/Library/Developer/CommandLineTools/usr/bin/lldb`, version `lldb-2100.0.17.203`, also preserves true-single-Metal and reaches the same RW marker.
However `-K/--source-on-crash` is not entered:
- `D97CG_LLDB_CRASH_HOOK_BEGIN=False`;
- `D97CG_LLDB_BAD_ACCESS_CAPTURED=False`;
- `D97CG_LLDB_RIP=UNRESOLVED`;
- `D97CG_LLDB_FRAME0=UNRESOLVED`;
- `D97CG_LLDB_CLASSIFICATION=DEBUGGER_DID_NOT_ENTER_ON_CRASH_HOOK`.

Classification: debugger harness limitation only; no new Metal causal conclusion. Do not rerun D97CG unchanged.

## D97CH — explicit-signal LLDB localizer ready
Run only `OCLP7_D97CH_single_metal_lldb_explicit_signal_localizer.sh`:
- bytes `32797`;
- SHA256 `a04f36e64fda0c070da083d1bbf15d4c84a478bfb1daa355f07f841032a62a61`;
- shell syntax PASS;
- embedded Python compile PASS.

D97CH preserves the exact D97CF/D97CG page-aligned SLIDE carrier and true-single-Metal framework override. It changes only debugger control:
- forces LLDB `SIGSEGV` and `SIGBUS` handling to stop+notify+do-not-pass before launch;
- executes crash-state capture commands directly after synchronous `run`, rather than relying on `-K`;
- captures process status, all-thread backtrace, x86_64 registers, PC lookup, PC region, disassembly and image slides;
- fails closed if LLDB does not stop the inferior or if true-single-Metal is not preserved.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.
Run only the exact D97CH script above and return its ZIP/output.

D97BV remains absent. No Root Patch, installation, source/local compilation, accelerated boot or reboot authorized. GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
