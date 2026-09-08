# OCLP7 CHECKPOINT — D97HA helper restored / D97GY post-Restore baseline PASS / D97GS reauthorized

Date: 2026-09-08 EEST
Host: ASUS2 / macOS Tahoe 26.6.2 build 25G82 / x86_64 / SMBIOS MacBookAir6,2 / Haswell 8086:0412

## D97HA — exact official privileged helper restored
Pre-state active helper:
- SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`
- DEBUG helper identity, ad-hoc, no Team ID.

Exact official source:
`/Library/Application Support/Dortania/OpenCore-Patcher.app/Contents/Resources/com.dortania.opencore-legacy-patcher.privileged-helper`
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`
- TeamIdentifier `S74BDJXQMD`.

D97HA result:
- active DEBUG precheck PASS;
- official source SHA/Team/codesign PASS;
- DEBUG helper backed up to Desktop;
- staged official helper SHA/Team/codesign PASS;
- atomic replacement PASS;
- active post SHA exact `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- active post Team `S74BDJXQMD`;
- stat `root:wheel -rwsr-xr-x 136816`;
- `D97HA_OFFICIAL_HELPER_RESTORED=PASS`;
- `D97HA_STATUS=PASS`;
- no Root Patch, no EFI/NVRAM/framebuffer mutation, no reboot.

## D97GY rerun — full post-Restore baseline PASS
Boot safety:
- `-igfxvesa` active;
- `-ocmcd97ez` inert/commented;
- `D97GY_VESA_GATE=PASS`.

Native Tahoe MTLCompilerService restored:
- SHA256 `4262e71f2412adcd66ec052611bc76a8f8c5477f38bd21f8094cf2ec0ee66256`;
- UUID match PASS;
- architectures `x86_64 arm64e`;
- `D97GY_NATIVE_SERVICE=PASS`.

Native CoreDisplay metallib restored:
- SHA256 `daee638d2bfa52b5196b63c0423cdf6dd2ae35eb264ea077c8e914884ee016e1`;
- bytes `24128`;
- magic `MTLB`;
- `D97GY_NATIVE_CORE=PASS`.

Haswell AuxKC/Data state:
- AppleIntelFramebufferAzul removed;
- AppleIntelHD5000Graphics removed;
- `D97GY_HASWELL_AUXKC_REMOVED=PASS`.

Corrected local 25G82 MetallibSupportPkg survived Restore:
- count `180`;
- CoreDisplay SHA256 `b848d54e7c98c326658fdb33fd481e373d2fdb2fbca60eca1078226ded4bc92d`;
- CoreDisplay bytes `20739`;
- magic `MTLB`;
- bad magic count `0`;
- `D97GY_LOCAL_METALLIB_SOURCE=PASS`.

Official helper final state:
- SHA256 `9b74b7c95d54dc99a577e6a700dcd5922f40d3430108034029715caca14a037a`;
- TeamIdentifier `S74BDJXQMD`;
- `D97GY_OFFICIAL_HELPER=PASS`.

Final D97GY classifications:
- `D97GY_NATIVE_BASELINE=PASS`;
- `D97GY_RESTORE_REBOOT=STRUCTURAL_SEMANTIC_PASS`;
- `D97GY_D97GS_ROOTPATCH_BASE=READY`;
- `D97GY_STATUS=PASS_READONLY_POST_RESTORE_GATE`;
- `D97GY_REBOOT=NO`.

## Authority / next action
D97GS manual P1-only Root Patch is reauthorized on this exact clean post-Restore baseline.

Use only exact audited D97GS artifact:
- ZIP SHA256 `e61d225d2bc1352795ef2aeb9e61959fef2f23b9d11192dd1ea033824c855266`;
- ZIP bytes `722879148`;
- inner x86_64 SHA256 `5f4abff89222939222e7d9b17a091ae19138445cb5a25b46cb9d2a290a315d6e`;
- launcher SHA256 `344ea23b3215c47db0208d22f0bbcf1478ebb903b744b8d0213dc9df5a4f484c`;
- DEBUG helper SHA256 `993bf7e846672b3c131b7c6dc9af2c97072f6ec53326df062e542a1f001ab7b9`;
- source diff SHA256 `cae9c340bc5ade561f38e949dde74da630475805e053c0acb87c36bed7ede65f`.

Expected D97GS P1 runtime transition after patchset installation:
- legacy service pre-P1 SHA `31a6f745eb55b0c92ebeac66b4a6246c126b27bc7f64c94dc43723b8ab788cc5`;
- exact P1 post-SHA `a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43`;
- postimage `81fe177d0000` at offset `0x3494`;
- only bytes `0x3496` and `0x3497` change.

After Root Patch: DO NOT reboot. Close inner OCLP so outer wrapper restores official helper, then run read-only D97GX post-patch/pre-reboot audit. No accelerated boot until VESA boot + active-snapshot audit passes.
