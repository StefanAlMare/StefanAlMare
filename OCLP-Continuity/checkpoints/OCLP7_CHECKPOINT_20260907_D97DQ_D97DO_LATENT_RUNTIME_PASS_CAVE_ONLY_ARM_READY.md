# OCLP7 CHECKPOINT — 2026-09-07 — D97DQ D97DO LATENT runtime PASS; CAVE-only arm ready

## ASUS2 authority
- Tahoe 26.6.2 / 25G82; Haswell 8086:0412; SMBIOS MacBookAir6,2.
- VESA only; no Root Patch.
- active EFI D97DO OCLPMetalCompat 0.0.8.
- D97DO executable SHA256 `45cc67efcc656e1085d7c34f707d4e00b71406d45d74edfa4e01823d2e89bfe4`.
- D97DO UUID `5CE5E9F9-9D18-33C0-8A03-18237D949A6A`.
- config SHA256 `b5f9fd91c3a09a4b60709a38692b1143b3699292d5b873b347fb936333015a48`.
- boot args contain `-igfxvesa -ocmcdiag` and contain neither `-ocmcd97bvcave` nor `-ocmcd97bv`.

## Returned D97DQ evidence
ZIP `OCLP7_D97DQ_D97DO_LATENT_RUNTIME_20260907_002344.zip`:
- bytes `2257`;
- SHA256 `63cbc17c27aec9970cc9c2c8f2c04b19fc639ffc26dcc16d05ec4f78b4af64b1`.

Inner TXT:
- bytes `6929`;
- SHA256 `646f89c7a20925b97d840ef471f729fa54764b4e11fffd22b4877f201e025087`.

Boot time: `Mon Sep 7 00:17:46 2026` EEST.

Runtime proof:
- exact D97DO 0.0.8 UUID loaded;
- Lilu 1.7.3 and WhateverGreen 1.7.1 loaded;
- `VersionInfo=DBG-008-2026-09-07`;
- `D97DOFunctionalMode=LATENT`;
- `D97DOCaveOnlyRequested=0`;
- `D97DOFullFunctionalArgPresent=0`;
- `D97DOSiteWriteBlocked=PASS`;
- `D97DOCaveWritePhase=0`;
- `D97DICaveWriteCount=0`;
- `D97DISiteWriteCount=0`;
- route PASS;
- callback exact-build gate 25G82 PASS;
- CAVE naturally seen once with window18/full208 PASS, Apple validated 15/0xF, tainted 0, NX 0;
- SITE not naturally seen, not negative.

Authoritative classifications:
- `D97DQ_D97DO_RUNTIME_IDENTITY=PASS`;
- `D97DQ_D97DO_LATENT_MODE=RUNTIME_PROVEN`;
- `D97DQ_D97DO_SITE_WRITE_BLOCKED=RUNTIME_PROVEN`;
- `D97DQ_D97DO_CAVE_WRITE_PHASE_ZERO=RUNTIME_PROVEN`;
- `D97DQ_D97DO_CAVE_WRITE_COUNT_ZERO=RUNTIME_PROVEN`;
- `D97DQ_D97DO_SITE_WRITE_COUNT_ZERO=RUNTIME_PROVEN`;
- `D97DQ_D97DO_ROUTE=PASS`;
- `D97DQ_D97DO_CALLBACK_BUILD_GATE_25G82=PASS`;
- `D97DQ_LATENT_RUNTIME_GATE=PASS`.

## Authorization
User previously explicitly authorized the first functional VESA mutation. D97DQ closes all required latent prerequisites.

AUTHORIZED next:
- D97DR: add only `-ocmcd97bvcave` to the active OpenCore boot-args with exact config/D97DO identity checks, backup, and structural plist comparison.

D97DR must NOT:
- add `-ocmcd97bv`;
- modify any other config value;
- Root Patch;
- reboot.

After D97DR, return the arm report before reboot.

Still not authorized until D97DR report audit:
- reboot with CAVE-only armed;
- full `-ocmcd97bv`;
- SITE mutation;
- Root Patch;
- accelerated boot.
