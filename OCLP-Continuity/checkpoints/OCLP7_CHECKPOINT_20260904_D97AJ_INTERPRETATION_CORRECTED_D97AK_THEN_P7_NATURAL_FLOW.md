# OCLP7 CHECKPOINT — D97AJ interpretation corrected; D97AK first; P7 natural-flow candidate

Date: 2026-09-04 EEST
Authority: ASUS2 Tahoe `26.6.2 / 25G82`, Intel x86_64 Haswell, SMBIOS `MacBookAir6,2`.
Previous checkpoint: `OCLP7_CHECKPOINT_20260903_D97AJ_A4F_FULLY_RESOLVED_CFG_NO_LATE_BYPASS_DIAGNOSTIC_ORIGIN_NEXT.md`.

## Carry-forward invariant
Baseline remains exactly P1+P2b+P3+AIR00+D34. P6/P7 are retained diagnostics/patches with runtime sufficiency NEGATIVE; they are not part of the accepted five-functional-patch baseline. Golden Sequoia remains immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired. Routine tests remain ASUS2-only; GitHub only for major compile/build/package. Root Patch/reboot remain manual-only and separately authorized.

D97AH app remains live. D97AH manual Root Patch remains FULL PASS. Current root-patched 32023 is exact A4F postimage `1636896` bytes / SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e` / LC_UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`. D97AH accelerated boot remains `NEGATIVE_NO_USABLE_GUI`; D97AF runtime diagnostic provenance remains PROVEN 28/28 for A4F/32023.

## D97AJ result retained exactly
D97AJ resolved the one known switch at REL+`0x279` on current A4F and proved:

```text
CFG_REACHABLE_INSTRUCTION_COUNT_WITH_SWITCH=317
CFG_REACHABLE_WITH_EXIT110_BLOCKED_AND_SWITCH=314
REACHABLE_UNRESOLVED_INDIRECT_COUNT_AFTER_KNOWN_SWITCH=0
D97AJ_STATIC_LATE_BLOCK_BYPASS_EXIT110=NEGATIVE_IN_FULLY_RESOLVED_REACHABLE_CFG
```

All five mapped late simulator-limit xrefs at image offsets `0x9D6C8`, `0x9D6EE`, `0x9D712`, `0x9D73A`, `0x9D75D` are unreachable from the normal instrumented function entry and remain unreachable with the exit110 region blocked.

## Methodology correction — decisive
The D97AJ CFG result must not be misread as proving that the original donor/Sequoia flow cannot reach the late simulator-limit checks.

D97AD exit codes `110..114` are project-invented terminal diagnostic outcomes, not original donor/Sequoia exits. Specifically:
- exit 110 = artificial marker for candidate/D97 boundary REL+`0x58B` / image offset `0x9D6BD`;
- exits 111/112/113 = artificial terminal markers for three other known error outcomes;
- exit 114 = artificial class for two other finite early outcomes.

At `0x9D6BD`, the pre-D97AD/P7 image contained ordinary donor instructions, not an exit. The exact preimage discriminator there is `8b8d10feffff83f941`; D97AD replaces that normal code with terminal bytes `6a6e5fe9bb38f6ff90` (`push 110; pop rdi; jmp Darwin exit stub`). Therefore the current A4F CFG is intentionally cut at that point by our instrumentation.

Authoritative interpretation:
- D97AJ proves there is no hidden internal bypass around the artificial D97AD terminal in the instrumented A4F image;
- D97AJ does NOT prove that the natural donor/P7 flow cannot traverse the ordinary compare/branch sequence that existed before D97AD;
- do not treat `exit110` or `exit114` as Sequoia semantics.

## User-proposed natural-flow experiment — evaluated
The user proposed removing exit110 and allowing the original path to run normally. After review, the experiment is technically justified but must be designed cleanly.

### Do NOT remove only exit110
Removing only 110 would leave exits 111/112/113/114 plus the shared exit stub active. That would create a hybrid classifier image and confound interpretation.

### Correct first natural-flow experiment
If the read-only origin audit below finds no alternative diagnostic origin that changes the plan, the correct experiment is to remove the ENTIRE D97AD whole-stage classifier byte-exactly back to its P7 preimages:
- restore all six terminal windows;
- clear/reconstruct the D97AD shared exit-stub cave to the exact P7 preimage;
- prove exact P7 MTLCompiler SHA256 `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda` before any new provenance stamp.

P7 is chosen for the first natural-flow test because it changes one variable only: D97AD instrumentation removed while P1/P2b/P3/AIR00/D34/P6/P7 remain as before. If P7 natural-flow remains negative, a later separate experiment may return to the accepted true-five functional baseline without P6/P7.

### New provenance UUID is mandatory
Do NOT reuse A4F for a P7-natural-flow image. A4F must remain permanently bound to the D97AD-instrumented cohort already proven 28/28. Any P7 natural-flow image must receive a new frozen UUID so future logs can distinguish instrumented A4F from natural-flow P7 unambiguously.

## ACTIVE FRONTIER / CURRENT NEXT ACTION
Do not mutate source/system yet. Run D97AK first because it is already prepared, read-only, and can obtain one last no-reboot fact before changing the image.

D97AK must audit the exact current A4F full image for:
1. every code xref to the five exact simulator-limit strings;
2. owner function/symbol of every xref;
3. direct branches/calls from outside `validSimulatorMetadata` into its interior/late region;
4. statically recoverable address-taken/RIP-relative entries into those late addresses.

If D97AK finds another origin/entry, analyze that first. If D97AK finds only the known late xrefs and no external entry, then advance to a bounded local source-design/audit for complete D97AD removal to exact P7 plus a NEW provenance UUID. Do not Root Patch or reboot before that new source/build/deploy chain is separately audited.

No Root Patch. No reboot. No manual MTLCompilerService launch. Return complete D97AK raw output and STOP.