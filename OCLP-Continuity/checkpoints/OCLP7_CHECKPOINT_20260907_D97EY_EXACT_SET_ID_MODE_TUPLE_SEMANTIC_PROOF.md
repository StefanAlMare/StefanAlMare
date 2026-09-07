# OCLP7 D97EY — exact accelerated `set_id_mode` tuple semantic proof

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2

## Authority entering D97EY
- Functional baseline remains exactly `P1 + P2b + P3 + AIR00 + D34`.
- Golden Sequoia remains immutable/read-only.
- D50/D68/D82 remain reserve-only; D84 retired.
- D97DX native-Metal-safe Root Patch remains installed.
- Active EFI observer is audited D97ES `OCLPMetalCompat.kext` 0.0.11.
- D97EX proved the persistent D97EW LaunchDaemon transport LIVE/PASS before acceleration.
- The only accelerated-boot change was `-igfxvesa` made inert as `#-igfxvesa`; `-ocmcdiag -ocmcd97bv -ocmcd97eh` remained active and `#-ocmcd97bvcave` inert.

## Accelerated run identity
Persisted D97EW run:
`/Users/Shared/OCLP-D97EW-Capture/20260907T115054Z-295`

Saved accelerated boot args prove:
- `#-igfxvesa` inert;
- `-ocmcdiag` active;
- `-ocmcd97bv` active;
- `-ocmcd97eh` active;
- `#-ocmcd97bvcave` inert.

Loaded observer identity captured in the same accelerated run:
- `com.oclpmetalcompat.OCLPMetalCompat (0.0.11)`;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4` x86_64.

Collector result:
- first sample service present;
- `D97ELRouteStatus=PASS`;
- `D97ESCapturedCount=8`;
- `D97ELSetIdModeCallCount=15` at first persisted snapshot;
- call count reached 20 in all five follow-up snapshots;
- `D97EW_CAPTURE_STATUS=TUPLE_CAPTURED`;
- first tuple snapshot, boot args and kext identity were persisted and synced before VESA recovery.

## Exact first-eight tuple evidence
All eight Valid flags are 1.

| Slot | id | mode | badBits | goodBits | original IOReturn |
|---|---:|---:|---:|---:|---:|
| 1 | `0x1000` | `0x0024` | `0x0000` | `0x0024` | `0x00000000` |
| 2 | `0x1001` | `0x0224` | `0x0200` | `0x0024` | `0xE00002C2` |
| 3 | `0x1002` | `0x0224` | `0x0200` | `0x0024` | `0xE00002C2` |
| 4 | `0x1003` | `0x0224` | `0x0200` | `0x0024` | `0xE00002C2` |
| 5 | `0x1004` | `0x0224` | `0x0200` | `0x0024` | `0xE00002C2` |
| 6 | `0x1000` | `0x0024` | `0x0000` | `0x0024` | `0x00000000` |
| 7 | `0x1001` | `0x0224` | `0x0200` | `0x0024` | `0xE00002C2` |
| 8 | `0x1002` | `0x0224` | `0x0200` | `0x0024` | `0xE00002C2` |

Raw decimal IOReturn observed for failing tuples was `18446744073172681410`, whose low 32 bits are `0xE00002C2` / signed `-536870206`, the standard IOKit `kIOReturnBadArgument` value.

## Decisive semantic interpretation
Directly PROVEN in the same accelerated boot and same exact routed Apple original:
1. `mode=0x24` has `badBits=0`, `goodBits=0x24`, and returns success.
2. `mode=0x224` differs from the successful mode by exactly one observed bit: `0x200`.
3. For every captured `0x224` tuple, `badBits=0x200`, `goodBits=0x24`, and Apple original returns `kIOReturnBadArgument`.
4. The pattern repeats across WindowServer surface-ID sequences: the first sequence is `0x1000..0x1004`, then a second sequence restarts at `0x1000`; the successful primary tuple and subsequent failing tuples repeat.
5. The first-eight tuple payload is stable across all five persisted follow-up snapshots; only the total call count rises from 15 to 20.
6. Therefore the exact incompatibility at the measured handoff is no longer merely a log-string correlation: the legacy Haswell IOAccelerator rejects a Tahoe-delivered `mode` carrying bit `0x200` while accepting the otherwise-identical observed `0x24` bit class.

Classification strength:
- exact route/control-flow = PROVEN;
- exact raw tuple transport = PROVEN;
- `0x24 -> success` and `0x224/0x200 -> kIOReturnBadArgument` correlation = SEMANTIC PROVEN for the captured calls;
- exact meaning of mode bit `0x200` = UNKNOWN;
- exact Golden runtime mode value for equivalent surfaces = UNKNOWN and must not be obtained by booting/modifying Golden;
- semantic equivalence of blindly clearing `0x200` for every possible request = NOT PROVEN.

## Same-boot downstream crash evidence
The accelerated boot produced repeated WindowServer crashes. A captured WindowServer report at `2026-09-07 14:52:09.1035 +0300`, boot uptime 150 seconds, shows:
- WindowServer PID 470, consecutive crash count 9;
- `EXC_BAD_ACCESS / SIGSEGV`;
- crash path through `CoreDisplay::MetalDevice::GetGPUPassRenderPipelineState` -> `CoreDisplay::CreateMetalDevice` -> display initialization -> SkyLight/WindowServer;
- Tahoe GPUCompiler 32023 libraries mapped;
- legacy `AppleIntelHD5000GraphicsMTLDriver` 18.8.4 mapped.

This remains downstream evidence and does not supersede the earlier causal rule: the new direct kernel handoff tuple is the stronger causal frontier.

## Public/static context
Public IOKit documentation identifies `0xE00002C2` as `kIOReturnBadArgument`. Public reverse-engineering literature describes `IOAccelSurface::set_id_mode` as surface initialization with bitwise presentation-type flags, but does not provide a reliable public semantic name for the observed `0x200` bit. Therefore no semantic name is assigned to that bit here.

## Methodology decision
Do NOT apply a global `mode &= ~0x200` or any global good-mask rewrite.

The next functional hypothesis, if pursued, must be an exact handoff adapter rather than a late validator patch:
- preserve D97ES observer route and telemetry;
- behind a separate explicit functional bootarg only;
- classify every call globally/no-PID;
- change only exact `mode == 0x224` to candidate `0x24`;
- pass every other mode byte-for-byte unchanged;
- call Apple original once and return its exact IOReturn;
- capture original mode, passed mode and return for audit;
- remain an experiment, not a production semantic claim.

This exact-match experiment is justified by the measured boundary but its semantic sufficiency is not yet PROVEN.

## Classification
- `D97EY_ACCELERATED_RUN_IDENTITY=PASS`
- `D97EY_D97ES_IDENTITY=PASS`
- `D97EY_D97EW_PERSISTENT_TRANSPORT=PASS`
- `D97EY_SET_ID_MODE_ROUTE=PASS`
- `D97EY_FIRST_EIGHT_TUPLES=PROVEN`
- `D97EY_MODE_0x24_RET_SUCCESS=SEMANTIC_PROVEN`
- `D97EY_MODE_0x224_BADBITS_0x200_RET_BADARG=SEMANTIC_PROVEN`
- `D97EY_EXTRA_BAD_BIT=0x200`
- `D97EY_BIT_0x200_SEMANTIC_NAME=UNKNOWN`
- `D97EY_GLOBAL_MASK_AUTHORIZED=NO`
- `D97EY_GOLDEN_RUNTIME_BOOT=NO`
- `D97EY_ROOT_PATCH_AUTHORIZED=NO`
- `D97EY_ACCELERATED_BOOT_AUTHORIZED=NO_PENDING_NEXT_DESIGN_AUDIT`

## CURRENT ACTION
GitHub-first: design and independently audit a bounded D97EZ exact-match handoff-adapter experiment derived from exact D97ES 0.0.11. The design may propose only `0x224 -> 0x24` behind a new explicit bootarg, preserve all other modes exactly, preserve original IOReturn semantics, add original/passed-mode telemetry, and remain LATENT by default. No ASUS2 mutation, Root Patch, EFI change or reboot is authorized until source/build/binary audit and a separate deployment checkpoint.