# OCLP7 CHECKPOINT — 2026-09-04 — Golden full contract book first; then identical original OCLP on Tahoe with eligibility-only bypass; D97AX V2 next

## User-authoritative strategy
The user explicitly fixed the final comparison methodology:

1. Stay in working Golden Sequoia `15.7.9 / 24G830` as long as necessary, including repeated manual boots, to exhaustively characterize the interaction between Sequoia and the ORIGINAL working OCLP/root-patch donor path.
2. Treat ORIGINAL OCLP behavior/payloads/selector/donor implementation as immutable reference semantics. Do not modify donor compiler logic merely to accept Tahoe-specific data.
3. Build a Golden contract book from producer ingress through OCLP and to the Haswell-driver handoff.
4. Only after the Golden contract book is sufficiently complete, prepare Tahoe with the SAME ORIGINAL OCLP functional content as Golden. The only permitted Tahoe-specific OCLP modification at that stage is a minimal, separately audited eligibility/OS-support bypass that makes the otherwise-original OCLP allow its Golden-equivalent Root Patch on Tahoe.
5. That bypass must not change payload selection, selector semantics, MTLCompiler logic, request layout, AIR/bitcode handling, donor binary contents, or driver payloads beyond what is strictly necessary to pass the Tahoe eligibility gate. Exact unchanged functional identities must be proven wherever possible.
6. Apply that eligibility-only OCLP to Tahoe manually, then run the SAME measurement suite/boundaries used on Golden.
7. Compare Golden vs Tahoe field-by-field and boundary-by-boundary. The repair belongs below the immutable OCLP donor: normalize Tahoe-produced data at the earliest non-equivalent producer/handoff until OCLP receives Golden-equivalent input and produces Golden-equivalent output.

Target architecture:
`Tahoe native producer -> Golden-equivalent contract -> ORIGINAL OCLP donor (same as Golden; Tahoe eligibility gate only) -> Golden-equivalent output -> Haswell driver -> image`.

## Experimental discipline
- Golden and Tahoe measurements must use equivalent collectors, workload definitions and boundary labels.
- Separate `SCHEMA_STATIC_PROVEN`, `RUNTIME_OBSERVED`, `RUNTIME_VALUE_PROVEN`, `GOLDEN_INVARIANT_PROVISIONAL`, `UNKNOWN`, `INCONCLUSIVE`.
- Do not infer runtime values from static code when exact values are unavailable.
- Repeated Golden boots are used to identify stable invariants and boot/workload-dependent fields.
- Historical custom patches P1/P2b/P3/AIR00/D34/P6/P7 are no longer presumed final and should not contaminate the identical-OCLP Tahoe comparator stage.
- No automatic Root Patch/reboot.

## Golden contract-book layers
### G1 — producer/XPC ingress
Metal.framework/request producer -> XPC dictionary -> MTLCompilerService selector.
Capture recoverable key/type schema, request classes, `llvmVersion`, generation split (`3802` vs `31001 -> 32023`), runtime UUID/path/PC/PID lanes, and repeated-boot stability.

### G2 — original donor ingress/internal semantics
Request headers/offsets, serialized payload, bitcode type/length/pointer, optional payload, AIR/Metal versions, getReadParameters, upgradeAIR, specialized/backend, module reconstruction, metadata/validator contracts.

### G3 — original donor output to Haswell graphics stack
GPUCompiler/Metal/IOGPU/AppleIntelHD5000GraphicsMTLDriver identities/load state, pipeline/library/function output paths, statuses, and the earliest observable handoff into the Haswell driver stack.

## Retained oracle facts
Working Golden Sequoia: `15.7.9 / 24G830`, HD4400 `0x0412`, Metal 2, display online.
Golden 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`, UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.
Golden 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`, UUID `D5CE0007-FAD0-3468-A62E-A21995BCA9F5`.
Golden original MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.
D97AU authoritative first-three-minute Golden window `2026-09-04 12:54:24..12:57:24`: 32023=220, 3802=193, 8 exact-generation PIDs; Golden 32023 PCs `0x9A9FC=88`, `0x9FFEE=66`, `0xA0521=66`, `0xA5F81=0`.
Tahoe historical custom comparator: 32023=79, 3802=0, 65 PIDs; `0x9A9FC=0`, `0x9FFEE=7`, `0xA0521=7`, `0xA5F81=65`. This is historical evidence only and is not the final identical-OCLP comparator.

Golden original selector: `3802 -> Versions/3802`, `31001 -> Versions/32023`; no 32023 immediate. Historical P1 changed only `31001 -> 32023`, leaving 3802 branch untouched, proving zero-3802 originated upstream of that shim.

## CURRENT ACTION — D97AX V2
Run Golden read-only ingress contract census through hardened wrapper:
`OCLP7_D97AX_V2_GOLDEN_ORIGINAL_OCLP_INGRESS_CONTRACT_CENSUS_HARDENED_WRAPPER.command`
- commit `d227fbc0b48415e3c3fda2b226fd279d786c9bfd`
- Git blob `ddd1584a697ee432ceee2813effc3537f44173f4`

Core V1 is commit `9f02c5c8200d2f37a785b0e87cd3ba8906a6da97`, blob `7a2cd15ca7aebdb3fe3d4a530b8aed79ecab9074`; V2 applies exactly two tooling-only `system_profiler` path corrections and verifies zsh + exactly three Python heredocs before execution.

D97AX outputs:
- `~/Desktop/OCLP7_D97AX_GOLDEN_ORIGINAL_OCLP_INGRESS_CONTRACT_CENSUS.txt`
- `~/Desktop/OCLP7_D97AX_GOLDEN_ORIGINAL_OCLP_INGRESS_CONTRACT_CENSUS.json`

STOP after D97AX V2 and return both files. Remain in Golden. No Root Patch and no reboot until D97AX is audited and the next Golden-UNKNOWN capture is selected.
