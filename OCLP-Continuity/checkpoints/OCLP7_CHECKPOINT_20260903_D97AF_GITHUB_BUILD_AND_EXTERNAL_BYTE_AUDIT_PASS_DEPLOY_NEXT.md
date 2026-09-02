# OCLP7 CHECKPOINT — 2026-09-03 — D97AF GitHub build and external byte audit PASS / deploy next

## Authority and supersession
This checkpoint supersedes only the execution-state and `CURRENT SINGLE NEXT ACTION` sections of `OCLP7_CHECKPOINT_20260903_D97AF_LOCAL_SOURCE_INTEGRATION_PASS_BUILD_NEXT.md`.

The accepted D97AF static transform, exact local source integration and every earlier project invariant remain unchanged. This checkpoint proves the substantial Intel application build, the packaged-source semantic audit, the exact GitHub artifact bytes after external retrieval and the inner deployment ZIP/executable identities. It does not claim ASUS2 deployment, Root Patch, accelerated boot, runtime marker observation or direct runtime text-byte proof.

## Exact GitHub build provenance

```text
GITHUB_REPOSITORY=StefanAlMare/Private-Work
GITHUB_BRANCH=oclp7-d97af-github-build
GITHUB_HEAD=76d45e6d4f37ad394a9f30a61c8bfc97dc587c4e
GITHUB_TREE=d38841ced37fba37e1baf5f690651048b8aaf961
D97AD_PRIVATE_SNAPSHOT_COMMIT=1faab13865eb945198f3551688f11f1ba645e29a
D97AD_PRIVATE_SNAPSHOT_TREE=af55ab655116a36622895d48578e3655be52a9c3
D97AD_SNAPSHOT_TAR_SHA256=924e51da01e19eabc6d4f1051d1b4318e3ef1e80e0211e9eec65068d122c88de
WORKFLOW_PATH=.github/workflows/oclp7-d97af-build.yml
WORKFLOW_SHA256=c6db20d6f9862c97926df981c520e6022890f3f8dd9a70708b7f64aa3f95b4e9
WORKFLOW_GIT_BLOB=7ef6557aba36a9148f0c3723b80c36e15f3bf961
WORKFLOW_BYTES=30337
D97AF_MANIFEST_SHA256=5d2ad66d88964f769c0e13316cea5adfbd5e4bd7141d8bf846ec466df79ab983
D97AF_SOURCE_TRANSITION_PATCH_SHA256=fd708a3b7f1a0d914dd63781cabefad03f0d4d3569099ca6ff959a7311f4791e
D97AF_SOURCE_TRANSITION_PATCH_BYTES=18947
```

GitHub Actions workflow ID `348814365`, run `33686570072`, job `100435354962` completed `success` on `macos-15-intel`; the runtime runner architecture was exactly `x86_64`. Every returned step succeeded. Run URL:

```text
https://github.com/StefanAlMare/Private-Work/actions/runs/33686570072
```

## Exact source and packaged-app audit
The workflow reconstructed the exact D97AD snapshot, verified it independently against the stored, manifest and hard-coded SHA identities, and applied only the exact normalized two-file D97AF transition.

```text
D97AF_EXACT_SOURCE_TRANSITION=PASS
D97AF_MANIFEST_MISMATCHES={}
D97AF_SOURCE_SHA256=HELPERS|a240a3cb62ce25381ef6bd9e2d78e36dc379c25f9e9c5641e07cd9841e820d8e
D97AF_SOURCE_SHA256=SYSPATCH|ccf5ad96de9ef9051cc30ac61bf3c24522628f5e26122d6c0af5abb352f777c9
D97AF_SOURCE_SHA256=METAL_3802|fe751967a67d09d2b2b49a7fc360097db804208ff6893b6c46b7f44c246cdf24
D97AF_SOURCE_COMPILE_NOWRITE=PASS
D97AD_METHOD_SOURCE_SHA256=bb66b1d5d883251431d5a7fa7bc42c0cc9bcb15ec77c74506bb2eae5bf987a12
D97AF_METHOD_SOURCE_SHA256=d48d6daec4affdcd9469bf2bb60ddadddb5dc43cebbdfeb6051336a0766ee7b7
D97AF_D97AD_UNCHANGED=PASS
D97AF_EXACT_TWO_FILE_SOURCE_INTEGRATION=PASS
D97AF_SOURCE_AST_AND_CALL_ORDER_AUDIT=PASS
```

All active helpers occurred exactly once; retired D97/D97Z helpers occurred zero times. Exact order remained:

```text
P1 -> P2b -> P3 -> AIR00 -> D34 -> retained P6 -> retained P7 -> D97AD -> D97AF
```

The packaged PyInstaller code-object fingerprints matched the exact audited source for all three relevant modules:

```text
HELPERS_FINGERPRINT=189fb3079e2bdafc3374c6eacf4115c71d0cc40d1fe7007bd99b42e9bc3b2403
SYSPATCH_FINGERPRINT=61c43a1be0ebcccdef16473c66c8bc190802e55a4bd5ae6bb0a3efd5c0dee89b
METAL_3802_FINGERPRINT=0c3994d77d3396fc00967a155a1d70fea9d4337c2a865bbc05abfd05d80a54bf
D97AF_METHOD_FINGERPRINT=ab0e60bee86495e7a8c5ac61af3ccf5d4c44f7062a10429f17960137e9d9c111
D97AF_PACKAGED_THREE_MODULE_SEMANTIC_IDENTITY=PASS
PACKAGED_D97AD_UNCHANGED=PASS
PACKAGED_D97AF_PRESENT_EXACTLY_ONCE=PASS
PACKAGED_D97AF_UUID_AND_POST_SHA_CONTRACT=PASS
PACKAGED_METAL_3802_TAHOE_COMPILER_SUBSTRATE=PASS
OCLP7_D97AF_GITHUB_BUILD_AUDIT=PASS
```

The fingerprint result proves semantic equality of the relevant compiled Python code objects, not byte-for-byte reproducibility of the whole bundle. The build log explicitly skipped signing/notarization validation because its signing inputs were incomplete; no codesign/notarization PASS is claimed.

## In-run deployment identities

```text
PACKAGED_APP_EXECUTABLE_ARCH=x86_64
PACKAGED_APP_EXECUTABLE_BYTES=6595600
PACKAGED_APP_EXECUTABLE_MODE=100755
PACKAGED_APP_EXECUTABLE_SHA256=ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470
INNER_DEPLOYMENT_APP_ZIP_BYTES=751492703
INNER_DEPLOYMENT_APP_ZIP_SHA256=728dd30d7a4483bc7318300f3911e8aae8590f0d9ff59afbcf7db66651d8e907
BUILD_AUDIT_REPORT_SHA256=a85a5c610d5cef0fd17e7578dc28a71c9316b59f3aee2b3ae90f1b318135fe56
EXECUTABLE_FILE_REPORT_SHA256=115edfbb0f491dfee4825ae6adbfb627c4cdc32ee622987cc9d3fd62fbe22f77
EXECUTABLE_ARCH_REPORT_SHA256=aaf631698ae5160ceb04a97681a14887fdcab47cd6e0f163c87485b3b1340b62
SOURCE_AUDIT_REPORT_SHA256=b9de666fce9d37dccd17e5d6605f35523b9adfa117e2d55633eb337eff40845d
```

The original GitHub artifact is ID `9868515225`, name `OCLP7-D97AF-OpenCore-Patcher-v1`, `751567689` bytes, digest `sha256:70a123bfad81e00072ed2691fc769fa81c25f07c48a2ddb39a092d06d1947d9b`, expiry `2026-10-02T21:47:02Z`, and exact build head `76d45e6d4f37ad394a9f30a61c8bfc97dc587c4e`.

## Connector-size transfer and external byte audit
The connector correctly refused the original artifact because `751567689` exceeds its `536870912`-byte materialization ceiling. This was a transfer boundary, not a build or identity failure. A separately audited byte-only workflow retrieved the exact already-built artifact, verified its metadata and full archive SHA, split it without rebuilding, reassembled it byte-for-byte before upload, and made two connector-sized wrappers.

```text
SPLIT_BRANCH=oclp7-d97af-artifact-split-9868515225
SPLIT_HEAD=7e179f9d3fc5192a3104a3786e68a70e42dc6d92
SPLIT_TREE=7013d21c7201a02268cac441c38aed3f75b33203
SPLIT_WORKFLOW_ID=348823887
SPLIT_RUN_ID=33688046460
SPLIT_JOB_ID=100440104020
SPLIT_WORKFLOW_SHA256=ecda263f8e986e3ed8713c19c6f6e06c38ca32b459f3985eebf1830515cb3f04
SPLIT_WORKFLOW_GIT_BLOB=414109eac1f1635acd4a541f7db1562139eac376
SPLIT_WORKFLOW_BYTES=12098
SPLIT_RUN_CONCLUSION=success
PART_00_BYTES=400000000
PART_00_SHA256=746be42d75dd966ced4db4775d0b79125ed325669e37ee79823e7430361f35c7
PART_01_BYTES=351567689
PART_01_SHA256=0d5cfc369b33afb6488d61dc64f075caf776a9f4282a604bb739bf9d72e1ae5e
D97AF_EXACT_BYTE_SPLIT=PASS
D97AF_PREUPLOAD_REASSEMBLY=PASS
```

Split artifact `9868927216` (`PART-00`) is `400001834` bytes with wrapper digest `d03c1b2687a0b713d7b127ea805f70f4e99ff063bc8ec99e14f17c1cbec56407`. Split artifact `9868930032` (`PART-01`) is `351569523` bytes with wrapper digest `5f2502422803717e8468a4cac49767eb1ed2eeb96ecd6197d9ca3f5c255729b2`. Both belong to split run `33688046460` / head `7e179f9d3fc5192a3104a3786e68a70e42dc6d92`, are unexpired, and passed the `<500000000`-byte connector gate.

Both wrappers were then independently downloaded outside GitHub. The external verifier, SHA256 `743e9bd7f057da0ac3fedeb30872b9e964a0c86d3d192f62c9500de3c950da33`, was Python-compiled before execution, passed an independent read-only logic audit, and closed with:

```text
D97AF_LOCAL_WRAPPER_DIGESTS=PASS
D97AF_LOCAL_SPLIT_MANIFESTS=PASS
D97AF_LOCAL_PART_HASHES=PASS
D97AF_LOCAL_OUTER_REASSEMBLY=PASS
D97AF_LOCAL_OUTER_SHA256=70a123bfad81e00072ed2691fc769fa81c25f07c48a2ddb39a092d06d1947d9b
D97AF_LOCAL_OUTER_BYTES=751567689
D97AF_LOCAL_INNER_SHA256SUMS=PASS
D97AF_LOCAL_APP_ZIP_SHA256=728dd30d7a4483bc7318300f3911e8aae8590f0d9ff59afbcf7db66651d8e907
D97AF_LOCAL_AUDIT_REPORTS=PASS
D97AF_LOCAL_APP_ZIP_CRC=PASS
D97AF_LOCAL_APP_EXE_CARDINALITY=1
D97AF_LOCAL_APP_EXE_SHA256=ec20b42afaf79ea0340180dd1f50f5d8927f847e4fa4c05164b945b6e6eda470
D97AF_EXTERNAL_ARTIFACT_BYTE_AUDIT=PASS
```

Authoritative classification:

```text
D97AF_GITHUB_BUILD=PROVEN_PASS
D97AF_SOURCE_AND_AST_AUDIT=PROVEN_PASS
D97AF_PACKAGED_APP_SEMANTIC_AUDIT=PROVEN_PASS
D97AF_PACKAGED_APP_ARCHITECTURE=PROVEN_X86_64
D97AF_GITHUB_ARTIFACT_UPLOAD=PROVEN_PASS
D97AF_EXTERNAL_ARTIFACT_BYTE_AUDIT=PROVEN_PASS
D97AF_INNER_APP_ZIP_AND_EXECUTABLE_IDENTITY=PROVEN_PASS
D97AF_APP_DEPLOY=NOT_STARTED
D97AF_RUNTIME_PROVENANCE=NOT_YET_TESTED
D97AF_DIRECT_RUNTIME_TEXT_BYTE_READ=NOT_PERFORMED
D97AF_ROOT_PATCH=NOT_AUTHORIZED
D97AF_REBOOT=NOT_AUTHORIZED
```

No D97AF app, system target, snapshot or Root Patch was modified on ASUS2 by the build, transfer or external audit.

## CURRENT SINGLE NEXT ACTION — identity-pinned ASUS2 app backup/deploy/open/STOP
Provide one bounded ASUS2 action that retrieves or consumes the exact audited artifact, re-verifies the outer artifact, complete `SHA256SUMS`, inner deployment ZIP, packaged executable SHA and x86_64 architecture, then backs up the existing `/Applications/OpenCore-Patcher.app`, deploys only the exact D97AF app, audits the installed executable identity, opens OCLP and stops.

The action must fail closed before installed-app mutation on any identity discrepancy and must preserve a recoverable timestamped backup. It must not touch the current root-patched system snapshot or Golden. After OCLP opens, STOP and return the complete terminal output. Root Patch and reboot remain unauthorized until the deployment result is audited and a later checkpoint explicitly authorizes the manual Root Patch.

## Safety invariants
- Functional baseline remains exactly P1+P2b+P3+AIR00+D34.
- P6/P7 remain retained with runtime sufficiency NEGATIVE.
- Golden Sequoia remains immutable/read-only.
- D34 cave `0xEF8..0xEFE` remains protected.
- D50/D68/D82 remain reserve-only.
- D84 remains retired.
- Patch8 remains unauthorized.
- D97AEX/D97AEZ external task-port method remains retired.
- D97AF UUID remains `A4F456DF-7447-49BF-AC4F-102D90023A1E`.
- ASUS2 installed app mutation `NO` at this checkpoint.
- ASUS2 system/root-patch target mutation `NO` at this checkpoint.
- service launch `AUTO-NO`;
- Root Patch `AUTO-NO`;
- reboot `AUTO-NO`.
