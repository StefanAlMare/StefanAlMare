# OCLP7 CHECKPOINT — D97BK accelerated boots are NOT kernel panic; Tahoe Metal4 ABI break causes controlled shutdown

Date: 2026-09-05 EEST

## Entering state
- Target: Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- D97BJ Root Patch execution was previously `PASS`.
- D97BJ replaced/merged Tahoe `Metal.framework` using legacy donor `13.2.1-24`, applied exact 25G82 metallib map, Monterey GVA/OpenCL, Haswell kexts and built/forced AuxKC.
- User perceived the two accelerated attempts as kernel panic/restart and later restored the saved/sealed snapshot.
- Current state: unpatched Tahoe VESA after snapshot restore.

## Evidence bundle
User returned `OCLP7_D97BK_PANIC_EVIDENCE_20260905.zip`.
- bytes: `291750`
- SHA256: `f8cdacb13cc2a7dcc23049ece416160259c1e9cf671c20546d1e0e90a32565f1`

Current recovery state in bundle:
- `/System/Library/CoreServices/OpenCore-Legacy-Patcher.plist` absent;
- VESA boot args contain active `-igfxvesa`.

Accelerated boot logs contain `#-igfxvesa`, confirming the two target attempts were non-VESA.

## Authoritative boot chronology
User identified the entries and this identification is authoritative under the permanent VESA rule:
- `05:15` — accelerated #1;
- `05:18` — accelerated #2;
- `12:09` — VESA/recovery, excluded from accelerated evidence;
- `12:36` — current VESA/recovery, excluded.

Analysis window used: `2026-09-05 05:14:30` through `05:21:00` EEST, with boot-specific interpretation inside that interval.

## Critical correction: no kernel panic occurred
The evidence bundle contains no panic report for either accelerated attempt. `DumpPanic` explicitly processed `0 files` after each failure. No `panic(cpu...)`, kernel panic backtrace or `Kernel Extensions in backtrace` record exists in the two accelerated windows.

The visual/automatic-restart behavior was therefore misclassified as kernel panic from the console appearance.

Classification corrections:
- `D97BJ_ACCELERATED_BOOT_KERNEL_PANIC_RESTART=RETRACTED_USER_VISUAL_MISCLASSIFICATION`;
- `D97BJ_ACCELERATED_BOOT_KERNEL_PANIC=NEGATIVE`.

## Accelerated #1 — deterministic userspace failure
Boot starts at approximately `05:15:36`.

Important sequence:
- `05:15:58.163` — `WindowServer` service state becomes `running`.
- `05:16:00.238` — `runningboardd` exits with `OS_REASON_OBJC`:
  `Superclass of IOGPUMetal4RenderCommandEncoder ... in /System/Library/PrivateFrameworks/IOGPU.framework/Versions/A/IOGPU is set to 0xbad4007, indicating it is missing from an installed root`.
- `05:16:01.025` — `launchservicesd` exits with the same exact Objective-C reason.
- `05:16:01.438` — `DumpPanic processed 0 files`.
- `05:16:02.774` — `runningboardd` dies again with the same reason.
- `05:16:03.758` — `runningboardd` dies again with the same reason; `launchd` logs `committing to system shutdown`.
- `05:16:04.750` — shutdown becomes `UNINITIALIZED -> COMMITTED`.

This is an orderly launchd/system shutdown following repeated destruction of essential userspace services, not a kernel panic.

## Accelerated #2 — exact reproduction
Boot starts at approximately `05:18:09`.

Important sequence:
- `05:18:30.514` — `WindowServer` service state becomes `running`.
- `05:18:31.886` — `runningboardd` exits with the same `IOGPUMetal4RenderCommandEncoder ... 0xbad4007 ... missing from an installed root` reason.
- `05:18:32.499` — `launchservicesd` exits with the same reason.
- `05:18:33.480` — `DumpPanic processed 0 files`.
- `05:18:34.247` — `runningboardd` dies again with the same reason.
- `05:18:35.262` — `runningboardd` dies again with the same reason; `launchd` commits to system shutdown.
- `05:18:35.986` — shutdown becomes `UNINITIALIZED -> COMMITTED`.

The two accelerated attempts therefore reproduce the same failure deterministically.

## Proven failure frontier
The kernel/AuxKC/Haswell boot hypothesis is rejected as the immediate failure frontier for D97BJ:
- userspace is reached;
- `launchd` is operational;
- `WindowServer` is launched and reaches running state;
- the fatal repeated events are Objective-C loader/runtime failures in clients touching `IOGPU.framework`;
- shutdown is explicitly committed by launchd after critical service crash loops.

Classifications:
- `D97BJ_ACCELERATED_BOOT_USERSPACE_REACHED=PROVEN`;
- `D97BJ_WINDOWSERVER_SPAWN_AND_RUNNING=PROVEN`;
- `D97BJ_IOGPU_METAL4_SUPERCLASS_MISSING=PROVEN`;
- `D97BJ_LAUNCHD_CONTROLLED_SHUTDOWN_AFTER_CRITICAL_SERVICE_CRASH_LOOP=PROVEN`;
- `D97BJ_ACCELERATED_BOOT_USABLE_GUI=NEGATIVE`.

## Static ABI closure
Tahoe-era IOGPU declares:
`IOGPUMetal4RenderCommandEncoder : _MTL4RenderCommandEncoder`.

Tahoe-era Metal.framework provides `_MTL4RenderCommandEncoder` and the wider Metal4 class family.

The dependency is not isolated to one render encoder. Tahoe IOGPU contains at least these Metal4 subclasses whose superclasses are Metal.framework classes:
- `IOGPUMetal4CommandQueue : _MTL4CommandQueue`;
- `IOGPUMetal4CommandBuffer : _MTL4CommandBuffer`;
- `IOGPUMetal4CommandAllocator : _MTL4CommandAllocator`;
- `IOGPUMetal4RenderCommandEncoder : _MTL4RenderCommandEncoder`;
- `IOGPUMetal4ComputeCommandEncoder : _MTL4ComputeCommandEncoder`;
- `IOGPUMetal4MachineLearningCommandEncoder : _MTL4MachineLearningCommandEncoder`.

Therefore adding/shimming only `_MTL4RenderCommandEncoder` would be structurally incomplete.

## Root cause
D97BJ's full legacy `Metal.framework` donor (`13.2.1-24`) is ABI-incompatible with native Tahoe IOGPU because it removes Tahoe's Metal4 Objective-C superclass surface while leaving Tahoe `IOGPU.framework` modern.

Classification:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

The old Golden/Sequoia full-framework downgrade cannot be transplanted unchanged to Tahoe 26.x.

## Strategic consequence
The identical-Golden-OCLP strategy is closed as a final Tahoe solution at the full Metal.framework boundary.

Next architecture must preserve the **native Tahoe Metal.framework / Metal4 ABI surface** and integrate legacy Haswell/3802 compiler behavior beneath or alongside it.

This returns the project to the durable boundary-adapter architecture from the accepted historical baseline:
`P1 + P2b + P3 + AIR00 + D34`.

Those five patches are not automatically re-enabled; they become the relevant proven design lineage because they adapt the legacy 3802 compiler path while preserving the Tahoe-native outer producer/surface instead of wholesale downgrading the framework.

Exact D97BJ improvements that remain valid and should be retained in a future hybrid build:
- Tahoe host eligibility;
- exact local `26.6.2-25G82` MetallibSupportPkg preference;
- exact 25G82 metallib destination/source map.

## Mandatory pre-reboot gate for next design
No further Root Patch/accelerated boot may be authorized until a static patch-root audit proves all of the following:
1. native Tahoe Metal4 ABI surface remains present after the proposed patch;
2. `_MTL4RenderCommandEncoder`, `_MTL4ComputeCommandEncoder`, `_MTL4CommandQueue`, `_MTL4CommandBuffer`, `_MTL4CommandAllocator`, `_MTL4MachineLearningCommandEncoder` and any additional IOGPU-referenced `_MTL4*` superclasses resolve from the installed root;
3. Tahoe `Metal.framework/Versions/A/Metal` is not blindly replaced by the 13.2.1 donor;
4. legacy 3802 compiler/selector path is integrated through an audited hybrid/boundary adapter;
5. exact 25G82 metallib map and local package handling remain intact.

This gate is specifically intended to reduce unavoidable Root Patch/recovery cycles.

## CURRENT ACTION
Remain unpatched in current VESA/recovery state.

No Root Patch and no accelerated reboot are authorized.

Design/audit D97BL as a Tahoe-native-Metal4-preserving hybrid. Reuse historical five-functional evidence where semantically applicable, but do not import retired/inconclusive diagnostics. Before any future boot, prove Metal4 superclass closure statically against the proposed patched root.