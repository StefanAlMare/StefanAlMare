#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AED_EXACT_LITERAL_PAIR_SWAP_P6_P7_SHA_FIX_WRAPPER_REPORT.txt"
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
P6_SHA="ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0b545f0da06c13a"
P7_SHA="a8fdac12d07a152e4a9ba5fc79558e0c594634f7762f6fd373421176e1a5b66b"

TMP="$(/usr/bin/mktemp -d -t oclp-d97aed)"
ORIG="$TMP/original.command"
FIXED="$TMP/fixed.command"
trap '/bin/rm -rf "$TMP"' EXIT
exec > >(tee "$REPORT") 2>&1
fail(){ echo "D97AED_FAIL=$*"; echo "REPORT=$REPORT"; exit 2; }

echo "===== OCLP7 D97AED — EXACT-LITERAL P6/P7 SHA PAIR-SWAP WRAPPER ====="
echo "CLASSIFICATION=D97AEC_MATCHER_FALSE_NEGATIVE_ABANDON_STRUCTURAL_INFERENCE"
echo "CORRECTION_SCOPE=swap_exact_authoritative_P6_and_P7_SHA_literals_only_inside_unique_PYINTEGRATE_failure_owner_block"
echo "P6_AUTHORITATIVE_SEG_SHA=$P6_SHA"
echo "P7_AUTHORITATIVE_SEG_SHA=$P7_SHA"
echo "D97AE_FUNCTIONAL_DESIGN_CHANGE=NO"
echo "D97AE_RUNTIME_PATCH_BYTES_CHANGE=NO"
echo "D97AE_SOURCE_TRANSITION_CHANGE=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"
echo "CORE_REPORT=$CORE_REPORT"

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
  echo "D97AED_PART_${i}_BLOB_ACTUAL=$ACTUAL"
  echo "D97AED_PART_${i}_BLOB_EXPECTED=$EXPECTED"
  [[ "$ACTUAL" == "$EXPECTED" ]] || fail "PART_${i}_IDENTITY_MISMATCH"
  /bin/cat "$PART" >> "$ALL"
done
echo "D97AED_PAYLOAD_PART_IDENTITIES=PASS"

/usr/bin/base64 -D -i "$ALL" | /usr/bin/gzip -dc > "$ORIG"
SHA="$(/usr/bin/shasum -a 256 "$ORIG" | /usr/bin/awk '{print $1}')"
echo "D97AED_ORIGINAL_CORE_SHA256_ACTUAL=$SHA"
echo "D97AED_ORIGINAL_CORE_SHA256_EXPECTED=$ORIGINAL_CORE_SHA"
[[ "$SHA" == "$ORIGINAL_CORE_SHA" ]] || fail "ORIGINAL_CORE_IDENTITY_MISMATCH"
/bin/cp "$ORIG" "$FIXED"

python3 - "$FIXED" "$P6_SHA" "$P7_SHA" <<'PYFIX'
from pathlib import Path
import hashlib, re, sys

p = Path(sys.argv[1])
p6 = sys.argv[2]
p7 = sys.argv[3]
text = p.read_text()
original_text = text

block_re = re.compile(r"(<<'(?P<tag>[A-Za-z0-9_]+)'\n)(?P<body>.*?)(\n(?P=tag)\n)", re.S)
blocks = list(block_re.finditer(text))
owners = [m for m in blocks if "helper segment SHA mismatch" in m.group("body")]
print(f"D97AED_EMBEDDED_PYTHON_BLOCKS={[m.group('tag') for m in blocks]}")
print(f"D97AED_SHA_AUDIT_OWNER_BLOCK_COUNT={len(owners)}")
if len(owners) != 1:
    raise SystemExit("D97AED_OWNER_BLOCK_CARDINALITY_FAIL")

o = owners[0]
body = o.group("body")
before = body

p6_count = body.count(p6)
p7_count = body.count(p7)
print(f"D97AED_OWNER_P6_LITERAL_COUNT={p6_count}")
print(f"D97AED_OWNER_P7_LITERAL_COUNT={p7_count}")
print(f"D97AED_FULL_CORE_P6_LITERAL_COUNT={text.count(p6)}")
print(f"D97AED_FULL_CORE_P7_LITERAL_COUNT={text.count(p7)}")

for label, token in (("P6", p6), ("P7", p7)):
    pos = body.find(token)
    if pos >= 0:
        lo = max(0, pos - 240)
        hi = min(len(body), pos + len(token) + 240)
        context = body[lo:hi].replace("\n", "\\n")
        print(f"D97AED_{label}_LITERAL_CONTEXT={context}")

if p6_count != 1 or p7_count != 1:
    raise SystemExit(f"D97AED_LITERAL_CARDINALITY_FAIL:P6={p6_count}:P7={p7_count}")

# The original D97AEA run proved that the P6 helper's actual authoritative SHA
# was rejected. The two authoritative P6/P7 literals occur exactly once inside
# the unique failing audit block. Swap only this exact pair, without attempting
# to infer the surrounding container/AST shape.
placeholder6 = "__D97AED_P6_PLACEHOLDER_" + ("6" * (64 - len("__D97AED_P6_PLACEHOLDER_")))
placeholder7 = "__D97AED_P7_PLACEHOLDER_" + ("7" * (64 - len("__D97AED_P7_PLACEHOLDER_")))
assert len(placeholder6) == 64 and len(placeholder7) == 64
body = body.replace(p6, placeholder6, 1)
body = body.replace(p7, placeholder7, 1)
body = body.replace(placeholder6, p7, 1)
body = body.replace(placeholder7, p6, 1)

if body.count(p6) != 1 or body.count(p7) != 1:
    raise SystemExit("D97AED_POST_SWAP_LITERAL_CARDINALITY_FAIL")
if body == before:
    raise SystemExit("D97AED_SWAP_PRODUCED_NO_CHANGE")

# Neutralize the two authoritative SHA literals to one common token. If any
# character other than the locations of this exact pair changed, this fails.
neutral = "<D97AED_P6_P7_SHA_PAIR>".ljust(64, "_")[:64]
def neutralize(src: str) -> str:
    return src.replace(p6, neutral).replace(p7, neutral)
if neutralize(before) != neutralize(body):
    raise SystemExit("D97AED_NON_LITERAL_LOGIC_CHANGE")

print("D97AED_EXACT_P6_P7_LITERAL_PAIR_SWAP=PASS")
print("D97AED_ONLY_TWO_AUTHORITATIVE_SHA_LITERAL_LOCATIONS_CHANGED=PASS")

text = text[:o.start("body")] + body + text[o.end("body"):]
p.write_text(text)

# The fixed core must preserve the complete functional/runtime contract.
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
print(f"D97AED_REQUIRED_ANCHORS_MISSING={missing}")
if missing:
    raise SystemExit("D97AED_RUNTIME_ANCHOR_MISSING")

for m in block_re.finditer(text):
    compile(m.group("body"), f"<{m.group('tag')}>", "exec")
print("D97AED_EMBEDDED_PYTHON_COMPILE=PASS")
print("D97AED_D97AE_FUNCTIONAL_CONTRACT_UNCHANGED=PASS")
print("D97AED_FIXED_CORE_SHA256=" + hashlib.sha256(p.read_bytes()).hexdigest())
PYFIX

/bin/zsh -n "$FIXED"
echo "D97AED_FIXED_CORE_ZSH_PARSE=PASS"

echo "===== EXECUTE EXACT-LITERAL-PAIR-CORRECTED D97AE CORE ====="
set +e
/bin/zsh "$FIXED"
RC=$?
set -e
echo "D97AED_CORE_RC=$RC"
if [[ "$RC" -ne 0 ]]; then
  echo "D97AED_WRAPPER=CORE_FAILED"
  echo "ROOT_PATCH=AUTO-NO"
  echo "REBOOT=AUTO-NO"
  exit "$RC"
fi

[[ -f "$CORE_REPORT" ]] || fail "CORE_REPORT_MISSING"
grep -q '^FASTLANE_D97AE_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER=PASS$' "$CORE_REPORT" || fail "CORE_PASS_GATE_MISSING"
grep -q '^ROOT_PATCH=AUTO-NO$' "$CORE_REPORT" || fail "ROOT_PATCH_GATE_MISSING"
grep -q '^REBOOT=AUTO-NO$' "$CORE_REPORT" || fail "REBOOT_GATE_MISSING"

echo "===== FINAL ====="
echo "D97AED_WRAPPER=PASS"
echo "D97AED_CORE_RC=0"
echo "D97AE_FUNCTIONAL_DESIGN_CHANGE=NO"
echo "D97AE_RUNTIME_PATCH_BYTES_CHANGE=NO"
echo "D97AE_SOURCE_TRANSITION_CHANGE=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_full_FASTLANE_audit_before_manual_Root_Patch"
echo "CORE_REPORT=$CORE_REPORT"
echo "WRAPPER_REPORT=$REPORT"
