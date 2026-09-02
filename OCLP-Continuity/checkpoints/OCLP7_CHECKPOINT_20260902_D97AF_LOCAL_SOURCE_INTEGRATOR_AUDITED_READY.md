# OCLP7 CHECKPOINT — 2026-09-02 — D97AF local source integrator audited / ready

## Authority and supersession
This checkpoint supersedes only the integrator-status and `CURRENT SINGLE NEXT ACTION` sections of `OCLP7_CHECKPOINT_20260902_D97AF_UUID_FROZEN_LOCAL_SOURCE_INTEGRATOR_NEXT.md`.

All earlier accepted D97AF transform boundaries and project invariants remain unchanged. In particular, the D97AEX/D97AEZ external task-port method remains retired, runtime D97AD text bytes remain `UNKNOWN`, and the D97AF UUID stamp can prove only marker-build provenance for a future covered diagnostic-sender cohort—not direct runtime text bytes.

## Frozen D97AF transform retained
The user-generated and persisted UUID remains frozen exactly:

```text
D97AF_LC_UUID=A4F456DF-7447-49BF-AC4F-102D90023A1E
D97AF_UUID_REGENERATION=FORBIDDEN
```

The authoritative binary transform remains:

```text
D97AF_INPUT_D97AD_SHA256=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755
D97AF_EXPECTED_POST_SHA256=a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e
D97AF_CHANGED_BYTE_COUNT=16
D97AF_CHANGED_RANGE=0xAB0..0xABF
D97AF_EXECUTABLE_INSTRUCTION_CHANGE=NO
```

Only the complete 16-byte `LC_UUID` payload changes. The code-signature blob, executable instructions, protected D34 cave, retained functional patches and D97AD classifier remain byte-identical.

## Audited source-only integrator identity
The final bounded local integrator is:

```text
FILE=OCLP7_D97AF_LOCAL_LC_UUID_SOURCE_INTEGRATOR.command
SHA256=3554473851eec1f315e558694bcd4c0bc321629efaebdf27c679167ec9477682
GIT_BLOB=ce6d626d3352d5d7c6bd0212a8c3e79c05d88308
BYTES=62980
D97AF_LOCAL_SOURCE_INTEGRATOR_AUDIT=DELIVERY_PASS
```

This identity is final for delivery. Superseded draft integrator identities are not authoritative.

## Exact intended source result
The integrator pins the canonical source root, branch `alex-tahoe-25G82-custom`, HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`, the exact three existing modified source identities, the D97AD binary preimage and the persisted UUID file.

It adds exactly one D97AF method immediately after the unchanged D97AD method in `sys_patch_helpers.py`, and exactly one D97AF call immediately after the D97AD call in `sys_patch.py`. It does not change `metal_3802.py`. The independently audited expected post-source identities are:

```text
D97AF_EXPECTED_HELPERS_POST_SHA256=a240a3cb62ce25381ef6bd9e2d78e36dc379c25f9e9c5641e07cd9841e820d8e
D97AF_EXPECTED_SYSPATCH_POST_SHA256=ccf5ad96de9ef9051cc30ac61bf3c24522628f5e26122d6c0af5abb352f777c9
D97AF_EXPECTED_METAL_3802_UNCHANGED_SHA256=fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
D97AD_METHOD_SOURCE_SHA256_UNCHANGED=bb66b1d5d883251431d5a7fa7bc42c0cc9bcb15ec77c74506bb2eae5bf987a12
D97AF_METHOD_SOURCE_SHA256=d48d6daec4affdcd9469bf2bb60ddadddb5dc43cebbdfeb6051336a0766ee7b7
```

These are deterministic expected outputs of the audited integrator. They are not a claim that ASUS2 source mutation has already occurred.

The active call order remains exactly:

```text
P1 -> P2b -> P3 -> AIR00 -> D34 -> retained P6 -> retained P7 -> D97AD -> D97AF
```

D97AF remains a provenance stamp, not a new functional compatibility patch.

## Independent delivery audit
The exact final wrapper passed zsh syntax and embedded-Python compilation. Static audit passed the frozen constants, Mach-O topology, exact 16-byte transform, source insertion/cardinality/AST/order checks, transactional backup, per-file first/second byte and metadata CAS, staged and committed byte verification, rollback, lstat/owner/link/parent/filesystem/flags/ACL/xattr gates, report exclusive creation with a held file descriptor, and final report PASS only after capture completion.

The future Root-Patch helper embedded into source was audited for exact target preimage and topology, root-owned same-volume sibling reservation, metadata-preserving `cp -p`, data-fork-only `dd`, exact flag restoration, immediate target byte/inode/metadata CAS, exact post SHA/UUID verification, atomic same-volume rename, and cleanup restricted to the exact owned sibling inode. It contains no automatic app deployment, Root Patch, service launch or reboot.

Bounded disposable-fixture simulations established:

- normal integration exits `0`, leaves `SOURCE_UPDATE_STATE=COMPLETE`, and ends the report with exactly `D97AF_REPORT_CAPTURE=PASS` then `D97AF_LOCAL_SOURCE_INTEGRATION=PASS`;
- HUP/INT/QUIT/TERM during the post-Python shell-finalization window cannot interrupt the conclusive report state;
- SIGQUIT after the first source commit causes fail-closed exit and exact two-file rollback with `SOURCE_UPDATE_STATE=ROLLED_BACK`;
- an injected external-byte conflict is preserved rather than deleted, the non-conflicting file is restored, and state remains `ROLLBACK_PARTIAL_EXTERNAL_EDIT_PRESERVED_MANUAL_RECOVERY_REQUIRED`.

The bounded simulations do not constitute execution on ASUS2 and do not create a D97AF app or binary there.

## Current execution state
```text
D97AF_LOCAL_SOURCE_INTEGRATOR_STATUS=AUDITED_READY_FOR_IDENTITY_PINNED_LOCAL_RUN
D97AF_LOCAL_SOURCE_INTEGRATOR_ASUS2_EXECUTION=NOT_RUN
D97AF_LOCAL_SOURCE_MUTATION=NOT_YET_PERFORMED
D97AF_APP_BUILD=NOT_STARTED
D97AF_APP_AUDIT=NOT_STARTED
D97AF_APP_DEPLOY=NOT_STARTED
D97AF_ROOT_PATCH=NOT_AUTHORIZED
D97AF_REBOOT=NOT_AUTHORIZED
```

## CURRENT SINGLE NEXT ACTION — run audited local source integrator
Deliver/download only `OCLP7_D97AF_LOCAL_LC_UUID_SOURCE_INTEGRATOR.command` with the exact SHA256, git blob and byte count recorded above. The user verifies all three identities and runs it locally against the canonical ASUS2 source and frozen UUID file.

Then STOP. The user returns the complete report. Audit that report, the exact two-file source result and `metal_3802.py` unchanged identity before any compilation or build.

A later substantial compile/build/package may use GitHub only when clearly faster, and remains assistant-run and fully audited. No compilation, app deployment, opening OCLP, Root Patch or reboot is authorized by this checkpoint.

## Safety invariants
- Functional baseline remains exactly P1+P2b+P3+AIR00+D34.
- P6/P7 remain retained with runtime sufficiency NEGATIVE.
- Golden Sequoia remains immutable/read-only.
- D34 cave `0xEF8..0xEFE` remains protected.
- D50/D68/D82 remain reserve-only.
- D84 remains retired.
- Patch8 remains unauthorized.
- D97AEX/D97AEZ external task-port method remains retired.
- D97AEZ active-artifact deletion proof remains `REQUESTED_RESULT_NOT_YET_RETURNED`.
- installed app mutation `NO` at this checkpoint;
- system/root-patch target mutation `NO` at this checkpoint;
- service launch `AUTO-NO`;
- Root Patch `AUTO-NO`;
- reboot `AUTO-NO`.
