# OCLP PROJECT HISTORY INDEX — ASUS2 / OCLP1 -> future phases

Updated: 2026-09-05 EEST
Master authority: `OCLP_MASTER_CONTINUITY.md`.
Permanent consolidated database: `OCLP_PERMANENT_PROJECT_DATABASE.md`.
Permanent rules: `OCLP_PERMANENT_WORKING_RULES.md` + `OCLP_PERMANENT_VESA_RECOVERY_RULE.md`.
Current checkpoint: `OCLP7_CHECKPOINT_20260905_D97BP_FULL_PASS_SHARED_GENERATION_ACCESSOR_SELECTOR_ARG_CORRECTION_D97BQ_NEXT.md`.
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
- alternate requestType immediate `9`;
- original service selector `3802 -> Versions/3802`, `31001 -> Versions/32023`.

Golden dual-generation runtime and positive Haswell -> compiler -> Metal compositor corridor were established. P1 became a downstream compatibility shim masking an upstream producer dialect difference.

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

## D97BN — two Tahoe request layouts + generation census
### Builder A
`0x7FF80F635510..0x7FF80F635A4D`
- llvmVersion `[arg1+0x1C]`;
- requestType helper `+0xAC` from arg2 object;
- timeout helper `+0xB8`.

### Builder B
`0x7FF80F663CA9..0x7FF80F66492C`
- llvmVersion `[arg1+0x38]`;
- requestType same `+0xAC` helper family from subordinate `[arg1+0x28]`;
- timeout same `+0xB8` family.

Both alternate requestType paths use immediate `9`.

D97BN-v2 generation census FULL PASS:
- 3802 raw 11 / validated 9;
- 31001 raw 0 / validated 0;
- 32023 raw 10 / validated 10.

Tahoe retains real 3802 + 32023 machinery but no 31001 immediate dialect. Builder A has three direct E8 callers; Builder B has no direct E8 callers.

Strategic rule: do not transplant Golden `+0x20` globally and do not globally replace `32023 -> 31001`.

## D97BO — field-writer / generation-origin FULL PASS
Generation singleton architecture:
- 3802 initializer -> global `0x7FF843D65C90`;
- 32023 initializer -> global `0x7FF843D65CB0`;
- selector `0x7FF80F5EFFEB..0x7FF80F5F009C` distinguishes 3802/3902/32023/32024 and returns matching singleton.

Generation-aware constructor candidate `0x7FF80F4A5DF8..0x7FF80F4A7A88` contains explicit 32023 logic and request-layout-like writes to `+0x1C/+0x20/+0x38`.

No direct generation-function/global -> broad writer one-hop bridge was found.

## D97BP — constructor/selector dataflow FULL PASS
Bundle:
`OCLP7_D97BP_CONSTRUCTOR_SELECTOR_DATAFLOW_20260905_230558.zip`
- bytes `20273`;
- SHA256 `22258abc2b4ce017cb77ae20f1c93baff4377428d18642b2e80f18eb6ef541d2`.

All D97BP final markers passed; no mutation.

### Constructor discriminator
Constructor calls `0x7FF80F5E16C3` on a generation-bearing object and stores EAX into local `-0x27C`. `[constructor arg1+0x138]`, if nonzero, overrides that discriminator. Final value is compared against 32023.

### Shared generation accessor — new common frontier
Multiple native generation-selector callers show the same pattern:
`object -> call 0x7FF80F5E16C3 -> movl %eax,%esi -> call selector 0x7FF80F5EFFEB`.

Thus the constructor and selector paths share exact generation accessor `0x7FF80F5E16C3`.

Classification:
`D97BP_SHARED_GENERATION_ACCESSOR_BETWEEN_CONSTRUCTOR_AND_SELECTOR=STATIC_PROVEN`.

### Tooling correction
D97BP scripted selector caller analysis traced RDX; this is retired for generation semantics. Raw caller contexts show accessor return copied into ESI immediately before selector call. Exact selector ABI propagation remains pending.

Classification:
`D97BP_SELECTOR_GENERATION_RDX_BACKSLICE=TOOLING_WRONG_REGISTER_RETIRED`.

### Direct call graph remains negative
Constructor has no direct E8 caller; selector has six. No selector->constructor, selector->Builder-A or constructor->Builder-A/B E8 path within depth 8. Object/dataflow is therefore the active frontier.

## CURRENT ACTION — D97BQ
Read-only collector:
`OCLP7_D97BQ_shared_generation_accessor_selector_abi.sh`
- bytes `22773`;
- SHA256 `228978fc900358958963c25acf1bf47add6fd7a05b8ba79ed8f2f25bc1746f25`.

D97BQ must map:
- accessor `0x7FF80F5E16C3` return source/object field;
- selector entry ABI generation argument and propagation to 3802/32023 compares;
- corrected selector-caller back-slices on the proven register;
- all direct accessor callers and stores of accessor result;
- constructor shared-accessor call + `arg1+0x138` override;
- Builder-A wrapper ancestry intersection with accessor/selector callers.

Remain unpatched in Tahoe VESA. No Root Patch and no accelerated reboot are authorized.
