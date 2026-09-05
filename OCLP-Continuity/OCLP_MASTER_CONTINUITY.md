# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BJ_TAHOE_25G82_ROOT_PATCH_RUNTIME_PASS_ACCELERATED_BOOT_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`

## Mandatory startup
Before proposing a technical modification in any future OCLP continuation, read the permanent database, permanent working rules, this MASTER, the VESA rule, and the current checkpoint linked above.

## Target
macOS Tahoe `26.6.2 / 25G82`, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware acceleration and usable GUI.

## Exact Golden ORIGINAL-OCLP baseline
- upstream `dortania/OpenCore-Legacy-Patcher`;
- exact commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`;
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`.

Golden/reference remains immutable/read-only.

Reference official Golden-lineage app:
- executable SHA256 `0cdb415b0fdcf7e4a0f82b9e8b62db79b9450fe287de535a00d754e2c504addc`;
- Info.plist SHA256 `6c6d1b12963e1b103baad517d64cef9d8cc778187ba1dd0bb9d38737e2519d77`;
- official Team ID `S74BDJXQMD`.

Official privileged helper reference SHA256:
`9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`.

## Durable Golden causal/producer evidence
Retain accepted causal chain:
`MTLCompilerService failure -> XPC_ERROR_CONNECTION_INTERRUPTED -> pipeline creation failure -> SkyLight/CopyPipelineState abort -> WindowServer death`.

Accepted historical five-functional diagnostic baseline remains:
`P1 + P2b + P3 + AIR00 + D34`.
P6/P7 insufficient; D50/D68/D82 reserve; D84 retired; D36-D44 invalidated for D34 cave overlap.

Golden request-builder closure remains authoritative:
- primary builder region `0x7FF80D370756..0x7FF80D370C28`;
- RBX = arg1/RDI; signed dword `[RBX+0x20] -> llvmVersion`;
- R13 = arg2/RSI; `[R13+0x08] -> requestType`, `[R13+0x18] -> timeout`, `[R13+0x70]` sandbox gate;
- alternate requestType immediate `9`.

## Exact Tahoe eligibility findings for b9df76
Exact b9df76 host gate originally had `_max_os = os_data.sequoia.value`; `os_data.py` already defines Tahoe = Darwin 25.
The built-in developer marker can bypass that host gate, but D97BG runtime later proved host-gate bypass alone is insufficient for complete Tahoe 25G82 Root Patch.

Historical second Haswell/native-OS blocker does NOT apply to exact b9df76:
- Haswell is unconditionally included;
- `IntelHaswell.native_os()` is only `xnu < Ventura`, false on Darwin 25;
- Haswell composition remains `LegacyMetal3802 + MontereyGVA + MontereyOpenCL + Haswell-specific`;
- LegacyMetal3802 has no Tahoe maximum.

## D97BG signed-wrapper result
D97BG preserved the exact signed Golden inner OCLP and official helper while automatically creating the built-in developer marker.
It proved the host-gate route, but live Tahoe Root Patch found further Tahoe-specific blockers and therefore D97BG is superseded for actual 25G82 Root Patch use.

## D97BH MetallibSupportPkg runtime PASS
Exact target package:
- `MetallibSupportPkg-26.6.2-25G82.pkg`;
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Installed exact local tree:
`/Library/Application Support/Dortania/MetallibSupportPkg/26.6.2-25G82`.

b9df76 official manifest lacks Tahoe 26.x, but runtime fallback proved exact local 25G82 is accepted. D97BJ later improved this by preferring exact local host-build Metallib before API fallback.

Classification:
`D97BH_25G82_LOCAL_METALLIB_FALLBACK_RUNTIME=PASS`.

## D97BI Metal.framework blocker
Exact b9df76 constructed `13.2.1-{Darwin major}` and on Darwin 25 requested nonexistent:
`Universal-Binaries/13.2.1-25/System/Library/Frameworks/Metal.framework`.
Historical Tahoe work had already identified existing donor `13.2.1-24`.

Classification:
`B9DF76_TAHOE_25_METAL_FRAMEWORK_SOURCE_13_2_1_25=PROVEN_MISSING`.

## D97BJ complete Tahoe functional delta
D97BJ starts from exact b9df76 and changes only three functional source files:
1. `opencore_legacy_patcher/support/metallib_handler.py`
2. `opencore_legacy_patcher/sys_patch/patchsets/detect.py`
3. `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`

Functional effects:
- host max Sequoia -> Tahoe;
- Tahoe `Metal.framework` donor -> existing `13.2.1-24`;
- Tahoe-only exact 25G82 metallib destination/source map generated from exact Pyquick `sys_patch_dict.py`;
- exact local host-build MetallibSupportPkg preferred before API fallback.

Exact Pyquick 25G82 patch dictionary SHA256:
`c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`.
Runtime map contained 182 metallib entries.

Prepackaging source validation PASS.

## D97BJ packaging/helper lane
Because current wxPython 4.3.1 resolved x86_64-only while exact b9df76 spec requested universal2, local PyInstaller initially failed in COLLECT. This was tooling/packaging only, not functional source failure.

Authorized packaging-only change for Intel ASUS2:
`OpenCore-Patcher-GUI.spec: target_arch="universal2" -> target_arch="x86_64"`.

D97BJ uses an intentionally built DEBUG privileged helper for the ad-hoc custom app only while that app is running, with the exact official Dortania helper bundled as a restore asset.
Pinned DEBUG helper SHA256 from preparation:
`a1b4189d01b3107c753a290491dfbca7dc5ba64b5279f71daf901aa74c9d7f87`.

Before any reboot after custom OCLP use, fully quit inner OCLP and verify that the installed system helper has been restored to exact official SHA256:
`9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`.

## D97BJ Tahoe 25G82 Root Patch — RUNTIME PASS
User executed the D97BJ Root Patch in Tahoe VESA.

Observed runtime sequence:
- exact local `26.6.2-25G82` metallib found and API skipped;
- Patcher capable of patching;
- Universal-Binaries.dmg mounted;
- preflight completed;
- `Metal 3802 Common` installed;
- `Metal 3802 Common Extended` installed with prior `13.2.1-25` blocker cleared;
- exact Tahoe `Metal 3802 .metallibs` map executed, including `VisionKitCore.framework`;
- Monterey GVA installed;
- Monterey OpenCL installed;
- Intel Haswell installed: Azul framebuffer, HD5000 graphics kext, GL/MTL/VA drivers, AppleIntelHSWVA;
- Modern Wireless Common installed;
- GPUCompiler libraries merged;
- patchset metadata written;
- RSR monitor and OCLP launchd plists installed;
- new Auxiliary Kernel Collection built;
- Auxiliary Kernel Collection usage forced;
- root volume unmounted;
- final `Patching complete`.

No traceback or Root Patch error is present.

Classifications:
- `D97BJ_TAHOE_25G82_ROOT_PATCH_PREFLIGHT=PASS`;
- `D97BJ_TAHOE_25G82_EXACT_LOCAL_METALLIB_RUNTIME=PASS`;
- `D97BJ_TAHOE_25G82_EXACT_METALLIB_MAP_RUNTIME=PASS`;
- `D97BJ_TAHOE_25G82_HASWELL_PATCHSET_RUNTIME=PASS`;
- `D97BJ_TAHOE_25G82_AUXKC_BUILD=PASS`;
- `D97BJ_TAHOE_25G82_ROOT_PATCH_EXECUTION=PASS`;
- `D97BJ_ACCELERATED_BOOT_RESULT=NOT_YET_TESTED`.

## Execution contract
GitHub Actions compilation remains suspended until user explicitly says quota reset/unblocked.
Current local Tahoe VESA build/test lane was explicitly authorized/executed by user.
Never auto Root Patch.
Never auto reboot.
Golden remains immutable/read-only.

## CURRENT ACTION
1. Fully quit the D97BJ inner OCLP so the outer wrapper cleanup runs.
2. Verify installed privileged helper SHA256 equals exact official:
   `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`.
3. Only after helper restore PASS, reboot manually into the normal accelerated/root-patched Tahoe configuration.
4. If accelerated boot has no usable image/GUI, hard restart/power-cycle and boot the established VESA recovery configuration.
5. Return from VESA and analyze only the immediately preceding accelerated diagnostic boot under `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

Root Patch is now runtime PASS. Accelerated GUI is the next unresolved boundary.
