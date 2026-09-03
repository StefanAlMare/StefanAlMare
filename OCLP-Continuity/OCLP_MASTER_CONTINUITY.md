# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260903_D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT_PASS_DEPLOY_NEXT.md`
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

Protocol now defaults to short, visible, explained ASUS2 collaboration with one bounded action and STOP gate at a time. Routine tests, ordinary validations, source inspection, small edits, probes, diff checks and diagnostic iteration stay on ASUS2 under user control. GitHub is reserved only for major/substantial compilation, build or packaging workloads. Substantial GitHub builds remain assistant-run and fully audited. Existing audited artifact-delivery mechanisms are reused to bring those build outputs to ASUS2. Hardware, installed-state, accelerated-boot and VESA evidence remain ASUS2-only. Never auto Root Patch or reboot. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized.

Interaction chain: `short explained ASUS2 action -> user result -> assistant audit -> next bounded action`; only a major/substantial compile/build inserts `assistant GitHub compile/build/package -> artifact delivery -> ASUS2 audit/test/deploy` before the normal Root Patch/accelerated-boot/VESA sequence.

Architecture: `Tahoe producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working donor path -> image`.

## Accepted functional lineage
P1 selector -> P2b request layout -> P3 serialized bitcode -> AIR00 AIR2.6/Metal3.1 -> D34 semantic-equivalent reset. P6/P7 retained with runtime sufficiency NEGATIVE.

## Durable D97 facts
D97AA proved runtime 32023 selection for an earlier cohort. D97AC statically mapped finite outcomes in `validSimulatorMetadata`. D97AD exact transition produced selector-only service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` and final MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`.

Private D97AD build/deploy and manual Root Patch passed exactly. Selected accelerated boot is `2026-09-02 00:10`; VESA recovery `00:12` excluded.

D97AEQ verified exact visible D97AD bytes but found 28/28 service PIDs terminating normally with `exit(1)`, zero signals/missing and zero classifier exits 110–114. Runtime outcome classification is INVALID; natural exit1 is RUNTIME PROVEN 28/28.

D97AER proved the visible 32023 late simulator-limit xrefs lie after the visible D97AD candidate terminal REL+`0x58B`.

D97AES proved all 33 simulator diagnostics across all 28 PIDs were sent by MTLCompiler path `Versions/32023/MTLCompiler` with UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`; 3802 is NEGATIVE for the cohort.

D97AET found only historical sender/backtrace offsets `0x9FFEE` and `0xA5F81`, both outside the validator, so archived backtrace does not directly prove traversal beyond the visible terminal. It also proved the x86_64h Cryptex dyld shared cache contains the 32023 image path and not 3802; cache execution remains UNKNOWN.

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

The user generated and persisted D97AF UUID `A4F456DF-7447-49BF-AC4F-102D90023A1E`. Independent recomputation against D97AD SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755` proved that changing only all 16 bytes of the `LC_UUID` payload at `0xAB0..0xABF` yields deterministic expected SHA256 `a0e78b297add5a4f76cf5ef71ce81a24750a6769167b225fc2f3a9248ba81c1e`. Executable instructions, D34, retained functional patches and D97AD classifier sites remain unchanged.

This stamp can establish marker-build provenance only for the diagnostic-sender cohort actually covered by future Unified Logs. It is not a direct runtime text-byte read and does not prove all runtime D97AD bytes. The D97AEX/D97AEZ external task-port method remains retired.

## D97AF local source integrator audited / ready
Final delivery identity is `OCLP7_D97AF_LOCAL_LC_UUID_SOURCE_INTEGRATOR.command`, SHA256 `3554473851eec1f315e558694bcd4c0bc321629efaebdf27c679167ec9477682`, git blob `ce6d626d3352d5d7c6bd0212a8c3e79c05d88308`, `62980` bytes. Independent syntax, embedded compile, static transform/AST/order, transaction/CAS/metadata/report and bounded fault-injection audit is `DELIVERY_PASS`.

Expected post-source identities are helpers `a240a3cb62ce25381ef6bd9e2d78e36dc379c25f9e9c5641e07cd9841e820d8e`, sys_patch `ccf5ad96de9ef9051cc30ac61bf3c24522628f5e26122d6c0af5abb352f777c9`, unchanged metal_3802 `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`, and D97AF method `d48d6daec4affdcd9469bf2bb60ddadddb5dc43cebbdfeb6051336a0766ee7b7`. At that audited-ready checkpoint ASUS2 execution was `NOT_RUN`; no source/app/system/Root Patch/reboot mutation was claimed at that stage.

## D97AF local source integration live PASS
The first live integrator invocation stopped fail-closed before mutation because the UUID file was absent. The frozen UUID file was recreated with the already-authoritative value; no replacement UUID was generated. The second exact wrapper invocation completed with RC `0` and report capture PASS.

Live post-source identities equal the audited expected outputs exactly: helpers `a240a3cb62ce25381ef6bd9e2d78e36dc379c25f9e9c5641e07cd9841e820d8e`, sys_patch `ccf5ad96de9ef9051cc30ac61bf3c24522628f5e26122d6c0af5abb352f777c9`, unchanged metal_3802 `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`, unchanged D97AD method `bb66b1d5d883251431d5a7fa7bc42c0cc9bcb15ec77c74506bb2eae5bf987a12`, and D97AF method `d48d6daec4affdcd9469bf2bb60ddadddb5dc43cebbdfeb6051336a0766ee7b7`. Transactional backup, AST/order and exact two-file integration passed. No app/system/Root Patch/reboot mutation occurred.

## D97AF GitHub build and external byte audit PASS
The substantial build completed on private head `76d45e6d4f37ad394a9f30a61c8bfc97dc587c4e`, workflow/run/job `348814365 / 33686570072 / 100435354962`, `macos-15-intel / x86_64`. Exact D97AD snapshot reconstruction, two-file D97AF transition, compile/AST/order and packaged PyInstaller audit passed. D97AD remained unchanged, D97AF occurs once, retired helpers are absent, and the packaged executable is x86_64 with SHA256 `ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470`. Inner app ZIP SHA256 is `728dd30d7a4483bc7318300f3911e8aae8590f0d9ff59afbcf7db66651d8e907`.

Original artifact `9868515225` is `751567689` bytes with GitHub digest `70a123bfad81e00072ed2691fc769fa81c25f07c48a2ddb39a092d06d1947d9b`. The connector's `536870912`-byte ceiling required a no-rebuild byte split. Audited split workflow/run `ecda263f8e986e3ed8713c19c6f6e06c38ca32b459f3985eebf1830515cb3f04 / 33688046460` verified the original archive, split and pre-upload reassembly. Both resulting wrappers were independently downloaded. Their hashes, the two exact part hashes, full outer reassembly/digest/size, all inner SHA records, app ZIP CRC, reports and single packaged executable identity passed. Signing/notarization validation was skipped and is not classified PASS. No ASUS2 app/system/Root Patch/reboot mutation occurred.

## D97AF deploy FASTLANE audited / ready
Exact wrapper `OCLP7_D97AF_EXACT_GITHUB_ARTIFACT_AUDIT_DEPLOY.command`, SHA256 `e82a5748abd09684a88932380d98d4ae8d83e0bfea94c462866080cfe7b535b4`, git blob `02b4a322eaabb1eff0c3a14089a9ce6508882bc6`, `26914` bytes, passed zsh parse, all three embedded Python compiles, independent pinning/archive/path audits and ordinary error/signal fault matrices.

Before `/Applications` mutation it re-verifies the exact private run/job/artifact, outer and inner ZIPs, full SHA records, unique x86_64 packaged executable and exact installed D97AD preimage. It prepares and re-verifies D97AF beside live, drains the exact old OCLP path, moves D97AD to a re-verified timestamped backup, performs a second gap census, installs/re-verifies exact D97AF, opens it and stops. EXIT/HUP/INT/TERM recovery removes owned staging or restores exact D97AD during ordinary failures. The two-rename interval is not represented as crash-atomic against SIGKILL/kernel crash/power loss. At that audited-ready checkpoint deployment was `NOT_STARTED`; the live result below supersedes that execution state.

## D97AF live app deployment PASS
The exact public delivery from commit `15c1a141cb362a03c1e63d8bfbb8dac72b693d0e` ran on ASUS2 with wrapper blob `02b4a322eaabb1eff0c3a14089a9ce6508882bc6`, SHA256 `e82a5748abd09684a88932380d98d4ae8d83e0bfea94c462866080cfe7b535b4`, `26914` bytes and outer RC `0`.

All 16 build job steps, exact `751567689`-byte artifact SHA256 `70a123bfad81e00072ed2691fc769fa81c25f07c48a2ddb39a092d06d1947d9b`, eight-member outer archive, complete SHA records, inner app ZIP SHA256 `728dd30d7a4483bc7318300f3911e8aae8590f0d9ff59afbcf7db66651d8e907`, reports and staged executable passed again on ASUS2. Exact live D97AD preimage SHA256 `5a214ab2a3dc28b70b0443b583a1c7999adf04a3647dbe29e85165f1b7a795b0` passed and is preserved at `/Applications/OpenCore-Patcher.app.D97AD-before-D97AF-20260903-013623`.

Both old-process censuses were empty. Live `/Applications/OpenCore-Patcher.app` is now exact D97AF x86_64, `6595600` bytes, SHA256 `ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470`; fresh exact-path PID `3678` passed. `D97AF_EXACT_GITHUB_ARTIFACT_AUDIT_DEPLOY=PASS` and `INSTALLED_APP_MUTATION_STATE=D97AF_DEPLOYED_EXACT`. No source/system target/Golden/Root Patch/reboot mutation occurred.

## Legacy Root Patch unpatch PASS
The next manual OCLP operation entered `Starting Unpatch Process`. It found exact local metallib `26.6.2-25G82`, skipped API fallback, completed the APFS snapshot revert, removed old Skylight plugins, and removed `AppleIntelFramebufferAzul.kext` plus `AppleIntelHD5000Graphics.kext` while cleaning the Auxiliary Kernel Collection. It ended `Unpatching complete` and explicitly requires reboot for the changes to take effect.

Classification at that checkpoint: `LEGACY_ROOT_PATCH_UNPATCH=OCLP_REPORTED_PASS_PENDING_REBOOT`, `SYSTEM_SNAPSHOT_MUTATION=YES_BY_MANUAL_UNPATCH`, `UNPATCH_ACTIVATION_REBOOT=NOT_YET_RUN`, `D97AF_ROOT_PATCH=NOT_STARTED`. The clean post-reboot state was not independently proven. This output was not a D97AF Root Patch result. Exact D97AF remained the last proven live application and exact D97AD remained in its timestamped backup.

## D97AF Root Patch invalid — packaged `os.listxattr` unavailable
The next returned evidence is a complete manual Root Patch log. No separate reboot/VESA return or clean-state/application-identity audit was returned between the unpatch output and this log; `LEGACY_UNPATCH_ACTIVATION_REBOOT=NOT_SEPARATELY_PROVEN`. The Root Patch log is SHA256 `b1a263a7bddadbbf46ad8c10abcbfb82043edb17a5c15a21637de6ecae0a24a1`, git blob `b22c777844a2253a8e7fafab851acd86149b9067`, `26879` bytes and `731` logical lines.

P1, P2b, P3, AIR00, D34, P6, P7 and D97AD all reported PASS, with D97AD committed SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. The D97AF method then raised `AttributeError: module 'os' has no attribute 'listxattr'` at `_xattrs` through `_target_metadata`. Exact source ordering proves the failure preceded every D97AF target byte read or write, temporary file, sibling reservation and rename; `D97AF_METHOD_TARGET_MUTATION=NOT_REACHED`.

OCLP caught the error, continued through patchset information, Auxiliary Kernel Collection handling and APFS snapshot creation, and printed generic `Patching complete`. This generic terminal message does not override the explicit custom-step exception. Classification: `D97AF_ROOT_PATCH=INVALID_PARTIAL`, `D97AF_LC_UUID_BUILD_STAMP=FAILED_NOT_APPLIED`, `POST_SNAPSHOT_MTL_IDENTITY=NOT_YET_READ`, `LAST_PROVEN_D97AF_APP_SHA256=ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470`, `ROOT_PATCH_INVOCATION_APP_IDENTITY=NOT_SEPARATELY_RECHECKED`, `REBOOT=NOT_AUTHORIZED`.

## D97AG Tahoe xattr backend and local source integration PASS
D97AG corrects the exact D97AF packaged-runtime incompatibility without changing D97AD or the patch target contract. The `_xattrs` helper now invokes `/usr/bin/xattr -s` for names and `/usr/bin/xattr -s -p -x` for exact binary values, with fail-closed framing, cardinality, stderr, exit and hex validation. The shared Metal-chain catch now unmounts best-effort and bare re-raises, placing every later patchset-write, AuxKC and snapshot action beyond the failure boundary.

A first pinned launcher correctly completed its temporary-file xattr operations but stopped because it over-constrained the unpatched live system to contain donor path `Versions/32023/MTLCompiler`. No source mutation occurred. The corrected pinned launcher, public commit `453c6b3ef450c9c3d80f1d68996dac14279a8cd4`, SHA256 `cd8b3da4fd88cea16b8c795007356a4fdbcd7fe9c7207dde31d1cbd83c7db35c`, `4042` bytes, explicitly accepts that pre-Root-Patch absence and completed with RC `0`.

ASUS2 printed `D97AG_TAHOE_XATTR_BACKEND=PASS`. The exact source patch SHA256/blob/bytes are `2c4e93e57b2d13762ef90020496f87c2a95c7e39553ff60f948bfacd2b6b659b / 532f8729658b3bc287fa83963043a4d2a8aa816a / 3137`. Exact D97AF preimages, branch `alex-tahoe-25G82-custom` and HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06` passed. The transactional two-file integration produced helpers `ac4724159c0a6ce8802940f11ec02f803e85d8ca934d4629d3640ec1e58d32a2`, sys_patch `93988a13b809a29a7e1f2f67c885b74d574e456d1f229368740209aa0ceeed69`, unchanged metal_3802 `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`, and unchanged D97AD method `bb66b1d5d883251431d5a7fa7bc42c0cc9bcb15ec77c74506bb2eae5bf987a12`. Compile/AST/order/native-reader/fatal-boundary checks all passed. Backup is `/Users/alex/Desktop/OCLP7_D97AG_SOURCE_BACKUP_20260903-023142.w9fQQg`.

No application, system target, Golden, Root Patch, snapshot or reboot mutation occurred. The last proven live app remains D97AF and is not authorized for another Root Patch.

## D97AG major Intel GitHub build PASS
The major build was found already completed and was not rerun. Private repo/branch/head are `StefanAlMare/Private-Work` / `oclp7-d97ag-github-build` / `4bde01b09717d076499ebf3640b5e4c0378798dd`. Workflow/run/job are `348876070 / 33696449978 / 100466229401` on Intel/x86_64; every substantive build/package/upload step completed `success`.

The exact reports artifact `9872066045` was independently downloaded and its local SHA256 equals the GitHub artifact digest `da5b9e2d2a55786c1b6a4f3c64c054779ad73f394578e1a5e07c2bd0fd287217`. Final app ZIP identity is `751494420` bytes / SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`; packaged executable is `6596544` bytes / SHA256 `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628` / x86_64. Packaged/source code fingerprints agree, D97AD is unchanged, D97AG appears exactly once and forbidden packaged `listxattr/getxattr` APIs are absent.

Delivery artifacts are part00 `9872061067` and part01 `9872064375`. Historical GitHub-side frozen xattr execution is build evidence only.

## D97AG ASUS2 artifact/reassembly + frozen runtime audit PASS
The first ASUS2 audit attempt failed closed before download/mutation solely because the wrapper pinned stale workflow ID `348947684`; actual run metadata is `348876070`. This is `TOOLING_FALSE_FAILURE_NO_MUTATION`.

After a deterministic one-occurrence local correction, the audit reran with outer RC `0`. Exact run/job/head/branch/path, all three artifact wrappers, safe member sets, shared manifest/checksum files, reports checksum set, part payloads and exact reassembly all passed.

Exact locally proven identities are:

```text
D97AG_APP_ZIP_BYTES=751494420
D97AG_APP_ZIP_SHA256=d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846
D97AG_PACKAGED_EXE_BYTES=6596544
D97AG_PACKAGED_EXE_SHA256=29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628
D97AG_PACKAGED_ARCH=x86_64
D97AG_ASUS2_ARTIFACT_REASSEMBLY=PASS
D97AG_ASUS2_PACKAGED_EXECUTABLE_IDENTITY=PASS
```

The exact x86_64 frozen auditor executed on ASUS2 against that exact packaged executable and returned `PACKAGED_FROZEN`, `PROCESS_FROZEN=YES`, `OS_LISTXATTR_AVAILABLE=NO`, exact backend fingerprint `71959f823a2da72c12e53581c85773ebdfd0100b22a780152bf8c69fe2d56286`, exact backend source SHA `d02e98be14d1881202565560198a9eb5b3ec3200057db98c4b0820454dab2019`, empty manifest PASS, empty/text/binary values PASS and exact xattr code-object runtime PASS. Therefore `D97AG_ASUS2_FROZEN_XATTR_RUNTIME=PASS` and `D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT=PASS`.

Verified application ZIP retained at `/Users/alex/Desktop/OCLP7_D97AG_VERIFIED_RUN33696449978_OpenCore-Patcher.app.zip`. Audit report: `/Users/alex/Desktop/OCLP7_D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT_REPORT_20260903-162932.txt`.

No source, installed-app, system-target, Golden, Root Patch, snapshot or reboot mutation occurred during the audit. Last proven live application remains exact D97AF executable SHA256 `ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470`, 6595600 bytes.

## CURRENT ACTION — ASUS2 exact D97AG app backup/deploy/open/STOP
ASUS2 remains at STOP: do not Root Patch and do not reboot.

The next bounded action is application-only: verify the retained exact D97AG ZIP, stage and verify exactly one D97AG app/executable `29078c174b4b1058fe903e6e9b76b39f681b59985274048df1071a4c51a2e628` / x86_64, prove the current live exact D97AF preimage `ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470`, drain only exact-path OCLP processes, create a timestamped recoverable D97AF backup, deploy exact D97AG to `/Applications/OpenCore-Patcher.app`, reverify exact live identity, open exact OCLP, prove a fresh exact-path process and STOP.

Only `/Applications/OpenCore-Patcher.app` may be mutated by this action. OCLP source, system target, root-patched snapshot and Golden remain untouched. Root Patch and reboot remain later, manual-only and separately authorized. Golden remains immutable/read-only; D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized; D97AEX/D97AEZ retired.
