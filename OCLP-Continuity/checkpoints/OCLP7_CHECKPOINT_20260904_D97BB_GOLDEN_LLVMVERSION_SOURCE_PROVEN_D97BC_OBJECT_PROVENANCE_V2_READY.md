# OCLP7 CHECKPOINT — 2026-09-04 — D97BB Golden llvmVersion source PROVEN; D97BC V2 object provenance ready

## Architecture
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Remain in GOLDEN_B Sequoia `15.8 / 24H22`. Do not start Tahoe eligibility bypass yet.

## D97BB decisive result
Returned exact files:
- TXT 4779 bytes / SHA256 `694647bdfa56ca79b9446df8d9fb1a383e48834c13bbdd7462d68e1f6810c4e1`;
- JSON 4113 bytes / SHA256 `3ede6711d2494b3a9f3ae3900c0c9f8572b0c955b46b325789a7e6026fca63e2`.

`LC_FUNCTION_STARTS` proves primary request-builder function `0x7FF80D370756..0x7FF80D370C28`.
Exact llvmVersion chain:
- `0x7FF80D37081B`: `movslq 0x20(%rbx), %rdx`;
- `0x7FF80D37081F`: key llvmVersion -> RSI;
- `0x7FF80D370829`: uint64-setter-family call.
Classification: `G1_GOLDEN_PRIMARY_LLVMVERSION_SOURCE_RBX_PLUS_0x20=STATIC_VALUE_SOURCE_PROVEN`.

Known adjacent producer fields:
- primary requestType = `[R13+0x8]` dword;
- timeout = `[R13+0x18]` qword;
- sandboxTokens condition = byte `[R13+0x70]`;
- alternate requestType = immediate `9`.

## D97BC V2 — exact next action
Core:
`OCLP7_D97BC_GOLDEN_15_8_PRIMARY_REQUEST_BUILDER_OBJECT_PROVENANCE.command`
- commit `6457b6f5c613de18f60ae6517fc3f05ee8323240`;
- Git blob `7513123504d526bb5439410c453080d909fef218`.

Hardened wrapper:
`OCLP7_D97BC_V2_GOLDEN_15_8_PRIMARY_REQUEST_BUILDER_OBJECT_PROVENANCE_HARDENED_WRAPPER.command`
- commit `02bfb4c212dc62a7659469e5439b6003e02721df`;
- Git blob `43e1a9a96c211f0db530dfa3395dde30d97a42d2`.

Wrapper fail-closes unless exact core blob, zsh syntax, one Python heredoc compile, GOLDEN_B Metal SHA/function-boundary/known-site pins and no-mutation safety tokens all pass.

D97BC core independently revalidates:
- GOLDEN_B OS/build and donor hashes;
- cached Metal text SHA `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`;
- `LC_FUNCTION_STARTS` containing function exactly `0x7FF80D370756..0x7FF80D370C28`.

Then it disassembles only that one function, prints the entry through the llvmVersion region, inventories writes to RBX/R13 before their known field uses, and traces explicit register-copy/memory/immediate origins conservatively.

Goals:
1. establish RBX provenance for `[RBX+0x20]=llvmVersion`;
2. establish R13 provenance for `[R13+0x8]=requestType`, `[R13+0x18]=timeout`, `[R13+0x70]` sandbox condition;
3. map either register to ABI argument/object pointer or other structural source where directly supported;
4. no broad cache scan, debugger attach, persistent instrumentation, system mutation, Root Patch or reboot.

After D97BC, decide whether one minimal Golden runtime capture remains necessary or whether Golden characterization is sufficient to begin the separately audited identical-OCLP Tahoe eligibility-bypass phase.