# OCLP7 CHECKPOINT — 2026-09-06 — D97DG publisher-window tooling NEGATIVE; D97DH ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97DF_ROUTE_CALLBACK_CAVE_RUNTIME_PROVEN_SITE_ACTIVE_FAULT_NEXT.md` for current execution.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Unpatched VESA only; `-igfxvesa -ocmcdiag` retained.
- Active EFI config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- D97DD `OCLPMetalCompat.kext` 0.0.4 remains deployed, executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`, UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`.
- D97DF already proved `_cs_validate_page` route/callback/build gate runtime and cave page/runtime invariants.
- No Root Patch and no functional D97BV shared-cache mutation.

## D97DG second attempt evidence
Returned TXT: `OCLP7_D97DG_D97DD_ACTIVE_PAGEFAULT_20260906_212953.txt`.
- bytes: `2437`;
- SHA256: `6622a56e51b73343fe1a77b2d7fe0202115fa17033e9b5881e446fee782fc5c8`.

Boot time: `Sun Sep 6 21:25:09 2026`.
Collector timestamp: approximately `21:29:53`, about 284 seconds after boot.

Runtime identity remained correct:
- D97DD 0.0.4 loaded;
- UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`;
- `D97DDObservedBuild=25G82`;
- `D97CTRouteStatus=PASS`;
- `D97CTBuildGate=1`;
- `D97DDCallbackSeenCount=251445`;
- cave remained `SeenCount=1`, `Window18=PASS`, `Full208=PASS`, `Validated=15`, `Tainted=0`, `NX=0`;
- site remained `SeenCount=0` before active trigger.

Crucially, `D97CTPublisherTicks=288` at collector start. The D97DG safety gate intentionally stopped before any mmap/page-fault trigger because the 300-second publisher window had insufficient remaining time.

This is the second independent demonstration that the 300-second publisher window is operationally too short for this ASUS2 VESA boot path: desktop/userland becomes usable only near the publication cutoff.

## Classification
- `D97DG_ACTIVE_SITE_MMAP_TRIGGER=NOT_EXECUTED`;
- `D97DG_SITE_RUNTIME_PREIMAGE=UNTESTED`;
- `D97DG_PUBLISHER_300S_WINDOW=TOOLING_NEGATIVE_FOR_POST_DESKTOP_ACTIVE_FAULT`;
- `D97DF_CS_VALIDATE_PAGE_ROUTE=RUNTIME_PROVEN` remains authoritative;
- `D97DF_CALLBACK_EXACT_BUILD_GATE_25G82=RUNTIME_PROVEN` remains authoritative;
- `D97DF_D97BV_CAVE_RUNTIME_INVARIANTS=PROVEN` remain authoritative;
- `D97BV_FUNCTIONAL_PAGE_WRITE=STILL_UNAUTHORIZED`.

No site-negative conclusion is permitted from D97DG because the active trigger never ran.

## D97DH design
D97DH is a minimal tooling-only successor to D97DD:
- preserve D97DD route installation unchanged;
- preserve Apple-original-first callback unchanged;
- preserve callback counter and exact `osversion == 25G82` build gate unchanged;
- preserve site/cave matching and all read-only invariants unchanged;
- preserve zero functional D97BV replacement bytes and zero page writes;
- extend only the asynchronous IORegistry publisher cutoff from 300 seconds to 900 seconds;
- retain early stop when both site and cave have been seen;
- expose `D97DHPublisherPolicy=extended-until-site-cave-or-900-v1` and `D97DHPublisherLimitTicks=900`.

Prepared D97DH source:
- `OCLP7_D97DH_kern_start.cpp`;
- SHA256 `63541e7135388ee73ca3b8a408a45578e742734a79f6d313f8aef919405251f1`.

Prepared iMac build script:
- `OCLP7_D97DH_IMAC_BUILD.sh`;
- SHA256 `d269baf9b841216ced0d202595c228772823b49a248962e6466575d99084e71a`;
- `bash -n` PASS.

Intended version: `0.0.5`.

## CURRENT ACTION
On the already-authorized iMac 9900K build host, build D97DH 0.0.5 from the exact prepared source and return the resulting ZIP for independent audit.

Do not alter ASUS2 EFI yet. D97DD 0.0.4 remains deployed until D97DH build/package audit passes.

No Root Patch, accelerated boot, or functional D97BV shared-cache mutation is authorized.
