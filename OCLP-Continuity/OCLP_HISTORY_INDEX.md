# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_D97BN_V2_FULL_PASS_ZERO_31001_TWO_LAYOUTS_D97BO_FIELD_WRITER_ORIGIN_NEXT.md`.
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

Golden dual-generation runtime and positive Haswell -> compiler -> Metal compositor corridor were established. P1 was reclassified as a downstream compatibility shim that masks an upstream producer dialect difference.

## D97AA — failing Tahoe cohort generation proven
In the accelerated cohort, 12/12 observed MTLCompilerService requests carried `llvmVersion=32023`; 3802=0 and other=0. This rejected compiler-generation misclassification as an explanation for the late validator frontier, but later became important when compared with Golden dual-generation behavior.

## 2026-09-05 — exact Golden OCLP lineage
Working Golden root patch pinned to OCLP `2.5.0`, PatcherSupportPkg `1.9.6`, exact upstream commit `b9df76ebdf3e768b37c1cc980e8444aa837c623e`, tree `7c3411fde7d40604164c8877a5ab5594448083ac`.

## D97BH / BI / BJ — Tahoe 25G82 Root Patch lane
D97BH proved exact local `MetallibSupportPkg-26.6.2-25G82` works. D97BI proved exact b9df76 asks for nonexistent `13.2.1-25/Metal.framework`. D97BJ forced legacy `13.2.1-24`, added exact 25G82 metallib map/local handling, and completed Root Patch/AuxKC successfully.

## D97BK — accelerated failure reclassified: not kernel panic
Two accelerated attempts reached WindowServer running. No panic report/backtrace existed. Essential services repeatedly died because Tahoe IOGPU Metal4 classes could not resolve `_MTL4*` superclasses after full legacy Metal.framework merge; launchd committed orderly shutdown.

Permanent classification:
`D97BJ_FULL_METAL_FRAMEWORK_13_2_1_24_ON_TAHOE=ABI_INCOMPATIBLE_NEGATIVE`.

## D97BL — native-Metal selective hybrid phase
Required architecture became:
`native Tahoe Metal / Metal4 ABI -> selective legacy 3802 ingress -> audited boundary adapters -> Haswell driver -> image`.

Donor audit proved:
- legacy `12.5-3802-23` can be bounded to `MTLCompilerService.xpc` only;
- `13.2.1-24/Versions/A/Metal` shadows the native cache-resident Metal image and is forbidden.

Historical native-Metal + legacy-XPC/private-compilers + true-five was already tested and failed to yield usable GUI, so repeating it is rejected as no-new-information.

## D97BM — exact native Tahoe shared-cache producer PASS
D97BM mapped exact 25G82 Metal and IOGPU from dyld shared cache.

Native Metal:
- start `0x7FF80F47D000`;
- `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

Native MTLCompilerService:
`4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`.

Native Metal4 `_MTL4*` and corresponding IOGPU class-name surface was present.

D97BM found two complete native eight-key request-builder clusters.

## D97BN v1 — two Tahoe request layouts, tooling stop after useful PASS
### Builder A
`0x7FF80F635510..0x7FF80F635A4D`
- llvmVersion `[arg1+0x1C]`;
- requestType helper reads `+0xAC` from arg2 object;
- timeout helper reads `+0xB8` from same object family.

### Builder B
`0x7FF80F663CA9..0x7FF80F66492C`
- llvmVersion `[arg1+0x38]`;
- requestType uses same `+0xAC` helper family from subordinate object `[arg1+0x28]`;
- timeout uses same `+0xB8` family.

Both alternate requestType paths use immediate `9`.

V1 then stopped fail-closed on oversized function disassembly. No mutation.

## D97BN v2 — generation census + caller census FULL PASS
Bundle:
`OCLP7_D97BN_V2_GENERATION_AND_CALLER_COMPLETION_20260905_224128.zip`
- bytes `11417`;
- SHA256 `06f6c90e89bd384189d8e2179ebbcc0351f3783738bc24f3268e47d24562957d`.

Final markers PASS for generation census, builder caller census and audit.

Exact native Metal instruction census:
- 3802: raw 11 / instruction-validated 9;
- **31001: raw 0 / validated 0**;
- 32023: raw 10 / validated 10.

Thus Tahoe native Metal retains real 3802 and 32023 generation machinery but has no 31001 immediate dialect at all.

Important static examples:
- tiny function `0x7FF80F596A81..0x7FF80F596A8C` returns exact 3802;
- `0x7FF80F614D86..0x7FF80F614D9F` initializes a 3802 generation lane;
- `0x7FF80F614DB8..0x7FF80F614DD1` analogously initializes 32023;
- multiple functions classify 3802 vs the 32023/32024 family.

Builder A has three direct E8 callers; two wrapper callers source its arg1 from `[incoming object+0x38]`. Builder B has no direct E8 callers, implying indirect/virtual/non-E8 ingress.

### Strategic consequence
Do not transplant Golden `+0x20` layout globally and do not globally replace `32023 -> 31001`. Tahoe has two valid native layouts and legitimate 32023 logic. The 12/12 runtime 32023 cohort must be traced to the object-field writers/generation-selection origin.

## CURRENT ACTION — D97BO
Remain unpatched in Tahoe VESA. Perform only a read-only field-writer/generation-origin audit:
- locate writes to Builder-A `+0x1C` and Builder-B `+0x38` llvmVersion fields;
- map Builder-A caller object provenance;
- map callers/dataflow of 3802-return and 3802/32023 initializer functions;
- connect generation selection to request-object fields where statically possible.

No Root Patch and no accelerated reboot are authorized.