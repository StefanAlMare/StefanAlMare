# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260903_D97AF_ROOT_PATCH_INVALID_PACKAGED_OS_LISTXATTR_FIX_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
Updated: 2026-09-03 EEST

## Mandatory startup
Before any technical change read in full:
1. `OCLP_PERMANENT_WORKING_RULES.md`;
2. this MASTER;
3. `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`;
4. the exact checkpoint named above;
5. `OCLP_PROJECT_RETROSPECTIVE_20260827.md`;
6. `OCLP_HISTORY_INDEX.md`.

## Permanent contract
Target Tahoe `26.6.2 / 25G82`, Haswell HD4600/4400 family, SMBIOS `MacBookAir6,2`. Local OCLP branch `alex-tahoe-25G82-custom`, expected HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`. Golden root-patched MTLCompiler SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`, immutable/read-only. True-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`.

Protocol now defaults to short, visible, explained ASUS2 collaboration with one bounded action and STOP gate at a time. GitHub is used only for a substantial compilation/build/package job when it is clearly faster than waiting through that job with the user; technical possibility alone is not sufficient. Substantial GitHub builds remain assistant-run and fully audited. Hardware, installed-state, accelerated-boot and VESA evidence remain ASUS2-only. Never auto Root Patch or reboot. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized.

Interaction chain: `short explained ASUS2 action -> user result -> assistant audit -> next bounded action`; only a substantial clearly faster compile/build inserts `assistant GitHub build/audit -> identity-pinned ASUS2 deploy` before the normal Root Patch/accelerated-boot/VESA sequence.

Architecture: `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working donor path -> image`.

## Accepted functional lineage
P1 selector -> P2b request layout -> P3 serialized bitcode -> AIR00 AIR2.6/Metal3.1 -> D34 semantic-equivalent reset. P6/P7 retained with runtime sufficiency NEGATIVE.

## Durable D97 facts
D97AA proved runtime 32023 selection for an earlier cohort. D97AC statically mapped finite outcomes in `validSimulatorMetadata`. D97AD exact transition produced selector-only service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` and final MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`.

Private D97AD build/deploy and manual Root Patch passed exactly. Selected accelerated boot is `2026-09-02 00:10`; VESA recovery `00:12` excluded.

D97AEQ verified exact visible D97AD bytes but found 28/28 service PIDs terminating normally with `exit(1)`, zero signals/missing and zero classifier exits 110–114. Runtime outcome classification is INVALID; natural exit1 is RUNTIME PROVEN 28/28.

D97AER proved the visible 32023 late simulator-limit xrefs lie after the visible D97AD candidate terminal REL+`0x58B`.

D97AES proved all 33 simulator diagnostics across all 28 PIDs were sent by MTLCompiler path `Versions/32023/MTLCompiler` with UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`; 3802 is NEGATIVE for the cohort.

D97AET found only historical sender/backtrace offsets `0x9FFEE` and `0xA5F81`, both outside the validator, so archived backtrace does not directly prove traversal beyond the visible terminal. It also proved the x86_64h Cryptex dyld shared cache contains the 32023 image path and not the 3802 path. Cache execution remains UNKNOWN.

Candidate discriminator at image offset `0x9D6BD`: P7/pre-D97AD `8b8d10feffff83f941`; D97AD `6a6e5fe9bb38f6ff90`.

## D97AEU tooling failure / cache topology
D97AEU discovered main x86_64h cache plus `.01`–`.06` subcaches. Each parseable subcache replicates the same `imagesText` table. The target 32023 path appeared seven times with identical logical identity: cache-table UUID `D2265480-60EB-3526-BAF7-2D6596149186`, load `0x7FFD03141000`, text size `0xCE239`, same path. The load address lies in the `.05` executable mapping.

D97AEU stopped at raw-hit cardinality `7` before reading any discriminator bytes. This is TOOLING FALSE FAILURE; no byte conclusion is permitted from that run.

## D97AEW corrected cache interpretation
D97AEW, D97AEV and the corrected D97AEU core completed with internal RC `0`. Wrapper/blob/SHA, scanner-only correction, all three D97AEV transforms, retained anchors, zsh parsing and embedded Python compilation passed exactly.

The seven replicated `imagesText` records deduplicate to one cached 32023 image: UUID `D2265480-60EB-3526-BAF7-2D6596149186`, load `0x7FFD03141000`, text size `0xCE239`, executable bytes in subcache `.05`. The physical `.05` address-to-file translation and byte reads are valid.

Apple dyld copies `imagesText.uuid` from the selected input Mach-O slice and preserves that slice's `LC_UUID`; D226 is therefore `CACHE_INPUT_SLICE_UUID`, not a cache-optimization UUID derived from D5CE. Direct transplantation of D5CE filesystem offsets into D226 is cross-lineage and unsupported. Consequently the observed `PRE=0|POST=0|OTHER=6`, OTHER stub, retained `0/16` and differing sender windows are valid physical reads at those numerical D226 offsets, but are not semantic classifications of the corresponding D226 functions. Authoritative status: `CACHE_PHYSICAL_BYTE_READ=VALID`, `CROSS_IMAGE_SITE_CORRELATION=NOT_ESTABLISHED`, `D97AD_CACHE_PATCH_DISCRIMINATOR=INCONCLUSIVE`.

The official OCLP 1.3.0 -> PatcherSupportPkg 1.4.6 donor is 14.2 Beta 1 MTLCompiler 32023 with exact UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`. The public dsce implementations bracketing internal version 8 mark only the first four UUID bytes as `D5 CE 00 <version>` and preserve the final twelve; the exact internal v8 source is not public. Exact 2023 release provenance independently establishes that this donor is not the current Tahoe D226 input, while the different retained UUID tails corroborate the separate lineage under the documented algorithm.

D97AES runtime evidence is now classified precisely: all 33 simulator diagnostics across 28/28 PIDs identify the immediate sender DSO as 32023/D5CE. Apple logging obtains the sender UUID from the loaded sender Mach-O header, and dsce created D5CE specifically for log visibility. Therefore `RUNTIME_DIAGNOSTIC_SENDER_D5CE_DSCE_32023=PROVEN` and `RUNTIME_DIAGNOSTIC_SENDER_CURRENT_D226_CACHE=NEGATIVE` for that diagnostic cohort. This does not exclude D226 elsewhere in those processes and does not prove the exact current D97AD SHA/postimage bytes in memory, because the known P7-to-D97AD transform lineage preserves the same D5CE LC_UUID. `RUNTIME_EXACT_CURRENT_D97AD_TEXT_BYTES=UNKNOWN`.

During D97AEW and the D97AES evidence reclassification, no source/system/Golden/service/Root Patch/reboot mutation occurred. The previous semantic-D226 mapper frontier is superseded and moved to reserve-only static cross-build research.

## D97AEZ accelerated natural-PID result / external method retired
D97AEZ was activated in VESA UUID `C57F4AEF-B109-463A-940A-AC10B1F7A02A`, claimed the user-identified accelerated boot UUID `0FCD86FE-6A94-450C-A250-45B6A8255A82`, and was extracted after VESA recovery UUID `7BC61319-78D8-46C5-A084-65C40B7F0941`. All pre/post runner/helper/plist/service/target identity gates passed; visible service SHA remained `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` and visible D97AD SHA remained `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`.

The passive no-PID watcher caught natural exact-path MTLCompilerService PID `434`, then `task_read_for_pid` returned `-1`, `errno=1` before any runtime byte window was read. It stopped fail-closed with RC `2`; watchdog did not fire. Authoritative result: natural PID observation PROVEN, external task-port access DENIED/UNAVAILABLE, runtime D97AD window bytes `0`, exact runtime D97AD text `UNKNOWN`. This is not a byte mismatch. The D97AEX/D97AEZ external method is retired; no LLDB/SIP/AMFI bypass continuation is authorized.

The observer is proven disabled. The user directed deletion of its active/quarantined ASUS2 artifacts; deletion result has not yet been returned and must remain `REQUESTED_RESULT_NOT_YET_RETURNED`. Historical evidence is retained.

The first bounded discovery proved installed app SHA `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0`, `6587056` bytes, and found no source only within its searched locations. A later targeted ASUS2 search superseded that scope-limited negative and proved the local D97AD source exists at canonical path `/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82`. The alternative `/Volumes/AsusLaptop/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82` resolves to the same helper file identity `16777225:61074310:497704`, not an independent source copy; `TWO_PATHS_SAME_HELPERS=PASS`.

The local repository is branch `alex-tahoe-25G82-custom`, HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`, with exactly three reported tracked modifications: `metal_3802.py`, `sys_patch.py` and `sys_patch_helpers.py`. The D97AD function definition occurs exactly once. Immediately before D97AF integration, the three input SHA256 identities were respectively `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`, `115153b0465102cba0fdd477cc6215c4531e50b2927a99c1c64d12325c64d948` and `fd37ede683ccb0612a7ba77ffe82b80bb8e081f4192f7485d05cdf8f9b51f515`. Their current post-D97AF identities are recorded below. The private commit `1faab13865eb945198f3551688f11f1ba645e29a` remains historical D97AD build provenance; local source acquisition is no longer required.

## D97AF frozen LC_UUID / exact static transform
The returned local input package SHA256 is `19c1b9dc34ede0533c3a7e6a7af9b00f2dcfd732cce9da6e47cdad6e93a06c41`, `673209` bytes. It contains the exact D97AD binary plus the three authoritative modified source inputs and their diff.

The user generated and persisted the frozen D97AF UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`. Against exact D97AD SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`, replacing only the 16-byte `LC_UUID` payload at `0xAB0..0xABF` deterministically yields expected SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`. No executable instruction, D34 byte, retained functional patch or D97AD classifier site changes.

The stamp can prove D97AF marker-build provenance only for a covered diagnostic-sender cohort. It is not a direct runtime text read and does not prove every runtime D97AD instruction byte. At the local-integrator checkpoint only a temporary audit postimage existed; that historical build state is now superseded by the exact GitHub build, external artifact audit and live application deployment below.

The final local source-only integrator `OCLP7_D97AF_LOCAL_LC_UUID_SOURCE_INTEGRATOR.command` is independently audited `DELIVERY_PASS`: SHA256 `3554473851eec1f315e558694bcd4c0bc321629efaebdf27c679167ec9477682`, git blob `ce6d626d3352d5d7c6bd0212a8c3e79c05d88308`, `62980` bytes.

The ASUS2 live run completed with outer RC `0`, transactional backup PASS, immediate CAS PASS, report capture PASS and exact source integration PASS. Exact live post-source identities are helpers SHA256 `a240a3cb62ce25381ef6bd9e2d78e36dc379c25f9e9c5641e07cd9841e820d8e`, sys_patch SHA256 `ccf5ad96de9ef9051cc30ac61bf3c24522628f5e26122d6c0af5abb352f777c9`, unchanged metal_3802 SHA256 `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`, unchanged D97AD method SHA256 `bb66b1d5d883251431d5a7fa7bc42c0cc9bcb15ec77c74506bb2eae5bf987a12`, and D97AF method SHA256 `d48d6daec4affdcd9469bf2bb60ddadddb5dc43cebbdfeb6051336a0766ee7b7`. `D97AF_LOCAL_SOURCE_INTEGRATION=PROVEN_PASS`.

The substantial Intel GitHub build completed on private head `76d45e6d4f37ad394a9f30a61c8bfc97dc587c4e`, workflow `348814365`, run `33686570072`, job `100435354962`, runner `macos-15-intel / x86_64`. Exact snapshot reconstruction, two-file transition, compile/AST/order and packaged PyInstaller semantic audit all passed. D97AD remained unchanged; D97AF is packaged exactly once; retired helpers are absent. The packaged executable SHA256 is `ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470`; inner app ZIP SHA256 is `728dd30d7a4483bc7318300f3911e8aae8590f0d9ff59afbcf7db66651d8e907`.

Original artifact `9868515225` is `751567689` bytes with GitHub digest `70a123bfad81e00072ed2691fc769fa81c25f07c48a2ddb39a092d06d1947d9b`. Because that exceeds the connector ceiling, audited split workflow `ecda263f8e986e3ed8713c19c6f6e06c38ca32b459f3985eebf1830515cb3f04`, run `33688046460`, divided the exact existing artifact into two lossless parts without rebuild. Both wrapper artifacts were externally downloaded; wrapper hashes, per-part hashes, exact reassembly, outer digest/size, complete inner SHA records, app ZIP CRC, reports and the single x86_64 executable all passed independently. Signing/notarization validation was skipped by the build and is not classified PASS.

The exact ASUS2 deploy/open/STOP wrapper is independently static-audited and ordinary-fault-tested: `OCLP7_D97AF_EXACT_GITHUB_ARTIFACT_AUDIT_DEPLOY.command`, SHA256 `e82a5748abd09684a88932380d98d4ae8d83e0bfea94c462866080cfe7b535b4`, git blob `02b4a322eaabb1eff0c3a14089a9ce6508882bc6`, `26914` bytes. It fails closed before mutation on every artifact/preimage discrepancy, creates and re-verifies a recoverable exact-D97AD backup, deploys and re-verifies only exact x86_64 D97AF, opens OCLP and stops. Its state-aware recovery protects ordinary command errors and caught HUP/INT/TERM; the short two-rename interval is not claimed crash-atomic against SIGKILL/kernel crash/power loss.

The live ASUS2 invocation completed with outer RC `0`. All run/job/artifact/outer/inner/SHA/report/staged-app gates passed. Exact D97AD preimage SHA256 `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0` was moved to recoverable backup `/Applications/OpenCore-Patcher.app.D97AD-before-D97AF-20260903-013623`. Live `/Applications/OpenCore-Patcher.app` is now exact D97AF x86_64, `6595600` bytes, SHA256 `ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470`; fresh exact-path PID `3678` was proven. `D97AF_APP_DEPLOY=PROVEN_PASS`. Source, system target, root-patched snapshot, Golden, Root Patch and reboot were not modified by deployment.

The next returned OCLP operation was the unpatch of the previously active root-patched snapshot. OCLP found exact local metallib `26.6.2-25G82`, reported APFS snapshot revert, removal of old Skylight plugins and Auxiliary Kernel Collection cleanup of `AppleIntelFramebufferAzul.kext` plus `AppleIntelHD5000Graphics.kext`, then ended `Unpatching complete` with reboot required. At that checkpoint, activation reboot was not yet run. No separate reboot/VESA return or clean-state/application-identity audit was subsequently returned before the manual D97AF Root Patch log, so `LEGACY_UNPATCH_ACTIVATION_REBOOT=NOT_SEPARATELY_PROVEN`.

The complete D97AF Root Patch log has SHA256 `b1a263a7bddadbbf46ad8c10abcbfb82043edb17a5c15a21637de6ecae0a24a1`, git blob `b22c777844a2253a8e7fafab851acd86149b9067`, `26879` bytes and `731` logical lines. P1, P2b, P3, AIR00, D34, retained P6/P7 and D97AD all reported exact PASS; D97AD committed exact SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. D97AF then failed with `AttributeError: module 'os' has no attribute 'listxattr'` in `_xattrs` called by `_target_metadata`.

Source ordering proves this exception occurred during the initial D97AF metadata gate, at xattr enumeration, before target data-fork read, in-memory UUID transform, temporary file, destination sibling or atomic rename. Therefore `D97AF_METHOD_TARGET_MUTATION=NOT_REACHED`. OCLP caught the exception and nevertheless continued to patchset records, Auxiliary Kernel Collection handling and APFS snapshot creation, then printed the generic `Patching complete`. That message is not a D97AF PASS. `D97AF_ROOT_PATCH=INVALID_PARTIAL`; the new inactive snapshot is not authorized for reboot and its exact final MTLCompiler identity remains unread. The last proven live D97AF app identity remains SHA256 `ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470`, but the invocation app identity was not separately rechecked after the unpatch output. The deployed D97AF method is runtime-incompatible and must be replaced by a corrected, packaged-runtime-tested build before any further Root Patch attempt.

## CURRENT ACTION — correct packaged-runtime metadata path; no reboot
STOP in the current running session. Do not reboot into the partial snapshot and do not run Root Patch again from the current D97AF application.

The next engineering action is a minimal D97AF source correction that preserves exact xattrs without depending on absent PyInstaller `os.listxattr`, followed by compile/diff, a substantial Intel build, an executable packaged-runtime capability test, full artifact/app audit, exact backup/deploy and OCLP open/STOP. Only after that corrected application is proven will a separately authorized recovery/unpatch sequence and a later manual Root Patch be selected. Baseline remains P1+P2b+P3+AIR00+D34; Golden immutable/read-only; D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ remains retired.
