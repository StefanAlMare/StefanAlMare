# OCLP7 checkpoint — D97AEX VESA calibration reclassified / hardware-test contract reset

Date: 2026-09-02 EEST

## Authoritative user correction
The project must remain focused on the end goal: stable Tahoe hardware-accelerated graphical output on ASUS2 Haswell, by identifying and correcting the earliest causal incompatibility. GitHub can validate, compile, build, package and audit tools, but it cannot substitute for a runtime experiment on the real hardware.

The foreground D97AEX command was run from the current online/VESA recovery session without a new Root Patch or accelerated reboot. Opening Terminal does not cause MTLCompilerService to spawn. D97AEX explicitly uses `SERVICE_LAUNCH=AUTO-NO`; it only observes exact-path processes created naturally by another Metal client. Therefore that run was not a correctly timed accelerated-hardware test of runtime bytes.

## What the run validly proved
The exact corrected D97AEY wrapper/helper identities, codesign, six-marker self-test, Tahoe build/arch, selector-only service identity, final D97AD target size `1636896`, target SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`, pre/post identity stability, wrapper parsing and safety contracts all passed.

The helper's production mode ran for 120 seconds and completed 3696 polls. No exact-path process was visible at a poll and no relevant record was visible to the complete Unified Log parser. RC3 `COVERAGE_INCOMPLETE_STOP` is the correct fail-closed terminal result for that empty foreground observation.

Authoritative classification:

- `D97AEY_SIZE_CONTRACT_LIVE_ACCEPTANCE=PASS`;
- `D97AEX_FOREGROUND_VESA_CALIBRATION=PASS_VALID_EMPTY_RC3`;
- `D97AEX_ACCELERATED_HARDWARE_CAUSAL_TEST=NOT_PERFORMED`;
- `TASK_READ_ON_LIVE_TARGET=NOT_TESTED`;
- `RUNTIME_D97AD_31_WINDOWS=UNKNOWN`;
- `RUNTIME_MATCH_OR_MISMATCH=NONE`.

The run must not be described as proving global absence of MTLCompilerService or as accelerated runtime proof.

## Exact unresolved causal question
The selected D97AD accelerated boot already proved 28/28 natural MTLCompilerService exit(1) events while the on-disk D97AD file and selector-only service identities were exact. D97AES proved the diagnostic sender was runtime 32023/D5CE, but the known transform lineage preserves that UUID. The remaining question is therefore narrow and directly causal:

**During a new accelerated boot, do naturally spawned exact-path MTLCompilerService processes map the current D97AD 31-window postimage, or different runtime text?**

Decision table:

- stable D5CE plus all 31 D97AD windows MATCH on a completely captured observed accelerated cohort: the known P7-vs-D97AD bounded-provenance mismatch hypothesis becomes NEGATIVE only within those 31 tested windows, and the inquiry moves beyond those windows without claiming whole-image or runtime-semantic identity;
- stable D5CE with one or more bounded-window MISMATCH results: runtime image selection/deployment/cache provenance becomes the active repair frontier;
- no natural process captured, task-read denied, UUID negative, race, incomplete durability or wrong boot: INCOMPLETE/UNKNOWN, with no semantic conclusion and no new functional patch.

This is the new causal information the next hardware test must provide. A reboot that cannot discriminate these outcomes is not authorized.

## Correct GitHub/hardware split
Before implementation, the assistant must present the minimal test contract and causal decision table to the user, rather than silently spending hours on an unreviewed diagnostic.

After that design gate, GitHub may author, compile/build, package and fully audit only the smallest orchestration required to have the already-audited D97AEX helper active during a later manually authorized accelerated boot. GitHub results prove tool properties only; they never count as ASUS2 runtime evidence.

The decisive sequence, only after a future audited authorization, is:

1. ASUS2 VESA installs/activates one exact identity-pinned observer;
2. user manually enters the accelerated configuration;
3. the observer watches the natural boot cohort without launching/stopping MTLCompilerService;
4. user waits for bounded completion, manually hard-restarts and enters VESA;
5. a boot-scoped report is retrieved and audited against the exact accelerated boot.

No new Root Patch is presently justified because the installed D97AD target is exact and stable. Any later observer-owned system mutation must be explicit, bounded, identity-pinned and removable. Never auto Root Patch or reboot; never mutate Golden or target bytes.

## CURRENT ACTION
Implementation is paused at the design gate. The assistant must first report the exact test contract above to the user and keep every subsequent work interval visible through concise progress updates. User action is STOP: no command, OCLP opening, Root Patch or reboot.

Baseline remains exactly P1+P2b+P3+AIR00+D34. Golden is immutable/read-only. D50/D68/D82 remain reserve-only; D84 retired; Patch8 unauthorized.
