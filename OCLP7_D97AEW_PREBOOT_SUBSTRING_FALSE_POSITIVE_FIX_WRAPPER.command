#!/bin/zsh
set -euo pipefail

REPORT="${D97AEW_REPORT_PATH:-$HOME/Desktop/OCLP7_D97AEW_PREBOOT_SUBSTRING_FALSE_POSITIVE_FIX_WRAPPER_REPORT.txt}"
BASE_COMMIT="b8350946e307ec2df253ffb795b31c2104034372"
BASE_BLOB_EXPECTED="1060f611b3fec7fc66f80d7674d2fb06a2cdfe6d"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/OCLP7_D97AEV_LOGICAL_CACHE_IMAGE_DEDUP_UUID_SAFE_WRAPPER.command"
TMPROOT="${TMPDIR:-/private/tmp}"
[[ -d "$TMPROOT" ]] || TMPROOT="/tmp"
BASE="$TMPROOT/OCLP7_D97AEW_D97AEV_BASE.command"
FIXED="$TMPROOT/OCLP7_D97AEW_D97AEV_FIXED.command"
VALIDATE_ONLY="${D97AEW_VALIDATE_ONLY:-0}"

REPORT_DIR="${REPORT:h}"
[[ -d "$REPORT_DIR" ]] || {
  print -u2 "D97AEW_FAIL=REPORT_DIRECTORY_MISSING:$REPORT_DIR"
  exit 2
}

exec > >(/usr/bin/tee "$REPORT") 2>&1
fail(){
  echo "D97AEW_FAIL=$*"
  echo "SOURCE_MUTATION=NO"
  echo "SYSTEM_MUTATION=NO"
  echo "GOLDEN_MUTATION=NO"
  echo "SERVICE_LAUNCH=AUTO-NO"
  echo "RUNTIME_INSTRUMENTATION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 2
}

/bin/rm -f "$BASE" "$FIXED"

echo "===== OCLP7 D97AEW — PREBOOT SUBSTRING FALSE-POSITIVE FIX WRAPPER ====="
echo "PURPOSE=fix_only_D97AEV_forbidden_reboot_command_scanner_so_Preboot_path_is_safe_while_real_reboot_commands_remain_forbidden"
echo "BASE_COMMIT=$BASE_COMMIT"
echo "BASE_BLOB_EXPECTED=$BASE_BLOB_EXPECTED"
echo "VALIDATE_ONLY=$VALIDATE_ONLY"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "RUNTIME_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"

[[ "$VALIDATE_ONLY" == "0" || "$VALIDATE_ONLY" == "1" ]] || fail "INVALID_VALIDATE_ONLY:$VALIDATE_ONLY"

for tool in curl git python3 zsh; do
  tool_path="$(command -v "$tool" 2>/dev/null || true)"
  echo "TOOL_${tool}=${tool_path:-MISSING}"
  [[ -n "$tool_path" ]] || fail "MISSING_TOOL:$tool"
done
CURL="$(command -v curl)"
GIT="$(command -v git)"
PYTHON="$(command -v python3)"
ZSH="$(command -v zsh)"

"$CURL" -fL "$BASE_URL" -o "$BASE"
BASE_BLOB_ACTUAL="$("$GIT" hash-object "$BASE")"
echo "D97AEW_BASE_BLOB_ACTUAL=$BASE_BLOB_ACTUAL"
[[ "$BASE_BLOB_ACTUAL" == "$BASE_BLOB_EXPECTED" ]] || fail "BASE_BLOB_MISMATCH:$BASE_BLOB_ACTUAL"
echo "D97AEW_BASE_IDENTITY=PASS"

"$PYTHON" - "$BASE" "$FIXED" <<'PY_D97AEW_TRANSFORM'
from pathlib import Path
import re
import sys

src=Path(sys.argv[1])
dst=Path(sys.argv[2])
original=src.read_text()
s=original

old_scanner="""for forbidden in ('open -a OpenCore-Patcher','start_root_patch','patch_root_volume(','shutdown -r','reboot'):
    hits=[ln for ln in s.splitlines() if forbidden in ln and not ln.strip().startswith('echo') and 'REBOOT=AUTO-NO' not in ln]
    if hits:
        raise SystemExit('FORBIDDEN_AUTOMATION:'+forbidden+':'+repr(hits[:3]))
"""

new_scanner=r"""for forbidden in ('open -a OpenCore-Patcher','start_root_patch','patch_root_volume(','shutdown -r'):
    hits=[ln for ln in s.splitlines() if forbidden in ln and not ln.strip().startswith('echo') and 'REBOOT=AUTO-NO' not in ln]
    if hits:
        raise SystemExit('FORBIDDEN_AUTOMATION:'+forbidden+':'+repr(hits[:3]))

reboot_command=__import__('re').compile(r'(?<![A-Za-z0-9_./-])(?:/(?:usr/)?s?bin/)?reboot(?=$|[ \t;&|)])')
hits=[ln for ln in s.splitlines() if reboot_command.search(ln) and 'REBOOT=AUTO-NO' not in ln]
if hits:
    raise SystemExit('FORBIDDEN_AUTOMATION:reboot-command:'+repr(hits[:3]))
"""

count=s.count(old_scanner)
print(f'D97AEW_SCANNER_TRANSFORM_MATCH_COUNT={count}')
if count != 1:
    raise SystemExit(f'D97AEW_SCANNER_TRANSFORM_CARDINALITY_FAIL:{count}')
s=s.replace(old_scanner,new_scanner,1)
if s.replace(new_scanner,old_scanner,1) != original:
    raise SystemExit('D97AEW_ONLY_SCANNER_CHANGE_PROOF_FAIL')
old_after=s.count(old_scanner)
new_after=s.count(new_scanner)
print(f'D97AEW_OLD_SCANNER_AFTER_COUNT={old_after}')
print(f'D97AEW_NEW_SCANNER_AFTER_COUNT={new_after}')
if old_after != 0 or new_after != 1:
    raise SystemExit(f'D97AEW_POST_TRANSFORM_SCANNER_CARDINALITY_FAIL:OLD={old_after}:NEW={new_after}')
print('D97AEW_ONLY_FORBIDDEN_SCANNER_CHANGED=PASS')

rx=re.compile(r'(?<![A-Za-z0-9_./-])(?:/(?:usr/)?s?bin/)?reboot(?=$|[ \t;&|)])')
safe_samples=[
    "Path('/System/Volumes/Preboot/Cryptexes/OS/System/Library/dyld'),",
    "Path('/System/Library/preboot_cache')",
    "Path('/System/Library/foo/reboot')",
    "my_reboot_marker=0",
    "echo REBOOT=AUTO-NO",
]
dangerous_samples=[
    'reboot',
    'sudo reboot now',
    '/bin/reboot',
    '/sbin/reboot',
    '/usr/sbin/reboot -q',
    '$(reboot)',
    'echo safe; reboot',
]
safe_hits=[x for x in safe_samples if rx.search(x)]
dangerous_misses=[x for x in dangerous_samples if not rx.search(x)]
print('D97AEW_PREBOOT_SAFE_SAMPLE_HITS='+repr(safe_hits))
print('D97AEW_REAL_REBOOT_COMMAND_MISSES='+repr(dangerous_misses))
if safe_hits or dangerous_misses:
    raise SystemExit('D97AEW_REBOOT_BOUNDARY_SYNTHETIC_TEST_FAIL')
print('D97AEW_PREBOOT_SAFE_REAL_REBOOT_FORBIDDEN_SYNTHETIC=PASS')

required=[
    'BASE_COMMIT="411f8f46f0096d714fe065fa091c1890f7edcc98"',
    'BASE_BLOB_EXPECTED="a412a6115c429d90b34895571927e9b39783c11a"',
    "repls=[('FILEOFF',old_fileoff,new_fileoff),('LOGICAL_HITS',old_hits,new_hits),('CACHE_UUID',old_lcuuid,new_lcuuid)]",
    "print(f'D97AEV_TRANSFORM_{name}_MATCH_COUNT={count}')",
    'D97AEV_REQUIRED_BYTE_AND_SAFETY_ANCHORS_MISSING=',
    'D97AEV_EXACT_THREE_TRANSFORMS=PASS',
    'D97AEV_FIXED_ZSH_PARSE=PASS',
    'D97AEV_LOGICAL_CACHE_IMAGE_DEDUP_UUID_SAFE_WRAPPER=PASS',
    'SOURCE_MUTATION=NO',
    'SYSTEM_MUTATION=NO',
    'ROOT_PATCH=AUTO-NO',
    'REBOOT=AUTO-NO',
]
missing=[x for x in required if x not in s]
print('D97AEW_RETAINED_D97AEV_IDENTITY_SAFETY_ANCHORS_MISSING='+repr(missing))
if missing:
    raise SystemExit('D97AEW_RETAINED_ANCHOR_MISSING')

dst.write_text(s)
print('D97AEW_FIXED_WRAPPER_WRITE=PASS')
PY_D97AEW_TRANSFORM

"$ZSH" -n "$FIXED" || fail "FIXED_D97AEV_ZSH_PARSE_FAIL"
echo "D97AEW_FIXED_D97AEV_ZSH_PARSE=PASS"

"$PYTHON" - "$FIXED" <<'PY_D97AEW_COMPILE'
from pathlib import Path
import re
import sys

text=Path(sys.argv[1]).read_text()
blocks=re.findall(r"<<'([A-Z0-9_]+)'\n(.*?)\n\1(?:\n|$)",text,re.S)
print(f'D97AEW_EMBEDDED_PYTHON_BLOCK_COUNT={len(blocks)}')
if len(blocks) != 1:
    raise SystemExit(f'D97AEW_EMBEDDED_PYTHON_CARDINALITY_FAIL:{len(blocks)}')
for index,(delimiter,body) in enumerate(blocks,1):
    compile(body,f'D97AEW_FIXED_D97AEV_{delimiter}_{index}','exec')
    print(f'D97AEW_EMBEDDED_PYTHON_COMPILE=PASS|INDEX={index}|DELIMITER={delimiter}')
PY_D97AEW_COMPILE
echo "D97AEW_STATIC_WRAPPER_AUDIT=PASS"

if [[ "$VALIDATE_ONLY" == "1" ]]; then
  echo "===== GITHUB VALIDATION-ONLY FINAL ====="
  echo "D97AEW_GITHUB_STATIC_AUDIT=PASS"
  echo "D97AEW_ASUS2_MAPPER_EXECUTION=NOT_RUN_IN_GITHUB"
  echo "SOURCE_MUTATION=NO"
  echo "SYSTEM_MUTATION=NO"
  echo "GOLDEN_MUTATION=NO"
  echo "SERVICE_LAUNCH=AUTO-NO"
  echo "RUNTIME_INSTRUMENTATION=NO"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  echo "REPORT=$REPORT"
  exit 0
fi

echo "===== EXECUTE FIXED D97AEV WRAPPER / READ-ONLY D97AEU CORE ====="
set +e
"$ZSH" "$FIXED"
INNER_RC=$?
set -e
echo "D97AEW_INNER_RC=$INNER_RC"
[[ "$INNER_RC" -eq 0 ]] || fail "INNER_FIXED_D97AEV_FAILED_RC:$INNER_RC"

echo "===== FINAL ====="
echo "D97AEV_PREBOOT_SUBSTRING_FALSE_POSITIVE=FIXED"
echo "D97AEV_EXACT_THREE_PARSER_TRANSFORMS=RETAINED"
echo "D97AEV_BYTE_DISCRIMINATORS=RETAINED_UNCHANGED"
echo "D97AEW_PREBOOT_SUBSTRING_FALSE_POSITIVE_FIX_WRAPPER=PASS"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "RUNTIME_INSTRUMENTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"
