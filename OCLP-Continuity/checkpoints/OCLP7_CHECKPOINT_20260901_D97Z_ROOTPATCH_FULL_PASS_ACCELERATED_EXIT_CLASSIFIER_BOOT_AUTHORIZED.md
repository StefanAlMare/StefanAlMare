# OCLP7 CHECKPOINT — 2026-09-01 — D97Z Root Patch FULL PASS / accelerated exit-classifier boot authorized

## Retained question and classifier
The fatal-request `llvmVersion` remains runtime UNKNOWN until the D97Z accelerated boot is analyzed.

The installed universal terminal classifier is:
- exit `123` when EAX is exactly `3802` (`0xEDA`);
- exit `124` when EAX is exactly `32023` (`0x7D17`);
- exit `125` for every other EAX value.

Transport is the Darwin x86_64 exit syscall `0x2000001`, observable through launchd. Coverage is universal/no-PID and terminal/no-pass-through.

## Preceding D97ZA/D97Z FASTLANE
D97ZA/D97Z FASTLANE was already FULL PASS:
- D97V helper/call replaced by D97Z, not stacked;
- exact in-place block `0x25C3..0x25EB`;
- exact expected D97Z service SHA `2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- selector/control/P6/P7/D97 retained;
- build/package/deploy/fresh-process provenance PASS;
- Root Patch and reboot were not automatic.

## Manual Root Patch observed result — FULL PASS
The complete Root Patch output was audited.

### Patchset/preflight
- product/build remained Tahoe `26.6.2 / 25G82`;
- exact local metallib was found;
- Root Patching capability verified;
- Universal-Binaries.dmg mounted elevated;
- normal Metal 3802, metallib, Monterey GVA/OpenCL, Intel Haswell and Modern Wireless patchsets installed.

### MTLCompilerService selector and D97Z classifier
- selector bridge applied and verified: `31001 (0x7919) -> 32023 (0x7D17)`;
- `D97Z_SERVICE_PREIMAGE_SHA=a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- `D97Z_LLVMVERSION_EXIT_CLASSIFIER_SERVICE_SHA=2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- `D97Z_COMMITTED_SERVICE_SHA=2ce8d92c23060a3f5b9b883bd465e6e46b26013d801b6887cdedc43386f9b37c`;
- `D97Z_MTLCOMPILERSERVICE_LLVMVERSION_EXIT_CLASSIFIER=PASS`;
- block/exits logged exactly as `0x25C3..0x25EB; exit3802=123; exit32023=124; exitOther=125; universal_no_pid_filter; terminal_no_pass_through`.

### Retained MTLCompiler lineage
- request-layout bridge `request+0xD0 -> request+0x110` verified;
- serialized-bitcode path verified;
- AIR00 verified;
- D34 semantic-equivalent reset verified;
- true-five SHA exact `6e8969ee606b5e9321db2d4cf847a7ff6b32d46a9899b8eaa23e9c8f4f895c01`;
- all 12 P6 ports applied; committed SHA exact `4b7660f6ddebd615cca4e67667f2e29a29366aa5b872866cfa79592d2cb6be76`; PASS;
- both P7 ports applied; committed SHA exact `6e0e312d0f4dc1c79ce320e9691a77312df95f05e41602e4d0d64d1dc2724bda`; PASS;
- downstream D97 six-counter snapshot retained; committed MTLCompiler SHA exact `c46e864afa7c44f4e5aac36c8ac1976326ab363107513b96240c07649b20c118`; PASS.

### Completion
- patchset information written to root volume;
- RSRMonitor handling completed;
- new Auxiliary Kernel Collection built and forced;
- generic Catalina/Mojave compatibility notices were nonfatal and execution continued;
- APFS snapshot created;
- root volume unmounted;
- `Patching complete` reached;
- no traceback, rollback or failed stage appeared.

## Authoritative classification
**D97Z MANUAL ROOT PATCH FULL PASS.**

The deterministic launchd-visible classifier is installed in the new APFS snapshot. Runtime is still UNTESTED until the next accelerated boot.

## CURRENT SINGLE NEXT ACTION
Accelerated D97Z classifier boot is AUTHORIZED.

Procedure:
1. reboot normally into the root-patched accelerated configuration;
2. if no usable image appears, hard restart/power-cycle and boot the known VESA recovery configuration;
3. after returning in VESA, do not Root Patch, modify OCLP or reboot again;
4. run `last reboot | head -n 5 | tee ~/Desktop/OCLP7_D97Z_LAST_5_BOOTS.txt` and return the complete output.

The assistant will identify the exact accelerated/VESA pair and then analyze launchd accounting only for that accelerated boot. Expected decisive classifications are exit 123, 124, 125, or a request-varying mixture.

D82 remains reserve-only. Patch8 remains unauthorized.
