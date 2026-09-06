# OCLP7 CHECKPOINT — 2026-09-06 — D97CG LLDB crash-hook negative; D97CH explicit-signal localizer ready

Authority: extends the prior D97CG-ready checkpoint without changing the D97CF true-single-Metal conclusions.

## State
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- D97BV remains absent/unauthorized.
- No Root Patch, installation, local compilation, accelerated boot or reboot authorized.

## D97CG returned bundle
`OCLP7_D97CG_SINGLE_METAL_FRAMEWORK_OVERRIDE_20260906_051636.zip`
- bytes `229595`;
- SHA256 `ec920f5a04e7f03a8ef274659350f1bfe087725c76e44e8e5530b32616582555`.

Packaged evidence:
- TXT bytes `672235`, SHA256 `0614cad86446e8a5afc21e15ce1f200d97ac5206dc2e2e154028fc042e097525`;
- JSON bytes `721501`, SHA256 `8735fd2245b2653acc88acb6df3151dd6f0ebc5f124b3547077820e28240bd72`.

## D97CG retained runtime result
Ordinary non-debugger run reconfirmed the exact D97CF frontier:
- framework override honored;
- exactly one Metal path loaded;
- native shared-cache Metal absent;
- `D97CG_TRUE_SINGLE_METAL=PASS`;
- `D97CG_FRAMEWORK_OVERRIDE_CLASSIFICATION=SINGLE_METAL_IDENTICAL_RW_MARKER_THEN_SIGSEGV`;
- RC `-11` SIGSEGV;
- final dyld marker `mprotect ... to read-write (Metal)`;
- zero dyld lines after marker.

Thus duplicate Metal remains CLOSED NEGATIVE as a sufficient current cause.

## D97CG LLDB result
Installed debugger was found:
- `/Library/Developer/CommandLineTools/usr/bin/lldb`;
- version `lldb-2100.0.17.203`.

The debugger run itself preserved the important runtime invariants:
- `D97CG_LLDB_TRUE_SINGLE_METAL=PASS`;
- target Metal was the only Metal path;
- target reached the same `mprotect ... to read-write (Metal)` marker.

However the `-K/--source-on-crash` command file was not entered:
- `D97CG_LLDB_CRASH_HOOK_BEGIN=False`;
- `D97CG_LLDB_CRASH_HOOK_END=False`;
- `D97CG_LLDB_BAD_ACCESS_CAPTURED=False`;
- `D97CG_LLDB_RIP=UNRESOLVED`;
- `D97CG_LLDB_FRAME0=UNRESOLVED`;
- `D97CG_LLDB_CLASSIFICATION=DEBUGGER_DID_NOT_ENTER_ON_CRASH_HOOK`.

This is a debugger harness limitation, not new Metal/runtime causal evidence. D97CG must not be rerun unchanged.

## D97CH design
Do not mutate Metal. Preserve the exact D97CF/D97CG SLIDE-page transform and true-single-Metal framework override.

D97CH changes only LLDB control:
1. set `process handle -s true -n true -p false SIGSEGV SIGBUS` before launch;
2. run the inferior synchronously;
3. put crash-state capture commands directly after `run`, not in `-K`;
4. capture process status, all-thread backtrace, registers, PC lookup, PC memory region, disassembly and image slides;
5. fail closed if debugger does not stop the inferior or if true-single-Metal is not preserved.

LLDB documentation confirms `process handle` controls stop/notify/pass behavior and `-K` is only a batch-mode source-on-crash hook; D97CH removes dependence on the latter.

## D97CH script identity
Run only:
`OCLP7_D97CH_single_metal_lldb_explicit_signal_localizer.sh`
- bytes `32797`;
- SHA256 `a04f36e64fda0c070da083d1bbf15d4c84a478bfb1daa355f07f841032a62a61`;
- shell syntax PASS;
- embedded Python compile PASS.

## CURRENT ACTION
Remain unpatched in VESA. Run only the exact D97CH script above and return its ZIP/output.
