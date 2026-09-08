# OCLP7 CHECKPOINT — D97HQ AUXKC VALID / VESA UNLOADED / DIRECT D97HO ROOT PATCH READY

Date: 2026-09-08 EEST
Target: ASUS2, macOS Tahoe 26.6.2 / 25G82, MacBookAir6,2, Haswell 8086:0412.

## Inputs already closed PASS
- D97HO wrapper assembly PASS, ZIP SHA256 `a1aa24d58a0e0c9653bab702c50d2f704b28c205efc6e82b9b3cce9b41ead9f3`, bytes `722975756`.
- D97HI inner source diff `c459056884d3469a14fd5ebadb6fc4aa96c3b86dc35e39717732ade34ae24da2`.
- D97HI inner executable SHA256 `1c3760fc232ccc653a62fb18cafd0192f5c079dc1a01b7caa58491b0bb775133`.
- P1 preserved exact; P3-only; P2b/AIR00/D34 replay = NO.

## D97HP read-only result before Haswell-load gate
PASS before stop:
- VESA active, D97EZ inert.
- exact D97HO artifact PASS.
- active P1 service exact SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` and postimage exact.
- active MTLCompiler 32023 exact pre-P3 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`.
- P2 remains original `418b81d0000000` at `0x9A8CD`.
- P3 remains unapplied exact preimage `81e100002000` at `0xA1573`.
- corrected metallibs 180/180 exact, missing0, different0.

D97HP then stopped at `AZUL_NOT_LOADED` because it used a loaded-only gate not appropriate to the current VESA state.

## D97HQ archive
User-supplied archive:
`OCLP7_D97HQ_AUXKC_HASWELL_AUDIT_20260908_125907.zip`
- bytes `346782`
- SHA256 `8095be562ce77e8d4b416f5d558b2938d583277119fb5d1e018e3045ad41bc68`

## D97HQ exact findings
Boot:
- VESA active.
- D97EZ inert.

On-disk kext identities:
- AppleIntelFramebufferAzul bundle id `com.apple.driver.AppleIntelFramebufferAzul`, version `18.0.8` / short `18.8.4`.
- AppleIntelHD5000Graphics bundle id `com.apple.driver.AppleIntelHD5000Graphics`, version `18.0.8` / short `18.8.4`.
- both present on disk.

AuxKC state:
- `D97HQ_AZUL_IN_AUX_ALL=1`
- `D97HQ_AZUL_IN_AUX_LOADED=0`
- `D97HQ_AZUL_IN_AUX_UNLOADED=1`
- `D97HQ_AZUL_IN_ALL_COLLECTIONS=1`
- `D97HQ_HD5000_IN_AUX_ALL=1`
- `D97HQ_HD5000_IN_AUX_LOADED=0`
- `D97HQ_HD5000_IN_AUX_UNLOADED=1`
- `D97HQ_HD5000_IN_ALL_COLLECTIONS=1`
- `D97HQ_KMUTIL_CHECK_AUX_LOADINFO_RC=0`
- AuxKC path `/Library/KernelCollections/AuxiliaryKernelExtensions.kc`, bytes `5439488`.
- kmutil inspect contains LC_FILESET_ENTRY for both:
  - `com.apple.driver.AppleIntelFramebufferAzul`
  - `com.apple.driver.AppleIntelHD5000Graphics`

IOKit under VESA:
- `AppleIntelFramebufferAzul` count 0
- `AppleIntelHD5000Graphics` count 0
- `IntelAccelerator` count 0
- `IntelFramebuffer` count 0
- `AppleIntelFramebuffer` count 0
- `display0` count 2
- `AppleBacklight` count 4

Official helper:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`
- Team `S74BDJXQMD`
- PASS.

D97HQ classifier:
`PRESENT_IN_AUX_BUT_NOT_BOTH_LOADED`.

## Interpretation
The current VESA boot intentionally has no IntelAccelerator/IntelFramebuffer service. Both Haswell kexts are nevertheless present in a valid AuxKC and explicitly classified by kmutil as unloaded. `kmutil check --collection aux --load-info` returns 0, so the Auxiliary Kernel Collection is coherent.

Therefore the D97HP `AZUL_NOT_LOADED` stop is not evidence of a broken AuxKC and is not a reason to Restore. It is a gate design mismatch for the current VESA diagnostic boot.

## Restore-first vs direct patch decision
`RESTORE_FIRST=NO`
`DIRECT_D97HO_ROOT_PATCH=AUTHORIZED`

Reason:
- active userspace base is exact P1-only;
- current MTLCompiler 32023 is exact pre-P3 with P2 original and P3 preimage exact;
- metallibs are exact 180/180;
- AuxKC is valid and contains both Haswell kexts;
- helper is exact;
- D97HO artifact is independently audited and exact.

Expected Root Patch semantics:
- P1 hook sees exact already-post SHA and must no-op idempotently.
- P3 hook sees exact Golden pre-P3 SHA and unique preimage, changes exactly byte `0xA1574: e1 -> c9`, requiring post-SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.
- P2b/AIR00/D34 remain absent.
- standard D97DX patchsets reapply/rebuild deterministic system files and AuxKC.

## Immediate next
1. User manually launches exact `/Users/alex/Desktop/OpenCore-Patcher-Tahoe-D97HO.app` on ASUS2.
2. Run Post-Install Root Patch.
3. Do NOT reboot when complete.
4. Capture full patch output.
5. Run a read-only pre-reboot audit that proves underlying/new root P1 + P3 exact, corrected metallibs exact, and AuxKC rebuild success before any reboot.

No EFI/NVRAM/framebuffer mutation is authorized. No accelerated boot is authorized yet.
