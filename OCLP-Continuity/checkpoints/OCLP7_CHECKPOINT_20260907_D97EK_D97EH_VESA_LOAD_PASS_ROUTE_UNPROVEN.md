# OCLP7 D97EK — D97EH VESA load PASS, set_id_mode route unproven

Date: 2026-09-07 EEST
Target: ASUS2, Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.

## Deployment identity — PASS
Active EFI `OCLPMetalCompat.kext` was replaced with audited D97EH 0.0.9 and independently checked before reboot:
- version `0.0.9`;
- executable SHA256 `23bbc4a30a0c445a20a2821530a427256662e4e4832eaa6c82b1219540460fcf`;
- UUID `E3BE3246-7F7A-36B8-822D-7D1AEB35D721` x86_64.

Boot args for first VESA deployment boot:
- `-igfxvesa` active;
- `-ocmcdiag` active;
- `-ocmcd97bv` active;
- `-ocmcd97eh` active;
- `#-ocmcd97bvcave` inert.

## VESA boot chronology
- reboot: 2026-09-07 11:52 EEST;
- prior shutdown: 11:51 EEST.

## Loaded-kext gate — PASS
`kmutil showloaded` in the 11:52 VESA boot shows:
- Lilu 1.7.3 UUID `38ACFA46-F60C-3795-B868-EF32F98C78ED`;
- OCLPMetalCompat 0.0.9 UUID `E3BE3246-7F7A-36B8-822D-7D1AEB35D721`;
- WhateverGreen 1.7.1;
- `com.apple.iokit.IOAcceleratorFamily2` 487.4.3 UUID `B77A42EC-6B0C-3A8D-89A2-B8F4CDBAC8C9`;
- AppleIntelFramebufferAzul 18.0.8;
- AppleIntelHD5000Graphics 18.0.8.

Important correction to earlier expectation: `IOAcceleratorFamily2` DOES load even in this VESA session.

## D97BV gate — healthy
OCLPMetalCompat IORegistry proves:
- `D97CTBootArgGate = 1`;
- `D97CTKernelGate = 1`;
- `D97CTCpuGate = 1`;
- `D97CTBuildGate = 1`;
- observed build `25G82`;
- `D97CTRouteStatus = PASS`;
- `D97DIFunctionalRequested = 1`;
- `D97DIFunctionalMode = ACTIVE`;
- `_cs_validate_page` callback count >254k.

SITE/CAVE remain pending in this VESA boot, with zero writes/seen counts; no regression is inferred because the D97BV target shared-cache pages have not been exercised in this session.

## D97EH route evidence — UNPROVEN
Unified-log query covering the 11:52 boot proves:
- boot arg `-ocmcd97eh` is active;
- `kernelmanagerd` reports `Received kext load notification: com.apple.iokit.IOAcceleratorFamily2` at 11:53:00.646238;
- NO `D97EH_ROUTE ... PASS` line;
- NO `D97EH_ROUTE ... NEGATIVE` line;
- NO `D97EH_SET_ID_MODE` line;
- NO `uuid mismatch` line for IOAcceleratorFamily2;
- NO `failed to init MachInfo` / `no loaded symbols buffer` line tied to the observer.

Therefore the observer route cannot be classified as PASS or NEGATIVE from current logging.

## Lilu implementation audit
Lilu 1.7.3 behavior reviewed:
- `onKextLoad` stores kext requests and callbacks separately;
- during `processPatcherLoadCallbacks`, Lilu loads KextInfo, sets up kext listening, and creates handlers;
- on Big Sur+ `activate()` processes already loaded kexts when `Loaded` is set;
- kext match checks both bundle id and current binary UUID before invoking callback;
- in kernel-collection mode `MachInfo::init` first attempts `initFromMemory()` and may succeed without a standalone filesystem executable.

Thus absence of the standalone IOAcceleratorFamily2 executable alone is NOT sufficient to claim KextInfo failure on Tahoe KC.

## Classification
- `D97EK_D97EH_EFI_IDENTITY=PASS`
- `D97EK_D97EH_KEXT_LOAD=PASS`
- `D97EK_D97BV_REGRESSION=NO_EVIDENCE`
- `D97EK_IOACCELERATORFAMILY2_VESA_LOAD=YES`
- `D97EK_D97EH_ROUTE_STATUS=UNPROVEN`
- `D97EK_ACCELERATED_BOOT_AUTHORIZED=NO`

## Next causal step
Build a telemetry-only successor from exact D97EH semantics. Do not change observer symbol, original call, mode, return value, masks, or registration behavior.

Publish explicit IORegistry telemetry for:
- observer boot-arg requested;
- current KextInfo loadIndex;
- generic kext-callback seen count;
- target-index callback seen count;
- last callback index;
- route status PASS/NEGATIVE/PENDING;
- set_id_mode observed call count.

First boot remains VESA. Only after route PASS is explicitly proven may one accelerated observer boot be authorized.

Still forbidden:
- accelerated boot now;
- mode-bit clearing;
- return coercion;
- Root Patch;
- framebuffer tuning;
- legacy main Metal shadow;
- true-five replay;
- Golden mutation.
