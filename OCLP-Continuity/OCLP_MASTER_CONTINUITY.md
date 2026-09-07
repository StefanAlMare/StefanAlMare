# OCLP MASTER CONTINUITY

Updated: 2026-09-07 EEST

Permanent database: `OCLP-Continuity/OCLP_PERMANENT_PROJECT_DATABASE.md`
Permanent rules: `OCLP-Continuity/OCLP_PERMANENT_WORKING_RULES.md`
Permanent VESA rule: `OCLP-Continuity/OCLP_PERMANENT_VESA_RECOVERY_RULE.md`
History index: `OCLP-Continuity/OCLP_HISTORY_INDEX.md`

Current authoritative runtime checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EY_EXACT_SET_ID_MODE_TUPLE_SEMANTIC_PROOF.md`

Previous accelerated authorization checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EX_PERSISTENT_COLLECTOR_LIVE_PASS_ACCEL_BOOT_AUTHORIZED.md`

Previous transport-preservation checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EW_D97ES_VESA_PASS_PERSISTENT_CAPTURE_GATE.md`

Current D97ES VESA runtime checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97EV_D97ES_VESA_RUNTIME_PASS_ACCEL_MEASUREMENT_AUTHORIZED.md`

Current observer build audit checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97ET_D97ES_0011_INDEPENDENT_BUILD_AUDIT_PASS.md`

Current Root Patch execution checkpoint:
`OCLP-Continuity/checkpoints/OCLP7_CHECKPOINT_20260907_D97DX_ROOT_PATCH_EXECUTION_PASS_PRE_VESA_REBOOT_GATE.md`

Current build design:
`OCLP-Continuity/artifacts/OCLP7_D97DU_NATIVE_METAL_SAFE_ROOTPATCH_DESIGN.md`

Current observer build helper:
`OCLP-Continuity/artifacts/OCLP7_D97ES_IMAC_BUILD.sh`

Current persistent accelerated-evidence collector:
`OCLP-Continuity/artifacts/OCLP7_D97EW_PERSISTENT_IOREG_CAPTURE_INSTALL.sh`
- source commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- Git blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`;
- installed capture SHA256 `bc818d5b26f337404945c5118b34d264505351ea0ca307f760c24e6a3260b017`;
- installed plist SHA256 `a2b5f2ed8d0c2c0ee49b437dffdf04e82f155cb2e20eea32b8d93b67d2881280`.

## Current ASUS2 authority
- Tahoe `26.6.2 / 25G82`;
- Haswell `8086:0412`;
- SMBIOS `MacBookAir6,2`;
- D97DX native-Metal-safe Root Patch remains installed;
- active EFI kext remains audited D97ES `OCLPMetalCompat.kext` 0.0.11;
- active D97ES executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- active D97ES UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4` x86_64;
- D97ES VESA route/publisher/empty-slot behavior is PASS;
- D97EW persistent collector is installed and LIVE/PASS;
- the authorized D97EX accelerated measurement boot was completed with only `-igfxvesa` inert;
- persisted accelerated run is `/Users/Shared/OCLP-D97EW-Capture/20260907T115054Z-295`;
- saved accelerated boot args prove `#-igfxvesa -ocmcdiag -ocmcd97bv -ocmcd97eh`, with `#-ocmcd97bvcave` inert;
- same-run loaded observer identity is D97ES 0.0.11 UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4`;
- first D97EW sample captured 8 tuples with total call count 15; follow-up snapshots reached call count 20;
- current session is VESA recovery after that accelerated boot;
- no functional `set_id_mode` correction is currently installed or authorized;
- no new T2/Haswell boot variable is currently authorized.

Never auto Root Patch. Never auto reboot. Golden remains immutable/read-only.

## Functional baseline and durable rules
Accepted functional baseline remains exactly:
- P1 selector bridge;
- P2b request-layout bridge `request+0xD0 -> request+0x110`;
- P3 serialized-bitcode path;
- AIR00 fallback producing AIR 2.6 / Metal 3.1;
- D34 semantic-equivalent reset.

D22 remains the accepted upstream semantic proof for AIR 2.6 / Metal 3.1. D34 cave `0xEF8..0xEFE` is protected. D50/D68/D82 remain reserve-only; D84 is retired. Golden Sequoia remains immutable/read-only.

Module-boundary + semantic evidence + far-frontier methodology remains mandatory. Universal/no-PID coverage is required when requests can vary. Control-flow success is never semantic proof by itself.

Permanent GitHub-first execution remains mandatory: all technically GitHub-executable validation/integration/build/package/audit work is done in GitHub; ASUS2 is reserved for identity-pinned live-state/deploy/manual boot/recovery evidence.

## Durable target architecture
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited adapter -> legacy compiler path -> Haswell driver -> image`

Permanent prohibitions:
- never shadow native Tahoe Metal with legacy main Metal;
- no global 32023 rewrite;
- no global forced-3802 production path;
- no standalone Objective-C rehabilitation mainline;
- no fake canonical Metal file for BinaryModInfo;
- no true-five reapplication;
- no global `set_id_mode` masking;
- no unmeasured semantic coercion of `set_id_mode` return codes.

## Settled runtime/build facts

### D97BV / D97DT — selective 3802 delivery CLOSED PASS
Selective-3802 runtime delivery is CLOSED PASS under VESA exact 25G82 using D97DL 0.0.7. CAVE/SITE exact runtime delivery, validation safety and cross-process visibility were proven. Do not retest absent contradiction.

D97DL source authority SHA256:
`f966d34850466441c4b2eb5a6cf78bd5365cc07223b128feb95aad97839878b2`.

### D97DX — native-Metal-safe Root Patch PASS
Installed bounded architecture:
- native Tahoe main Metal remains authoritative;
- bounded legacy `MTLCompilerService.xpc` only under native Metal.framework;
- private compiler lanes plus CoreImage/RenderBox compatibility;
- exact 25G82 metallib handling;
- Monterey GVA/OpenCL and Haswell graphics drivers;
- no MetalOld, no legacy main Metal shadow and no true-five replay.

### D97EB / D97EE — core accelerated failure
Normal 3/3/3 accelerated boot and isolated 1/1/1 framebuffer experiment reached the same core failure:
`IOAccelSurface::set_id_mode(...): Surface mode contains bad bits` -> display offline -> WindowServer SIGSEGV.

No kernel panic and no `_MTL4*` superclass regression occurred. Framebuffer-count tuning is CLOSED NEGATIVE; 3/3/3 remains authoritative.

### D97EG-D97EP — exact observer route
AppleIntelHD5000Graphics imports `__ZN14IOAccelSurface11set_id_modeEjj` = `IOAccelSurface::set_id_mode(uint32_t id, uint32_t mode)` from IOAcceleratorFamily2 487.4.3.

D97EH/D97EL proved observe-only passthrough semantics: original `that/id/mode` passed unchanged, Apple original called first, original IOReturn returned unchanged, candidate masks computed only after return, no mode mutation/coercion.

D97EP VESA proved observer requested, global callback path active, exact target callback and route PASS, with zero set_id_mode calls as expected.

### D97EQ / D97ER — tuple transport gap
D97EQ accelerated boot reproduced the failure after `GPU: FB: 3 of 3 opened`: four bad-bits errors, display offline about 3 ms later, WindowServer SIGSEGV about 20.6 ms after fourth error. No kernel panic, no `_MTL4*` regression, no preceding MTLCompilerService failure.

Exact tuple was not captured. D97ER established unified log and dmesg custom-marker absence, so repeating unchanged D97EL was not justified; the problem became tuple transport/capture.

### D97ES / D97ET — IORegistry tuple telemetry build PASS
D97ES 0.0.11 preserves D97EL passthrough semantics and adds first-eight tuple capture:
- `id`;
- `mode`;
- `badBits = mode & 0xFF8073C0`;
- `goodBits = mode & 0x007F8C3F`;
- raw original IOReturn.

Independent build audit PASS:
- source SHA256 `8184610aca1f2e651e6526e45c05d00a96055711c985571bc34c703ba7f6a8d0`;
- UUID `4E0CD60C-2408-3EDA-9C0A-0FACD06FD9F4`;
- executable SHA256 `2a4d3b3dde347f87b31fffd067d3ab5fd8616f036321f61b7b5f38abbf1dd2de`;
- exact D97ES -> D97EL -> D97EH -> D97DL lineage proved;
- no functional mode mutation or return coercion.

D97ES publisher updates IORegistry asynchronously and is bounded to 300 seconds.

### D97EU / D97EV — deployment and VESA runtime PASS
D97EU proved exact active EFI D97ES identity. D97EV VESA proved:
- loaded D97ES 0.0.11 exact UUID;
- observer/callback/target route PASS;
- `D97ELSetIdModeCallCount=0`;
- `D97ESCaptureSlots=8`;
- `D97ESCapturedCount=0`;
- all eight Valid=0;
- D97CT route/build/cpu/kernel gates healthy;
- D97BV functional requested/ACTIVE;
- publisher reached bounded tick 300.

Thus D97ES route, schema, publisher liveness and empty-slot behavior are CLOSED PASS in VESA.

### D97EW / D97EX — persistent accelerated evidence transport PASS
D97EW identified that hard VESA recovery destroys prior live IORegistry, so a WindowServer-independent on-disk collector was required before acceleration.

Collector artifact:
`OCLP-Continuity/artifacts/OCLP7_D97EW_PERSISTENT_IOREG_CAPTURE_INSTALL.sh`
- source commit `b23f1e78a02e3aedd48a4e30101a6d3e8abaf00d`;
- Git blob `d5a60a8b69c22249b03988afe6e6e94a3947d195`.

D97EX current-VESA live proof closed source identity, install/plist, LaunchDaemon-running, live IORegistry read, live disk persistence and zero-tuple cross-check. Accelerated evidence transport is CLOSED PASS.

### D97EY — exact accelerated `set_id_mode` semantic proof
Persisted accelerated run:
`/Users/Shared/OCLP-D97EW-Capture/20260907T115054Z-295`.

First persisted snapshot:
- route `PASS`;
- captured slots `8`;
- call count `15`, later stable follow-ups at `20` total calls.

Exact first-eight tuples:
1. `id=0x1000 mode=0x24 badBits=0x0 goodBits=0x24 ret=0x0`;
2. `id=0x1001 mode=0x224 badBits=0x200 goodBits=0x24 ret=0xE00002C2`;
3. `id=0x1002 mode=0x224 badBits=0x200 goodBits=0x24 ret=0xE00002C2`;
4. `id=0x1003 mode=0x224 badBits=0x200 goodBits=0x24 ret=0xE00002C2`;
5. `id=0x1004 mode=0x224 badBits=0x200 goodBits=0x24 ret=0xE00002C2`;
6. `id=0x1000 mode=0x24 badBits=0x0 goodBits=0x24 ret=0x0`;
7. `id=0x1001 mode=0x224 badBits=0x200 goodBits=0x24 ret=0xE00002C2`;
8. `id=0x1002 mode=0x224 badBits=0x200 goodBits=0x24 ret=0xE00002C2`.

`0xE00002C2` is `kIOReturnBadArgument`. Direct same-boot semantic result:
- observed `0x24` class is accepted by Apple original;
- observed `0x224` class differs by exactly `0x200`, is classified `badBits=0x200`, preserves the same `goodBits=0x24`, and is rejected with BadArgument for every captured instance;
- pattern repeats across surface-ID sequences.

Classification:
- exact first-eight payload = PROVEN;
- `0x24 -> success` = SEMANTIC PROVEN for captured calls;
- `0x224 / badBits 0x200 -> BadArgument` = SEMANTIC PROVEN for captured calls;
- semantic name/meaning of bit `0x200` = UNKNOWN;
- exact Golden runtime equivalent mode = UNKNOWN;
- global clearing of bit `0x200` = NOT AUTHORIZED.

Same accelerated boot also produced repeated WindowServer SIGSEGV in the known downstream CoreDisplay/SkyLight initialization path; the direct D97EY tuple remains the stronger causal frontier.

D97EY checkpoint commit:
`f2762e713565b1e72498241de639bdd5698c82c6`.

## OCLP T2 / Haswell audit integration policy
The exact `set_id_mode` measurement is now resolved for the captured class, but no unrelated T2/Haswell boot variable is promoted at this gate. Existing `ipc_control_port_options=0` and `-amfipassbeta` remain. `igfxmetal=1`, `-disablegfxfirmware`, `watchdog=0` and other variables remain unapproved until the measured `0x224/0x200` boundary experiment is resolved.

## Current causal frontier
`Tahoe/CoreDisplay surface-mode semantics -> mode 0x224 (good 0x24 + extra 0x200) -> IOAccelSurface::set_id_mode -> legacy Haswell IOAccelerator returns kIOReturnBadArgument`.

The exact failing bit class is measured. What remains UNKNOWN is the semantic name/intent of bit `0x200` and whether selectively translating the observed exact `0x224` class to legacy-accepted `0x24` is sufficient for stable graphical progress.

## CURRENT ACTION — GITHUB-FIRST D97EZ EXACT-MATCH ADAPTER DESIGN/AUDIT
Do not mutate ASUS2 yet.

In GitHub, design a D97EZ successor derived deterministically from exact D97ES 0.0.11 with these hard requirements:
1. LATENT by default behind a new explicit functional bootarg.
2. Preserve exact D97ES route and observer telemetry.
3. Global/no-PID classification for every `set_id_mode` call.
4. Only when the new functional gate is active and original `mode == 0x224`, pass candidate `0x24` to Apple original.
5. Every other mode must reach Apple original byte-for-byte unchanged.
6. No global mask and no broad `mode &=` logic.
7. Return Apple original IOReturn unchanged.
8. Publish original mode, passed mode, exact-match counters and return so the experiment remains semantically auditable.
9. GitHub-first source validation, deterministic generation, x86_64 compile, binary/disassembly audit, package identity and artifact publication.
10. No Root Patch, EFI change, reboot or accelerated boot is authorized until the GitHub build/binary audit is independently PASS and a separate VESA-first deployment checkpoint is persisted.