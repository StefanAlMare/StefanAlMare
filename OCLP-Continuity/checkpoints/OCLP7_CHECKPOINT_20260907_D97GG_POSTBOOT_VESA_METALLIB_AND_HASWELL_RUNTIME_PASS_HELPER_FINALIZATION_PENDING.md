# OCLP7 CHECKPOINT — D97GG postboot VESA metallib + Haswell runtime PASS; helper finalization pending

Date: 2026-09-07 EEST

## Entering authority
- Corrected D97DX Root Patch was structurally/semantically closed PASS pre-boot by D97GE.
- Current boot remains VESA with `-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`; `-ocmcd97ez` remains inert/commented.
- Goal of D97GF is to prove that the corrected snapshot is actually active after reboot before authorizing acceleration.

## D97GF returned evidence
The user executed exact helper blob `238dcba4a84429d7ebcc5553264cf06178809b65`.

### Boot state
- macOS `26.6.2 / 25G82`, x86_64.
- Boot args remain VESA and D97EZ ACTIVE mode is inert.

Classification:
`D97GG_VESA_POSTBOOT_GATE=PASS`.

### Active snapshot metallib identity
D97GF proved directly against the currently booted `/` snapshot:
- `D97GF_ACTIVE_METALLIB_EXACT=180`;
- `D97GF_ACTIVE_METALLIB_MISSING=0`;
- `D97GF_ACTIVE_METALLIB_DIFFERENT=0`;
- `D97GF_ACTIVE_METADATA_STUB=0`;
- `D97GF_ACTIVE_CORE_BYTES=20739`;
- `D97GF_ACTIVE_CORE_SHA256=b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- `D97GF_ACTIVE_CORE_MAGIC=4d544c42` (`MTLB`);
- `D97GF_ACTIVE_CORE_IDENTITY=PASS`;
- `D97GF_180_ACTIVE_METALLIB_IDENTITY=PASS`.

Classification:
- `D97GG_ACTIVE_SNAPSHOT_180_DYNAMIC_METALLIB_IDENTITY=STRUCTURAL_SEMANTIC_PROVEN`;
- `D97GG_ACTIVE_COREDISPLAY_METALLIB_IDENTITY=STRUCTURAL_SEMANTIC_PROVEN`.

This is the first post-reboot proof that the corrected 25G82 metallib payload is not only written to the underlying System volume but is the material actually visible in the booted snapshot.

### Haswell AuxKC state
D97GF proved both Data-volume kexts remain correctly installed:
- `/Library/Extensions/AppleIntelFramebufferAzul.kext`, bundle ID `com.apple.driver.AppleIntelFramebufferAzul`, `OSBundleRequired=Auxiliary`;
- `/Library/Extensions/AppleIntelHD5000Graphics.kext`, bundle ID `com.apple.driver.AppleIntelHD5000Graphics`, `OSBundleRequired=Auxiliary`.

AuxKC instructions contain both exact paths:
- `/Library/Extensions/AppleIntelFramebufferAzul.kext`;
- `/Library/Extensions/AppleIntelHD5000Graphics.kext`;
with `D97GF_AUXKC_MATCH_COUNT=2` and `D97GF_AUXKC_INSTRUCTIONS=PASS`.

Classification:
`D97GG_HASWELL_AUXKC_CONFIGURATION=STRUCTURAL_SEMANTIC_PROVEN`.

### Loaded-state proof in VESA
`kmutil showloaded` lists:
- `com.apple.driver.AppleIntelFramebufferAzul (18.0.8)` UUID `FA074475-16C7-3503-92E0-7BE42DD78F75`;
- `com.apple.driver.AppleIntelHD5000Graphics (18.0.8)` UUID `1BCC06E9-8026-3D04-8750-E563E55583A6`.

Classification:
`D97GG_HASWELL_KEXTS_LOADED_POSTBOOT=REACHED_PASS`.

This is stronger than pre-boot file presence: the corrected Root Patch's AuxKC Haswell drivers are actually loaded in the current VESA boot.

## D97GF helper-check tooling stop
The helper stopped immediately after printing `===== OFFICIAL HELPER =====`, before emitting helper identity or the final `D97GF_STATUS=PASS` block.

No Root Patch/Restore/EFI/NVRAM/framebuffer mutation occurred.
The already-proven critical postboot payload/runtime gates above are valid and unaffected.

Classification:
`D97GF_HELPER_SECTION_STOP=TOOLING_INCONCLUSIVE`.

A minimal direct helper check plus boot-history/persistent-collector sanity check is required before composing full D97GF PASS and authorizing accelerated boot.

## Current action
Remain VESA. No reboot, no EFI changes, no acceleration yet.
Run direct read-only checks for:
1. official privileged helper exact SHA/team/codesign;
2. `last reboot | head -n 5`;
3. D97EW LaunchDaemon `com.oclp.d97ew.capture` presence and evidence directory sanity.

If these pass, D97GF may be closed PASS by composed evidence and the next controlled ACTIVE accelerated boot can be separately authorized.
