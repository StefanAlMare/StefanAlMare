# OCLP7 CHECKPOINT — 2026-09-04 — D97AV V2 static utility map PASS; boot subsection tooling-false; P1 masks upstream llvmVersion difference; D97AW ready

## Authority / scope
Target Tahoe remains `26.6.2 / 25G82`, Haswell HD4400/4600, SMBIOS `MacBookAir6,2`. User is currently in manually restored working Golden Sequoia `15.7.9 / 24G830` for comparator work. No experimental Golden Root Patch, debugger attach, system-file mutation or reboot occurred in D97AV V2.

Batch identity returned by user and independently verified:
- JSON bytes `12407`, SHA256 `685acdd2df077908eec6cbeedff60d2bb66bbbe4b323c670fdb603dcf1385626`;
- TXT bytes `36248`, SHA256 `2d6d6d6c06df896d251441eb00172e0b2d5d72a6a8e3bba40e4c8a1ed6dc2542`.

D97AV V2 wrapper identity was commit `56bf44d75d145a6b738468a9c3869c5291aa31be`, Git blob `d7b01788f8edc85c5190e481577b479e895892ea`.

## Golden identity — PASS
D97AV V2 observed:
- OS `15.7.9 / 24G830`;
- Golden 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- Golden 32023 UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`;
- Golden original MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`, UUID `3716D20F-B990-3906-B3E5-44E88AE63AF8`.

## D97AV V2 boot subsection — RETIRED TOOLING FALSE WINDOW
Report printed:
- `GOLDEN_BOOT3M_START=1970-01-03 08:18:27`;
- `GOLDEN_BOOT3M_END=1970-01-03 08:21:27`.

Root cause is in wrapper chronology parsing:
`sysctl -n kern.boottime | sed -E 's/.*sec = ([0-9]+).*/\1/'` uses greedy `.*sec =` and can match the later `usec = ...` field rather than the `sec = ...` epoch field. Therefore the D97AV V2 boot-window rows/PID sequences (`305` rows / `18` PIDs) are NOT boot-aligned evidence and are retired.

Authoritative runtime comparator remains D97AU fixed Golden window `2026-09-04 12:54:24..12:57:24`:
- Golden 32023 `220`, 3802 `193`, 8 exact-generation PIDs;
- Golden 32023 PCs `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`, `0xA5F81=0`;
- Tahoe D97AN: 32023 `79`, 3802 `0`, `0x9A9FC=0`, `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`.

Classification: `D97AV_V2_BOOT_SEQUENCE_SUBSECTION=TOOLING_FALSE_WINDOW_RETIRED`. Do not use the 1970-window counts for causal conclusions.

## Decisive new static map — PASS
D97AV V2 maps `0x9A9FC` to `MTLCompilerObject::upgradeAIRModule(llvm::Module*, unsigned int, unsigned int)`, immediately after the os_log literal:
`MTLCompiler upgrade pass forced to use air version %d.%d`.

Known Golden-vs-Tahoe patch sites:
- P2b `0x9A8CD`: Golden `418b81d0000000` -> Tahoe `418b8110010000`, owner `getReadParametersFromRequest`;
- AIR00 `0x9A933`: Golden `488b433049894628` -> Tahoe `49c7462800000000`, owner `getReadParametersFromRequest`;
- P7 `0x9A93B/0x9A946`: Golden `+0x88/+0x8C` reads -> Tahoe `+0xA8/+0xAC`, same owner `getReadParametersFromRequest`;
- P3 `0xA1573`: Golden `81e100002000` -> Tahoe `81c900002000`, owner `backendCompileModule`;
- D34 callsite `0x9F6FA`, owner `runFrameworkPasses`; cave `0xEF8` donor-zero;
- P6 12 sites belong to `invokeLowerModule` and `runFrameworkPasses`.

Therefore P2b/AIR00/P7 form a tight producer/read-parameter cluster immediately upstream-adjacent in the binary to the Golden-observed `upgradeAIRModule` function. This does NOT yet prove a direct call/causal edge; it promotes that relation for explicit static call-graph audit.

Classification: `D97AV_V2_SEVEN_PATCH_STATIC_LOCATION_MAP=STATIC_PROVEN`.

## P1 exact Golden semantics — decisive correction
Golden original MTLCompilerService has:
- exact imm32 `3802` at fileoff `0x3478`;
- exact imm32 `31001` at fileoff `0x3496`;
- zero imm32 `32023` occurrences in the selector.

Golden selector control:
- ESI `3802` selects `/Versions/3802/MTLCompiler`;
- ESI `31001` selects `/Versions/32023/MTLCompiler`;
- other unsupported values select NULL according to the already-proven selector logic.

Tahoe P1 changes only fileoff `0x3496` from compare `31001` to compare `32023`; the separate 3802 compare at `0x3478` is untouched.

Consequences:
1. P1 cannot directly transform a genuine `llvmVersion=3802` request into 32023. If Tahoe producer emitted 3802, the 3802 branch would remain available.
2. P1 is therefore NOT a sufficient explanation for Tahoe's observed zero-3802 cohort.
3. P1 is a compatibility shim for Tahoe requests carrying 32023; a simple P1 ablation would make those requests lose the 32023 donor path rather than become Golden-equivalent.
4. The strategically correct repair, if producer comparison confirms it, is upstream normalization to Golden request semantics with the Golden selector restored unchanged, not isolated P1 removal.

Combined with D97O (`llvmVersion` is the selector source) and runtime sender provenance, the earliest currently exposed non-equivalence is upstream at request `llvmVersion` / request-class production.

## Patch utility reevaluation after D97AV V2
- P1: `KEEP_TEMPORARY_SHIM / RETIRE_ONLY_WITH_PRODUCER_NORMALIZATION`; not isolated-ablation candidate.
- P2b: `PROVISIONAL`; exact structural mismatch correction, but located in the promoted getReadParameters cluster.
- AIR00: `HIGH_PRIORITY_REEVALUATE`; D22 proves AIR2.6/Metal3.1 local semantics, but Golden working actively reaches `upgradeAIRModule` while Tahoe does not; exact causal relation still unproven.
- P7: `HIGH_PRIORITY_REEVALUATE`; same getReadParameters cluster, runtime sufficiency NEGATIVE.
- P3: `PROVISIONAL`; inside backendCompileModule, runtime GUI sufficiency unproven; direct relationship to top-level backend/specialized lane still to map.
- D34: `PROVISIONAL_LOWER_PRIORITY`; runFrameworkPasses downstream, accepted semantic reset but no GUI sufficiency.
- P6: `PROVISIONAL_LOWER_PRIORITY / INSUFFICIENT`; real dialect mismatch corrected, runtime sufficiency NEGATIVE, deeper functions.

No patch is yet RETIRED solely from D97AV V2.

## D97AW prepared — CURRENT ACTION
Read-only Golden wrapper:
`OCLP7_D97AW_GOLDEN_FIXED_BOOT_3802_32023_CALLGRAPH_AND_SHARED_CACHE_LLVMVERSION_PRODUCER_AUDIT.command`
- commit `8187316e61bfa47ace5db0da19d3df1cc60e887d`;
- Git blob `e2d77333fb4d67efe17b1afb6ffb9168aeafc828`.

D97AW goals:
1. use the absolute authoritative D97AU Golden window `2026-09-04 12:54:24..12:57:24` (no current-boottime parsing);
2. map every exact observed 3802/32023 sender PC in that fixed window to function/instruction context;
3. build a conservative direct-call graph among `getReadParametersFromRequest`, `upgradeAIRModule`, specialized/backend entry functions, `backendCompileModule`, `invokeLowerModule`, `runFrameworkPasses`;
4. discover Golden shared-cache Metal.framework `llvmVersion` key ownership, exact xrefs and `xpc_dictionary_set_uint64` writer value sources;
5. compare Golden writer source shape to persisted Tahoe D97R source shape `[RBX+0x1C]` / `[RCX+0x38]`;
6. perform no debugger attach, cache extraction, system mutation, Root Patch or reboot.

## CURRENT ACTION
Remain in working Golden and run only D97AW after identity/parse/embedded-Python compile gates. Return complete TXT + JSON. STOP after D97AW. No Root Patch and no reboot.
