# OCLP MASTER CONTINUITY

Updated: 2026-09-05 EEST

Permanent consolidated database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260905_D97BJ_ACCELERATED_BOOT_KERNEL_PANIC_TWICE_SNAPSHOT_RESTORED_EVIDENCE_COLLECTION_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md` and `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.

## Mandatory startup
Before any technical modification, read the permanent database, permanent working rules, this MASTER, permanent VESA rule, the exact current checkpoint above, and retrospective/history when strategic context is needed.

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
- Team ID `S74BDJXQMD`.

Official privileged helper reference SHA256:
`9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`.

## Durable Golden causal/producer evidence
Retain accepted causal chain:
`MTLCompilerService failure -> XPC_ERROR_CONNECTION_INTERRUPTED -> pipeline creation failure -> SkyLight/CopyPipelineState abort -> WindowServer death`.

Accepted historical five-functional diagnostic baseline:
`P1 + P2b + P3 + AIR00 + D34`.
P6/P7 insufficient; D50/D68/D82 reserve; D84 retired; D36-D44 invalidated for D34 cave overlap.

Golden request-builder closure:
- primary builder `0x7FF80D370756..0x7FF80D370C28`;
- RBX = arg1/RDI; signed dword `[RBX+0x20] -> llvmVersion`;
- R13 = arg2/RSI; `[R13+0x08] -> requestType`, `[R13+0x18] -> timeout`, `[R13+0x70]` sandbox gate;
- alternate requestType immediate `9`.

These userspace/compiler results remain durable but are not assumed reachable in the newest D97BJ accelerated boot because that boot now fails earlier with kernel panic.

## Exact b9df76 Tahoe findings
Exact b9df76 originally had `_max_os = os_data.sequoia.value`; Tahoe is Darwin 25. Haswell itself is still patchable on Darwin 25: its historical native-OS blocker does not apply to exact b9df76.

D97BG proved host-gate bypass alone was insufficient. D97BH proved exact local MetallibSupportPkg `26.6.2-25G82` is accepted. D97BI proved exact b9df76 requests nonexistent `13.2.1-25/Metal.framework` on Darwin 25; existing donor is `13.2.1-24`.

Exact target Metallib package:
- `MetallibSupportPkg-26.6.2-25G82.pkg`;
- bytes `116574513`;
- SHA256 `602c66b6a558edf81fc71474441fff54a9cdc2f616a91d44b0557a8a12beaea3`.

Exact Pyquick 25G82 patch dictionary SHA256:
`c05a083e5614f07cf4befaa466b64a69d7d1b6518a3c36d18884a17e003d890e`.

## D97BJ complete Tahoe functional delta
D97BJ starts from exact b9df76 and changes only three functional source files:
1. `opencore_legacy_patcher/support/metallib_handler.py`
2. `opencore_legacy_patcher/sys_patch/patchsets/detect.py`
3. `opencore_legacy_patcher/sys_patch/patchsets/shared_patches/metal_3802.py`

Functional effects:
- host max Sequoia -> Tahoe;
- Tahoe `Metal.framework` donor -> `13.2.1-24`;
- Tahoe-only exact 25G82 metallib destination/source map generated from exact Pyquick dictionary (182 entries);
- prefer exact local host-build MetallibSupportPkg before remote API.

Packaging-only correction for Intel ASUS2:
`OpenCore-Patcher-GUI.spec target_arch="universal2" -> "x86_64"` because current wxPython wheel is x86_64-only.

Pinned DEBUG helper used for custom ad-hoc D97BJ app:
`a1b4189d01b3107c753a290491dfbca7dc5ba64b5279f71daf901aa74c9d7f87`.

## D97BJ Tahoe 25G82 Root Patch — RUNTIME PASS
User executed D97BJ Root Patch in Tahoe VESA. Runtime proved:
- exact local `26.6.2-25G82` metallib found and API skipped;
- Patcher capable;
- Universal-Binaries mounted;
- preflight completed;
- Metal 3802 Common + Extended installed with prior `13.2.1-25` blocker cleared;
- exact Tahoe 25G82 metallib map executed including `VisionKitCore.framework`;
- Monterey GVA installed;
- Monterey OpenCL installed;
- Intel Haswell installed: AppleIntelFramebufferAzul, AppleIntelHD5000Graphics, GL/MTL/VA drivers, AppleIntelHSWVA;
- Modern Wireless Common installed;
- GPUCompiler libraries merged;
- patch metadata/RSR/OCLP launchd files installed;
- new Auxiliary Kernel Collection built and forced;
- root volume unmounted;
- final `Patching complete` with no traceback.

Classifications:
- `D97BJ_TAHOE_25G82_ROOT_PATCH_PREFLIGHT=PASS`;
- `D97BJ_TAHOE_25G82_EXACT_LOCAL_METALLIB_RUNTIME=PASS`;
- `D97BJ_TAHOE_25G82_EXACT_METALLIB_MAP_RUNTIME=PASS`;
- `D97BJ_TAHOE_25G82_HASWELL_PATCHSET_RUNTIME=PASS`;
- `D97BJ_TAHOE_25G82_AUXKC_BUILD=PASS`;
- `D97BJ_TAHOE_25G82_ROOT_PATCH_EXECUTION=PASS`.

## D97BJ helper cleanup — PASS before accelerated boot
Automatic wrapper cleanup left the DEBUG helper installed after app exit. Before reboot this was detected and corrected manually.

Verified official restore source:
`/Applications/OpenCore-Patcher.app/Contents/Resources/official-privileged-helper`

Final installed helper before accelerated boot:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- TeamIdentifier `S74BDJXQMD`;
- `OFFICIAL_HELPER_RESTORED=PASS`.

Thus the helper state is not an unresolved pre-boot confounder.

## D97BJ accelerated boot — NEW KERNEL-PANIC FRONTIER
User manually performed the accelerated/root-patched Tahoe boot after all pre-boot gates passed.

User-observed behavior:
- did not reach the historical black-screen / later-VESA behavior;
- hit a kernel panic and automatically restarted;
- user reports approximately two accelerated attempts followed by VESA/recovery boots; exact boot chronology must be confirmed from `last reboot` and panic timestamps;
- after VESA recovery, patched boot was not usable, so the user restored the saved/sealed system snapshot;
- current state is VESA/recovery with **no Root Patch**.

The snapshot restore is recovery, not evidence against the preceding accelerated panic.

Current classifications:
- `D97BJ_TAHOE_25G82_ROOT_PATCH_EXECUTION=PASS` remains valid;
- `D97BJ_ACCELERATED_BOOT_USABLE_GUI=NEGATIVE`;
- `D97BJ_ACCELERATED_BOOT_KERNEL_PANIC_RESTART=USER_OBSERVED_PROVEN`;
- `D97BJ_ACCELERATED_BOOT_PANIC_ROOT_CAUSE=UNKNOWN_PENDING_LOCAL_EVIDENCE`;
- `D97BJ_CURRENT_ROOT_PATCH_STATE=RESTORED_TO_UNPATCHED_SNAPSHOT`.

Do NOT attribute the older 03:31/03:35 crash captures to this D97BJ incident: they predate the accelerated attempts and do not contain a matching panic/kext record.

## High-value current hypotheses — not yet proven
1. Haswell kext/AuxKC load/start/match boundary (`AppleIntelFramebufferAzul` / `AppleIntelHD5000Graphics`). Historical Tahoe D26 evidence once showed transient `Info.plist digest is missing` / kernelmanager rejection for these exact staged kexts, making this a high-value comparison point. D97BJ AuxKC build success means the historical digest failure is not by itself proof of current cause.
2. AMFI / kernel-collection validation boundary.
3. Graphics kext initialization / IOGraphics boundary.
4. Only if evidence proves userspace reached: historical MTLCompilerService/WindowServer path.

A public current MacBookPro11,1 / Tahoe 26.6.2 boot-failure report exists, but it has no panic log and therefore is contextual only, not causal evidence for ASUS2.

## Execution contract
GitHub Actions compilation remains suspended until user explicitly says quota reset/unblocked.
Current local Tahoe VESA build/test lane was explicitly authorized/executed by user.
Never auto Root Patch.
Never auto reboot.
Golden remains immutable/read-only.

## CURRENT ACTION
Remain in current unpatched VESA/recovery state. **No new Root Patch and no accelerated reboot.**

Run one read-only D97BJ panic-evidence collection and return its ZIP. It must collect:
1. `last reboot` / shutdown chronology;
2. NVRAM panic keys (`aapl,panic-info`) and current boot/OCLP args only;
3. current-day panic/kernel DiagnosticReports around the post-05:00 accelerated attempts, including protected PanicReporter paths;
4. filtered unified logs for panic, Previous shutdown cause, watchdog, kernel collection/AuxKC, kernelmanager, Haswell graphics kext load/start/match, AMFI and IOGraphics;
5. current unpatched/VESA baseline and snapshot state.

After evidence return:
- identify the two accelerated boot windows exactly;
- analyze only those accelerated windows, excluding later VESA/recovery and snapshot-restore activity;
- if panic report names a kext/backtrace, promote that module boundary immediately;
- do not resume MTLCompilerService/WindowServer diagnostics unless evidence proves that userspace stage was reached;
- design any future test to maximize evidence per unavoidable Root Patch/recovery cycle, ideally with persistent/boot-visible panic capture rather than repeated single-point probes.
