# OCLP MASTER CONTINUITY

Current authoritative checkpoint: `OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260902_D97AEU_REPLICATED_TABLE_TOOLING_FAIL_D97AEV_READY.md`
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

Protocol: identity-pinned FASTLANE -> complete audit -> manual Root Patch -> complete audit -> accelerated boot -> VESA recovery -> selected accelerated-boot analysis -> persist. Never auto Root Patch or reboot. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized.

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

## CURRENT ACTION — D97AEV
Run `OCLP7_D97AEV_LOGICAL_CACHE_IMAGE_DEDUP_UUID_SAFE_WRAPPER.command`, commit `b8350946e307ec2df253ffb795b31c2104034372`, blob `1060f611b3fec7fc66f80d7674d2fb06a2cdfe6d`.

D97AEV pins the D97AEU core, deduplicates replicated image-table hits by logical cache identity, separates cache-optimized UUID from filesystem LC_UUID, retains the safe `__TEXT.vmaddr` contract, and leaves all six D97AD pre/post byte discriminators plus shared-stub/D34/AIR00/P6/P7 windows unchanged.

No Root Patch or reboot. Cache byte identity must remain separate from runtime-cache execution proof. D82 reserve-only; Patch8 unauthorized.
