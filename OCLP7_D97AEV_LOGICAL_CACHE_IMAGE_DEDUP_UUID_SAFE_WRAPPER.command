#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEV_LOGICAL_CACHE_IMAGE_DEDUP_UUID_SAFE_WRAPPER_REPORT.txt"
BASE_COMMIT="411f8f46f0096d714fe065fa091c1890f7edcc98"
BASE_BLOB_EXPECTED="a412a6115c429d90b34895571927e9b39783c11a"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/OCLP7_D97AEU_READONLY_DYLD_CACHE_32023_BYTE_IDENTITY_MAP.command"
BASE="/private/tmp/OCLP7_D97AEV_BASE.command"
FIXED="/private/tmp/OCLP7_D97AEV_FIXED.command"

exec > >(/usr/bin/tee "$REPORT") 2>&1
fail(){
  echo "D97AEV_FAIL=$*"
  echo "SOURCE_MUTATION=NO"
  echo "SYSTEM_MUTATION=NO"
  echo "GOLDEN_MUTATION=NO"
  echo "SERVICE_LAUNCH=AUTO-NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 2
}

/bin/rm -f "$BASE" "$FIXED"

echo "===== OCLP7 D97AEV — LOGICAL CACHE IMAGE DEDUP / UUID-SAFE WRAPPER ====="
echo "PURPOSE=fix_only_replicated_imagesText_table_cardinality_and_cache_optimized_UUID_assumptions_while_retaining_all_byte_discriminators"
echo "BASE_COMMIT=$BASE_COMMIT"
echo "BASE_BLOB_EXPECTED=$BASE_BLOB_EXPECTED"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"

for tool in curl git python3 zsh; do
  tool_path="$(command -v "$tool" 2>/dev/null || true)"
  echo "TOOL_${tool}=${tool_path:-MISSING}"
  [[ -n "$tool_path" ]] || fail "MISSING_TOOL:$tool"
done

/usr/bin/curl -fL "$BASE_URL" -o "$BASE"
BASE_BLOB_ACTUAL="$(/usr/bin/git hash-object "$BASE")"
echo "D97AEV_BASE_BLOB_ACTUAL=$BASE_BLOB_ACTUAL"
[[ "$BASE_BLOB_ACTUAL" == "$BASE_BLOB_EXPECTED" ]] || fail "BASE_BLOB_MISMATCH:$BASE_BLOB_ACTUAL"
echo "D97AEV_BASE_IDENTITY=PASS"

/usr/local/bin/python3 - "$BASE" "$FIXED" <<'PY'
from pathlib import Path
import sys
src=Path(sys.argv[1]); dst=Path(sys.argv[2])
s=src.read_text()

old_fileoff="""    if text[0] != image_load or text[2] != 0:\n        raise SystemExit(f'CACHED_TEXT_BASE_CONTRACT_FAIL:{text}')\n"""
new_fileoff="""    if text[0] != image_load:\n        raise SystemExit(f'CACHED_TEXT_BASE_CONTRACT_FAIL:{text}')\n"""

old_hits="""    if len(image_hits) != 1:\n        raise SystemExit(f'CACHED_IMAGE_HIT_CARDINALITY_FAIL:{len(image_hits)}')\n    table_cache,index,cached_uuid,image_load,text_size,path_off=image_hits[0]\n    if cached_uuid.upper() != expected_uuid:\n        raise SystemExit(f'CACHED_IMAGE_UUID_MISMATCH:{cached_uuid}')\n    print('CACHED_IMAGE_PATH_UUID_IDENTITY=PASS')\n"""
new_hits="""    logical={}\n    for hit in image_hits:\n        c,i,cu,load,ts,po=hit\n        key=(cu.upper(),load,ts,target_path)\n        logical.setdefault(key,[]).append(hit)\n    print(f'CACHED_IMAGE_RAW_HIT_COUNT={len(image_hits)}')\n    print(f'CACHED_IMAGE_LOGICAL_IDENTITY_COUNT={len(logical)}')\n    for key,reps in logical.items():\n        cu,load,ts,path=key\n        print(f'CACHED_IMAGE_LOGICAL=UUID={cu}|LOAD=0x{load:X}|TEXT_SIZE=0x{ts:X}|PATH={path}|REPLICA_TABLE_COUNT={len(reps)}|TABLE_FILES={[str(x[0].path) for x in reps]}')\n    if len(logical) != 1:\n        raise SystemExit(f'CACHED_IMAGE_LOGICAL_CARDINALITY_FAIL:{len(logical)}')\n    (logical_key,replicas),=logical.items()\n    cached_uuid,image_load,text_size,_=logical_key\n    table_cache,index,_,_,_,path_off=replicas[0]\n    print(f'CACHED_IMAGE_LOGICAL_DEDUP=PASS|REPLICA_TABLE_COUNT={len(replicas)}')\n    print(f'CACHED_IMAGE_TABLE_UUID={cached_uuid}')\n    print(f'FILESYSTEM_LC_UUID_EXPECTED={expected_uuid}')\n    print('CACHED_TABLE_UUID_EQUALS_FILESYSTEM_UUID=' + ('YES' if cached_uuid.upper()==expected_uuid else 'NO'))\n"""

old_lcuuid="""    if lc_uuid is not None and lc_uuid.upper()!=expected_uuid:\n        raise SystemExit(f'CACHED_MACHO_LC_UUID_MISMATCH:{lc_uuid}')\n"""
new_lcuuid="""    if lc_uuid is not None:\n        print(f'CACHED_MACHO_LC_UUID={lc_uuid}')\n        print('CACHED_MACHO_UUID_EQUALS_TABLE_UUID=' + ('YES' if lc_uuid.upper()==cached_uuid.upper() else 'NO'))\n        print('CACHED_MACHO_UUID_EQUALS_FILESYSTEM_UUID=' + ('YES' if lc_uuid.upper()==expected_uuid else 'NO'))\n"""

repls=[('FILEOFF',old_fileoff,new_fileoff),('LOGICAL_HITS',old_hits,new_hits),('CACHE_UUID',old_lcuuid,new_lcuuid)]
for name,old,new in repls:
    count=s.count(old)
    print(f'D97AEV_TRANSFORM_{name}_MATCH_COUNT={count}')
    if count!=1:
        raise SystemExit(f'TRANSFORM_{name}_CARDINALITY_FAIL:{count}')
    s=s.replace(old,new,1)

required=[
    "('CANDIDATE_110',0x9D6BD,'8b8d10feffff83f941','6a6e5fe9bb38f6ff90')",
    "('BUFFER_111',0x9D3CC",
    "('SAMPLER_112',0x9D40B",
    "('NESTED_113',0x9D514",
    "('EARLY_RETURN_114',0x9D1EB",
    "('UNWIND_114',0x9D7FE",
    "('D34_PROTECTED_CAVE',0xEF8,'4889f8488937c3')",
    "('AIR00',0x9A933,'49c7462800000000')",
    "CACHE_D97AD_SITE_SUMMARY=",
    "D97AEU_DECISIVE_BYTE_DISCRIMINATOR=",
    "SOURCE_MUTATION=NO",
    "SYSTEM_MUTATION=NO",
    "ROOT_PATCH=AUTO-NO",
    "REBOOT=AUTO-NO",
]
missing=[x for x in required if x not in s]
print('D97AEV_REQUIRED_BYTE_AND_SAFETY_ANCHORS_MISSING='+repr(missing))
if missing:
    raise SystemExit('REQUIRED_ANCHOR_MISSING')

for forbidden in ('open -a OpenCore-Patcher','start_root_patch','patch_root_volume(','shutdown -r','reboot'):
    hits=[ln for ln in s.splitlines() if forbidden in ln and not ln.strip().startswith('echo') and 'REBOOT=AUTO-NO' not in ln]
    if hits:
        raise SystemExit('FORBIDDEN_AUTOMATION:'+forbidden+':'+repr(hits[:3]))

dst.write_text(s)
print('D97AEV_EXACT_THREE_TRANSFORMS=PASS')
PY

/bin/zsh -n "$FIXED" || fail "FIXED_ZSH_PARSE_FAIL"
echo "D97AEV_FIXED_ZSH_PARSE=PASS"
echo "===== EXECUTE FIXED READ-ONLY D97AEU CORE ====="
set +e
/bin/zsh "$FIXED"
INNER_RC=$?
set -e
echo "D97AEV_INNER_RC=$INNER_RC"
[[ "$INNER_RC" -eq 0 ]] || fail "INNER_D97AEU_FAILED_RC:$INNER_RC"

echo "===== FINAL ====="
echo "D97AEU_REPLICATED_IMAGE_TABLES=LOGICALLY_DEDUPED"
echo "D97AEU_CACHE_OPTIMIZED_UUID=SEPARATED_FROM_FILESYSTEM_UUID"
echo "D97AEU_BYTE_DISCRIMINATORS=RETAINED_UNCHANGED"
echo "D97AEV_LOGICAL_CACHE_IMAGE_DEDUP_UUID_SAFE_WRAPPER=PASS"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"
