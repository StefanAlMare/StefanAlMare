# OCLP7 CHECKPOINT — D97GH postboot VESA corrected Root Patch PASS; accelerated test authorized

Date: 2026-09-07 EEST

## Entering authority
- ASUS2 Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`.
- D97GE closed corrected Root Patch preboot structure as STRUCTURAL-SEMANTIC PASS.
- User rebooted once into VESA with the corrected Root Patch active and ran D97GF plus a direct helper/collector micro-gate.

## D97GF active-snapshot metallib identity
Boot state:
- current boot remains VESA;
- active `-igfxvesa`, `-ocmcdiag`, `-ocmcd97bv`, `-ocmcd97eh`;
- `-ocmcd97ez` remains inert/commented as `#-ocmcd97ez`.

D97GF proved on the *active booted snapshot*:
- `D97GF_ACTIVE_METALLIB_EXACT=180`;
- missing `0`;
- different `0`;
- metadata stubs `0`;
- active CoreDisplay bytes `20739`;
- active CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- active CoreDisplay magic `4d544c42` = `MTLB`;
- `D97GF_ACTIVE_CORE_IDENTITY=PASS`;
- `D97GF_180_ACTIVE_METALLIB_IDENTITY=PASS`.

Classification:
`D97GH_ACTIVE_CORRECTED_METALLIB_LAYER=SEMANTIC_PROVEN`.

This closes the previous uncertainty that corrected payloads might be present only on the underlying System volume but not in the booted snapshot.

## Haswell Data kext / AuxKC runtime state
D97GF proved:
- `/Library/Extensions/AppleIntelFramebufferAzul.kext` present with `CFBundleIdentifier=com.apple.driver.AppleIntelFramebufferAzul` and `OSBundleRequired=Auxiliary`;
- `/Library/Extensions/AppleIntelHD5000Graphics.kext` present with `CFBundleIdentifier=com.apple.driver.AppleIntelHD5000Graphics` and `OSBundleRequired=Auxiliary`;
- AuxKC instruction match count `2` for the exact two Data-volume paths;
- `D97GF_AUXKC_INSTRUCTIONS=PASS`.

Loaded-state observation in the same VESA boot:
- `com.apple.driver.AppleIntelFramebufferAzul (18.0.8)` loaded, UUID `FA074475-16C7-3503-92E0-7BE42DD78F75`;
- `com.apple.driver.AppleIntelHD5000Graphics (18.0.8)` loaded, UUID `1BCC06E9-8026-3D04-8750-E563E55583A6`.

Classification:
`D97GH_HASWELL_AUXKC_RUNTIME_LOAD=REACHED_AND_PROVEN_FOR_VESA_BOOT`.

## Official privileged helper closure
D97GF helper section stopped before emitting final lines because of the same shell-helper handling issue seen previously; a direct micro-gate immediately after supplied the missing evidence.

Exact helper:
`/Library/PrivilegedHelperTools/com.dortania.opencore-legacy-patcher.privileged-helper`

Direct evidence:
- present;
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- TeamIdentifier `S74BDJXQMD`;
- codesign valid on disk and satisfies Designated Requirement;
- `HELPER_CODESIGN_RC=0`;
- `HELPER_SHA=PASS`;
- `HELPER_TEAM=PASS`.

Classification:
`D97GH_OFFICIAL_HELPER_IDENTITY=PASS`.

## D97EW hard-recovery evidence transport
Direct launchd gate proved:
- plist `/Library/LaunchDaemons/com.oclp.d97ew.capture.plist` present;
- capture script `/Library/Application Support/OCLP-D97EW/d97ew-capture.sh` present;
- launchd label `com.oclp.d97ew.capture`;
- `state = running`;
- `pid = 331`;
- `last exit code = (never exited)`;
- latest VESA run `/Users/Shared/OCLP-D97EW-Capture/20260907T202117Z-331`;
- prior accelerated authoritative run remains `/Users/Shared/OCLP-D97EW-Capture/20260907T135033Z-290`.

Classification:
`D97GH_D97EW_PERSISTENT_COLLECTOR=LIVE_PASS`.

## Boot boundary
Boot history returned:
- reboot `2026-09-07 23:15` local — current corrected-Root-Patch VESA boot;
- shutdown `23:14`;
- previous reboot `22:27`;
- previous shutdown `22:26`;
- previous reboot `22:02`.

Thus the current VESA boot boundary is explicit and distinguishable from the next accelerated experiment.

## D97GF composite closure
Although the D97GF shell did not emit its final PASS stanza, its critical active-snapshot, CoreDisplay, Data-kext, AuxKC and loaded-state checks all passed, and the direct micro-gate supplied exact helper + collector + boot-boundary evidence.

By composition:
`D97GF_POSTBOOT_VESA_ROOTPATCH=PASS_BY_COMPOSED_EVIDENCE`.

## Corrected Root Patch classification
Combining D97GB execution, D97GD byte-for-byte patched-volume proof, D97GE AuxKC/userspace preboot proof and D97GH/D97GF active-snapshot runtime proof:

`D97GH_CORRECTED_ROOTPATCH=STRUCTURAL_SEMANTIC_PASS_PRE_ACCELERATION`.

This does **not** yet prove accelerated GUI success or close the D97FJ causal model at runtime.

## Current causal frontier
Closed/excluded:
- old `set_id_mode 0x224` bad-bits rejection (D97FH);
- D97BV selective 3802 delivery;
- Tahoe-only CoreDisplay bootstrap tuple/descriptor divergence;
- invalid local MetallibSupportPkg materialization;
- old installed metadata-stub layer;
- corrected patched-volume metallib identity uncertainty;
- corrected active-snapshot metallib identity uncertainty;
- Haswell AuxKC placement/enrollment/load uncertainty in VESA.

Pending decisive runtime question:
`corrected real 25G82 metallib layer + D97EZ exact 0x224->0x24 adapter -> CoreDisplay GPUPass/render-pipeline -> usable accelerated GUI OR a new downstream measured frontier`.

## Accelerated test authorization
AUTHORIZED NOW:
`D97GH_ONE_MEASURED_ACCELERATED_BOOT=YES`.

Exact EFI delta for the single experiment:
1. change exact token `-igfxvesa` to inert/commented `#-igfxvesa`;
2. change exact token `#-ocmcd97ez` to active `-ocmcd97ez`;
3. preserve all other boot args and EFI state exactly, including `-ocmcdiag`, `-ocmcd97bv`, `-ocmcd97eh`, `ipc_control_port_options=0`, `-amfipassbeta`, normal framebuffer 3/3/3 and audited D97EZ 0.0.12 kext;
4. no additional T2/Haswell variables, no framebuffer changes, no NVRAM experiment.

D97EW collector must remain installed and will restart at boot.

### If accelerated boot produces a usable GUI
- do not change EFI or run Root Patch;
- allow the system/collector to settle;
- report that a usable image was reached and return the newest D97EW run plus `last reboot | head -n 5` for measured closure.

### If accelerated boot produces no usable image
- follow the permanent VESA recovery rule: hard power-cycle as needed, restore exact VESA tokens (`-igfxvesa` active and `-ocmcd97ez` inert/commented), boot VESA;
- do not mix recovery logs with the accelerated cohort;
- authoritative evidence is the immediately preceding accelerated D97EW run;
- after VESA return, first provide `last reboot | head -n 5` and newest D97EW run identities before deeper log audit.

Still forbidden:
- any new patch/adapter semantics;
- global mode masking;
- EFI changes beyond the exact two-token acceleration delta/recovery reversal;
- Golden mutation;
- legacy main Metal shadow;
- true-five reapplication.
