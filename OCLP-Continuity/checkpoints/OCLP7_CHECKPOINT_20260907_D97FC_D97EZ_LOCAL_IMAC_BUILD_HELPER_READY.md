# OCLP7 D97FC — D97EZ authorized local Intel-iMac build helper READY

Date: 2026-09-07 EEST

## Authority
D97FB records explicit user authorization to compile locally on the user's home Intel iMac while GitHub Actions execution/quota is unavailable.

D97EY remains the decisive semantic proof:
- `mode=0x24` -> badBits `0`, goodBits `0x24`, Apple success;
- `mode=0x224` -> badBits `0x200`, goodBits `0x24`, Apple `kIOReturnBadArgument`;
- bit `0x200` semantic name remains UNKNOWN;
- global masking remains prohibited.

## D97EZ design/generator
Design:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_EXACT_224_ADAPTER_DESIGN.md`

Generator:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_EXACT_224_ADAPTER_GENERATOR.py`
- commit `cd76d912018bfa60284af3cb732ae8bca84db091`;
- Git blob `3bf728b999e2163af77742686d7ce9aaac04e8fb`.

D97EZ remains an exact-match experiment:
- LATENT unless `-ocmcd97ez` is active;
- ACTIVE exact rule only: `0x224 -> 0x24`;
- all non-`0x224` modes exact passthrough;
- `that`/`id` unchanged;
- Apple original called once;
- Apple IOReturn returned unchanged;
- first-eight original/passed mode telemetry plus global/no-PID counters.

## Local build helper
Authoritative helper:
`OCLP-Continuity/artifacts/OCLP7_D97EZ_IMAC_BUILD.sh`
- hardened helper commit `38b19ff0ff8e83eb3afeedb18747a56078ce89c1`;
- Git blob `19a22fe133fe04d0758f8a14a5306d4f81d25007`.

Helper contract:
1. requires Darwin x86_64 and full selected Xcode;
2. clones the continuity repo and fetches exact pinned lineage sources/generators by commit;
3. verifies D97DL SHA, D97EH generator SHA, D97EL/D97ES/D97EZ generator Git blobs;
4. reconstructs exact D97EH/D97EL/D97ES and verifies their known source SHA256 values;
5. generates D97EZ twice and byte-compares outputs;
6. performs source semantic audit: exact-match only, no broad mask, no return coercion, exact one Apple call, latent bootarg gate, global counters, original/passed telemetry;
7. requires a non-empty D97ES->D97EZ diff;
8. builds pinned Lilu x86_64 and pinned FeatureUnlock scaffold with MacKernelSDK;
9. builds `OCLPMetalCompat.kext` version 0.0.12 x86_64;
10. records version/UUID/executable SHA/Info.plist SHA;
11. records strings, nm and otool disassembly plus llvm-objdump when available;
12. packages kext, lineage sources, generators, diff, logs, disassembly and identity files;
13. freezes package content before SHA256 manifest generation and self-verifies that manifest;
14. creates a Desktop ZIP plus ZIP SHA256 sidecar;
15. performs no deploy, EFI/NVRAM mutation, Root Patch or reboot.

Packaging audit corrections made before authorization:
- diff gate now requires exact `git diff --no-index` RC=1 and non-empty diff;
- package report is finalized before manifest generation;
- package is not mutated after `SHA256SUMS.txt` is written;
- manifest is self-checked before ZIP creation.

## Classification
- `D97FC_LOCAL_COMPILE_USER_AUTHORIZED=YES`
- `D97FC_HELPER_SOURCE_PINNED=PASS`
- `D97FC_HELPER_FAIL_CLOSED_DESIGN=PASS`
- `D97FC_PACKAGING_MANIFEST_ORDER=PASS`
- `D97FC_ASUS2_COMPILE_AUTHORIZED=NO`
- `D97FC_D97EZ_DEPLOYMENT_AUTHORIZED=NO`
- `D97FC_ROOT_PATCH_AUTHORIZED=NO`
- `D97FC_REBOOT_AUTHORIZED=NO`

## CURRENT ACTION
Run the exact pinned D97EZ helper on the authorized home Intel iMac. Return the complete terminal output and the produced `OCLP7_D97EZ_IMAC_BUILD_<stamp>.zip` for independent audit. Do not deploy anything to ASUS2 until that returned artifact is independently audited and a later checkpoint explicitly authorizes deployment.
