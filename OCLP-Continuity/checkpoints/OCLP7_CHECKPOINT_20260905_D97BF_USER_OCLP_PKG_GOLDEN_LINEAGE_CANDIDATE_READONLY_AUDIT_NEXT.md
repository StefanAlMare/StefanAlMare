# OCLP7 CHECKPOINT — 2026-09-05 — User OpenCore-Patcher.pkg is a strong Golden-lineage candidate; read-only package audit next

Status: **D97BF SUPPORTING EVIDENCE / EXECUTION-LANE REFINEMENT**.
Previous authoritative checkpoint: `OCLP7_CHECKPOINT_20260905_D97BF_GITHUB_BUILD_QUOTA_SUSPENDED_EXTERNAL_OR_LOCAL_MAC_BUILD_NEXT.md`.

## User-supplied TrueNAS Reader manifest
Batch:
`20260904T225753Z-dv103208c1-178bdb6a`

Path:
`ChatGPT-Inbox/Diverse/2026-09-05/20260904T225753Z-dv103208c1-178bdb6a/OpenCore-Patcher.pkg`

Identity supplied by Reader manifest:
- bytes: `738123183`;
- SHA256: `b4e32cbfb1f978f670ccafff7b513d352e0665366caa73faeed0dbcd428dc364`.

User states this package is also present on the current Mac and suspects it is the OCLP version used to patch the working ASUS Sequoia system.

## Golden source context
The working Golden root-patch manifest already pins:
- OCLP `2.5.0`;
- PatcherSupportPkg `1.9.6`;
- exact upstream commit `dortania/OpenCore-Legacy-Patcher@b9df76ebdf3e768b37c1cc980e8444aa837c623e`;
- exact tree `7c3411fde7d40604164c8877a5ab5594448083ac`.

GitHub commit metadata shows `b9df76...` was created on `2026-03-19T16:31:54Z` and is the exact source lineage already proven from the Golden root-patch manifest.

The exact `OpenCore-Patcher-GUI.spec` at this commit builds a PyInstaller `universal2` application and injects dynamic `Build Date` and `BuildMachineOSBuild` metadata. Therefore two packages from the same source commit are not expected to be byte-identical merely from source identity; packaging timestamps, signing/notarization state and build-host metadata may alter the final package bytes.

## Public 2.5.0 nightly comparator
A community-reshared `OpenCore-Patcher.pkg` identified as the March 19, 2026 OCLP 2.5.0 nightly was located on Google Drive.

Google Drive metadata for that comparator reports:
- filename: `OpenCore-Patcher.pkg`;
- bytes: `738128962`.

User package bytes:
- `738123183`.

Difference:
- `5779` bytes.

Classification:
`USER_PKG_BYTE_IDENTITY_TO_PUBLIC_RESHARED_2_5_0N=NEGATIVE_BY_SIZE`.

This **does not** disprove common source lineage because the exact Golden build spec contains dynamic build metadata and final PKG packaging may vary.

## TrueNAS Reader transport/tooling status
The account-level `TrueNAS ChatGPT Reader` plugin is installed/enabled, and prior project evidence proves a real Finder -> TrueNAS -> Reader GREEN path.

In the current assistant tool harness, the plugin's invokable namespace is not exposed even though the plugin is installed/enabled. The batch manifest reached the conversation, but the actual 738 MB PKG bytes were not exposed as a conversation/library file and therefore were not unpacked or inspected in this turn.

Classification:
`USER_PKG_ACTUAL_CONTENT_AUDIT=INCONCLUSIVE_TOOLING_PENDING_LOCAL_READONLY_AUDIT`.

Do not misclassify this as package incompatibility.

## Current package-lineage assessment
The package is a **strong Golden-lineage candidate**, because:
1. Golden is proven OCLP 2.5.0 / PatcherSupportPkg 1.9.6;
2. Golden exact source commit is dated 19 March 2026;
3. the known Sequoia 2.5.0 nightly lineage circulating for this use is also the 19 March 2026 build family;
4. the user's package is in the same ~738 MB packaging class;
5. final byte differences are technically compatible with dynamic build/package metadata.

But exact identity is not yet proven.

Classification:
`USER_PKG_GOLDEN_LINEAGE=STRONGLY_COMPATIBLE_NOT_YET_PROVEN`.

## Safety / modification rule
Do **not** modify or binary-patch this original PKG in place.
Preserve it as immutable evidence/reference with its supplied SHA256.

The preferred engineering route remains source-controlled reconstruction from exact Golden commit `b9df76...`, applying only the already-audited Tahoe eligibility delta:

```diff
-        _max_os = os_data.sequoia.value
+        _max_os = os_data.tahoe.value
```

No other functional source change is authorized.

## CURRENT ACTION
Before compilation, perform a **read-only local audit** of the user's existing `OpenCore-Patcher.pkg` on the current Mac to establish package lineage as strongly as possible without installing or modifying it. Audit should capture at minimum:
- local SHA256 and byte count and verify against Reader manifest;
- `pkgutil --check-signature` / package signature identity;
- expanded package metadata (`Distribution`, `PackageInfo`, BOM/component structure as applicable);
- embedded `OpenCore-Patcher.app` Info.plist version/build metadata;
- embedded executable architecture (`x86_64` / universal2);
- any recoverable OCLP 2.5.0 / PatcherSupportPkg 1.9.6 / commit-lineage markers.

This read-only audit is not compilation and does not require changing the local-compilation prohibition.

After lineage audit, D97BF still requires a controlled non-GitHub macOS build of exact Golden source plus the one-line Tahoe eligibility delta. Local compilation remains forbidden until the user explicitly authorizes it. GitHub compilation remains forbidden until the user explicitly states the Actions quota reset/unblocked.

No Root Patch is authorized.
No reboot is authorized.
Golden remains immutable/read-only.
