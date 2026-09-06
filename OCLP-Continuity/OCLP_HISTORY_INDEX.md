# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-06 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260906_D97CG_LLDB_HOOK_NEGATIVE_D97CH_EXPLICIT_SIGNAL_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture
Historical accepted functional baseline: `P1 + P2b + P3 + AIR00 + D34`.
Core principle: `Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.
Current target: `native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited upstream adapter -> legacy compiler path -> Haswell driver -> image`.

## Golden / generation closure
Golden selector maps `3802 -> Versions/3802`, `31001 -> Versions/32023`; Golden runtime naturally uses both lanes.
D97AA failing Tahoe cohort: 12/12 requests `llvmVersion=32023`, 3802=0.
D97BM/BN/BO mapped Tahoe native producer; D97BP/BQ proved shared accessor/selector ABI; D97BT proved default-environment 3802 suppression.

## Whole legacy Metal rejected
D97BJ/BK: full legacy main Metal shadows/removes Tahoe Metal4 superclass ABI. Permanent NEGATIVE.
D97BL: legacy MTLCompilerService/private compilers may be bounded; legacy main Metal remains forbidden.

## D97BV — selective 3802-preserve adapter
Static-semantic proven: preserve exact 3802, otherwise execute original Tahoe floor.
Pre-sign cave was `0x1560..0x1630`. D97CD later proved ad-hoc codesign consumes `0x1560..0x1570`; any standalone D97BV requires a new cave audit.

## D97BW-v2 / D97BX — sparse closure
Sparse reconstruction preserves native code/Metal4 but is not standalone-loadable. Signing and D97BV were not the blocker.

## D97BY — real DSC export
Pinned `blacktop/ipsw v3.1.713` RAW and `--slide` extraction succeed and preserve native `__text`/Metal4. First real-load rejection was missing `SG_READ_ONLY`.

## D97BZ — SG_READ_ONLY gate passed
Metadata-only flag repair passes that gate. Next exact rejection was segment VM order.

## D97CA — order-remap surface enumerated
Coherent repair surface: 0 dyld segment-index rewrites, 0 relocation ordinal rewrites, 5 section fileoffs, 3652 symtab `n_sect`, no chained/split/unknown blockers.

## D97CB — atomic order remap structural PASS
Exact order/SG_READ_ONLY/n_sect repair passed parser/preflight. v2-v4 contained only harness tooling defects. v5 finally proved a valid cold harness.

## D97CB-v5 — cold harness proven; sub-page mapping frontier
Bundle SHA256 `2d1a47c49bb6724b4ad5c65e878fa2872ee72880842ed1301aa1b94bf52bf17e`.
Baseline `/usr/bin/true` exit 0 with native Metal/libbz2 delayed. Positive control `DYLD_INSERT_LIBRARIES=/usr/lib/libbz2.1.0.dylib` exit 0 with libbz2 final loaded.
Signed remapped RAW Metal target observed; `__TEXT` maps; next failure `__DATA_CONST mmap(...CD0) errno=22`.

## D97CC — page-prefix/LINKEDIT static closure
4K page-prefix plan preserves all original section/content VM addresses while page-aligning segment mapping starts/fileoffs. Exactly 20 section offsets change; `__LINKEDIT +0x3000`; 7 total LINKEDIT metadata updates; no unknown blocker after identifying the printed `0xD48` hit as `__LINKEDIT.fileoff` itself.

## D97CD — page-aligned standalone mapping succeeds; Objective-C frontier
Bundle SHA256 `f1d208d223b516a931daae1ff1f421f60e5e2d633e208a180f24063ee73cd447`.
Transient unsigned page-aligned Metal: bytes `5735232`, SHA256 `0bce7edee6a01d372fab584b5a3022326a8c7c8fd061ff82d33b1b189e0af13c`.
All five standalone Metal segments map successfully. Runtime then reaches target `makeSegmentsReadWrite` and exits `RC=-11` SIGSEGV.

## D97CE — `--slide` does not advance Objective-C frontier
SLIDE Metal SHA256 `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`.
`--slide` changes `88012` bytes / `43909` qword chunks, heavily in Objective-C/data metadata, but page-aligned SLIDE Metal reproduces exactly the D97CD boundary: target final loaded, `makeSegmentsReadWrite`, zero dyld lines after marker, RC `-11` SIGSEGV.
Classification: `D97CE_SLIDE_ADVANCES_BEYOND_D97CD=NEGATIVE`.

## D97CF — true single Metal still identical Objective-C SIGSEGV
Returned bundle SHA256 `0a8d8c80521ccfefaa0419b4c5261e2b280488f9f74187954b29d1f2bd3cd7fc`.
Framework override is runtime-proven honored: temporary page-aligned SLIDE Metal loaded, native shared-cache Metal absent, no native-cache mapping, exactly one Metal path/UUID, `D97CF_TRUE_SINGLE_METAL=PASS`.
Yet runtime remains identical: target final loaded, final dyld marker `mprotect ... to read-write (Metal)`, zero lines after marker, RC `-11` SIGSEGV.
Authoritative classification: `D97CF_DUPLICATE_METAL_IS_SUFFICIENT_CAUSE_OF_CURRENT_OBJC_SIGSEGV=NEGATIVE`.

## D97CG — LLDB hook attempt is tooling-negative, runtime frontier unchanged
Returned bundle `OCLP7_D97CG_SINGLE_METAL_FRAMEWORK_OVERRIDE_20260906_051636.zip`:
- bytes `229595`;
- SHA256 `ec920f5a04e7f03a8ef274659350f1bfe087725c76e44e8e5530b32616582555`.
Packaged TXT SHA256 `0614cad86446e8a5afc21e15ce1f200d97ac5206dc2e2e154028fc042e097525`; JSON SHA256 `8735fd2245b2653acc88acb6df3151dd6f0ebc5f124b3547077820e28240bd72`.

Ordinary D97CF frontier reconfirmed exactly: true single Metal, final `makeSegmentsReadWrite`, zero post-marker dyld lines, RC `-11`.
Installed LLDB `/Library/Developer/CommandLineTools/usr/bin/lldb` (`lldb-2100.0.17.203`) also preserves true-single-Metal and reaches the same RW marker.
But the `-K/--source-on-crash` file is never entered: crash hook false, bad-access capture false, RIP/frame0 unresolved.
Classification: `D97CG_LLDB_CLASSIFICATION=DEBUGGER_DID_NOT_ENTER_ON_CRASH_HOOK`.
This is debugger-harness evidence only. Do not rerun D97CG unchanged.

## D97CH — explicit-signal LLDB crash localizer ready
Script `OCLP7_D97CH_single_metal_lldb_explicit_signal_localizer.sh`:
- bytes `32797`;
- SHA256 `a04f36e64fda0c070da083d1bbf15d4c84a478bfb1daa355f07f841032a62a61`;
- shell syntax PASS;
- embedded Python compile PASS.

D97CH preserves the exact D97CF/D97CG SLIDE-page transform and framework override. It changes only debugger control: LLDB is told to stop+notify and not pass `SIGSEGV`/`SIGBUS`, then crash-state commands execute directly after synchronous `run` instead of relying on `-K`. It captures process state, all-thread backtrace, registers, PC lookup, memory region, disassembly and image slides, and fails closed if the inferior does not stop or true-single-Metal is not preserved.

## CURRENT ACTION
Remain unpatched VESA.
Run only exact D97CH and return its ZIP/output.

No D97BV, Root Patch, installation, source/local compilation, accelerated boot or reboot is authorized.
