# OCLP MASTER CONTINUITY

Updated: 2026-09-08 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`
Project retrospective: `OCLP-Continuity/OCLP_PROJECT_RETROSPECTIVE_20260827.md`

All earlier checkpoints remain authoritative for deep history. This MASTER and its current checkpoint are the current execution/causal authority.

## Current authoritative checkpoint
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260908_D97HK_PYTHON_ANCHOR_FALSE_NEGATIVE_D97HL_V2_READY.md`
- commit `35b579df09aa669be91b19f252973458a3c06a51`.

Immediate decisive predecessors:
- portable Intel build-host authorization / D97HK ready — `018c46a1d853c93617338d630e7beb7afe323b21`;
- D97HG exact P3-only reconstruction PASS / D97HI build authorized — `3aa5c5ea432b99fd538c44eb9bfe0ab481bf71ec`;
- D97HF P1 runtime semantic progress / measured P3 frontier — `1af98134a40236290484037548dfba621df1c626`;
- D97HE historical misselection invalid / D97HF exact collector ready — `d7691224526b3b35c4607f15d43bccfa8372d5f9`;
- first post-P1 accelerated no-GUI / VESA recovery — `52125fed156f25c9f08ef611e7876793eab5e42a`;
- D97HD active P1 VESA snapshot PASS + D97EW live gate PASS — `f5c342197210248a47469a7e6ec709c26ab66e9c`;
- D97HC exact pre-reboot audit PASS — `c809157e3773a17a149a8cba322bde0fc724c5cb`;
- D97GS P1-only Root Patch PASS — `c702ca47f20a036f2201799d05c1723441eb8a88`.

## Target / invariants
Tahoe `26.6.2 / 25G82`, Haswell `8086:0412`, SMBIOS `MacBookAir6,2`, framebuffer 3/3/3.

Never auto Root Patch. Never auto reboot. Never modify EFI/NVRAM automatically.
Golden Sequoia immutable/read-only.
Never compile on ASUS2.

### Build-host rule — current explicit exception
The historical home Intel iMac remains a valid build host. The user is currently on an Intel MacBook Pro at work and explicitly requested adaptation to that host.
A non-target Intel/x86_64 Mac is authorized for this build only when exact source/provenance gates reconstruct the known D97DX/D97GS state. ASUS2 remains forbidden as a compilation host.

Portable host preflight:
- x86_64 Intel Core i9-9880H;
- macOS 15.7.9 / 24G830;
- Xcode full developer dir present;
- macOS SDK 26.2;
- Python 3.13.15 x86_64 at `/usr/local/bin/python3.13`;
- required git/clang/curl/shasum/codesign/lipo/ditto/make present;
- Intel Homebrew `/usr/local/bin/brew`;
- ~122 GiB free.

Classification: `PORTABLE_INTEL_MAC_BUILD_HOST=CAPABLE_PREFLIGHT_PASS`.

## Durable architecture / replay rule
`Tahoe native Metal / Metal4 ABI -> selective legacy compiler ingress -> audited adapter(s) -> legacy compiler/backend -> Haswell driver -> image`.

Historical accepted compiler baseline remains `P1 + P2b + P3 + AIR00 + D34`, but wholesale replay is forbidden. Only measured modules return.

Current measured modules:
- P1 runtime semantic progress PROVEN;
- P2b NOT justified as next patch;
- P3 serialized-bitcode boundary measured and historically causal;
- AIR00/D34 not authorized.

## Settled ASUS2 state
ASUS2 is back in VESA with D97EZ inert after first post-P1 accelerated no-image test.
Active service is exact P1 SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`.
Corrected metallibs remain 180/180 exact; Haswell Azul/HD5000 loaded.

## D97HF — P1 runtime semantic progress
Exact 03:35 window contained 9 MTLCompilerService crashes. Old `RIP=0 / r15=32023 / MTLConnectionCtx+56` signature appeared 0/9.
All 9 advanced through `MTLCodeGenServiceBuildRequest` into the 32023 backend/plugin path and crashed in the same pre-P3 LLVM-3802 metadata family:
`MTLCompilerBuildRequestWithOptions -> addMsaaPositionInfoToModuleMetadata -> getOrInsertNamedMetadata -> collectUsedGlobalVariables -> StringMapImpl::LookupBucketFor`.

Classification:
`P1_SELECTOR_BRIDGE_RUNTIME_SEMANTIC_PROGRESS=PROVEN`
`CURRENT_FRONTIER=P3_SERIALIZED_BITCODE_BOUNDARY_MATCH_PROVEN`.

## D97HG — P3-only copy reconstruction PASS
Current exact MTLCompiler 32023 base:
- SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- P2 state still original `+0xD0`, no P2b;
- P3 unique preimage `81e100002000` at `0xA1573`.

P3-only changes exactly one byte:
- `0xA1574: e1 -> c9`;
- postimage `81c900002000`;
- exact P3-only post-SHA `0066a944e7db5f15c397c156b968cbe71a4bf51fb4cad819beb23a99309f6e90`.

Classification:
`D97HG_P3_ONLY_RECONSTRUCTION=STATIC_STRUCTURAL_SEMANTIC_PROVEN`.

## D97HI direct build attempt — tooling false negative
Original D97HI assumed historical worktree path existed on the build host and stopped immediately with `WORKTREE_MISSING`. No mutation occurred.

## D97HK portable build attempt v1 — tooling false negative
D97HK v1 successfully proved the portable host and exact historical authority identities:
- D97DU blob `ceed3890b5d35efbefc38ebf1a40f358884e58b9`;
- D97GS blob `b408d8d372ca6956db0caeb2a253df44acd7a5b9`;
- D97HI blob `0bf2e5601f08613d916d1414a5e2561153517ed5`.

It then stopped before cloning/source mutation with:
`python loop anchor count=2`.

Cause: portable transformation searched generic `for p in \\` and incorrectly required one occurrence; historical D97DU contains more than one such loop.

Classification:
`D97HK_V1_RESULT=INCONCLUSIVE_TOOLING_FALSE_NEGATIVE`
`D97HK_FUNCTIONAL_EVIDENCE=NONE`
`D97HK_SYSTEM_MUTATION=NO`.

## CURRENT ACTION — D97HL v2 tooling fix + corrected D97HK run
Artifact:
`OCLP-Continuity/artifacts/OCLP7_D97HL_PORTABLE_BOOTSTRAP_FIX_PYTHON_ANCHOR_AND_RUN_D97HK.sh`
- commit `bfab26f8c1fe180447df80de9321f3f565bb520f`;
- Git blob `b52520b349055674cbd978fb645da7cfa83efbee`.

D97HL v2:
1. fetches exact D97HK v1 and requires blob `b3d8022ac3d543fd1fd38fedc14ebab6bd0ccfe8`;
2. changes only D97HK's tooling transformation of D97DU's Python-selection region;
3. locates the unique D97DU region from `PYTHON_BIN=""` to `Verify exact local 25G82 MetallibSupportPkg` and replaces it with fixed `/usr/local/bin/python3.13` x86_64 selection;
4. preserves all D97DX/D97GS/P1/P3 authority tokens and commits unchanged;
5. syntax-checks corrected D97HK;
6. executes the otherwise unchanged portable chain.

Expected downstream chain still must prove:
- exact upstream b9df76/tree;
- D97DX diff SHA `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- exact Universal-Binaries SHA `33b6f11c7593827f66044fd79c3d3ad2ffb84dfa0d0921c3795033543ec601d7`;
- D97GS diff SHA `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`;
- P1 preserved exactly;
- P3-only insertion;
- x86_64 inner app build and packaging.

No outer wrapper assembly, target transfer, Root Patch, reboot, acceleration, P2b, AIR00 or D34 is authorized until D97HL/D97HK output is reviewed and independently audited.
