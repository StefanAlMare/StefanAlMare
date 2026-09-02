# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-02 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260902_GITHUB_FIRST_EXECUTION_CONTRACT_D97AEV_READY.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

## Permanent protocol
Permanent GitHub-first split: assistant executes all GitHub-capable validation, source/workflow integration, compile/diff, build/package, packaged-app audit, SHA/manifest, artifact publication and CI audit. User performs only identity-pinned ASUS2-dependent evidence/deploy plus manual Root Patch/boot/VESA recovery after explicit authorization. No user local compilation/build/package by default; no automatic Root Patch/reboot. Golden immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized.

## GitHub-first execution methodology
User-directed permanent methodology change on 2026-09-02: work must not be shifted to the user when it can run in GitHub. GitHub failures are repaired/rerun by the assistant. A genuine GitHub capability blocker causes STOP and must be recorded; local compilation requires explicit user override. Historical user-run full-FASTLANE wording is superseded prospectively. D97AD private GitHub Actions build/deploy provenance already proves the split model operationally. D97AEV remains the current ASUS2-only exception because its decisive input is the real machine's Cryptex dyld shared cache.

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

## CURRENT ACTION — D97AEV
Run pinned wrapper `OCLP7_D97AEV_LOGICAL_CACHE_IMAGE_DEDUP_UUID_SAFE_WRAPPER.command`, commit `b8350946e307ec2df253ffb795b31c2104034372`, blob `1060f611b3fec7fc66f80d7674d2fb06a2cdfe6d`. It deduplicates logical cache image identity, separates cache UUID from filesystem UUID, and leaves all D97AD byte discriminators unchanged. No Root Patch/reboot.
