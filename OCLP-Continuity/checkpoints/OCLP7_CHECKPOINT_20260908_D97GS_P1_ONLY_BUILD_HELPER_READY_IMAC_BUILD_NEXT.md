# OCLP7 CHECKPOINT — D97GS P1-only build helper ready; Intel iMac build next

Date: 2026-09-08 EEST

## Entering authority
D97GR closed the currently measured MTLCompilerService NULL-call cause as missing P1 selector bridge:
- exact current service pre-SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- unique preimage `81fe19790000` at `0x3494`;
- exact P1 postimage `81fe177d0000`;
- only bytes `0x3496` and `0x3497` change;
- reconstructed SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`, exact historical P1/D97M identity;
- classification STATIC-STRUCTURAL-SEMANTIC PROVEN.

Current runtime crash therefore has a known bounded repair. No evidence currently justifies replaying P2b/P3/AIR00/D34 at the same time.

## D97GS integration principle
D97GS is derived from exact audited D97DX source/base and adds only one functional delta:
`P1 selector bridge`.

It does not modify the D97DX patch dictionary or metallib handling.
It does not add legacy main Metal, MetalOld, global 32023 rewrite, global 3802 forcing, P2b, P3, AIR00, or D34.

The P1 hook runs after all Root Patch patchset file installs and before root-volume rebuild/new APFS snapshot. This location guarantees:
- the final installed legacy `MTLCompilerService.xpc` is the object being checked/patched;
- no later patchset file copy can overwrite P1;
- metallib copy/materialization logic remains untouched.

Exact runtime guards in source:
- build must be `25G82`;
- model must be `MacBookAir6,2`;
- target must be exact MTLCompilerService path under mounted System root;
- accepted pre-SHA only `31a6f745...` or already-patched exact post-SHA;
- unique six-byte preimage at `0x3494` required;
- write is only the two differing bytes at `0x3496/0x3497` via root `dd` with `conv=notrunc`;
- final diff offsets must be exactly `[0x3496, 0x3497]`;
- final six-byte postimage required;
- final SHA must be exact historical P1 `a8716ffd...`;
- any mismatch raises and stops patching before snapshot.

## Build strategy
Build host remains the explicitly authorized home Intel iMac. No compilation on ASUS2.

D97GS helper reuses:
- exact b9df76 D97DX worktree `$HOME/Developer/OpenCore-Legacy-Patcher-D97DU-b9df76-Tahoe25G82`;
- exact pre-D97GS D97DX source diff SHA `c8b45d7f256a13b24f4569b342bd70bad8b45fa348f36395eb4c7e1ae2d24ca4`;
- exact audited D97DX outer-wrapper template ZIP SHA `2f84fcaf39eb6c5a917ebb7b878bf2bef495050981b52fbe41e971fa1fe5cf1a` when available, with validated app fallback;
- exact D97DX debug privileged helper SHA `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- unchanged audited D97DX launcher copied byte-for-byte.

Before build it requires:
- HEAD exact b9df76;
- `sys_patch.py` pristine relative to b9df76;
- current four-file D97DX diff SHA exact;
- current four-file changed-set exact;
- Python syntax/diff checks after P1 insertion;
- final changed-set exactly five files (the four D97DX files + `sys_patch.py`).

Build itself:
- x86_64 inner OCLP only;
- new full D97GS source diff embedded in wrapper alongside original D97DX base diff;
- debug helper and launcher must remain exact;
- output outer app/ZIP codesign verified;
- build performs no Root Patch/system/EFI/NVRAM/framebuffer mutation and no reboot.

## Helper authority
`OCLP-Continuity/artifacts/OCLP7_D97GS_IMAC_BUILD_P1_ONLY_FROM_D97DX.sh`
- commit `8f86bfa76282b3b1c5b9aca311e95324406224d5`;
- Git blob `b408d8d372ca6956db0caeb2a253df44acd7a5b9`.

## Current action
Run D97GS helper only on the authorized Intel iMac.
Return the full build report and output ZIP identity.

Do not yet transfer/run Root Patch on ASUS2 until the D97GS source diff and built artifact are independently audited.
No accelerated boot is authorized.
