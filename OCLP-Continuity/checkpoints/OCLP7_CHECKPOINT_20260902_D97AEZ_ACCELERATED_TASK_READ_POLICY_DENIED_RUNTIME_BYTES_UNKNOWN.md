# OCLP7 CHECKPOINT — 2026-09-02 — D97AEZ accelerated natural PID / task-read denied / runtime bytes UNKNOWN

## Authority and supersession
This checkpoint supersedes only the `assistant GitHub runtime D5CE text-provenance audit` current action in `OCLP7_CHECKPOINT_20260902_D97AEW_PHYSICAL_READ_VALID_D5CE_RUNTIME_TEXT_NEXT.md`.

All accepted D97AEW physical-cache conclusions and D97AES D5CE diagnostic-sender provenance remain unchanged. The external D97AEX/D97AEZ task-port method is now a completed negative methodology result and is retired. It produced no runtime text bytes and no PRE/POST/OTHER byte classification.

## Returned evidence identities
The direct extracted result supplied by the user is:

- `1df9e86b-3beb-4e1e-bbc3-0997787c720a.txt`;
- SHA256 `56cc6b98737415758c61687314a295818c39d9b561c82378e55d58dd6a99af17`;
- `277` lines / `14916` bytes.

The preserved state archive supplied by the user is:

- `D97AEZ_RESULT_20260902_214406.tar`;
- SHA256 `f1691f05e379ac4b2404af75ce701f1f5af4c04a49a2e47fb50a4549f15fd9af`;
- `25088` bytes.

The complete extraction terminal transcript is:

- `Text lipit(20260902-184502).txt`;
- SHA256 `20644fa1fd71e934f2ac05090988447957255838d9ac714a5a911d55d64858d`;
- `600` lines / `16782` bytes.

The selected-boot WindowServer crash transcript is:

- `Text lipit(20260902-183809).txt`;
- SHA256 `333900dc0354e72cdb1f3d7db9f907939820597fe618b5f021c777b0788d06f6`;
- `913` lines / `74936` bytes.

## Exact boot binding
D97AEZ was activated during VESA boot UUID `C57F4AEF-B109-463A-940A-AC10B1F7A02A`.

Its one-shot claim and final report are bound to boot UUID `0FCD86FE-6A94-450C-A250-45B6A8255A82`. The user identified the `21:29` boot as the accelerated boot. The later `21:32` boot, UUID `7BC61319-78D8-46C5-A084-65C40B7F0941`, is the VESA recovery boot and is excluded from accelerated runtime interpretation.

The runner itself recorded `BOOT_LANE_INTRINSIC_PROOF=NOT_AVAILABLE`; therefore accelerated-lane classification uses the persisted UUIDs plus the user's authoritative chronology, exactly as required by the permanent VESA rule.

WindowServer crashed in the selected accelerated boot at `2026-09-02 21:31:53.3414 +0300`, with boot-session UUID `0FCD86FE-6A94-450C-A250-45B6A8255A82`. This remains downstream evidence and does not change the retained causal model.

## D97AEZ installed-state and identity gates
The one-shot runner passed every pre/post identity gate for its own runner, helper and plist and for the two project targets. Relevant exact project identities were stable before and after the helper:

- selector-only MTLCompilerService SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, `85520` bytes;
- D97AD MTLCompiler 32023 SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`, `1636896` bytes.

The helper was configured for a finite `120` second watch, `25` millisecond interval and minimum `3` complete instances. It was universal/no-PID at each poll and did not launch or stop MTLCompilerService. Global spawn-cohort coverage remained explicitly `UNKNOWN`.

The observer's own installed identities recorded in the returned evidence were:

- runner SHA256 `9c2dc2060ea557dfea9ca1901b055f1242ba4e34f5ec29297e6b847997a320a4`, `36701` bytes;
- helper SHA256 `f55b79d498e52a63b5d7c6cdbfde8b7a4c109e14158c7fe1b8c47e2883a85dc9`, `94928` bytes;
- launchd plist SHA256 `90c0801805319126520cc946d9f2bb4a69e95fd7a0be4a85914a1c3305ec03c5`, `1027` bytes.

## Decisive runtime result
The observer caught one naturally occurring exact-path MTLCompilerService instance:

```text
PID_CAPTURE_BEGIN=PID=434|P_UNIQUEID=434|P_IDVERSION=972|START_SEC=1788373831|START_USEC=552540|ATTEMPT=1
PID_TASK_READ_ACCESS=DENIED_OR_UNAVAILABLE|PID=434|RETURN=-1|ERRNO=1|STRAY_PORT_DEALLOCATED=YES
D97AEX_STOP=FAIL_CLOSED|PID=434|REASON=LIVE_BYTES_BLOCKED_BY_TASK_PORT_POLICY
```

The helper stopped immediately and correctly on the denied `task_read_for_pid` access. Runner/helper RC was `2`, mapped to fail-closed; the watchdog did not fire. Terminal counts were `RESULT:0|STOP_OR_FATAL:1|MATCH:0|INCOMPLETE:0|MISMATCH:0`.

Authoritative classification:

```text
NATURAL_EXACT_PATH_MTLSERVICE_PID_OBSERVED=PROVEN
TASK_READ_FOR_PID_ACCESS=DENIED_OR_UNAVAILABLE_ERRNO_1
RUNTIME_D97AD_WINDOW_BYTES_READ=0
RUNTIME_D97AD_PRE_POST_OTHER_CLASSIFICATION=NOT_PERFORMED
RUNTIME_EXACT_CURRENT_D97AD_TEXT_BYTES=UNKNOWN
D97AEX_D97AEZ_EXTERNAL_TASK_PORT_METHOD=NEGATIVE_RETIRED
```

This is not a D97AD byte mismatch and not evidence that the visible D97AD file was stale. It is `task_read_for_pid` access denied or unavailable under Tahoe (`errno=1`), encountered before the first bounded runtime-byte window could be read. No LLDB attach, SIP/AMFI weakening or entitlement bypass is authorized as a continuation of this method.

## Mutation and retirement status
D97AEZ did not mutate OCLP source, Golden, target code bytes, the root-patched MTLCompilerService/MTLCompiler files or the APFS snapshot. Its persistent system writes were confined to its own external launchd observer/state paths; ephemeral temporary artifacts and user-report files are not classified as persistent system-target mutation.

The returned extraction transcript proves `D97AEZ_OBSERVER_DISABLED=PASS`. The user subsequently directed that the observer be deleted and never reused. At checkpoint time, deletion of all active/quarantined ASUS2 observer artifacts is `REQUESTED_RESULT_NOT_YET_RETURNED`; it must not be misreported as already complete. Historical evidence is retained.

```text
D97AEZ_OBSERVER_RUNTIME_STATUS=DISABLED
D97AEZ_METHOD_STATUS=RETIRED_DO_NOT_REACTIVATE
D97AEZ_ACTIVE_ARTIFACT_DELETION=REQUESTED_RESULT_NOT_YET_RETURNED
D97AD_ROOT_PATCHED_TARGET_MUTATION_BY_OBSERVER=NO
```

## Local source discovery after retirement
The first bounded ASUS2 discovery proved installed app executable `/Applications/OpenCore-Patcher.app/Contents/MacOS/OpenCore-Patcher` SHA256 `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`, `6587056` bytes, but found no matching repository only within the paths it searched and no visible D97AD marker inside the packaged app. Its no-source statement was therefore scope-limited, not a global filesystem conclusion.

The user's targeted follow-up search superseded that limited negative and proved local D97AD source at both displayed paths:

- `/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82`;
- `/Volumes/AsusLaptop/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82`.

Both resolve to the same `sys_patch_helpers.py` identity `16777225:61074310:497704`, and direct comparison returned `TWO_PATHS_SAME_HELPERS=PASS`; they are not independent working copies. The canonical project path is the first path, under `AsusLaptop - Data`.

Exact local repository evidence:

- branch `alex-tahoe-25G82-custom`;
- HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`;
- exactly three reported tracked modifications: `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`, `opencore_legacy_patcher/sys_patch/sys_patch.py`, and `opencore_legacy_patcher/sys_patch/sys_patch_helpers.py`;
- D97AD function definition count `1` in `sys_patch_helpers.py`;
- `metal_3802.py` SHA256 `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`;
- `sys_patch.py` SHA256 `115153b0465102cba0fdd477cc6215c4531e50b2927a99c1c64d12325c64d948`;
- `sys_patch_helpers.py` SHA256 `fd37ede683ccb0612a7ba77ffe82b80bb8e081f4192f7485d05cdf8f9b51f515`.

HEAD identifies the committed base while the three SHA256 values identify the current modified working-tree inputs. The already-persisted private snapshot commit `1faab13865eb945198f3551688f11f1ba645e29a` remains historical D97AD build provenance, but source acquisition/cloning is no longer the next action.

## Methodology correction directed by the user
The previous GitHub-first rule is superseded prospectively. Work now defaults to short, visible, explained ASUS2 steps with immediate user feedback. GitHub is used only for a substantial compilation/build job when doing it there is clearly faster than waiting through that job with the user. Merely being technically possible in GitHub is not sufficient.

The historical FASTLANE ordering remains mandatory:
`validations -> integration -> compile/diff -> build -> packaged-app audit -> SHA -> backup/deploy -> open OCLP -> STOP`.

Never auto Root Patch or reboot.

## New diagnostic direction — inside OCLP
The external task-port reader is abandoned. The next diagnostic returns to the project's proven pattern: instrumentation is integrated into the exact OCLP source/build so it is present during the accelerated boot.

The minimum proposed provenance diagnostic is an audited fresh `LC_UUID` stamp on the exact D97AD MTLCompiler build, without changing executable instructions. The implementation must select and persist a new exact UUID, prove by compile/diff that only the intended `LC_UUID` payload changed in addition to already accepted D97AD changes, and retain every functional patch and diagnostic safety invariant.

Existing Apple logging behavior makes the sender Mach-O UUID visible in Unified Logs. Therefore a relevant diagnostic from the newly stamped UUID can establish provenance for that exact marker build without external task-port access. It remains a build-provenance result, not a direct read of all runtime text bytes.

Required interpretation after a future authorized accelerated boot:

- fresh stamped UUID on every relevant diagnostic sender: current stamped D97AD marker-build provenance PROVEN for that covered cohort;
- retained `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`: stale/alternate D5CE build remains possible;
- `D2265480-60EB-3526-BAF7-2D6596149186`: current Tahoe cache-input sender observed;
- no relevant diagnostic: coverage incomplete, no provenance verdict.

No new UUID value is invented by this checkpoint. It must be generated, displayed and persisted during the audited implementation.

## CURRENT SINGLE NEXT ACTION — local collaborative lane
From canonical path `/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82`, produce one bounded read-only source input package/report containing the exact three modified files, branch/HEAD/status identity and their diffs, and return it for inspection before any edit. Do not clone, reacquire or modify the source in this step. This is local source-input collection, not a GitHub Actions build and not a system/root-patch mutation.

Only after the exact local inputs are inspected may the assistant design the in-OCLP `LC_UUID` provenance stamp and its exact diff gates. If subsequent app compilation/package work is substantial and clearly faster on GitHub, only that substantial compile/build may move to GitHub under the revised permanent rule.

No Root Patch or reboot is authorized now.

## Safety invariants
- Functional baseline remains exactly P1+P2b+P3+AIR00+D34.
- P6/P7 remain retained with runtime sufficiency NEGATIVE.
- Golden Sequoia remains immutable/read-only.
- D34 cave `0xEF8..0xEFE` remains protected.
- D50/D68/D82 remain reserve-only.
- D84 remains retired.
- Patch8 remains unauthorized.
- D97AEZ external observer remains retired.
- service launch `AUTO-NO`;
- Root Patch `AUTO-NO`;
- reboot `AUTO-NO`.
