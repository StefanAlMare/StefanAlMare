#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEE_EXACT_P6_TRUNCATED_LITERAL_REPAIR_WRAPPER_REPORT.txt"
CORE_REPORT="$HOME/Desktop/OCLP7_FASTLANE_D97AE_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER_REPORT.txt"
PAYLOAD_COMMIT="473d4bab1571e2a8907d3ae500fb88e5fd9639c0"
PAYLOAD_DIR="OCLP7-D97AEA-payload"
PREFIX="OCLP7_D97AE_CORE_PAYLOAD.part"
ORIGINAL_CORE_SHA="d8166ed5697cf281a60b19dba4c902470c4900de740006431d7cff5580fa5bb6"
PART_BLOBS=(
  "bcfcc00786676f3d946e9782f4fe94f3980b392d"
  "a389b2eedcd1960475de0ddd3024b0afaec6f930"
  "c34f26b9a111aef8926ee49cfaa0f6fa4edd8423"
  "c74b2b02171f1c38669f6b45f8f0bf14aa7a9d17"
)
P6_BAD="ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0da06c13a"
P6_GOOD="ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0b545f0da06c13a"
P7_GOOD="a8fdac12d07a152e4a9ba5fc79558e0c594634f7762f6fd373421176e1a5b66b"

TMP="$(/usr/bin/mktemp -d -t oclp-d97aee)"
ORIG="$TMP/original.command"
FIXED="$TMP/fixed.command"
trap '/bin/rm -rf "$TMP"' EXIT
exec > >(tee "$REPORT") 2>&1
fail(){ echo "D97AEE_FAIL=$*"; echo "REPORT=$REPORT"; exit 2; }

echo "===== OCLP7 D97AEE — EXACT TRUNCATED P6 SHA-LITERAL REPAIR WRAPPER ====="
echo "CLASSIFICATION=D97AED_REVEALED_EXACT_ROOT_CAUSE_P6_EXPECTED_SHA_LITERAL_TRUNCATED_58_NOT_P6_P7_SWAP"
echo "CORRECTION_SCOPE=replace_only_the_value_bound_to_P6_in_unique_PYINTEGRATE_failure_owner_dictionary"
echo "P6_BAD_LITERAL=$P6_BAD"
echo "P6_BAD_LENGTH=${#P6_BAD}"
echo "P6_AUTHORITATIVE_SEG_SHA=$P6_GOOD"
echo "P6_AUTHORITATIVE_LENGTH=${#P6_GOOD}"
echo "P7_AUTHORITATIVE_SEG_SHA=$P7_GOOD"
echo "D97AE_FUNCTIONAL_DESIGN_CHANGE=NO"
echo "D97AE_RUNTIME_PATCH_BYTES_CHANGE=NO"
echo "D97AE_SOURCE_TRANSITION_CHANGE=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"
echo "CORE_REPORT=$CORE_REPORT"

[[ ${#P6_BAD} -eq 58 ]] || fail "P6_BAD_LITERAL_LENGTH_NOT_58"
[[ ${#P6_GOOD} -eq 64 ]] || fail "P6_GOOD_LITERAL_LENGTH_NOT_64"
[[ ${#P7_GOOD} -eq 64 ]] || fail "P7_GOOD_LITERAL_LENGTH_NOT_64"

for t in curl git python3 zsh shasum base64 gzip; do
  P="$(command -v "$t" 2>/dev/null || true)"
  echo "TOOL_${t}=${P:-MISSING}"
  [[ -n "$P" ]] || fail "MISSING_TOOL:$t"
done
python3 --version 2>&1

ALL="$TMP/core.b64"
: > "$ALL"
for i in 1 2 3 4; do
  PART="$TMP/part${i}.b64"
  /usr/bin/curl -fL "https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${PAYLOAD_COMMIT}/${PAYLOAD_DIR}/${PREFIX}${i}.b64" -o "$PART"
  ACTUAL="$(/usr/bin/git hash-object "$PART")"
  EXPECTED="${PART_BLOBS[$i]}"
  echo "D97AEE_PART_${i}_BLOB_ACTUAL=$ACTUAL"
  echo "D97AEE_PART_${i}_BLOB_EXPECTED=$EXPECTED"
  [[ "$ACTUAL" == "$EXPECTED" ]] || fail "PART_${i}_IDENTITY_MISMATCH"
  /bin/cat "$PART" >> "$ALL"
done
echo "D97AEE_PAYLOAD_PART_IDENTITIES=PASS"

/usr/bin/base64 -D -i "$ALL" | /usr/bin/gzip -dc > "$ORIG"
SHA="$(/usr/bin/shasum -a 256 "$ORIG" | /usr/bin/awk '{print $1}')"
echo "D97AEE_ORIGINAL_CORE_SHA256_ACTUAL=$SHA"
echo "D97AEE_ORIGINAL_CORE_SHA256_EXPECTED=$ORIGINAL_CORE_SHA"
[[ "$SHA" == "$ORIGINAL_CORE_SHA" ]] || fail "ORIGINAL_CORE_IDENTITY_MISMATCH"
/bin/cp "$ORIG" "$FIXED"

python3 - "$FIXED" "$P6_BAD" "$P6_GOOD" "$P7_GOOD" <<'PYFIX'
from pathlib import Path
import hashlib, re, sys

p = Path(sys.argv[1])
p6_bad = sys.argv[2]
p6_good = sys.argv[3]
p7_good = sys.argv[4]
text = p.read_text()

block_re = re.compile(r"(<<'(?P<tag>[A-Za-z0-9_]+)'\n)(?P<body>.*?)(\n(?P=tag)\n)", re.S)
blocks = list(block_re.finditer(text))
owners = [m for m in blocks if "helper segment SHA mismatch" in m.group("body")]
print(f"D97AEE_EMBEDDED_PYTHON_BLOCKS={[m.group('tag') for m in blocks]}")
print(f"D97AEE_SHA_AUDIT_OWNER_BLOCK_COUNT={len(owners)}")
if len(owners) != 1:
    raise SystemExit("D97AEE_OWNER_BLOCK_CARDINALITY_FAIL")

o = owners[0]
before = o.group("body")

# D97AED exposed the real source shape:
#     P6: "<truncated 58-char value>",
#     P7: "<correct 64-char value>",
# Bind directly to those dictionary keys. No structural inference or pair swap.
p6_re = re.compile(r"(?m)^(?P<indent>\s*)P6\s*:\s*(?P<q>['\"])(?P<sha>[0-9a-f]+)(?P=q)\s*,?\s*$")
p7_re = re.compile(r"(?m)^(?P<indent>\s*)P7\s*:\s*(?P<q>['\"])(?P<sha>[0-9a-f]+)(?P=q)\s*,?\s*$")
p6_hits = list(p6_re.finditer(before))
p7_hits = list(p7_re.finditer(before))
print(f"D97AEE_P6_KEY_BINDING_COUNT={len(p6_hits)}")
print(f"D97AEE_P7_KEY_BINDING_COUNT={len(p7_hits)}")
if len(p6_hits) != 1 or len(p7_hits) != 1:
    raise SystemExit(f"D97AEE_KEY_BINDING_CARDINALITY_FAIL:P6={len(p6_hits)}:P7={len(p7_hits)}")

p6m = p6_hits[0]
p7m = p7_hits[0]
p6_actual = p6m.group("sha")
p7_actual = p7m.group("sha")
print(f"D97AEE_P6_BOUND_LITERAL={p6_actual}")
print(f"D97AEE_P6_BOUND_LITERAL_LENGTH={len(p6_actual)}")
print(f"D97AEE_P7_BOUND_LITERAL={p7_actual}")
print(f"D97AEE_P7_BOUND_LITERAL_LENGTH={len(p7_actual)}")
print(f"D97AEE_FULL_CORE_P6_BAD_COUNT={text.count(p6_bad)}")
print(f"D97AEE_FULL_CORE_P6_GOOD_PRE_COUNT={text.count(p6_good)}")
print(f"D97AEE_FULL_CORE_P7_GOOD_COUNT={text.count(p7_good)}")

if p6_actual != p6_bad:
    raise SystemExit(f"D97AEE_P6_TRUNCATED_PREIMAGE_MISMATCH:{p6_actual}")
if len(p6_actual) != 58:
    raise SystemExit(f"D97AEE_P6_TRUNCATED_LENGTH_MISMATCH:{len(p6_actual)}")
if p7_actual != p7_good or len(p7_actual) != 64:
    raise SystemExit(f"D97AEE_P7_AUTHORITATIVE_PREIMAGE_MISMATCH:{p7_actual}")
if text.count(p6_bad) != 1 or text.count(p6_good) != 0 or text.count(p7_good) != 1:
    raise SystemExit("D97AEE_FULL_CORE_LITERAL_CARDINALITY_FAIL")

lo = max(0, p6m.start() - 180)
hi = min(len(before), p7m.end() + 180)
print("D97AEE_P6_P7_MAPPING_CONTEXT=" + before[lo:hi].replace("\n", "\\n"))

s, e = p6m.start("sha"), p6m.end("sha")
after = before[:s] + p6_good + before[e:]

# Prove only the P6-bound value changed, despite the intentional +6-byte repair.
def normalize(src: str) -> str:
    matches = list(p6_re.finditer(src))
    if len(matches) != 1:
        raise SystemExit("D97AEE_NORMALIZE_P6_CARDINALITY_FAIL")
    m = matches[0]
    return src[:m.start("sha")] + "<P6_EXPECTED_SHA>" + src[m.end("sha"):]
if normalize(before) != normalize(after):
    raise SystemExit("D97AEE_NON_P6_LITERAL_LOGIC_CHANGE")

p6_after = list(p6_re.finditer(after))
p7_after = list(p7_re.finditer(after))
if len(p6_after) != 1 or p6_after[0].group("sha") != p6_good:
    raise SystemExit("D97AEE_P6_POSTIMAGE_FAIL")
if len(p7_after) != 1 or p7_after[0].group("sha") != p7_good:
    raise SystemExit("D97AEE_P7_CHANGED_OR_INVALID")

print("D97AEE_EXACT_TRUNCATED_P6_LITERAL_REPAIR=PASS")
print("D97AEE_ONLY_P6_BOUND_LITERAL_CHANGED=PASS")
print("D97AEE_P7_AUTHORITATIVE_LITERAL_UNCHANGED=PASS")

text = text[:o.start("body")] + after + text[o.end("body"):]
p.write_text(text)

if text.count(p6_bad) != 0 or text.count(p6_good) != 1 or text.count(p7_good) != 1:
    raise SystemExit("D97AEE_POSTWRITE_LITERAL_CARDINALITY_FAIL")

anchors = [
    "EXPECTED_SELECTOR_ONLY_SERVICE_SHA=a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43",
    "EXPECTED_D97AD_FINAL_MTL_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755",
    "OUTCOME_110=validator_reaches_REL_0x58B",
    "OUTCOME_111=buffer_argument_index_error_REL_0x29A",
    "OUTCOME_112=sampler_argument_index_error_REL_0x2D9",
    "OUTCOME_113=nested_argument_buffer_pointer_REL_0x3E2",
    "OUTCOME_114=other_early_return_REL_0xB9_or_unwind_REL_0x6CC",
    "RUNTIME_LIVENESS_GATE=every_spawned_MTLCompilerService_must_emit_exactly_one_exit_110_114_or_runtime_run_invalid",
    "ROOT_PATCH=AUTO-NO",
    "REBOOT=AUTO-NO",
]
missing = [a for a in anchors if a not in text]
print(f"D97AEE_REQUIRED_ANCHORS_MISSING={missing}")
if missing:
    raise SystemExit("D97AEE_RUNTIME_ANCHOR_MISSING")

for m in block_re.finditer(text):
    compile(m.group("body"), f"<{m.group('tag')}>", "exec")
print("D97AEE_EMBEDDED_PYTHON_COMPILE=PASS")
print("D97AEE_D97AE_FUNCTIONAL_CONTRACT_UNCHANGED=PASS")
print("D97AEE_FIXED_CORE_SHA256=" + hashlib.sha256(p.read_bytes()).hexdigest())
PYFIX

/bin/zsh -n "$FIXED"
echo "D97AEE_FIXED_CORE_ZSH_PARSE=PASS"

echo "===== EXECUTE EXACT-P6-LITERAL-REPAIRED D97AE CORE ====="
set +e
/bin/zsh "$FIXED"
RC=$?
set -e
echo "D97AEE_CORE_RC=$RC"
if [[ "$RC" -ne 0 ]]; then
  echo "D97AEE_WRAPPER=CORE_FAILED"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  exit "$RC"
fi

[[ -f "$CORE_REPORT" ]] || fail "CORE_REPORT_MISSING"
grep -q '^FASTLANE_D97AE_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER=PASS$' "$CORE_REPORT" || fail "CORE_PASS_GATE_MISSING"
grep -q '^ROOT_PATCH=AUTO-NO$' "$CORE_REPORT" || fail "ROOT_PATCH_GATE_MISSING"
grep -q '^REBOOT=AUTO-NO$' "$CORE_REPORT" || fail "REBOOT_GATE_MISSING"

echo "===== FINAL ====="
echo "D97AEE_WRAPPER=PASS"
echo "D97AEE_CORE_RC=0"
echo "D97AE_FUNCTIONAL_DESIGN_CHANGE=NO"
echo "D97AE_RUNTIME_PATCH_BYTES_CHANGE=NO"
echo "D97AE_SOURCE_TRANSITION_CHANGE=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_full_FASTLANE_audit_before_manual_Root_Patch"
echo "CORE_REPORT=$CORE_REPORT"
echo "WRAPPER_REPORT=$REPORT"
