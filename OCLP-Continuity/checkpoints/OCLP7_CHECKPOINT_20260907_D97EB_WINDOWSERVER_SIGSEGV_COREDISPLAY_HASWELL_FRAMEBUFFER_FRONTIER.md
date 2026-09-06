# OCLP7 CHECKPOINT — D97EB accelerated failure: WindowServer SIGSEGV at CoreDisplay/Haswell framebuffer frontier

Date: 2026-09-07 EEST

## Entering state
- ASUS2: Tahoe 26.6.2 / 25G82, Haswell 8086:0412, MacBookAir6,2.
- D97DX native-Metal-safe Root Patch installed and post-patch VESA validation D97DZ PASS.
- D97DL 0.0.7 + full D97BV selective-3802 adapter remains the EFI compatibility path.
- First non-VESA accelerated boot failed at GUI transition; user hard-powered off and recovered into established VESA mode.

## D97EB evidence artifact
Returned ZIP:
`OCLP7_D97EB_ACCEL_FAIL_20260907_023429.zip`

Identity:
- bytes: `1633378`
- SHA256: `c5e141f4e5e8a9de60b09ebde4229814a0846065582b0796cd3a8bf9bd467374`
- ZIP CRC test: PASS
- entries: 128

## Corrected boot chronology
The earlier interpretation of shutdown-cause 5 as the accelerated failure cause is rejected.

Exact lifecycle evidence:
- `2026-09-07 02:23:21.748201` prior VESA session: `System shutdown initiated by: shutdown[1045]<-sessionlogoutd[1040]`.
- kernel mirrors this at `02:23:23.631980`.
- accelerated boot kernel begins around `02:23:58`.
- `Previous shutdown cause: 5` at `02:24:00.432575` therefore describes the prior voluntary shutdown, not the accelerated failure.
- launchd boot UUID/lifecycle starts around `02:24:08.550626`.

Classification:
`D97EB_PREVIOUS_SHUTDOWN_CAUSE_5=PRIOR_NORMAL_SHUTDOWN_NOT_ACCEL_FAILURE`

## First accelerated WindowServer lifecycle
- launchd schedules/spawns WindowServer PID 177 at `02:24:16.4165`.
- PID 177 reaches running/INIT at `02:24:18.6208`.
- WindowServer/CoreDisplay display initialization becomes visible around `02:24:56`.

CoreDisplay sequence:
1. `02:24:56.384679` — `Setting offline display 0x00000000 main in CGXConstructVirtualFramebuffer`.
2. `02:24:56.404841` — `Setting offline display 0x41dc9d00 main in CGXMainDisplayDevice`.
3. `02:24:57.687927` — `Creating FB 1 of 3`.
4. FB1 obtains/sets the internal 1366x768 display mode.
5. `02:24:58.558950` — `Creating FB 2 of 3`; CoreDisplay then reports `Failed to obtain mode info from IOFBGetDisplayModeInformation()` and `Attempting to get capabilities from capabilities with no devices`.
6. `02:24:58.617353` — `Creating FB 3 of 3`; same mode-info/capability failure.
7. `02:24:58.676958` — `GPU: FB: 3 of 3 opened`.

Kernel evidence in the same interval shows the legacy Haswell path alive and servicing display changes through AppleIntelFramebufferAzul and IOAcceleratorFamily2.

Immediately before WindowServer death:
- `02:24:58.777577` through `02:24:58.778468` — four occurrences of:
  `IOAccelSurface::set_id_mode(...): Surface mode contains bad bits`.
- `02:24:58.782202` — CoreDisplay: `Setting offline display 0x00000000 main in AddCGXDisplayDeviceToDeviceList`.
- `02:24:58.795730` — kernel: `WindowServer[177] Corpse allowed 1 of 5`.
- `02:24:58.799390` — launchd: `WindowServer [177] exited due to SIGSEGV | sent by exc handler[177], ran for 42384ms`.
- `02:24:58.799413` — `service has crashed 1 times in a row`.
- launchd immediately respawns WindowServer as PID 348, which begins the same framebuffer initialization sequence and also reaches the same `Surface mode contains bad bits` path before the user power-cycles.

## Important negative evidence
- no kernel panic in the accelerated failure window;
- no `_MTL4*` unresolved-superclass evidence;
- no MTLCompilerService crash/log evidence before first WindowServer death;
- no GPUCompiler/Metal/MTL4 failure before first WindowServer death;
- ReportCrash_ROOT is spawned after WindowServer death, but no new 2026-09-07 WindowServer/MTLCompiler crash report persisted before poweroff.

Therefore this failure is materially different from D97BK.

D97BK historical cause:
`legacy main Metal shadow -> unresolved Tahoe _MTL4* superclass ABI failure`.

D97EB current cause frontier:
`native Tahoe Metal preserved -> WindowServer/CoreDisplay enumerates legacy Haswell framebuffers -> dead/offline FB2/FB3 mode/capability failures + IOAccelSurface bad mode bits -> WindowServer SIGSEGV`.

## Classifications
- `D97EB_KERNEL_PANIC=NO`
- `D97EB_WINDOWSERVER_REACHED=YES`
- `D97EB_WINDOWSERVER_FIRST_CRASH=SIGSEGV`
- `D97EB_WINDOWSERVER_SIGSEGV_TIME=2026-09-07 02:24:58.799390+0300`
- `D97EB_WINDOWSERVER_RESTART=PROVEN`
- `D97EB_COREDISPLAY_OFFLINE_FB_ERRORS=PROVEN`
- `D97EB_IOFB_MODE_INFO_FAILURE_FB2_FB3=PROVEN`
- `D97EB_IOACCEL_SURFACE_BAD_BITS=PROVEN`
- `D97EB_MTL4_UNRESOLVED=ABSENT`
- `D97EB_MTLCOMPILERSERVICE_PRECRASH=NOT_REACHED_OR_NO_EVIDENCE`
- `D97EB_D97BK_OLD_METAL_SHADOW_CAUSE=CLOSED_NOT_REPEATED`
- `D97EB_NEW_FRONTIER=TAHOE_COREDISPLAY_LEGACY_HASWELL_FRAMEBUFFER_IOACCEL_COMPATIBILITY`

Do NOT claim the compiler path is runtime-proven under acceleration from this boot: WindowServer dies before useful compiler-path evidence is obtained.

## Upstream orientation
Official Dortania Tahoe tracking still identifies Metal 3802 (Ivy Bridge/Haswell/Kepler) as an active graphics-support workstream with initial promising results. No public Tahoe-specific CoreDisplay shim for Metal3802 was identified in the current patchset. Non-Metal CoreDisplay downgrade logic exists but must NOT be transplanted blindly into this native-Metal architecture.

## NEXT ACTION
Remain in VESA recovery.

Perform one read-only ASUS2 framebuffer topology audit before any further functional mutation. Establish:
- effective `AAPL,ig-platform-id` and device-id;
- IGPU registry properties;
- AppleIntelFramebuffer@0/@1/@2 topology;
- online/offline state and attached display relationship;
- connector type/pipe/port-count/memory properties where exposed;
- current display state.

Decision after that audit:
A. if FB2/FB3 are misdeclared/incorrectly exposed, prefer a bounded framebuffer topology correction;
B. if topology is already correct and dead pipes are expected, investigate a narrowly-scoped CoreDisplay/IOAccelerator compatibility shim.

Forbidden until topology audit closes:
- another accelerated boot;
- EFI mutation;
- another Root Patch;
- legacy main Metal shadow;
- global LLVM coercion;
- true-five reapplication;
- CoreDisplay donor/downgrade without independent ABI audit;
- Golden mutation.
