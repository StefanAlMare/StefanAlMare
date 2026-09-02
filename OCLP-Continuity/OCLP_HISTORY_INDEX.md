# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 → future phases

Updated: 2026-09-02 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260902_D97AEW_PHYSICAL_READ_VALID_D5CE_RUNTIME_TEXT_NEXT.md`.
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

## D97AEV / D97AEW
D97AEV passed pinned wrapper/base identities, all three transform cardinalities and all required anchors, but its raw `reboot` substring check falsely matched the legitimate `/System/Volumes/Preboot/...` cache path. It stopped before fixed-wrapper write/parse/core execution. Classification: TOOLING FALSE FAILURE; all cache-byte comparisons NOT REACHED; no mutation/Root Patch/reboot.

D97AEW pins D97AEV commit `b8350946e307ec2df253ffb795b31c2104034372` / blob `1060f611b3fec7fc66f80d7674d2fb06a2cdfe6d` and replaces only the scanner block with a reversible command-boundary correction plus safe/dangerous regression corpus. The GitHub-audited D97AEW wrapper is commit `2d14c7831d4adc9578daf5b80b55b72f663d836a`, blob `45876fa66e9018053882be7b01eeccabcfe8046b`, SHA256 `cdd976be2ee2981aec2d35055e96fc0559f2f3277a9e38d62f2476817ef74394`.

GitHub-first validation completed `success` in private workflow ID `348172340`, run `33600569828`, job `100153125476`, exact audit head `3a152504867fa743750f5307749c9d152bf9164e`; every job step passed. Artifact `9835010017` ZIP digest `4f02b891ee4004806117e473ffc67f29fdf28ec65a7061e1e5b7b7e0c0fb339a` matched after download; its single complete report also passed content audit. Live ASUS2 mapper execution remains the only required local step.

## D97AEW live result
D97AEW/D97AEV/D97AEU completed with RC `0`. Seven raw cache records deduplicated to one logical 32023 image, UUID `D2265480-60EB-3526-BAF7-2D6596149186`, distinct from visible filesystem UUID `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`.

At the six visible D97AD image offsets the cache is OTHER `6/6` (`PRE=0`, `POST=0`), while the visible file is D97AD POST `6/6`. The cache shared stub is OTHER; retained functional postimages match visible filesystem `16/16` but cache `0/16` at those same offsets; both sender-PC windows differ. Positional cache/filesystem byte identity is NEGATIVE. Semantic cache-site mapping and runtime cache execution remain UNKNOWN; no cache intervention is authorized.

## D97AEW primary-source correction / D5CE provenance
Apple dyld source proves the `imagesText` UUID is copied from the selected input Mach-O slice and is not regenerated by cache optimization. D97AEW's D226 `.05` reads are physically valid, but D5CE offsets cannot be transferred to D226 without same-input identity. The former OTHER/0-of-16 results are therefore numerical cross-image observations, not semantic classifier results: `CACHE_PHYSICAL_BYTE_READ=VALID`, `CROSS_IMAGE_SITE_CORRELATION=NOT_ESTABLISHED`, `D97AD_CACHE_PATCH_DISCRIMINATOR=INCONCLUSIVE`.

The exact official release lineage is OCLP 1.3.0 -> PatcherSupportPkg 1.4.6 -> 14.2 Beta 1 MTLCompiler 32023. The exact unmodified packaged PSP payload UUID is `D5CE0008-587C-3861-971A-4BAEFB7B9C5B`, git blob `ef4389a312867860b2034a42ca75e95162a0f10e`, SHA256 `4f65fb8890a5b18a222c9b0171b6c8240672fb48334fb7739892b7591ffc5641`. Public dsce v7 and v10 change only the first four UUID bytes and preserve the final twelve; exact v8 source is internal/unpublished. The 2023 release provenance independently separates D5CE from the current Tahoe D226 input, and the differing tails corroborate that lineage under the documented algorithm.

D97AES is reclassified as direct runtime provenance: 33/33 simulator diagnostics across 28/28 PIDs came from immediate sender DSO 32023/D5CE; current cache D226 is NEGATIVE as the immediate sender of those records. This does not exclude D226 elsewhere and does not prove exact D97AD postimage bytes because the known P7-to-D97AD transform lineage preserves D5CE. Exact runtime D97AD text remains UNKNOWN. The earlier semantic-D226 next action is superseded and becomes reserve-only static cross-build research.

## CURRENT ACTION — assistant GitHub runtime D5CE text proof
Assistant designs and audits a passive non-stopping universal/no-PID mapper for a new naturally occurring service cohort: per PID loaded D5CE header/path/base/backing plus direct read-only classification of the six D97AD sites, stub and required retained/late/far-frontier anchors. No service launch. STOP on unsafe/denied task access; no LLDB attach, Root Patch or reboot. No ASUS2 command before GitHub audit.
