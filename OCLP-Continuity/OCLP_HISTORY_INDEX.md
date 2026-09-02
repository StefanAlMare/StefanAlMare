# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-03 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260903_D97AF_ROOT_PATCH_INVALID_PACKAGED_OS_LISTXATTR_FIX_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Permanent protocol
Permanent current default: short, visible, explained ASUS2 collaboration, one bounded action and STOP gate at a time. GitHub is used only for a substantial compile/build/package job when it is clearly faster than waiting through that job with the user; technical possibility alone does not justify remote work. A justified substantial GitHub build remains assistant-run and fully audited. No automatic Root Patch/reboot. Golden immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized.

## Local/GitHub execution methodology
The earlier 2026-09-02 GitHub-first rule was later superseded explicitly by the user after D97AEZ. Work must now stay local for short source inspection, edits, validations, probes and direct diagnostic iteration so the user can see and return immediate feedback. GitHub is reserved for a large/substantial compilation or build that is clearly faster there. When used, it remains the assistant's responsibility to run, repair and completely audit that build; it is never a substitute for ASUS2 hardware evidence. FASTLANE ordering and manual-only Root Patch/reboot remain unchanged.

## Functional baseline
P1 -> P2b -> P3 -> AIR00 -> D34. True-five SHA `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`. P6/P7 retained, runtime sufficiency NEGATIVE.

## Durable milestones
D22 AIR semantics PROVEN. D69/D70 WindowServer downstream. D71R compiler lifecycle observable. D83 upstream llvm::Module*. D93 RMP contract. D95D wrapped LLVM bitcode structural-semantic proof. D96C/D97JB late validator frontier/static CFG.

## D97 provenance / exact transition
D97AA proved runtime 32023 selection in an earlier cohort. D97AC statically mapped validator finite outcomes. D97AD exact transition produced selector-only service SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43` and final MTLCompiler SHA `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. Private build/deploy and manual Root Patch passed exactly.

## Accelerated D97AD boot
Selected boot `2026-09-02 00:10`; VESA `00:12` excluded. D97AEQ: exact visible D97AD identity PASS, 28/28 normal exit(1), zero signals/missing, zero exits110–114; runtime whole-stage outcome INVALID.

D97AER proved visible late simulator-limit xrefs are after candidate REL+0x58B. D97AES proved all diagnostic senders are 32023 path/UUID; 3802 NEGATIVE. D97AET proved the Cryptex x86_64h shared cache contains 32023 path and not 3802; archived PC/backtrace did not directly prove traversal beyond the visible terminal.

## D97AEU
D97AEU discovered main x86_64h cache and `.01`–`.06` subcaches. The target MTLCompiler 32023 record is replicated in each `imagesText` table with the same logical identity: cache UUID `D2265480-60EB-3526-BAF7-2D6596149186`, load `0x7FFD03141000`, text size `0xCE239`, same path. The load maps into subcache `.05`.

The mapper stopped at `CACHED_IMAGE_HIT_CARDINALITY_FAIL:7` before byte comparison. Classification: TOOLING FALSE FAILURE caused by counting replicated tables as distinct images. No cache byte result was produced.

## D97AEV / D97AEW
D97AEV passed pinned wrapper/base identities, all three transform cardinalities and all required anchors, but its raw `reboot` substring check falsely matched the legitimate `/System/Volumes/Preboot/...` cache path. It stopped before fixed-wrapper write/parse/core execution. Classification: TOOLING FALSE FAILURE; all cache-byte comparisons NOT REACHED; no mutation/Root Patch/reboot.

D97AEW pins D97AEV commit `b8350946e307ec2df253ffb795b31c2104034372` / blob `1060f611b3fec7fc66f80d7674d2fb06a2cdfe6d` and replaces only the scanner block with a reversible command-boundary correction plus safe/dangerous regression corpus. The GitHub-audited D97AEW wrapper is commit `2d14c7831d4adc9578daf5b80b55b72f663d836a`, blob `45876fa66e9018053882be7b01eeccabcfe8046b`, SHA256 `cdd976be2ee2981aec2d35055e96fc0559f2f3277a9e38d62f2476817ef74394`.

GitHub-first validation completed `success` in private workflow ID `348172340`, run `33600569828`, job `100153125476`, exact audit head `3a152504867fa743750f5307749c9d152bf9164e`; every job step passed. Artifact `9835010017` ZIP digest `4f02b891ee4004806117e473ffc67f29fdf28ec65a7061e1e5b7b7e0c0fb339a` matched after download; its single complete report also passed content audit. At that historical point, live ASUS2 mapper execution was the only remaining step; the following sections record its completion and superseding results.

## D97AEW live result
D97AEW/D97AEV/D97AEU completed with RC `0`. Seven raw cache records deduplicated to one logical 32023 image, UUID `D2265480-60EB-3526-BAF7-2D6596149186`, distinct from visible filesystem UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.

At the six visible D97AD image offsets the cache is OTHER `6/6` (`PRE=0`, `POST=0`), while the visible file is D97AD POST `6/6`. The cache shared stub is OTHER; retained functional postimages match visible filesystem `16/16` but cache `0/16` at those same offsets; both sender-PC windows differ. Positional cache/filesystem byte identity is NEGATIVE. Semantic cache-site mapping and runtime cache execution remain UNKNOWN; no cache intervention is authorized.

## D97AEW primary-source correction / D5CE provenance
Apple dyld source proves the `imagesText` UUID is copied from the selected input Mach-O slice and is not regenerated by cache optimization. D97AEW's D226 `.05` reads are physically valid, but D5CE offsets cannot be transferred to D226 without same-input identity. The former OTHER/0-of-16 results are therefore numerical cross-image observations, not semantic classifier results: `CACHE_PHYSICAL_BYTE_READ=VALID`, `CROSS_IMAGE_SITE_CORRELATION=NOT_ESTABLISHED`, `D97AD_CACHE_PATCH_DISCRIMINATOR=INCONCLUSIVE`.

The exact official release lineage is OCLP 1.3.0 -> PatcherSupportPkg 1.4.6 -> 14.2 Beta 1 MTLCompiler 32023. The exact unmodified packaged PSP payload UUID is `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`, git blob `ef4389a312867860b2034a42ca75e95162a0f10e`, SHA256 `4f65fb8890a5b18a222c9b0171b6c8240672fb48334fb7739892b7591ffc5641`. Public dsce v7 and v10 change only the first four UUID bytes and preserve the final twelve; exact v8 source is internal/unpublished. The 2023 release provenance independently separates D5CE from the current Tahoe D226 input, and the differing tails corroborate that lineage under the documented algorithm.

D97AES is reclassified as direct runtime provenance: 33/33 simulator diagnostics across 28/28 PIDs came from immediate sender DSO 32023/D5CE; current cache D226 is NEGATIVE as the immediate sender of those records. This does not exclude D226 elsewhere and does not prove exact D97AD postimage bytes because the known P7-to-D97AD transform lineage preserves D5CE. Exact runtime D97AD text remains UNKNOWN. The earlier semantic-D226 next action is superseded and becomes reserve-only static cross-build research.

## D97AEZ accelerated observer result / retirement
D97AEZ was activated in VESA UUID `C57F4AEF-B109-463A-940A-AC10B1F7A02A` and claimed the user-identified accelerated boot UUID `0FCD86FE-6A94-450C-A250-45B6A8255A82`; later VESA UUID `7BC61319-78D8-46C5-A084-65C40B7F0941` is excluded. All pre/post identities passed for the observer and exact service/D97AD target.

The universal/no-PID watcher caught natural exact-path MTLCompilerService PID `434`, but `task_read_for_pid` failed immediately with return `-1`, `errno=1`. Zero runtime text windows were read; helper/runner stopped fail-closed RC `2`; watchdog did not fire. Natural PID observation is PROVEN, task-port method is NEGATIVE/RETIRED, and exact runtime D97AD text remains UNKNOWN—not mismatched. No LLDB/SIP/AMFI bypass is authorized.

The observer is disabled. The user directed complete deletion of its ASUS2 artifacts; returned proof of deletion remains pending, so status is `REQUESTED_RESULT_NOT_YET_RETURNED`. The first bounded search found no source only within its searched locations; a targeted follow-up superseded that limited negative and located the local D97AD source at canonical path `/Volumes/AsusLaptop - Data/Users/alex/Developer/OpenCore-Legacy-Patcher-T2-Tahoe-25G82`. The `/Volumes/AsusLaptop/...` alternative is the same APFS-backed helper identity `16777225:61074310:497704`, with `TWO_PATHS_SAME_HELPERS=PASS`.

The source is on branch `alex-tahoe-25G82-custom`, HEAD `4143b7077a9a4e5aa41ec7a06c0888597eda9b06`, with exactly three reported tracked modifications: `metal_3802.py` SHA256 `fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24`, `sys_patch.py` SHA256 `115153b0465102cba0fdd477cc6215c4531e50b2927a99c1c64d12325c64d948`, and `sys_patch_helpers.py` SHA256 `fd37ede683ccb0612a7ba77ffe82b80bb8e081f4192f7485d05cdf8f9b51f515`. The D97AD definition count is exactly one.

## D97AF UUID frozen / static transform established
The returned local input archive SHA256 is `19c1b9dc34ede0533c3a7e6a7af9b00f2dcfd732cce9da6e47cdad6e93a06c41`, `673209` bytes, and contains the exact D97AD binary and authoritative three-file source input/diff.

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

Classification: `LEGACY_ROOT_PATCH_UNPATCH=OCLP_REPORTED_PASS_PENDING_REBOOT`, `SYSTEM_SNAPSHOT_MUTATION=YES_BY_MANUAL_UNPATCH`, `UNPATCH_ACTIVATION_REBOOT=NOT_YET_RUN`, `D97AF_ROOT_PATCH=NOT_STARTED`. The clean post-reboot state is not yet independently proven. This output is not a D97AF Root Patch result. Exact D97AF remains the last proven live application and exact D97AD remains in its timestamped backup.

## D97AF Root Patch invalid — packaged `os.listxattr` unavailable
After returning in VESA, the user manually ran Root Patch from the exact deployed D97AF app. The returned complete log is SHA256 `b1a263a7bddadbbf46ad8c10abcbfb82043edb17a5c15a21637de6ecae0a24a1`, git blob `b22c777844a2253a8e7fafab851acd86149b9067`, `26879` bytes and `731` logical lines.

P1, P2b, P3, AIR00, D34, P6, P7 and D97AD all reported PASS, with D97AD committed SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`. The D97AF method then raised `AttributeError: module 'os' has no attribute 'listxattr'` at `_xattrs` through `_target_metadata`. Exact source ordering proves the failure preceded every D97AF target byte read or write, temporary file, sibling reservation and rename; `D97AF_METHOD_TARGET_MUTATION=NOT_REACHED`.

OCLP caught the error, continued through patchset information, Auxiliary Kernel Collection handling and APFS snapshot creation, and printed generic `Patching complete`. This generic terminal message does not override the explicit custom-step exception. Classification: `D97AF_ROOT_PATCH=INVALID_PARTIAL`, `D97AF_LC_UUID_BUILD_STAMP=FAILED_NOT_APPLIED`, `POST_SNAPSHOT_MTL_IDENTITY=NOT_YET_READ`, `REBOOT=NOT_AUTHORIZED`.

## CURRENT ACTION — correct D97AF packaged-runtime metadata path; no reboot
Remain in VESA and do not reboot or rerun Root Patch from the current D97AF app. Replace the unavailable packaged-Python xattr dependency with an exact macOS-compatible mechanism, validate source and packaged runtime, run the substantial Intel build and full FASTLANE artifact/app audit, then deploy/open/STOP. A separately authorized recovery/unpatch action will follow only after the corrected app is proven.
