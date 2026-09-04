# OCLP7 CHECKPOINT — 2026-09-04 — D97AU lane divergence; seven-patch utility reevaluation; D97AV V2 ready

## Authority / carry-forward
Tahoe target remains `26.6.2 / 25G82`, Haswell HD4400/4600, SMBIOS `MacBookAir6,2`. User-authorized Golden comparator override remains active: user may manually boot working Golden Sequoia restored with ORIGINAL OCLP Root Patch; assistant does not automate Golden Root Patch/reboot and does not install experimental Golden system-file patches without separate explicit authorization.

Accepted historical conceptual patch set is exactly seven functional interventions currently active in Tahoe:
1. P1 service selector bridge;
2. P2b request-layout bridge;
3. P3 serialized-bitcode path;
4. AIR00 AIR 2.6 / Metal 3.1 fallback;
5. D34 semantic-equivalent reset;
6. P6 12 request-dialect call-site ports;
7. P7 two raw optional-payload read ports.

D97AM LC_UUID stamp is provenance-only and is NOT an eighth functional patch.

Historical acceptance is no longer treated as automatic strategic justification. New criterion: a patch must be judged by whether it moves Tahoe toward the working Golden request/generation/lane contract, not merely whether it permits deeper local execution.

## D97AU — decisive Golden/Tahoe boot-aligned observations
Golden working first three minutes:
- total exact MTL records `451`;
- 32023 sender records `220`;
- 3802 sender records `193`;
- active generation set `3802,32023`;
- 8 exact-generation PIDs, with no PID mixing generations;
- 32023-only PIDs `360,395,528,553`;
- 3802-only PIDs `367,398,540,565`.

Golden 32023 outer PCs:
- `0x9A9FC = 88`;
- `0x9FFEE = 66`;
- `0xA0521 = 66`;
- `0xA5F81 = 0`.

Tahoe D97AN accelerated reference:
- 32023 sender records `79`;
- 3802 sender records `0`;
- exact 32023 PID count `65`;
- `0x9FFEE = 7`;
- `0xA0521 = 7`;
- `0xA5F81 = 65`.

Authoritative classifications:
- `GOLDEN_TAHOE_BOOT_ALIGNED_GENERATION_SELECTION_DIVERGENCE=RUNTIME_PROVEN_OBSERVED`;
- `GOLDEN_TAHOE_BOOT_ALIGNED_32023_REQUEST_LANE_DIVERGENCE=RUNTIME_PROVEN_OBSERVED`.

These are observations, NOT yet causal proof.

D97AU existing-PID LLDB capture was explicitly denied by macOS (`Not allowed to attach to process`). Therefore Golden raw six-counter values remain `UNKNOWN_ATTACH_DENIED`; do not retry the same debugger lane and do not infer zero/no traffic.

## Critical methodological correction — patch utility must be re-proven
The clean historical true-five configuration P1+P2b+P3+AIR00+D34 did not produce a usable accelerated GUI. It did establish important local semantic/structural progress, but combined GUI/runtime sufficiency was NEGATIVE.

P6 corrected a real fixed-header request-dialect mismatch at 12 exact call sites, but its accelerated runtime sufficiency was NEGATIVE.
P7 corrected two real raw optional-payload read-port mismatches, but its accelerated runtime sufficiency was NEGATIVE.

Therefore all seven interventions are now subject to utility/causal reevaluation. Do NOT remove them blindly; do NOT retain them by inertia.

## Exact patch architecture recovered from historical authoritative wrappers
### P1 — MTLCompilerService selector bridge
Historical Root Patch explicitly verifies `31001 -> 32023` service selector bridge. D97M proves the service selector itself maps ESI 32023 to dlopen 32023 and ESI 3802 to dlopen 3802, all other values to NULL. D97O proves selector source is low32 of XPC request key `llvmVersion`.

P1 is the only one of the seven interventions located before MTLCompiler generation dlopen, and therefore the only patch with direct generation-selection influence. Important limit: P1 remaps 31001 to 32023; it does NOT rewrite an existing 3802 request to 32023. Hence P1 alone cannot be asserted to explain Golden 3802 present / Tahoe 3802 absent.

### True-five MTLCompiler-side sites — P2b/P3/AIR00/D34
Golden-derived true-five oracle proves the MTLCompiler functional bytes are exactly:
- P2b fileoff `0x9A8CD`, post `41 8B 81 10 01 00 00`;
- AIR00 fileoff `0x9A933`, post `49 C7 46 28 00 00 00 00`;
- P3 fileoff `0xA1573`, post `81 C9 00 00 20 00`;
- D34 cave `0xEF8`, post `48 89 F8 48 89 37 C3`;
- D34 callsite `0x9F6FA`, post `E8 F9 17 F6 FF`.

P1 is not part of these MTLCompiler bytes; it is the service selector bridge.

### P6
Twelve exact 32023 call-site ports only:
`0x9F53A,0x9F5B0,0x9F63F,0x9F65E,0x9E95D,0x9E97C,0x9E9CF,0x9E985,0x9E9AC,0x9E8EF,0x9E757,0x9E74E`, translating the fixed request dialect `C4/C8/CC/DC/E0 -> E4/E8/EC/11C/120`. No global rewrite.

### P7
Exactly two 32023 read ports:
- `0x9A93B`: raw `+0x88 -> +0xA8`;
- `0x9A946`: raw `+0x8C -> +0xAC`.

P2b/P3/AIR00/D34/P6/P7 execute only after the service has selected/loaded 32023 and therefore cannot directly choose 3802 versus 32023. They may still alter the internal 32023 request lane and must be mapped against the newly observed `specialized` versus `backend` divergence.

## D97AV V1 retired before execution
Old unrun wrapper `OCLP7_D97AV_GOLDEN_BOOT_LANE_AND_LLVMVERSION_PRODUCER_STATIC_AUDIT.command`, commit/blob `d0e8c3f476ffcfd0deacb4866d94e6098a6bffcd / 9344774aa6cf97f4216486b76e7bf470001ac20e`, is retired before user execution because it did not include the seven-patch utility reevaluation requested by the user.

## D97AV V2 — ACTIVE NEXT ACTION
Public Golden-only read-only wrapper:
- `OCLP7_D97AV_V2_GOLDEN_BOOT_LANE_LLVMVERSION_AND_PATCH_UTILITY_CAUSAL_AUDIT.command`;
- commit `56bf44d75d145a6b738468a9c3869c5291aa31be`;
- Git blob `d7b01788f8edc85c5190e481577b479e895892ea`.

D97AV V2:
1. fail-closes on exact Golden OS/build and exact Golden 32023 SHA;
2. maps Golden 32023 PCs `0x9A9FC/0x9FFEE/0xA0521/0xA5F81` to exact functions/instructions;
3. reads exact Golden preimage bytes at every P2b/P3/AIR00/D34/P6/P7 site and compares them to exact Tahoe patched postimages;
4. maps each patch site to its containing Golden 32023 function;
5. inspects Golden MTLCompilerService for exact 31001/32023/3802 selector constants and contexts, rather than assuming Golden uses the Tahoe P1 bridge;
6. reconstructs exact first-three-minute per-PID generation/lane sequences;
7. scans visible Golden Metal.framework for `llvmVersion` producer context when available;
8. emits a conservative seven-patch utility matrix with direct-generation-selection influence, known semantic/runtime benefit, known insufficiency/cost, and provisional justification.

No debugger, source/system mutation, experimental Root Patch or reboot.

## After D97AV V2
Do NOT perform seven one-patch-per-reboot tests. First audit the static influence map. Then design at most a small targeted ablation matrix for only the patch(es) that can plausibly cause the Golden/Tahoe generation or internal-32023 lane divergence.

D97AS six-bit late classifier remains reserve-only while this earlier producer/handoff frontier is stronger.

STOP after D97AV V2 and return both report and JSON.