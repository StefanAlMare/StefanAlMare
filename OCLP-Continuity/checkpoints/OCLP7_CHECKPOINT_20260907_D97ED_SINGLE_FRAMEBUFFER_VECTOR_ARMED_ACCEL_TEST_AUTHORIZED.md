# OCLP7 CHECKPOINT — D97ED single-framebuffer vector armed; accelerated test authorized

Date: 2026-09-07 EEST

## Entering authority
- ASUS2 Tahoe 26.6.2 / 25G82, Haswell 8086:0412, SMBIOS MacBookAir6,2.
- D97DX native-Metal-safe Root Patch installed and VESA validation PASS.
- D97EB accelerated failure frontier: repeated WindowServer SIGSEGV during Tahoe CoreDisplay handling of inactive/offline legacy Haswell framebuffer/display semantics.
- D97EC established platform baseline 0x0A260006 with native WhateverGreen count vector 3 pipes / 3 ports / 3 framebuffer memories.
- Current safe recovery mode is VESA.

## User-confirmed manual EFI mutation
User explicitly reported completion after being instructed to set the following IGPU DeviceProperties at `PciRoot(0x0)/Pci(0x2,0x0)`:
- `AAPL,ig-platform-id` Data `0600260A` (0x0A260006);
- `device-id` Data `12040000` (0x0412);
- `framebuffer-patch-enable` Data `01000000`;
- `framebuffer-pipecount` Data `01000000`;
- `framebuffer-portcount` Data `01000000`;
- `framebuffer-memorycount` Data `01000000`;
- retain `framebuffer-cursormem` Data `00009000`;
- remove/disable `framebuffer-con2-enable`;
- remove/disable `framebuffer-con2-type`.

No con0 index/busid/type override is introduced. The intent is to preserve the native first LVDS framebuffer definition of 0x0A260006 while reducing the logical framebuffer-count vector from 3/3/3 to 1/1/1.

This checkpoint records the user's manual completion of the exact instructed mutation. It does not claim an independently re-read config SHA after mutation.

## Causal purpose
This is a single bounded diagnostic variable:
- preserve native-Metal-safe Root Patch;
- preserve D97DL/D97BV selective-3802 adapter;
- preserve Haswell platform-id 0x0A260006 and device-id 0x0412;
- remove only the two inactive external framebuffer slots from the logical count vector.

If WindowServer progresses beyond the prior D97EB CoreDisplay failure, the offline-FB hypothesis gains causal support.
If the same SIGSEGV persists, the framebuffer-count hypothesis is rejected and the frontier moves toward a narrow Tahoe CoreDisplay/IOAccelerator compatibility shim.

## Authorized accelerated test
For exactly one diagnostic boot:
- make `-igfxvesa` inactive only (recommended form `#-igfxvesa` for easy restoration);
- retain `-ocmcdiag` active;
- retain `-ocmcd97bv` active;
- keep `#-ocmcd97bvcave` inactive;
- make no other EFI, Root Patch, kext, boot-arg, or system-root changes;
- reboot once into accelerated mode.

Success condition:
- usable GUI reaches login/desktop; do not immediately make further changes.

Failure condition:
- if black screen / verbose recurrence / unusable GUI occurs, hard power-cycle if necessary, restore/reactivate `-igfxvesa`, return to VESA recovery, and analyze only that immediately preceding accelerated diagnostic boot under the permanent VESA recovery rule.

## Still forbidden
- another Root Patch;
- any legacy main Metal shadow;
- global 3802 forcing;
- true-five reapplication;
- CoreDisplay framework donor/downgrade;
- Golden mutation;
- any additional framebuffer/property mutation before evaluating this one-variable test.

Classification:
- `D97ED_SINGLE_FRAMEBUFFER_VECTOR=ARMED_USER_CONFIRMED`;
- `D97ED_ACCELERATED_DIAGNOSTIC_BOOT=AUTHORIZED_ONE_ATTEMPT`.
