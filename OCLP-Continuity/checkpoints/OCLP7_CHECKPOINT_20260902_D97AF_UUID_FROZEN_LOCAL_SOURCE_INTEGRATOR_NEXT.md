# OCLP7 CHECKPOINT — 2026-09-02 — D97AF UUID frozen / local source integrator next

## Authority and supersession
This checkpoint supersedes only the `CURRENT SINGLE NEXT ACTION` in `OCLP7_CHECKPOINT_20260902_D97AEZ_ACCELERATED_TASK_READ_POLICY_DENIED_RUNTIME_BYTES_UNKNOWN.md`.

All accepted D97AEW/D97AES cache and runtime-sender conclusions remain unchanged. The D97AEX/D97AEZ external task-port method remains NEGATIVE, retired and unauthorized for reactivation. Exact current D97AD runtime text bytes remain `UNKNOWN`.

## Returned local source input
The requested local D97AD input package was returned and inspected. The received gzip-compressed tar archive has:

- received filename `7675b786-d20d-414f-becf-a6f75c1b52b2.gz`;
- SHA256 `19c1b9dc34ede0533c3a7e6a7af9b00f2dcfd732cce9da6e47cdad6e93a06c41`;
- size `673209` bytes;
- one D97AD MTLCompiler input, the exact three modified source files, their combined diff, repository/status identity, Mach-O load-command output and code-sign verification output.

The package confirms the authoritative local source state already recorded by the preceding checkpoint:

- canonical source root `/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82`;
- branch `alex-tahoe-25G82-custom`;
- HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`;
- `sys_patch_helpers.py` SHA256 `fd37ede683ccb0612a7ba77ffe82b80bb8e081f4192f7485d05cdf8f9b51f515`;
- `sys_patch.py` SHA256 `115153b0465102cba0fdd477cc6215c4531e50b2927a99c1c64d12325c64d948`;
- `metal_3802.py` SHA256 `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`.

The input D97AD MTLCompiler is `1636896` bytes with exact SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. Its existing code signature is already invalid because its executable bytes contain the accepted D97AD diagnostic changes; the returned `codesign --verify` RC is `1`. This is input identity, not a new D97AF build or deployment.

## User-generated D97AF UUID frozen and persisted
The user generated the D97AF marker UUID locally and persisted it in `~/Desktop/OCLP7_D97AF_UUID.txt`:

```text
D97AF_LC_UUID=A4F456DF-7447-49BF-AC4F-102D90023A1E
```

This exact UUID is now frozen for D97AF. It must not be regenerated or silently substituted by a later implementation.

```text
D97AF_UUID_SELECTION=USER_GENERATED_AND_PERSISTED
D97AF_LC_UUID=A4F456DF-7447-49BF-AC4F-102D90023A1E
D97AF_UUID_REGENERATION=FORBIDDEN
```

## Exact LC_UUID transform established
Independent parsing and recomputation against the exact D97AD input established:

- the Mach-O is x86_64 `MH_DYLIB`, with `25` load commands and `sizeofcmds=3800`;
- `LC_UUID` is load command index `8`, command offset `0xAA8`, with its 16-byte payload at `0xAB0..0xABF`;
- the D97AD payload there is exactly `D5CE0008-587C-3861-971A-4BAEFB7B9C5B` and occurs once in the input;
- the new D97AF payload is exactly `A4F456DF-7447-49BF-AC4F-102D90023A1E` and is absent from the input;
- replacing only those 16 payload bytes changes every position in the exact range `0xAB0..0xABF` and no other byte;
- the deterministic expected postimage SHA256 is `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`;
- the `LC_CODE_SIGNATURE` command remains at `0xEE8`, with data range `0x188180..0x18FA1F`; its blob is byte-identical under the proposed transform;
- executable instructions, the protected D34 cave `0xEF8..0xEFE`, all retained functional patches and all D97AD classifier sites/stub are unchanged.

Authoritative static classification:

```text
D97AF_INPUT_D97AD_SHA256=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755
D97AF_EXPECTED_POST_SHA256=a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e
D97AF_CHANGED_BYTE_COUNT=16
D97AF_CHANGED_RANGE=0xAB0..0xABF
D97AF_EXECUTABLE_INSTRUCTION_CHANGE=NO
D97AF_STATIC_LC_UUID_TRANSFORM=PROVEN
D97AF_POST_BINARY_ON_ASUS2=NOT_YET_CREATED
```

The expected post SHA is a deterministic static computation and independent recomputation. It must not be described as an already built, installed or runtime-loaded binary.

## Intended in-OCLP integration scope
The source-only integration must add exactly one D97AF helper to `sys_patch_helpers.py` and exactly one call in `sys_patch.py`, immediately after the retained D97AD helper call. `metal_3802.py` must remain byte-identical.

The active order must remain:

```text
P1 selector
-> P2b request layout
-> P3 serialized bitcode
-> AIR00 AIR 2.6 / Metal 3.1
-> D34 semantic-equivalent reset
-> retained P6
-> retained P7
-> D97AD classifier
-> D97AF LC_UUID build stamp
```

The D97AF transform changes build provenance only. It is not a new functional compatibility patch and does not promote P6/P7, D50, D68, D82, D84 or Patch8.

## Runtime interpretation boundary
Existing Unified Log sender metadata can expose the loaded sender Mach-O UUID. After a future fully audited D97AF build, deployment, manual Root Patch and accelerated boot, relevant diagnostics from UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E` can prove that the D97AF-stamped marker build supplied the sender for the covered cohort.

The strongest permitted positive label is:

```text
RUNTIME_D97AF_STAMPED_BUILD_PROVENANCE_FOR_COVERED_DIAGNOSTIC_COHORT=PROVEN
DIRECT_RUNTIME_TEXT_BYTE_READ=NOT_PERFORMED
RUNTIME_EXACT_ALL_D97AD_TEXT_BYTES=NOT_PROVEN_BY_UUID_STAMP
```

The UUID stamp does not directly read runtime text, does not by itself prove every patched instruction byte in memory, and cannot GREEN-seal requests or processes absent from the covered log cohort. A retained D5CE sender identifies an unstamped D5CE image for that record; D226 identifies the current Tahoe cache-input lineage for that record; absence of a relevant diagnostic is `COVERAGE_INCOMPLETE`, not a negative provenance verdict.

## Integrator status at checkpoint time
A local source-only integrator is under final hardening and audit. Its final file identity is deliberately not frozen in this checkpoint, and it has not been run on ASUS2.

```text
D97AF_LOCAL_SOURCE_INTEGRATOR_STATUS=FINAL_HARDENING_AND_AUDIT_IN_PROGRESS
D97AF_LOCAL_SOURCE_INTEGRATOR_FINAL_IDENTITY=NOT_YET_FROZEN
D97AF_LOCAL_SOURCE_INTEGRATOR_ASUS2_EXECUTION=NOT_RUN
D97AF_LOCAL_SOURCE_MUTATION=NOT_YET_PERFORMED
D97AF_APP_BUILD=NOT_STARTED
D97AF_APP_DEPLOY=NOT_STARTED
D97AF_ROOT_PATCH=NOT_AUTHORIZED
D97AF_REBOOT=NOT_AUTHORIZED
```

No draft integrator SHA or draft post-source SHA is authoritative until final hardening, independent audit and explicit delivery identity are complete.

## CURRENT SINGLE NEXT ACTION — audited local source-only integration
Finish hardening and independently auditing the bounded LOCAL source-only integrator. Then deliver its exact identity-pinned invocation to the user. The user runs that integrator against the canonical local source and returns the complete report. STOP after source integration; audit the returned report and exact two-file source diff before any compile/build.

Only after local source integration is proven may a substantial app compile/build/package move to GitHub, and only when it is clearly faster there. Such a build remains assistant-run and must complete compile/diff, packaged-app audit and exact identities before any ASUS2 deployment.

All installed-state checks, backup/deploy, opening OCLP, manual Root Patch, accelerated boot and VESA recovery remain ASUS2/user actions under explicit gates. No Root Patch or reboot is authorized by this checkpoint.

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
