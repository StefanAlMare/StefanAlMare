# OCLP7 CHECKPOINT — 2026-09-04 — D97AU Golden boot-aligned generation/lane divergence PROVEN as observation; D97AV producer map next

## Authority / user Golden comparator override
Target Tahoe remains `26.6.2 / 25G82`, Haswell HD4400/4600 family, SMBIOS `MacBookAir6,2`. Accepted Tahoe functional baseline remains P1+P2b+P3+AIR00+D34; P6/P7 retained with runtime sufficiency NEGATIVE. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.

User has explicitly authorized manual Golden comparator boot after restoring ORIGINAL OCLP Root Patch. Assistant does not automate Golden Root Patch/reboot and does not install experimental system-file patches on Golden without separate explicit authorization. Read-only/static/log comparison is allowed. D97AU attempted only temporary debugger attachment and made no persistent mutation.

Previous authoritative checkpoint: `OCLP7_CHECKPOINT_20260904_D97AT_GOLDEN_COMPARATOR_D97AU_V2_HARDENED_READY.md`.

## D97AU exact Golden identity — PASS
User returned D97AU report + JSON from working Golden Sequoia.

```text
OS_VERSION=15.7.9
OS_BUILD=24G830
D97AU_GOLDEN_OS_IDENTITY=PASS
GOLDEN_32023_SHA256=ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269
D97AU_GOLDEN_32023_IDENTITY=PASS
KERN_BOOTTIME=Fri Sep 4 12:54:24 2026
```

No system-file mutation, experimental Root Patch or reboot occurred in D97AU.

## Golden first-three-minute generation mix — runtime PROVEN
Boot-aligned Golden window exactly `2026-09-04 12:54:24..12:57:24`:

```text
GOLDEN_BOOT3M_TOTAL_MTL_RECORDS=451
GOLDEN_BOOT3M_32023_SENDER_RECORDS=220
GOLDEN_BOOT3M_3802_SENDER_RECORDS=193
GOLDEN_BOOT3M_GENERATION_ACTIVE_SET=3802,32023
GOLDEN_BOOT3M_EXACT_GENERATION_PID_COUNT=8
GOLDEN_BOOT3M_PIDS_BOTH_GENERATIONS=NONE
GOLDEN_BOOT3M_PIDS_32023_ONLY=360,395,528,553
GOLDEN_BOOT3M_PIDS_3802_ONLY=367,398,540,565
```

This is now a boot-aligned comparison, not the earlier broad desktop-window observation. Working Golden actively uses both 3802 and 32023 during startup, in disjoint MTLCompilerService PID cohorts.

Tahoe D97AN failing accelerated cohort remains:
```text
TAHOE_D97AN exact 32023 sender records=79
TAHOE_D97AN exact 3802 sender records=0
TAHOE_D97AN exact 32023 PID count=65
```

Classification: `GOLDEN_TAHOE_BOOT_ALIGNED_GENERATION_SELECTION_DIVERGENCE=RUNTIME_PROVEN_OBSERVED`. This is an observed behavioral difference, NOT yet causal proof that 3802 absence causes the Tahoe failure.

## Golden 32023 vs Tahoe 32023 request-lane divergence — runtime PROVEN as observation
Golden first 3 minutes, exact 32023/D5CE:
```text
0x9A9FC = 88
0x9FFEE = 66
0xA0521 = 66
0xA5F81 = 0
```

Tahoe D97AN exact natural 32023/0FC4 cohort:
```text
0x9A9FC = 0 (D97AN all 79 exact sender records were exhausted by the three PCs below)
0x9FFEE = 7
0xA0521 = 7
0xA5F81 = 65
```

D97AO/D97AP already mapped:
- `0x9FFEE` -> `buildSpecializedFunctionRequest`, after `Build request: %s`;
- `0xA0521` -> same function, after `Compilation (%s) time %f ms`;
- `0xA5F81` -> `backendCompileExecutableRequest`, after `Build request: %s`.

Therefore working Golden 32023 startup has 66 specialized start/timing events and zero observed backend-start events, while failing Tahoe is dominated by 65 backend-start events with only seven specialized start/timing events.

Classification: `GOLDEN_TAHOE_BOOT_ALIGNED_32023_REQUEST_LANE_DIVERGENCE=RUNTIME_PROVEN_OBSERVED`. This strongly promotes the producer/handoff frontier but is not yet causal or semantic equivalence proof.

## Raw six-counter Golden capture — attach denied, values remain UNKNOWN
D97AU enumerated many live MTLCompilerService processes. It attempted an existing-PID LLDB attach to PID 528 and macOS returned explicitly:

`attach failed (Not allowed to attach to process...)`.

Result:
```text
LLDB_EXISTING_PID_RC=1
GOLDEN_EXISTING_PID_CAPTURE_TOTAL_HITS=0
D97AU_GOLDEN_RAW_SIX_COUNTER_CAPTURE=NO_HITS_OR_ATTACH_DENIED_OR_IDLE_EXISTING_PID
```

Raw audit makes the stronger exact classification: `D97AU_GOLDEN_RAW_SIX_COUNTER_VALUES=UNKNOWN_ATTACH_DENIED`. Zero hits must not be interpreted as counter value zero or absence of validator activity.

D97AS six-bit Tahoe terminal threshold-vector classifier remains STATIC-PROVEN feasible and reserve-ready, but no longer has priority over the newly proven earlier producer/lane divergence.

## Strategic implication
The project architecture is `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working donor path -> image`. D97AT/D97AU show identical late donor static contract but a strongly different boot-time generation/request-lane pattern before the late validator. Therefore the next bounded work should move upstream to map the request producer/handoff instead of instrumenting the late validator first.

Historical D97K-T evidence that cached `Metal.framework` writes XPC key `llvmVersion` is directly relevant again.

## D97AV prepared — Golden boot lane + llvmVersion producer static audit
Public read-only wrapper:
- `OCLP7_D97AV_GOLDEN_BOOT_LANE_AND_LLVMVERSION_PRODUCER_STATIC_AUDIT.command`;
- commit `d0e8c3f476ffcfd0deacb4866d94e6098a6bffcd`;
- Git blob `9344774aa6cf97f4216486b76e7bf470001ac20e`.

D97AV, while still in Golden, will:
1. fail-close on exact Golden OS/build and exact 32023 SHA;
2. statically map Golden 32023 runtime PCs `0x9A9FC`, `0x9FFEE`, `0xA0521`, `0xA5F81` to containing functions and surrounding instructions/os_log sites;
3. inspect Golden `Metal.framework` disassembly for the `llvmVersion` producer, `xpc_dictionary_set_uint64`, and nearby immediates 3802 (`0xEDA`), 32023 (`0x7D17`), 31001 (`0x7919`);
4. reconstruct exact per-PID first-three-minute generation/PC sequence and representative event text for Golden 3802/32023 lanes;
5. make no debugger attach, Root Patch, reboot or system-file mutation.

## CURRENT ACTION
Remain in working Golden. Run D97AV once and return the complete report. Do NOT reboot to Tahoe before D97AV is audited.

STOP after D97AV. No Root Patch, no process-debug attach, no system-file mutation, no reboot.