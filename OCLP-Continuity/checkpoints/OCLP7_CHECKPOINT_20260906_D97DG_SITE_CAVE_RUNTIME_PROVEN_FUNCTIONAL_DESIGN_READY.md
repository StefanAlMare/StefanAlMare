# OCLP7 CHECKPOINT — 2026-09-06 — D97DG site+cave runtime PROVEN; functional design ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97DF_ROUTE_CALLBACK_CAVE_RUNTIME_PROVEN_SITE_ACTIVE_FAULT_NEXT.md` for current execution.

## Entering state
- ASUS2: macOS Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Unpatched VESA only; `-igfxvesa -ocmcdiag` retained.
- Active EFI config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- D97DD `OCLPMetalCompat.kext` 0.0.4 deployed, executable SHA256 `3cf3f05809e6dcb8dae9d65c01f72ec9f233596c1c1538c26f6e9ba2045cfc25`, UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644`.
- No Root Patch and no functional D97BV shared-cache mutation.

## Returned D97DG evidence
Returned ZIP: `OCLP7_D97DG_D97DD_ACTIVE_PAGEFAULT_20260906_213336.zip`.
- ZIP bytes: `2153`.
- ZIP SHA256: `ce6788ad55f2d6405463509311905d79ef3e18b2b12dbaf9fa7d9db85dcd0fb3`.

Inner TXT:
- bytes: `5958`.
- SHA256: `0ebb77f6833554415694ab55ee6b28f3cd9854ec4de2f6877c3ed03040774fcc`.

Boot time: `Sun Sep 6 21:32:00 2026`.
Boot args preserve `-igfxvesa -ocmcdiag`.
Initial publisher ticks: `119`, so active-fault test ran well within observation window.

## Runtime identity / route / build closure
`kmutil showloaded` proves exact D97DD 0.0.4 UUID `7651279E-31FA-385C-AD40-D9FB5DFC9644` loaded.

Initial persistent state:
- `D97CTRouteStatus=PASS`;
- `D97CTBuildGate=1`;
- `D97DDObservedBuild=25G82`;
- `D97DDCallbackSeenCount=171846`;
- CaveSeenCount=1 with prior cave invariants PASS.

After active read-only mappings, callback count increased to `174416`.

Classifications retained:
- `D97DF_CS_VALIDATE_PAGE_ROUTE=RUNTIME_PROVEN`;
- `D97DF_CS_VALIDATE_PAGE_CALLBACK_EXECUTION=RUNTIME_PROVEN`;
- `D97DF_CALLBACK_EXACT_BUILD_GATE_25G82=RUNTIME_PROVEN`.

## Active read-only SITE fault — runtime closure
D97DG opened exact main Cryptex `dyld_shared_cache_x86_64h` read-only and mapped the site page with private read+execute access only.

Userspace mapping evidence:
- SITE page offset `0xF5E1000`;
- SITE mmap PASS;
- exact 13-byte window read `3d187d0000b9177d00000f4cc1`;
- expected window exact match PASS;
- SITE page SHA256 `cc710a65a4dfbc674819bb024eade213b90821ab2a12b9a3e1df3d07fb013c43`.

One publisher poll later:
- `D97CTSiteSeenCount=1`;
- `D97CTSitePreimage=PASS`;
- `D97CTSiteValidated=15` (`0xF`, XNU `VMP_CS_ALL_TRUE`);
- `D97CTSiteTainted=0`;
- `D97CTSiteNX=0`.

Authoritative classifications:
- `D97DG_D97BV_SITE_PAGE_ACTIVE_FAULT=RUNTIME_PROVEN`;
- `D97DG_D97BV_SITE_PREIMAGE=RUNTIME_PROVEN`;
- `D97DG_D97BV_SITE_APPLE_VALIDATED_ALL=RUNTIME_PROVEN`;
- `D97DG_D97BV_SITE_TAINTED=0`;
- `D97DG_D97BV_SITE_NX=0`.

## Active read-only CAVE positive-control closure
D97DG also mapped the cave page read-only/private+execute:
- CAVE page offset `0xF47E000`;
- CAVE mmap PASS;
- full 208 bytes zero PASS;
- first 18 bytes zero PASS;
- CAVE page SHA256 `466792ab709cc54b58d42f1c6ef4ce73e0906071ed5b6160af2722d52cf35140`.

Final persistent state:
- CaveSeenCount=1;
- CaveWindow18=PASS;
- CaveFull208=PASS;
- CaveValidated=15 / 0xF;
- CaveTainted=0;
- CaveNX=0.

Authoritative classifications:
- `D97DG_D97BV_CAVE_PAGE_ACTIVE_FAULT=RUNTIME_PROVEN`;
- `D97DG_D97BV_CAVE_FULL208_ZERO=RUNTIME_PROVEN`;
- `D97DG_D97BV_CAVE_FUNCTIONAL18_ZERO=RUNTIME_PROVEN`;
- `D97DG_D97BV_CAVE_APPLE_VALIDATED_ALL=RUNTIME_PROVEN`.

## Functional readiness boundary
The complete delivery substrate required by the selective D97BV adapter is now runtime-proven on exact Tahoe 25G82:
- Lilu route installation PASS;
- routed callback execution PASS;
- callback exact-build gate PASS;
- exact site page can be delivered and matches preimage;
- exact cave page can be delivered and remains zero in required windows;
- Apple original validation returns all-validated for both pages;
- both pages are untainted and non-NX.

This closes the prior runtime timing/preimage prerequisite.

However **functional D97BV page writes remain unauthorized** until separately authorized by the user.

## D97DH cancellation
The previously prepared D97DH extended-publisher tooling build is no longer needed because D97DG succeeded within the original D97DD window. Do not deploy D97DH. ASUS2 remains on D97DD 0.0.4.

## CURRENT ACTION
No EFI/config/kext change and no reboot are currently authorized.

The next allowed engineering action is static design/audit of a functional D97BV successor using the already-proven D97DD `_cs_validate_page` delivery path. Actual functional page mutation, deployment, Root Patch or accelerated boot requires separate explicit authorization.
