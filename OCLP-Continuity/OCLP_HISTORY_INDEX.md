# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_D97BO_FULL_PASS_NO_DIRECT_INTERSECTION_CONSTRUCTOR_SELECTOR_DATAFLOW_D97BP_NEXT.md`.
Strategic retrospective: `OCLP_PROJECT_RETROSPECTIVE_20260827.md`.

This is the high-level chronological index. Detailed evidence remains in `OCLP-Continuity/checkpoints/`; current state is in MASTER and the permanent database.

## Project end goal
Tahoe `26.6.2 / 25G82` on ASUS2, Intel Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`, stable hardware-accelerated GUI.

## Durable architecture / methodology
Historical accepted functional baseline:
`P1 + P2b + P3 + AIR00 + D34`.

P6/P7 insufficient. D50/D68/D82 reserve-only. D84 retired. D36-D44 invalidated for D34 cave overlap.

Core adapter principle:
`Tahoe-native producer -> earliest non-equivalent handoff -> adapter/normalizer -> unchanged working legacy donor path -> image`.

## 2026-09-01 to 2026-09-04 — D97 provenance / producer closure
Golden request-builder and selector contract closed:
- cached Metal builder `0x7FF80D370756..0x7FF80D370C28`;
- `[ABI arg1 +0x20] -> llvmVersion`;
- `[ABI arg2 +0x08] -> requestType`;
- `[ABI arg2 +0x18] -> timeout`;
- `[ABI arg2 +0x70]` sandbox gate;
- alternate requestType immediate `9`;
- original service selector `3802 -> Versions/3802`, `31001 -> Versions/32023`.

Golden dual-generation runtime and positive Haswell -> compiler -> Metal compositor corridor were established. P1 was reclassified as a downstream compatibility shim masking an upstream producer dialect difference.

## D97AA — failing Tahoe cohort generation proven
Accelerated Tahoe cohort: 12/12 observed MTLCompilerService requests carried exact `llvmVersion=32023`; 3802=0; other=0.

## 2026-09-05 — exact Golden OCLP lineage
Working Golden root patch pinned to OCLP `2.5.0`, PatcherSupportPkg `1.9.6`, upstream commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`.

## D97BH / BI / BJ — Tahoe 25G82 Root Patch lane
D97BH proved exact local `MetallibSupportPkg-26.6.2-25G82` works. D97BI proved exact b9df76 requests nonexistent `13.2.1-25/Metal.framework`. D97BJ forced `13.2.1-24`, added exact 25G82 metallib map/local handling, and completed Root Patch/AuxKC successfully.

## D97BK — accelerated failure reclassified: not kernel panic
Both accelerated boots reached WindowServer running. Essential services died because Tahoe IOGPU Metal4 classes could not resolve `_MTL4*` superclasses after full legacy Metal.framework merge; launchd committed orderly shutdown.

Permanent classification:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

## D97BL — native-Metal selective hybrid phase
Required architecture:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited boundary adapters -> Haswell driver -> image`.

Donor audit proved:
- `12.5-3802-23` can be bounded to `MTLCompilerService.xpc` only;
- `13.2.1-24/Versions/A/Metal` shadows cache-resident native Metal and is forbidden.

Historical native-Metal + legacy-XPC/private-compilers + true-five was already tested and failed, so repeating it is rejected as no-new-information.

## D97BM — exact native Tahoe shared-cache producer PASS
Native Metal:
- start `0x7FF80F47D000`;
- `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

Native MTLCompilerService SHA256:
`4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.

Native Metal4 `_MTL4*` and corresponding IOGPU class-name surface was present. D97BM found two complete eight-key request-builder clusters.

## D97BN v1 — two Tahoe request layouts
### Builder A
`0x7FF80F635510..0x7FF80F635A4D`
- llvmVersion `[arg1+0x1C]`;
- requestType helper `+0xAC` from arg2 object;
- timeout helper `+0xB8` from same family.

### Builder B
`0x7FF80F663CA9..0x7FF80F66492C`
- llvmVersion `[arg1+0x38]`;
- requestType same `+0xAC` helper family from subordinate `[arg1+0x28]`;
- timeout same `+0xB8` family.

Both alternate requestType paths use immediate `9`.

## D97BN v2 — generation + caller census FULL PASS
Bundle:
`OCLP7_D97BN_V2_GENERATION_AND_CALLER_COMPLETION_20260905_224128.zip`
- bytes `11417`;
- SHA256 `06f6c90e89bd384189d8e2179ebbcc0351f3783738bc24f3268e47d24562957d`.

Native Metal instruction census:
- 3802 raw 11 / validated 9;
- 31001 raw 0 / validated 0;
- 32023 raw 10 / validated 10.

Tahoe therefore retains real 3802 + 32023 generation machinery but has no 31001 immediate dialect.

Examples:
- `0x7FF80F596A81..0x7FF80F596A8C` returns 3802;
- `0x7FF80F614D86..0x7FF80F614D9F` initializes 3802 lane;
- `0x7FF80F614DB8..0x7FF80F614DD1` initializes 32023 lane.

Builder A has three direct E8 callers; two wrapper callers source its arg1 from `[incoming object+0x38]`. Builder B has no direct E8 callers.

Strategic rule: do not transplant Golden `+0x20` globally and do not globally replace `32023 -> 31001`.

## D97BO — field-writer / generation-origin FULL PASS
Bundle:
`OCLP7_D97BO_LLVMVERSION_FIELD_WRITER_AND_GENERATION_ORIGIN_20260905_225120.zip`
- bytes `905767`;
- SHA256 `a83675a6f07bb330537d93d4011ae6688a0024f162cc8acd67756ecdc0ab6380`.

All final D97BO markers passed; no system/cache/source mutation.

### Native generation singleton architecture
- 3802 initializer stores factory object in global `0x7FF843D65C90`;
- 32023 initializer stores factory object in global `0x7FF843D65CB0`;
- selector `0x7FF80F5EFFEB..0x7FF80F5F009C` explicitly distinguishes 3802/3902/32023/32024 and returns corresponding singleton.

Classification:
`TAHOE_NATIVE_GENERATION_SINGLETON_SELECTOR_3802_32023=STATIC_PROVEN`.

### Generation-aware object constructor candidate
Function `0x7FF80F4A5DF8..0x7FF80F4A7A88` contains explicit 32023 logic and request-layout-like writes:
- compare local `-0x27C` to 32023 at `0x7FF80F4A6283`;
- local `-0x3A0` -> `+0x1C(%r13)` at `0x7FF80F4A726F`;
- separate field -> `+0x20(%r13)`;
- 16-byte block -> `+0x38(%r13)`;
- local `-0x2C4` -> `+0x38(%r8)` at `0x7FF80F4A79CE`.

This is high-priority STATIC-MAPPED evidence but not yet proof that the exact object reaches Builder A/B.

### No direct one-hop bridge
No broad displacement-writer function directly calls known generation functions or references generation singleton globals. No broad writer contains a 3802 immediate. Only three broad writers contain 32023 immediates; the large constructor above is the only high-value object-layout candidate.

Therefore a simple one-instruction/one-global normalization site is not yet proven.

## CURRENT ACTION — D97BP
Remain unpatched in Tahoe VESA.

Read-only D97BP must:
1. back-slice constructor locals `-0x3A0`, `-0x2C4`, discriminator `-0x27C` inside `0x7FF80F4A5DF8..0x7FF80F4A7A88`;
2. map direct callers and argument/object provenance of that constructor;
3. map direct callers of generation selector `0x7FF80F5EFFEB..0x7FF80F5F009C` and EDX source at each call;
4. compare those dataflow objects against Builder-A wrapper and Builder-B shapes;
5. prove or reject one natural upstream adapter boundary.

No Root Patch and no accelerated reboot are authorized.
