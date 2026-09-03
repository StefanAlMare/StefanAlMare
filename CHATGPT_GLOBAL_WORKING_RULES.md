# CHATGPT GLOBAL WORKING RULES

Updated: 2026-09-03 EEST
Scope: all current and future projects developed with ChatGPT for StefanAlMare, unless the user explicitly overrides a rule for a specific project.

This file is the durable cross-project infrastructure contract. It is intentionally project-independent.

## 1. Canonical infrastructure

### GitHub
- Account: `StefanAlMare`.
- GitHub is primarily for source code, scripts, workflow definitions, durable text documentation, small manifests/checkpoints, version control, and major/substantial compilation/build/package workloads when appropriate.
- GitHub Actions storage is not the permanent artifact archive.
- Avoid paid GitHub Actions storage. The user does not want extra storage charges.

### TrueNAS artifact vault
- Host reachable on the home LAN or through the user's VPN: `192.168.1.3`.
- TrueNAS hostname observed: `truenas2`.
- SMB port: `445`.
- SMB share: `Diverse`.
- TrueNAS dataset: `hddPool/Diverse`.
- TrueNAS local dataset path: `/mnt/hddPool/Diverse`.
- Canonical cross-project vault root inside the share: `ChatGPT-Projects`.
- Current measured free capacity at establishment: approximately `1.7 TiB`.
- Administrative SSH exists on port `2033`; root SSH is management-only and is not the normal artifact-transfer identity.
- Normal artifact transport uses SMB as the user's non-root account, unless a later explicit rule establishes a restricted dedicated SSH transfer account.

## 2. Cross-device rule

The TrueNAS vault is not tied to one workstation. Any user computer connected either to the home LAN or to the VPN may act as the transfer/audit workstation.

Canonical network locations:
- macOS / URL form: `smb://192.168.1.3/Diverse`
- Windows UNC form: `\\192.168.1.3\Diverse`
- Linux SMB target: `//192.168.1.3/Diverse`
- Logical project root after mounting: `ChatGPT-Projects`

Do not encode one workstation-specific local mount path as the durable identity of an artifact. Local paths such as `/Volumes/Diverse` are merely workstation mountpoints. Durable manifests identify the TrueNAS share/dataset plus relative vault path.

Each workstation may require a one-time local mount/authentication setup. Credentials, private keys, passwords, tokens, and VPN secrets must never be committed to GitHub or persisted in project manifests.

## 3. Default artifact lifecycle

For any project that produces large build outputs or other bulky artifacts, use this default lifecycle unless the user explicitly requests another one:

`source/version state -> build/compile -> local or CI audit -> cryptographic identity -> copy to TrueNAS vault -> re-hash/verify on TrueNAS -> write manifest -> only then delete disposable GitHub Actions artifacts`

A successful upload or copy by itself is not sufficient. Before a GitHub artifact is deleted, the TrueNAS copy must be independently verified against the expected byte size and SHA-256/digest whenever those identities are available.

Never delete the only known valid copy of an important artifact.

## 4. GitHub Actions storage discipline

- Large Actions artifacts are temporary delivery objects, not archives.
- Use the shortest practical retention for large artifacts.
- Prefer small reports/manifests on GitHub and large binary payloads in the TrueNAS vault.
- After a large artifact is safely archived and verified on TrueNAS, remove the GitHub Actions artifact when it is no longer required by an active local test/deploy step.
- Do not rerun a major build merely because a GitHub artifact was deleted when the exact build can be reconstructed from pinned source/provenance or a verified TrueNAS copy exists.
- If GitHub Actions included storage is exhausted or near exhaustion, stop creating unnecessary artifacts, archive existing required artifacts to TrueNAS, verify them, then delete disposable GitHub copies.
- The user does not authorize additional paid Actions storage merely to preserve artifacts that can live in the TrueNAS vault.

## 5. Vault structure

Canonical root:

`Diverse/ChatGPT-Projects/`

Established top-level structure:
- `_incoming/` — temporary landing zone; content is not authoritative until verified and promoted.
- `_manifests/` — global storage/identity manifests when not project-local.
- `OCLP/`
  - `builds/`
  - `artifacts/`
  - `reports/`
  - `archive/`
- `Hackintosh/`
- `Hardware/`
- `Other/`

New projects may receive their own top-level directory. Prefer meaningful project names over generic temporary names.

## 6. Integrity and manifest requirements

For important build artifacts, persist as many of the following as are available:
- project and phase/build name;
- source repository;
- branch/tag;
- exact commit/head SHA;
- workflow/run/job/attempt identity when GitHub Actions is involved;
- artifact ID and artifact name;
- source byte size;
- source SHA-256 or GitHub artifact digest;
- final TrueNAS relative path;
- TrueNAS byte size;
- independently recomputed TrueNAS SHA-256;
- inner payload SHA-256/size when an outer GitHub ZIP contains another build archive;
- audit status and date.

An `_incoming` file is temporary. A verified artifact should be promoted into the correct project path together with or referenced by a manifest.

## 7. Storage housekeeping

- Never automatically delete a `PINNED`, golden, authoritative, release, deployed-only-copy, or otherwise explicitly retained artifact.
- Prefer deleting disposable intermediate builds, duplicate payloads, superseded temporary archives, and caches before deleting validated releases/provenance artifacts.
- When capacity monitoring is implemented, use warning/cleanup thresholds rather than waiting for full-disk failure. Initial policy target: warning around 75% used and explicit cleanup review around 85% used; no destructive automatic purge of authoritative artifacts.
- Deduplication must be based on reliable identity (prefer SHA-256), not filename alone.

## 8. Workstation independence

A workflow must not assume that the user is on ASUS2, the MacBook Pro, a Hackintosh, Ubuntu, or another specific computer unless that project step genuinely requires that hardware.

Before giving a workstation-specific command, determine or use the currently stated workstation. Storage operations should be written so the current machine can be substituted without changing the durable artifact identity.

For hardware-bound projects, project-specific execution rules still govern where tests run. This global storage rule does not move hardware tests to another machine; it only makes the artifact vault accessible from whichever workstation is authorized for that step.

## 9. Security baseline

- Do not ask the user to send passwords, private SSH keys, GitHub tokens, SMB credentials, VPN secrets, or equivalent secrets in chat.
- Keep TrueNAS SSH password authentication disabled unless the user explicitly changes policy for an independent reason.
- Keep administrative root SSH separate from routine artifact transfer.
- Do not expose the TrueNAS SMB service directly to the public Internet for this workflow; use the home LAN/VPN path already established.
- Do not commit secrets to repositories or artifact manifests.

## 10. Relationship-wide default

For every new project with the user, when large files, compiled applications, packages, logs, datasets, archives, disk images, or other storage-heavy outputs are involved, apply this infrastructure policy by default:

1. keep durable code/state/provenance in GitHub where appropriate;
2. use GitHub compute only when the project warrants it;
3. do not treat GitHub Actions artifact storage as permanent storage;
4. archive large validated outputs to the TrueNAS `ChatGPT-Projects` vault;
5. verify integrity before deleting temporary cloud copies;
6. preserve only what is useful/authoritative and clean duplicates/intermediates deliberately;
7. remain workstation-independent and use any authorized user computer connected by LAN/VPN as the transfer/audit endpoint.

Project-specific permanent rules may add stricter requirements but should not silently weaken this global storage/integrity policy. If a project needs an exception, record the exception explicitly.
