# OCLP7 CHECKPOINT — 2026-09-06 — D97CF true single-Metal PASS, identical ObjC SIGSEGV; crash localization next

Authority: extends `OCLP7_CHECKPOINT_20260906_D97CF_SINGLE_METAL_OVERRIDE_SCRIPT_READY.md`.

## State
- Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- Machine remains unpatched VESA with `-igfxvesa`; no active Root Patch.
- D97BV remains absent/unauthorized pending a fresh signed-cave audit.
- No Root Patch, installation, source/local compilation, accelerated boot or reboot authorized.

## Returned D97CF evidence
Returned Terminal paste `Text lipit(6).txt` and bundle `OCLP7_D97CF_SINGLE_METAL_FRAMEWORK_OVERRIDE_20260906_041903.zip`.

Bundle:
- ZIP bytes `118754`;
- ZIP SHA256 `0a8d8c80521ccfefaa0419b4c5261e2b280488f9f74187954b29d1f2bd3cd7fc`.

Pinned SLIDE source remains exact:
- bytes `5722944`;
- SHA256 `df0fae6844a72500492db7c57b0a22ad5a45a0ab40861ddb8ea1e1e5bdf79e4c`.

Transient page-aligned transform remains exact D97CE identity:
- bytes `5735232`;
- SHA256 `068ec08cff3d279ce1a700695162d0eda19ab8f5b956b8a91e60c9009d155de2`.

D97CF structural/provenance gates all PASS:
- SLIDE identity PASS;
- page transform PASS;
- file/otool parsers PASS;
- framework target ad-hoc sign/strict verify PASS;
- proven cold baseline PASS;
- libbz2 control injection PASS.

## Decisive single-Metal runtime result
Framework override cold run:
- process RC `-11` (SIGSEGV);
- `OVERRIDE_HONORED=True`;
- temporary framework Metal loaded = True;
- canonical native shared-cache Metal loaded = False;
- native cache Metal mapping = False;
- `SINGLE_METAL=True`;
- unique Metal path count = `1`;
- unique Metal path = temporary `Frameworks/Metal.framework/Versions/A/Metal`;
- unique Metal UUID = `5D64FA80-29CE-32AA-BAB6-4E5034132C0B`;
- target `makeSegmentsReadWrite` marker seen;
- zero dyld lines after that marker.

Exact printed classifications:
- `D97CF_FRAMEWORK_OVERRIDE_CLASSIFICATION=SINGLE_METAL_IDENTICAL_RW_MARKER_THEN_SIGSEGV`;
- `D97CF_FRAMEWORK_OVERRIDE_HONORED=PASS`;
- `D97CF_TRUE_SINGLE_METAL=PASS`;
- `D97CF_DUPLICATE_METAL_IS_SUFFICIENT_CAUSE_OF_CURRENT_OBJC_SIGSEGV=NEGATIVE`;
- `D97CF_D97BV_APPLIED=NO`;
- `D97CF_AUDIT=PASS`.

Cleanup/package gates PASS; no system/cache mutation, no local compilation, no Root Patch, no reboot.

## Authoritative conclusions
- `D97CF_TRUE_SINGLE_METAL=RUNTIME_PROVEN`.
- `D97CF_DUPLICATE_NATIVE_PLUS_STANDALONE_METAL_IS_SUFFICIENT_CAUSE=NEGATIVE`.
- The current crash frontier remains the same Objective-C registration/fixup transition immediately after target `makeSegmentsReadWrite`.
- D97CD/D97CE/D97CF now jointly exclude: sub-page mapping geometry, unresolved raw cache slide-info as sufficient cause, and duplicate Metal loading as sufficient cause.

## CURRENT ACTION — exact crash localization
Remain unpatched in Tahoe VESA.

Next bounded diagnostic must preserve the exact D97CF single-Metal framework override and page-aligned SLIDE image, but run the proven cold target under an available debugger/crash-capture substrate to collect the actual faulting state rather than another indirect hypothesis.

Preferred first discriminator: LLDB launch of the same ad-hoc cold host with the exact D97CF environment, fail-closed on debugger/tooling availability. Capture at SIGSEGV/EXC_BAD_ACCESS:
1. faulting RIP/PC and stop reason;
2. all-thread backtrace, with crashing thread identified;
3. x86_64 general registers;
4. image/module list sufficient to symbolize whether fault is in libobjc, dyld, Metal, or another image;
5. instruction bytes/disassembly around RIP;
6. re-prove framework override / true single-Metal inside the debug run from dyld trace evidence;
7. do not apply D97BV.

If LLDB cannot launch the ad-hoc target or the exact DYLD override is not honored under debugger, classify harness-only and choose a non-invasive crash-report/sample substrate; do not modify the Metal payload merely to make debugging work.

No Root Patch, reboot, installation, source/local compilation, or accelerated boot is authorized.
