# OCLP7 CHECKPOINT — 2026-09-06 — D97CL Lilu / DSC preflight PASS; D97CM map-parser parity next

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97CJ_OBJC_RELOCATION_TOPOLOGY_AUDIT_READY.md`.

## D97CJ returned evidence — standalone carrier mainline closure
Returned ZIP:
`OCLP7_D97CJ_OBJC_RELOCATION_TOPOLOGY_20260906_135939.zip`.

D97CJ reproduced the already-proven D97CI one-bit clear (`__objc_imageinfo` flags `0x49 -> 0x41`, XOR `0x08`) and the post-clear `libobjc.A.dylib readClass + 69` fault.

Raw LLDB evidence gives:
- `RAX=0x8` at `movq 0x18(%rax), %r15`, matching `EXC_BAD_ACCESS address=0x20`;
- `RBX=RDI=0x7FF843D60620`;
- D97CJ static `__objc_classlist[0]` value is exactly `0x7FF843D60620`;
- that class pointer is `__DATA + 0x7620` in the preferred shared-cache image;
- standalone runtime `__DATA` base is `0x134FA9000`, so expected relocated class address is `0x134FB0620`.

Therefore the class pointer handed to `readClass()` remains in preferred shared-cache VM form instead of the standalone runtime mapping.

The static topology is broad rather than a single-pointer anomaly:
- `__objc_classlist`: 422/422 in-image preferred pointers;
- `__objc_catlist`: 2/2 in-image preferred;
- `__objc_protolist`: 144/144 in-image preferred;
- `__objc_superrefs`: 385/385 in-image preferred;
- additional preferred/cache-like surfaces exist in `__got`, `__cfstring`, `__objc_selrefs`, `__objc_protorefs`.

The LLDB helper later failed on `SBFileSpec.GetPath()` API compatibility, so its final machine classifier reported missing markers. That is a tooling failure after decisive raw evidence, not a reversal of the runtime proof.

Authoritative classifications:
- `D97CJ_UNREBASED_OBJC_CLASSLIST_POINTER_CURRENT_READCLASS_CAUSE=RUNTIME_STRUCTURAL_PROVEN`;
- `D97CJ_BROAD_STANDALONE_OBJC_CACHE_RELOCATION_STATE=PROVEN`;
- `D97CJ_AUTOMATED_LLDB_HELPER_FINAL_CLASSIFIER=TOOLING_FAILURE_AFTER_DECISIVE_EVIDENCE`;
- `D97CJ_STANDALONE_METAL_CARRIER_PRODUCTION_MAINLINE=CLOSED`.

Do not repair individual ObjC pointers or continue standalone-carrier rehydration as the production path. Retain D97CD-D97CJ as causal/design evidence.

## Production direction promoted for evaluation
Preserve native Tahoe Metal/Metal4 inside dyld shared cache and evaluate a separate OCLP-specific Lilu plugin/kext that applies only the bounded selective-3802 runtime adapter where required.

This is **not** a modification of Lilu itself and is **not** a mandate to enlarge WhateverGreen. Lilu is treated as generic userspace/shared-cache patching infrastructure; OCLP-specific compatibility logic belongs in a separate plugin/kext under OCLP hardware/OS gating.

## D97CL returned evidence
Returned ZIP:
`OCLP7_D97CL_LILU_DSC_RUNTIME_PREFLIGHT_20260906_150640.zip`
- ZIP SHA256 `3f97d2b82765d5e1a847b8c0a0ad1982fcced6c5c1978ff282f177ea39dd1f4e`;
- TXT final SHA256 `ee9762f22ad15ed7185c184b5246298e091bdf9a97d44b07a56d402bb6c56774`;
- embedded pre-append report SHA256 `5443d54ea576d0739723eb0d501e86fc9f050abb64f2b8bacf12072cd2c28f58`, verified exactly as SHA256 of the report excluding its final `REPORT_SHA256=` line.

Environment:
- macOS `26.6.2 / 25G82`, Darwin `25.6.0` x86_64;
- CPU `Intel Core i3-4005U`, AVX2 present;
- Lilu `1.7.3` loaded;
- WhateverGreen `1.7.1` loaded;
- `-liluuseroff` absent;
- `-liluslow` absent;
- expected Lilu fast-cache variant `x86_64h`.

Exact Tahoe cache substrate:
- `/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld/dyld_shared_cache_x86_64h` readable, bytes `888668160`;
- matching `.map` readable, bytes `1156310`;
- `/System/Library/Frameworks/Metal.framework/Versions/A/Metal` is present in that exact map;
- no x86_64 fallback map is present on this machine.

D97CL classifications:
- `D97CL_FAST_SHARED_CACHE_MAPPING_PRECONDITION=PASS`;
- `D97CL_EXPECTED_CACHE_BINARY_PRECONDITION=PASS`;
- `D97CL_USERPATCHER_BOOTARG_PRECONDITION=PASS`;
- `D97CL_NO_SYSTEM_MUTATION=PASS`.

Thus the **path/variant/existence** prerequisites for Lilu fast UserPatcher on Tahoe 25G82 are proven on ASUS2.

## Remaining pre-build uncertainty
D97CL deliberately did not prove that Lilu's `UserPatcher::mapAddresses()` parser interprets the exact Tahoe 25G82 `.map` record geometry for Metal correctly.

Current upstream parser behavior to parity-test:
- selects the Ventura+ Cryptex `x86_64h.map` on AVX2 CPUs;
- matches the target framework path;
- scans for `__TEXT`, first `->`, `__DATA`, and the subsequent parsed values;
- transfers `startTEXT/endTEXT/startDATA/endDATA` into `BinaryModInfo`;
- `patchSharedCache()` later uses `modStart + segment-relative offset + shared-cache slide`.

Because the D97CL grep shows the Metal path on its own output line, D97CM must emulate the exact Lilu parser against the real local Tahoe map and independently derive the Metal map block to verify parity rather than infer it.

## D97CM scope
Read-only, no mutation. It must:
1. pin `26.6.2 / 25G82` and the same `x86_64h.map` path;
2. print a bounded raw context around the exact Metal entry;
3. emulate the current Lilu `mapAddresses()` algorithm byte-for-byte/semantically on that map;
4. independently parse the Metal record/block and derive true `__TEXT` and `__DATA` ranges;
5. compare Lilu-emulated values against the independent values and against retained native Metal cache base `0x7FF80F47D000` where applicable;
6. report explicit PASS/NEGATIVE/PARTIAL classifications;
7. perform no Root Patch, reboot, install, compile, kext mutation or cache mutation.

## CURRENT ACTION
Remain unpatched VESA. Run only D97CM map-parser parity audit when provided and return its ZIP/output.

D97BV remains unapplied. No Root Patch, accelerated boot, installation or local compilation is authorized. GitHub Actions build/package remains suspended until explicit quota-unblocked confirmation.
