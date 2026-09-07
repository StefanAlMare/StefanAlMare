# OCLP7 D97EZ — exact `0x224 -> 0x24` handoff-adapter experimental design

Date: 2026-09-07 EEST
Input authority: D97EY exact accelerated tuple semantic proof.
Base source authority: exact generated D97ES 0.0.11 source SHA256 `8184610aca1f2e651e6526e45c05d00a96055711c985571bc34c703ba7f6a8d0`.

## Purpose
Test one narrowly measured compatibility hypothesis at the exact Tahoe-to-legacy `IOAccelSurface::set_id_mode` handoff without changing the legacy validator and without applying any broad mask.

D97EY proved for captured accelerated calls:
- `mode=0x24`, `badBits=0`, `goodBits=0x24` -> Apple original returns success;
- `mode=0x224`, `badBits=0x200`, `goodBits=0x24` -> Apple original returns `kIOReturnBadArgument`;
- the only observed mode-bit difference between these two classes is `0x200`.

The semantic name of bit `0x200` remains UNKNOWN. Therefore D97EZ is an experiment, not a production semantic claim.

## Exact functional rule
New explicit bootarg: `-ocmcd97ez`.

D97EZ remains LATENT when that bootarg is absent.

Inside the already-routed exact `IOAccelSurface::set_id_mode(uint32_t id, uint32_t mode)` wrapper:
1. preserve `that`, `id`, and `originalMode`;
2. classify every call globally/no-PID;
3. if and only if `-ocmcd97ez` is active AND `originalMode == 0x00000224`, choose `passedMode = 0x00000024`;
4. otherwise choose `passedMode = originalMode` byte-for-byte;
5. call Apple original exactly once with `that`, unchanged `id`, and `passedMode`;
6. return Apple's exact IOReturn unchanged.

Forbidden implementation forms:
- no `mode &=`;
- no `~0x200` mask;
- no `mode & goodMask` rewrite;
- no rewrite of any mode other than exact `0x224`;
- no ID rewrite;
- no return coercion;
- no global 0x200 clearing.

## Universal/no-PID audit state
Counters cover every routed call, not only first-eight samples:
- total call count remains existing `D97ELSetIdModeCallCount`;
- `D97EZExact224SeenCount`;
- `D97EZExact224AdaptedCount`;
- `D97EZOtherModeSeenCount`;
- `D97EZAdaptSuccessCount`;
- `D97EZAdaptFailureCount`;
- `D97EZPassthroughSuccessCount`;
- `D97EZPassthroughFailureCount`.

Exhaustive invariant after any run:
`Exact224SeenCount + OtherModeSeenCount == D97ELSetIdModeCallCount`.

When functional mode is ACTIVE:
`Exact224AdaptedCount == Exact224SeenCount`.

When LATENT:
`Exact224AdaptedCount == 0` and every call is exact passthrough.

## Per-slot telemetry
Preserve all D97ES first-eight fields as ORIGINAL-input telemetry:
- `D97ESxxId`;
- `D97ESxxMode` = original mode;
- `D97ESxxBadBits` = original mode bad bits;
- `D97ESxxGoodBits` = original mode good bits;
- `D97ESxxRet` = Apple original return after the selected handoff input.

Add:
- `D97EZxxPassedMode` for slots 01..08.

Thus a functional run directly shows original input, exact translated input and Apple result without relying on inference.

## Route and gate contract
- Existing `-ocmcd97eh` continues to control observer-route registration.
- `-ocmcd97ez` only enables the exact-match translation inside that already-installed route.
- Deployment testing must keep both `-ocmcd97eh` and `-ocmcd97ez` when ACTIVE.
- If D97EZ is present but `-ocmcd97ez` is absent, wrapper behavior must remain exact D97ES passthrough.

## Build/audit requirements
GitHub-first only:
1. reconstruct exact D97ES deterministically from pinned D97DL -> D97EH -> D97EL -> D97ES lineage;
2. verify exact D97ES input SHA before D97EZ generation;
3. generate D97EZ twice and byte-compare;
4. source audit exact-match branch and forbidden-mask absence;
5. compile x86_64 on an Intel GitHub macOS runner;
6. verify version `0.0.12`, x86_64, UUID and executable SHA256;
7. binary strings/symbol audit;
8. disassemble `patchedSetIdMode` and preserve the disassembly artifact for independent review;
9. package kext, generated source, generators, build log, disassembly and SHA manifest;
10. publish GitHub Actions artifact and persist run/job/artifact identities.

## Runtime gating
Before any accelerated functional test:
- deploy D97EZ to EFI only after build audit PASS;
- first boot D97EZ in VESA with `-ocmcd97ez` ABSENT to prove LATENT exact route/publisher behavior;
- only after that PASS may a separate checkpoint authorize ACTIVE `-ocmcd97ez` and one accelerated A/B boot.

No Root Patch is required or authorized for this kext-only observer/adapter revision. Never auto reboot.

## CI trigger note
This branch-only note is non-functional and exists solely to exercise the repository's `pull_request` GitHub Actions lane for the D97EZ GitHub-first build/audit. It changes no runtime contract, source generator, EFI state, Root Patch state, or ASUS2 state.

Synchronization probe: this second documentation-only commit exists solely to emit a `pull_request` synchronize event after PR #17 is already open; it changes no D97EZ behavior.