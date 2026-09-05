# OCLP7 CHECKPOINT — 2026-09-05 — D97BT full PASS; default accessor-wide 3802 suppression closed; explicit env override remains intentional exception

## Entering state
- Tahoe `26.6.2 / 25G82`, Haswell HD4400/4600 `8086:0412`, SMBIOS `MacBookAir6,2`.
- Current machine remains unpatched VESA; `-igfxvesa` active; no Root Patch.
- Native Tahoe Metal remains cache-resident and authoritative.
- No Root Patch or accelerated reboot authorized.

## D97BT returned bundle
`OCLP7_D97BT_OVERRIDE_PRODUCER_AND_LAZY_FLOOR_20260905_235137.zip`
- bytes `3719`;
- SHA256 `6741153378f842849df5436ad3ea7734f7e79607aa33f3edbb7131cedaf18197`.

All collector final markers PASS:
- `D97BT_OVERRIDE_PRODUCER_CFG=PASS`;
- `D97BT_OVERRIDE_PRODUCER_RETURN_CENSUS=PASS`;
- `D97BT_LAZY_FLOOR_FORMALIZATION=PASS`;
- `D97BT_ESCAPE_SEMANTIC_CLOSURE=PASS`;
- `D97BT_AUDIT=PASS`.

No mutation, Root Patch or reboot.

## Native identity revalidated
- native MTLCompilerService SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- native cached Metal `__TEXT` SHA256 `bf405828f42ba59e68273190ac19b70aa0c3d1d4b34de6dc49de206dd5b04605`.

## Lazy fallback semantics — both branches suppress 3802
Lazy block `0x7FF80F5E1624..0x7FF80F5E16C3` has two generation floors:

### First lazy write
`0x7FF80F5E165A`: load candidate EAX
`0x7FF80F5E1660`: compare EAX with `32024`
`0x7FF80F5E1665`: ECX=`32023`
`0x7FF80F5E166A`: `cmovge EAX,ECX`
`0x7FF80F5E166D`: store ECX

Semantics: stored value = `max(candidate,32023)`.
Therefore 3802 becomes 32023.

### Second lazy write
`0x7FF80F5E16A0`: load candidate EAX
`0x7FF80F5E16A6`: compare EAX with `32025`
`0x7FF80F5E16AB`: ECX=`32024`
`0x7FF80F5E16B0`: `cmovge EAX,ECX`
`0x7FF80F5E16B3`: store ECX

Semantics: stored value = `max(candidate,32024)`.
Therefore 3802 becomes 32024.

The collector printed `PROOF=False` for the second write only because its verifier was hard-coded for the first 32024/32023 pair. Raw instructions prove the second floor independently.

Classifications:
- `D97BT_LAZY_FIRST_WRITE_3802_TO_32023=SEMANTIC_PROVEN`;
- `D97BT_LAZY_SECOND_WRITE_3802_TO_32024=SEMANTIC_PROVEN`;
- `D97BT_LAZY_FALLBACK_PRESERVES_3802=NEGATIVE`.

## Explicit override path identified
Global override writer `0x7FF80F612AF4..0x7FF80F612B0E` uses exact key string:
`MTL_FORCE_MTLCOMPILER_LLVM_VERSION`.

Writer passes:
- RDI = pointer to that environment/config key;
- ESI = `0` fallback;
- calls producer `0x7FF80F58A5F4..0x7FF80F58A623`;
- stores returned EAX into global `0x7FF843853E18`.

Producer semantics from raw code:
- saves fallback RSI;
- calls lookup function with key;
- if lookup returns NULL, returns fallback RSI, therefore `0` for this writer;
- if lookup returns non-NULL, forwards returned string pointer with zeroed RSI/RDX to a parser tail.

Thus the nonzero global path is an intentional explicit override mechanism, not ordinary generation selection. Current static global value is `0`, so this override is disabled in the current default environment.

The exact imported helper/parser symbol names remain to be resolved before claiming arbitrary numeric input semantics, but the key's purpose and zero-default bypass semantics are static-proven.

Classifications:
- `D97BT_OVERRIDE_KEY_MTL_FORCE_MTLCOMPILER_LLVM_VERSION=STATIC_PROVEN`;
- `D97BT_OVERRIDE_DEFAULT_VALUE_ZERO=STATIC_PROVEN`;
- `D97BT_CURRENT_OVERRIDE_GLOBAL_ZERO=STATIC_PROVEN`;
- `D97BT_OVERRIDE_PATH_IS_EXPLICIT_NONDEFAULT_EXCEPTION=STRUCTURAL_SEMANTIC_PROVEN`.

## Accessor-wide default behavior
Combine prior D97BR clamp proof with D97BT lazy fallback closure:
- main clamp path converts 3802 -> 32023;
- lazy fallback first branch converts 3802 -> 32023;
- lazy fallback second branch converts 3802 -> 32024;
- only explicit nonzero `MTL_FORCE_MTLCOMPILER_LLVM_VERSION` override bypasses these floors;
- current override is zero/disabled.

Therefore under the current/default environment:
`D97BT_DEFAULT_ENV_ACCESSOR_WIDE_3802_SUPPRESSION=SEMANTIC_PROVEN`.

Do NOT overstate this as absolute suppression under deliberate override.

## Strategic consequence
This is now a concrete upstream causal mechanism consistent with D97AA runtime evidence:
- Tahoe observed 12/12 requests as 32023;
- 3802 observed 0;
- Golden naturally uses a real 3802 lane.

The upstream repair candidate is the native Tahoe shared-generation accessor/floor boundary, not the downstream selector shim alone and not a global rewrite of 32023.

Before designing a patch, one remaining static task is required:
1. resolve the two external calls in override producer (`0x7FF80F68A77E` and parser tail target corresponding to synthetic `0x20c418`) to exact imported semantics;
2. audit the minimal complete-instruction patch window/cave strategy for preserving Tahoe's normal 32023/32024 behavior while allowing legacy 3802 only for the Haswell/legacy-required request class;
3. prove this adapter does not perturb native Metal4 ABI or unrelated request families.

## CURRENT ACTION
Remain unpatched in Tahoe VESA.

Prepare/run only a read-only D97BU override-helper + minimal-adapter preflight. No Root Patch and no accelerated reboot.
