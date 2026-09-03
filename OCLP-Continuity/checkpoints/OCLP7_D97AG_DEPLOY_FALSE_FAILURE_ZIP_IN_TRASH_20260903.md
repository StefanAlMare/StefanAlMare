# OCLP7 D97AG — DEPLOY FALSE FAILURE; EXACT VERIFIED ZIP FOUND IN TRASH

Date: 2026-09-03 EEST
Parent authority: `OCLP7_CHECKPOINT_20260903_D97AG_ASUS2_ARTIFACT_RUNTIME_AUDIT_PASS_DEPLOY_NEXT.md`.

The first D97AG application deploy invocation used exact wrapper commit `fcd817dec08e1ff782316516f7d2432e2b5d51df`, git blob `e8dca8761903de7f612629ff85ea9ec81bc5d65c`, local SHA256 `64d7ceb501c8b909b7633a836c371257f1e2c48fd13d4f1f290095b6a4123c96`, 14858 bytes, with local zsh parse PASS.

The wrapper stopped fail-closed before any application mutation because the expected verified ZIP path `/Users/alex/Desktop/OCLP7_D97AG_VERIFIED_RUN33696449978_OpenCore-Patcher.app.zip` was absent. Returned state: `D97AG_EXACT_APP_DEPLOY_OPEN_STOP=FAIL_CLOSED|REASON=VERIFIED_ZIP_MISSING_OR_SYMLINK`, `INSTALLED_APP_MUTATION_STATE=NO`, recovery `NOT_REQUIRED_NO_APPLICATION_MUTATION`, Root Patch AUTO-NO, reboot AUTO-NO. D97AF live therefore remains the last proven installed application and was not touched by this attempt.

A bounded read-only ASUS2 search found exactly one candidate at `/Users/alex/.Trash/OCLP7_D97AG_VERIFIED_RUN33696449978_OpenCore-Patcher.app.zip`. It is a regular non-symlink file, exactly `751494420` bytes, SHA256 `d6cc47143cee0a2bde55ab3de66b15fc39969299db175f9a336e615fb8e10846`, therefore byte-identical to the previously audited/reassembled D97AG application ZIP. Classification: `D97AG_DEPLOY_FIRST_ATTEMPT=TOOLING_INPUT_LOCATION_FALSE_FAILURE_NO_APPLICATION_MUTATION`; no re-download or rebuild is required.

## Current bounded next action
ASUS2-only: move the exact verified ZIP from the Trash path back to the exact expected Desktop path, then immediately re-verify size and SHA256 and STOP. No `/Applications` mutation, no OCLP launch, no Root Patch, no reboot. Only after that restore is returned PASS may the already-published exact D97AG deploy wrapper be rerun.