# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260902_D97AEW_PHYSICAL_READ_VALID_D5CE_RUNTIME_TEXT_NEXT.md`
Strategic retrospective authority: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`
Repository recovery record: `OCLP-Continuity/OCLP_REPOSITORY_RECOVERY_20260901.md`
Updated: 2026-09-02 EEST

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

Protocol is permanently GitHub-first. The assistant executes in GitHub everything technically possible there, including validation, source/workflow integration, compile/diff, build/package, packaged-app audit, SHA/manifest work, artifact publication and complete CI audit. The user is never asked to compile/build/package locally and runs only identity-pinned actions that inherently require live ASUS2 state: local cache/file/log/hardware evidence, exact installed-state proof, privileged backup/deploy, opening OCLP, manual Root Patch, accelerated boot and VESA recovery. Never auto Root Patch or reboot. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized.

Interaction chain: `assistant GitHub lane -> assistant full audit/persist -> minimal ASUS2-only lane when required -> assistant audit -> manual Root Patch only if authorized -> assistant audit -> accelerated boot -> VESA recovery -> selected accelerated-boot analysis -> persist`.

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

No source/system/Golden/service/Root Patch/reboot mutation occurred. The previous semantic-D226 mapper frontier is superseded and moved to reserve-only static cross-build research.

## CURRENT ACTION — assistant GitHub runtime D5CE text-provenance audit
The assistant must first design and fully audit in GitHub an identity-pinned, passive, non-stopping, universal/no-PID method for a new naturally occurring MTLCompilerService cohort. Per captured PID it must prove loaded 32023 header/path/UUID/base/backing and, only through safe read-only memory access, classify the six D97AD sites, shared stub and required retained/late/far-frontier anchors as PRE/POST/OTHER with explicit coverage. It must not launch the service. If task-port or exact memory reading is unsafe, perturbative or denied, STOP with a recorded blocker; do not use LLDB attach and do not substitute a semantic remap of D226. Only after complete GitHub audit may the user receive a minimal ASUS2-only command.

No user action, Root Patch or reboot is currently authorized. Baseline remains P1+P2b+P3+AIR00+D34; Golden immutable/read-only; D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized.
