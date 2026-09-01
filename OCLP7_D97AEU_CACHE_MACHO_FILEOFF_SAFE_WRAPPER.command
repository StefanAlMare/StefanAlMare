#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEU_CACHE_MACHO_FILEOFF_SAFE_WRAPPER_REPORT.txt"
BASE_COMMIT="411f8f46f0096d714fe065fa091c1890f7edcc98"
BASE_BLOB_EXPECTED="a412a6115c429d90b34895571927e9b39783c11a"
BASE_URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${BASE_COMMIT}/OCLP7_D97AEU_READONLY_DYLD_CACHE_32023_BYTE_IDENTITY_MAP.command"
BASE="/private/tmp/OCLP7_D97AEU_BASE.command"
FIXED="/private/tmp/OCLP7_D97AEU_FILEOFF_SAFE.command"

exec > >(/usr/bin/tee "$REPORT") 2>&1
fail(){ echo "D97AEU_WRAPPER_FAIL=$*"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; echo "REPORT=$REPORT"; exit 2; }

print "===== OCLP7 D97AEU — CACHE MACH-O FILEOFF SAFE WRAPPER ====="
print "CORRECTION_SCOPE=relax_only_cached_TEXT_fileoff_zero_assumption;retain_VM_base_and_all_byte_comparisons"
print "BASE_COMMIT=$BASE_COMMIT"
print "BASE_BLOB_EXPECTED=$BASE_BLOB_EXPECTED"
print "SOURCE_MUTATION=NO"
print "SYSTEM_MUTATION=NO"
print "SERVICE_LAUNCH=AUTO-NO"
print "ROOT_PATCH=AUTO-NO"
print "REBOOT=AUTO-NO"

for tool in curl git python3 zsh; do
  p="$(command -v "$tool" 2>/dev/null || true)"
  print "TOOL_${tool}=${p:-MISSING}"
  [[ -n "$p" ]] || fail "MISSING_TOOL:$tool"
done

/usr/bin/curl -fL "$BASE_URL" -o "$BASE"
ACTUAL="$(/usr/bin/git hash-object "$BASE")"
print "D97AEU_BASE_BLOB_ACTUAL=$ACTUAL"
[[ "$ACTUAL" == "$BASE_BLOB_EXPECTED" ]] || fail "BASE_BLOB_MISMATCH:$ACTUAL"
print "D97AEU_BASE_IDENTITY=PASS"

python3 - "$BASE" "$FIXED" <<'PY'
from pathlib import Path
import sys
src=Path(sys.argv[1]).read_text()
out=Path(sys.argv[2])
old="    if text[0] != image_load or text[2] != 0:\n"
new="    if text[0] != image_load:\n"
print('D97AEU_STRICT_FILEOFF_LINE_COUNT='+str(src.count(old)))
if src.count(old)!=1:
    raise SystemExit('D97AEU_STRICT_FILEOFF_LINE_CARDINALITY_FAIL')
fixed=src.replace(old,new,1)
# Require exactly one source line change.
a=src.splitlines(); b=fixed.splitlines()
changed=[(i+1,x,y) for i,(x,y) in enumerate(zip(a,b)) if x!=y]
print('D97AEU_CHANGED_LINE_COUNT='+str(len(changed)))
for i,x,y in changed:
    print(f'D97AEU_CHANGED_LINE={i}|BEFORE={x}|AFTER={y}')
if len(changed)!=1:
    raise SystemExit('D97AEU_UNEXPECTED_CHANGE_COUNT')
# Retain exact read-only and byte discriminator anchors.
required=[
 'SOURCE_MUTATION=NO','SYSTEM_MUTATION=NO','SERVICE_LAUNCH=AUTO-NO',
 'ROOT_PATCH=AUTO-NO','REBOOT=AUTO-NO',
 "('CANDIDATE_110',0x9D6BD,'8b8d10feffff83f941','6a6e5fe9bb38f6ff90')",
 'CACHE_D97AD_SITE_SUMMARY=',
 'D97AEU_DECISIVE_BYTE_DISCRIMINATOR=',
 'RUNTIME_CACHE_EXECUTION_CLAIM=NOT_MADE_BY_THIS_STATIC_MAPPER',
]
missing=[x for x in required if x not in fixed]
print('D97AEU_REQUIRED_ANCHORS_MISSING='+repr(missing))
if missing:
    raise SystemExit('D97AEU_REQUIRED_ANCHOR_FAIL')
out.write_text(fixed)
print('D97AEU_ONLY_FILEOFF_ZERO_ASSUMPTION_RELAXED=PASS')
PY

/bin/zsh -n "$FIXED"
print "D97AEU_FIXED_ZSH_PARSE=PASS"
/bin/chmod +x "$FIXED"

set +e
"$FIXED"
RC=$?
set -e
print "D97AEU_INNER_RC=$RC"
[[ "$RC" -eq 0 ]] || fail "INNER_D97AEU_FAILED_RC:$RC"

print "===== FINAL ====="
print "D97AEU_FILEOFF_ZERO_ASSUMPTION=RELAXED_ONLY"
print "D97AEU_BYTE_COMPARISON_CONTRACT=UNCHANGED"
print "D97AEU_SAFE_WRAPPER=PASS"
print "SOURCE_MUTATION=NO"
print "SYSTEM_MUTATION=NO"
print "SERVICE_LAUNCH=AUTO-NO"
print "ROOT_PATCH=AUTO-NO"
print "REBOOT=AUTO-NO"
print "REPORT=$REPORT"
