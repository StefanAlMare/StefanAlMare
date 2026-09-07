# OCLP7 D97EQ — accelerated failure reproduced, observer tuple not captured

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2

## Input artifact
User collector:
`OCLP7_D97EQ_ACCEL_FAIL_20260907_132111.zip`

Independent artifact checks:
- bytes: `352126`
- SHA256: `82c884ff6c5ae642a5c4a4a029fbd78fee123e5c74631f5e34a791e467fad748`
- ZIP CRC/test: PASS

## Boot chronology
Collector chronology:
- accelerated diagnostic boot: reboot around 13:13 / userspace 13:14;
- recovery VESA boot: reboot 13:15;
- do not mix recovery VESA evidence into accelerated boot analysis.

Accelerated boot args explicitly show `#-igfxvesa` while preserving:
- `-ocmcdiag`
- `-ocmcd97bv`
- `-ocmcd97eh`
- `ipc_control_port_options=0`
- `-amfipassbeta`

Recovery VESA boot restores `-igfxvesa`.

## Accelerated runtime sequence
WindowServer PID 177:
- spawned at 13:14:15.013788;
- `GPU: FB: 3 of 3 opened` at 13:14:56.623169;
- four exact kernel errors from IOAcceleratorFamily2:
  - 13:14:56.723835 `IOAccelSurface::set_id_mode(uint32_t,uint32_t): Surface mode contains bad bits`
  - 13:14:56.724216 same
  - 13:14:56.724494 same
  - 13:14:56.724772 same
- main display forced offline at 13:14:56.727861;
- WindowServer PID 177 exits due to SIGSEGV at 13:14:56.745335.

Timing:
- offline transition is ~3.089 ms after fourth bad-bits error;
- WindowServer SIGSEGV is ~20.563 ms after fourth bad-bits error.

WindowServer PID 340 respawns at 13:14:57.220045 and again reaches `GPU: FB: 3 of 3 opened`, but main display remains offline.

## Negative findings
During the accelerated failure window:
- no kernel panic evidence;
- no `_MTL4*` unresolved-superclass regression;
- no MTLCompilerService failure before the first WindowServer death;
- no `EXC_BAD_ACCESS` textual marker beyond launchd SIGSEGV record;
- recent crash-report collector found no standalone WindowServer/CoreDisplay/MTLCompilerService report file.

Recovery boot records `Previous shutdown cause: 5`, corresponding to the manual hard power-off after image loss, not to a kernel panic.

## D97EL observer status
Before this accelerated run, D97EP proved in VESA:
- `D97ELObserverRequested=1`
- `D97ELTargetCallbackSeenCount=1`
- `D97ELRouteStatus=PASS`
- exact target symbol route installed.

However the D97EQ recovered unified log contains no custom markers:
- no `D97EH_ROUTE`
- no `D97EH_SET_ID_MODE`
- no `badBits=`
- no `goodBits=`
- no observer tuple `id/mode/ret`.

Important classification:
- absence of the custom marker in post-recovery unified log does NOT prove the route failed during accelerated boot;
- the same custom route marker had already been absent from unified log in VESA even when IORegistry independently proved `D97ELRouteStatus=PASS`;
- therefore the immediate problem is telemetry transport/persistence across hard reboot, not a demonstrated regression of the observer route.

Current recovery VESA again shows D97EL 0.0.10 loaded and route PASS, but that is current-boot state and cannot be substituted for the preceding accelerated boot tuple.

## Classification
- `D97EQ_ACCELERATED_BOOT_REPRO=PASS`
- `D97EQ_NORMAL_3_OF_3_BASELINE=PASS`
- `D97EQ_SET_ID_MODE_BAD_BITS_COUNT=4`
- `D97EQ_DISPLAY_OFFLINE_AFTER_BAD_BITS=YES`
- `D97EQ_WINDOWSERVER_SIGSEGV=YES`
- `D97EQ_KERNEL_PANIC=NO`
- `D97EQ_MTL4_REGRESSION=NO`
- `D97EQ_MTLCOMPILERSERVICE_PRECRASH_FAILURE=NO`
- `D97EQ_OBSERVER_TUPLE_CAPTURE=NOT_CAPTURED`
- `D97EQ_UNIFIED_LOG_CUSTOM_MARKERS=ABSENT`
- `D97EQ_FUNCTIONAL_MODE_MASKING_AUTHORIZED=NO`

## Next gate
Do not make any EFI semantic change and do not add T2/Haswell audit boot-args yet.
Before rebuilding OCLPMetalCompat, test whether the current boot's custom D97EH/D97EL marker is visible in the live kernel message buffer (`dmesg`).

If live `dmesg` exposes the custom route marker, retain D97EL 0.0.10 and use a live capture method during the next accelerated boot (preferably SSH from another Mac before hard power-off) to recover `D97EH_SET_ID_MODE` tuples.

If custom markers are absent even from live `dmesg`, build a telemetry successor that publishes the first set_id_mode tuple(s) through a channel that can be read live before power-off. No mode-bit masking or return coercion is authorized before exact measurement.
