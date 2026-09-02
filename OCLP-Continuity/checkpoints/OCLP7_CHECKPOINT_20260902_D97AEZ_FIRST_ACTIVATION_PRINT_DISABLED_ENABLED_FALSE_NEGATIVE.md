# OCLP7 checkpoint — D97AEZ first activation / `print-disabled` vocabulary false negative

Date: 2026-09-02 EEST

## Live result
The exact D97AEZ activation wrapper blob `484182b44283c338213faeae46b9c8b2592df744`, SHA256 `1fe59799df1e46822dca2ffb4a0d203bd8f06cc41923fa7cfc78c29acd81c115`, 39883 bytes ran once on ASUS2 and ended fail-closed RC2.

PASS before the failure:

- outer blob/SHA256/bytes;
- Tahoe `26.6.2 / 25G82 / x86_64`;
- payload commit/tree `b30a02fed23cdd75de880c90947f5c985571b53a` / `51b4df3c6935dbf818b5269c99a7752d71da2eba`;
- exact staged and installed runner/plist/helper identities;
- helper codesign and exact six-marker self-test;
- live service SHA256 `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- live final D97AD target SHA256 `524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755`, 1636896 bytes;
- exact root directories/files, empty launchd logs, exact immutable deploy record SHA256 `bdd4d5fa61614a82a1760d1505a2810b66f3575fac426288173867021c57f127`;
- activation boot UUID `85583BA8-8C7A-49F7-B7A5-F4D2E5285C3F`.

## Exact failure and classification
After successful `launchctl enable`, Tahoe emitted:

`"com.stefanalmare.oclp7.d97aez.boot-bound-one-shot" => enabled`

The wrapper required only the older boolean representation `=> false`. Therefore an actually enabled state was rejected as `OBSERVER_EXPLICIT_ENABLE_AUDIT_FAILED`.

Classification: `D97AEZ_PRINT_DISABLED_ENABLED_VOCABULARY=TOOLING_FALSE_NEGATIVE`. This is neither a D97AD failure nor accelerated-runtime evidence.

Fail-closed behavior passed: bootstrap was not reached; bootout found no loaded job; disable passed; observer is disabled and not loaded. The exact install/state/plist residue remains. No CLAIM, DONE, production-helper result or accelerated evidence exists. No OCLP, Root Patch, reboot, service launch/stop/control, target/Golden mutation occurred.

Transcript identity: 394 lines / 11259 bytes / blob `013404ddecab88a8e189536586f6837d4fb1d806` / SHA256 `4ff333dac5b22b6bfa1719a9baeaea58fd0b8b7f752a99edb4a2715a3fc27e80`.

## Correction contract
GitHub must produce one recovery activation wrapper that:

1. revalidates wrapper/payload/helper/live D97AD identities;
2. accepts recovery only from the exact fail-closed residue and same activation boot/deploy UUID;
3. recognizes exactly one label line and only semantic enabled forms `enabled` or boolean `false`;
4. rejects `disabled`, boolean `true`, absent, duplicate or ambiguous forms;
5. enables and bootstraps the unchanged observer, proves same-boot skip and no CLAIM/DONE/helper execution;
6. preserves AUTO-NO for OCLP, Root Patch, reboot and MTLCompilerService control;
7. is syntax/static/fixture/package/artifact audited in GitHub before ASUS2 execution.

## CURRENT ACTION
Assistant: implement and exhaustively audit the recovery correction in GitHub. User: STOP. Do not rerun the old wrapper, delete residue, open OCLP, Root Patch or reboot.

Baseline remains exactly P1+P2b+P3+AIR00+D34. Golden immutable/read-only. D50/D68/D82 reserve-only; D84 retired; Patch8 unauthorized.
