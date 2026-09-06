# OCLP7 CHECKPOINT — 2026-09-06 — D97CT persistent state diagnostic design ready

Authority: supersedes `OCLP7_CHECKPOINT_20260906_D97CS_IOKIT_LIFECYCLE_PASS_PERSISTENT_STATE_CHANNEL_READY.md` for current action.

## Proven runtime facts
- D97CO exact kext is loaded at runtime on ASUS2.
- `-igfxvesa -ocmcdiag` are active.
- OCLPMetalCompat IOKit service is active and `IOMatchedAtBoot=Yes`.
- `VersionInfo=DBG-001-2026-09-06` matches the compiled diagnostic build.
- Unified-log absence of D97CO markers is an observation-channel ambiguity, not plugin-lifecycle failure.

## D97CT design
The next diagnostic preserves D97CO behavior but replaces early log dependence with persistent IORegistry state.

Callback constraints:
- Apple `_cs_validate_page` first;
- exact page/path/build/CPU/bootarg gates retained;
- page data remains const/read-only;
- callback updates bounded atomic state only;
- no IORegistry property writes inside the validation callback.

Async publisher:
- preallocated `thread_call`;
- periodic bounded early-boot polling;
- mirrors atomics into `OCLPMetalCompat` service properties after IOKit service availability;
- publishes route/site/cave results and Apple validated/tainted/nx values.

No D97BV functional bytes, no Root Patch, no accelerated boot.

## CURRENT ACTION
IMAC 9900K: compile/audit D97CT using the already authorized local build lane.
ASUS2: no change until a new identity-pinned audited diagnostic kext is supplied.
