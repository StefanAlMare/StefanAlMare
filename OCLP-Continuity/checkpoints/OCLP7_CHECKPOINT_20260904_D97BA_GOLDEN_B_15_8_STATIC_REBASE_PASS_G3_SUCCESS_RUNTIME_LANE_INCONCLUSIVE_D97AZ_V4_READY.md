# OCLP7 CHECKPOINT — 2026-09-04 — D97BA GOLDEN_B 15.8 static producer rebase PASS; G3 success reconfirmed; boot3m generation lane visibility INCONCLUSIVE; D97AZ V4 ready

## Authoritative architecture
`Tahoe native producer -> Golden-equivalent ingress contract -> ORIGINAL OCLP selector/donor -> Golden-equivalent compiler output -> Haswell driver handoff -> image`.

Remain in Golden until the Golden contract book is sufficient. Final Tahoe comparator uses the SAME ORIGINAL OCLP functional content, with only a separately audited minimal eligibility/OS-support bypass.

## Golden snapshots
- `GOLDEN_A`: Sequoia `15.7.9 / 24G830`, complete D97AU/D97AX/D97AY snapshot retained.
- `GOLDEN_B`: current Sequoia `15.8 / 24H22`, no EFI changes per user, manually re-root-patched with same original OCLP, accelerated GUI working.

## D97BA returned batch — exact local identities
User returned:
- JSON `OCLP7_D97BA_GOLDEN_SEQUOIA_15_8_PRODUCER_REBASE.json`: 10774 bytes / SHA256 `f702cd1bff179ce268d18d1ab42762f0e4fcba066b488de7fc3e1ae599444a48`;
- TXT `OCLP7_D97BA_GOLDEN_SEQUOIA_15_8_PRODUCER_REBASE.txt`: 16246 bytes / SHA256 `79f2aa9d3e65f14258e75d1459127b4f5801b492418d6a750550a478df1a3ad4`.

D97BA final core audit completed with no system mutation, cache mmap/extraction, debugger attach, Root Patch or reboot.

## Original OCLP donor identity survives 15.7.9 -> 15.8
On GOLDEN_B D97BA revalidated:
- 32023 SHA `ddabe975cd2ff3e8854d92a102aedfea6f1a3e586eccd50259639182b29ee269`;
- 3802 SHA `85d4c285915c4d2094f3624d80fd2d0c4dd30994fc5150c22d1e6d2b58d67f40`;
- MTLCompilerService SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`.

Classification: `ORIGINAL_OCLP_DONOR_15_8_VS_15_7_9=BYTE_IDENTITY_PROVEN_FOR_32023_3802_SERVICE`.

Therefore original selector semantics and G2 donor-side schema remain valid. Original selector still maps `3802 -> Versions/3802`, `31001 -> Versions/32023`.

## G1 GOLDEN_B Metal producer static rebase — PASS
D97BA dynamically located exactly one Metal image in the 15.8 shared cache:
- text start `0x7FF80D343000`;
- text end `0x7FF80D5C5C3D`;
- cached Metal text SHA256 `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865`.

These absolute Metal text bounds are the same as GOLDEN_A.

All eight primary key xrefs retain the exact GOLDEN_A offsets:
- `llvmVersion +0x2D81F`;
- `requestType +0x2D832`;
- `sandboxTokens +0x2D914`;
- `targetData +0x2D939`;
- `data +0x2D95E`;
- `pluginPath +0x2D97F`;
- `client_name +0x2D9FD`;
- `APISpecifiedTimeoutInSeconds +0x2DA13`.

Additional xrefs also remain:
- `requestType +0x1089E1`;
- `data +0xDB881`.

Classification:
- `G1_GOLDEN_B_METAL_PRIMARY_EIGHT_KEY_REQUEST_BUILDER_REBASE=STATIC_PROVEN_SAME_OFFSETS`;
- `SEQUOIA_15_8_PRIMARY_EIGHT_KEY_OFFSETS_MATCH_15_7_9=YES`.

No rediscovery via a full D97AY scan is needed before the next backslice.

## G3 GOLDEN_B success corridor — runtime observed
GOLDEN_B reports:
- Intel HD Graphics 4400 device `0x0412`, revision `0x000b`, Metal 2, internal display online;
- AppleIntelFramebufferAzul 18.0.8 loaded;
- AppleIntelHD5000Graphics 18.0.8 loaded.

Current boot start `2026-09-04 18:12:36`.
Positive chronology includes:
- driver load notifications at `18:13:31.615`;
- framebuffer/IGPU events at `18:13:34.269..34.284`;
- `Metal compositor activated.` at `18:13:35.728` and `18:13:35.730`.

Classification: `G3_GOLDEN_B_15_8_METAL_COMPOSITOR_SUCCESS=RUNTIME_OBSERVED`.

The same nil-IOGPU and restricted-lookup warnings seen on working GOLDEN_A also occur on working GOLDEN_B and remain non-failure-specific by themselves.

## D97BA boot3m MTL generation lane — printed classification corrected
Raw D97BA boot3m MTL data:
- records `0`;
- 32023 `0`;
- 3802 `0`;
- other `0`;
- no generation PIDs.

The core printed `G1_SEQUOIA_15_8_BOOT3M_GENERATION_LANE=RUNTIME_OBSERVED`, but that label is too strong and is RETRACTED.

Because the same boot has working acceleration and reaches `Metal compositor activated`, zero MTL records are not evidence that no compiler traffic occurred. This is an observation-channel/log-query visibility result only.

Authoritative classification:
`G1_GOLDEN_B_15_8_BOOT3M_GENERATION_LANE=INCONCLUSIVE_VISIBILITY_CHANNEL_ZERO_RECORDS`.

Do NOT infer 32023/3802 absence from D97BA.
GOLDEN_A D97AU dual-generation runtime evidence remains authoritative for the 15.7.9 snapshot until a GOLDEN_B runtime channel is recovered.

## D97AZ status and next backslice
D97AZ V3 on 15.8 correctly fail-closed at the old GOLDEN_A OS pin and produced no backslice result.
D97BA now proves that the exact request-builder addresses needed by D97AZ remain valid on GOLDEN_B.

Authoritative next wrapper:
`OCLP7_D97AZ_V4_GOLDEN_15_8_METAL_REQUEST_BUILDER_VALUE_BACKSLICE_PINNED_HARDENED_WRAPPER.command`
- wrapper commit `f0387a32d91abffb8f64e9d068ee3091dd04a0fe`;
- wrapper Git blob `70ef7429a6a4daf2312f20892e12a887f0c9a307`.

Unchanged D97AZ core:
- commit `fb509db4b1e40c8e9c466fed45b53c8462ed408c`;
- blob `fec92ab86cad92cc69307284c6ad3cd26ed74c19`.

V4 transforms only:
1. OS pin `15.7.9 -> 15.8`;
2. build pin `24G830 -> 24H22`;
3. primary range start to exact proven xref boundary `0x7FF80D37081F`;
4. alternate data range start `0x7FF80D41E881`;
5. alternate requestType range start `0x7FF80D44B9E1`;
6. signed rel32 translation for the temporary diagnostic Mach-O.

Before running the backslice V4 also verifies current cached Metal text SHA256 exactly equals `f3e49d47c9c62baaa90ad483836a1a859696b61010c96664c56441a5f6c28865` over `0x7FF80D343000..0x7FF80D5C5C3D`.

## CURRENT ACTION
Remain in GOLDEN_B Sequoia `15.8 / 24H22`.
Run only D97AZ V4.
Goal: pair all eight request-builder key xrefs with their setters and backslice the XPC value argument, prioritizing exact source/value for `llvmVersion` and `requestType`, then the other six. Keep alternate `data`/`requestType` paths separate.

No debugger attach, persistent instrumentation, system mutation, Root Patch or reboot.
Do not start Tahoe eligibility bypass yet.
