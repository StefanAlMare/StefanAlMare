# OCLP7 CHECKPOINT — 2026-09-03 — D97AF deploy FASTLANE audited / ASUS2 execution next

## Authority and supersession
This checkpoint supersedes only the execution-state and `CURRENT SINGLE NEXT ACTION` sections of `OCLP7_CHECKPOINT_20260903_D97AF_GITHUB_BUILD_AND_EXTERNAL_BYTE_AUDIT_PASS_DEPLOY_NEXT.md`.

All accepted D97AF source/build/artifact identities, the exact functional lineage and every permanent safety invariant remain unchanged. This checkpoint proves that the bounded ASUS2 application backup/deploy/open wrapper is identity-pinned, statically audited and fault-tested. It does not claim that the wrapper has run, that D97AF is installed, that Root Patch has run, or that any reboot/runtime observation has occurred.

## Exact delivery identity

```text
DELIVERY_FILE=OCLP7_D97AF_EXACT_GITHUB_ARTIFACT_AUDIT_DEPLOY.command
DELIVERY_SHA256=e82a5748abd09684a88932380d98d4ae8d83e0bfea94c462866080cfe7b535b4
DELIVERY_GIT_BLOB=02b4a322eaabb1eff0c3a14089a9ce6508882bc6
DELIVERY_BYTES=26914
ZSH_PARSE=PASS
EMBEDDED_PYTHON_BLOCK_COUNT=3
EMBEDDED_PYTHON_COMPILE=PASS
DELIVERY_AUDIT=PASS
ORDINARY_FAULT_MATRIX=PASS
```

The wrapper pins private repository `StefanAlMare/Private-Work`, workflow/run/job `348814365 / 33686570072 / 100435354962`, build head `76d45e6d4f37ad394a9f30a61c8bfc97dc587c4e`, artifact `9868515225`, artifact bytes `751567689` and outer SHA256 `70a123bfad81e00072ed2691fc769fa81c25f07c48a2ddb39a092d06d1947d9b`.

It re-verifies the exact complete artifact metadata and successful job-step set, outer ZIP bytes/SHA/CRC/member set, the complete pinned SHA256SUMS, inner deployment ZIP bytes/SHA/CRC, build/source reports, unique packaged executable, executable size/SHA and exact `x86_64` architecture before any installed-app mutation.

Exact app identities are:

```text
LIVE_D97AD_EXECUTABLE_BYTES=6587056
LIVE_D97AD_EXECUTABLE_SHA256=5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0
D97AF_EXECUTABLE_BYTES=6595600
D97AF_EXECUTABLE_SHA256=ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470
D97AF_EXECUTABLE_ARCH=x86_64
D97AF_INNER_APP_ZIP_SHA256=728dd30d7a4483bc7318300f3911e8aae8590f0d9ff59afbcf7db66651d8e907
```

## Transaction and fault audit
The wrapper authenticates only after all download/package identities pass, prepares the new app beside the live path, verifies it again, stops the exact old OCLP process set and requires an empty exact-path process census. It then moves exact D97AD to a unique timestamped backup, re-verifies that backup, requires a second empty census in the switch gap, moves D97AF to the canonical path, re-verifies the live executable and architecture, opens OCLP, proves a fresh exact-path process and stops.

The state-aware EXIT/HUP/INT/TERM handler was exercised over all ordinary transaction layouts. Before the live switch it removes only wrapper-owned staging and re-proves live D97AD. During the switch it quarantines a candidate where needed, restores the moved D97AD backup, verifies the exact restored SHA and removes remaining staging. After exact D97AF post-audit, an open/process-proof failure deliberately retains exact D97AF plus the recoverable D97AD backup.

The transaction is recovery-protected for ordinary command failures and caught HUP/INT/TERM, but a hard `SIGKILL`, kernel crash or power loss in the inherently short two-rename interval cannot execute a shell EXIT handler and is not classified crash-atomic. The user must not interrupt, reboot or power off ASUS2 during the bounded app switch.

Independent audits also proved that the pinned inner app ZIP contains 171 unique members under one `OpenCore-Patcher.app`, no absolute/traversal/backslash/NUL/duplicate/case-collision/special-file entries, and only relative symlinks resolving within the application. Signing/notarization was skipped by the build and is not claimed PASS; exact artifact and executable identity plus live launch are the deployment gates.

## Authoritative execution state

```text
D97AF_LOCAL_SOURCE_INTEGRATION=PROVEN_PASS
D97AF_GITHUB_BUILD=PROVEN_PASS
D97AF_PACKAGED_APP_SEMANTIC_AUDIT=PROVEN_PASS
D97AF_EXTERNAL_ARTIFACT_BYTE_AUDIT=PROVEN_PASS
D97AF_DEPLOY_FASTLANE_STATIC_AUDIT=PROVEN_PASS
D97AF_DEPLOY_FASTLANE_FAULT_TEST=PROVEN_PASS_FOR_ORDINARY_ERRORS_AND_CAUGHT_SIGNALS
D97AF_APP_DEPLOY=NOT_STARTED
D97AF_ROOT_PATCH=NOT_AUTHORIZED
D97AF_REBOOT=NOT_AUTHORIZED
D97AF_RUNTIME_PROVENANCE=NOT_YET_TESTED
D97AF_DIRECT_RUNTIME_TEXT_BYTE_READ=NOT_PERFORMED
```

No ASUS2 installed application, system target, snapshot, Root Patch or Golden bytes were modified while producing or auditing this delivery wrapper.

## CURRENT SINGLE NEXT ACTION — run exact D97AF app deploy/open/STOP wrapper
Deliver one public-commit-pinned outer command that downloads `OCLP7_D97AF_EXACT_GITHUB_ARTIFACT_AUDIT_DEPLOY.command`, verifies its exact blob/SHA256/byte identities above, and runs it with `/bin/zsh -f`.

The user may be asked for the existing GitHub CLI authentication only if that session has expired and for the normal `sudo` password at the bounded `/Applications` deployment gate. Do not launch OCLP separately during the command. When exact D97AF OCLP opens, do not click Root Patch: STOP and return the complete terminal output for audit.

Only after deployment output is audited may a later checkpoint authorize manual Root Patch. Root Patch and reboot remain unauthorized at this checkpoint.

## Safety invariants
- Functional baseline remains exactly P1+P2b+P3+AIR00+D34.
- P6/P7 remain retained with runtime sufficiency NEGATIVE.
- Golden Sequoia remains immutable/read-only.
- D34 cave `0xEF8..0xEFE` remains protected.
- D50/D68/D82 remain reserve-only.
- D84 remains retired.
- Patch8 remains unauthorized.
- D97AEX/D97AEZ external task-port method remains retired.
- D97AF UUID remains `A4F456DF-7447-49BF-AC4F-102D90023A1E`.
- service launch `AUTO-NO` except opening the audited OCLP application;
- Root Patch `AUTO-NO`;
- reboot `AUTO-NO`.
