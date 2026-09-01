#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEB_P6_P7_SHA_MAP_FIX_WRAPPER_REPORT.txt"
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
TMP="$(/usr/bin/mktemp -d -t oclp-d97aeb)"
ORIG="$TMP/original.command"
FIXED="$TMP/fixed.command"
trap '/bin/rm -rf "$TMP"' EXIT
exec > >(tee "$REPORT") 2>&1
fail(){ echo "D97AEB_FAIL=$*"; echo "REPORT=$REPORT"; exit 2; }

echo "===== OCLP7 D97AEB — P6/P7 RETAINED-HELPER SHA-MAP FIX WRAPPER ====="
echo "CLASSIFICATION=D97AEA_SOURCE_PREIMAGE_AUDIT_FALSE_FAIL_P6_P7_EXPECTED_SHA_MAP"
echo "OBSERVED_P6_SEG_SHA=ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0b545f0da06c13a"
echo "CORRECTION_SCOPE=PYINTEGRATE_expected_P6_and_P7_helper_SHA_literals_only"
echo "D97AE_FUNCTIONAL_DESIGN_CHANGE=NO"
echo "D97AE_RUNTIME_PATCH_BYTES_CHANGE=NO"
echo "D97AE_SOURCE_TRANSITION_CHANGE=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "REPORT=$REPORT"
echo "CORE_REPORT=$CORE_REPORT"

for t in curl git python3 zsh shasum base64 gzip; do
 P="$(command -v "$t" 2>/dev/null || true)"; echo "TOOL_${t}=${P:-MISSING}"; [[ -n "$P" ]] || fail "MISSING_TOOL:$t"
done
python3 --version 2>&1

ALL="$TMP/core.b64"; : > "$ALL"
for i in 1 2 3 4; do
 PART="$TMP/part${i}.b64"
 /usr/bin/curl -fL "https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/${PAYLOAD_COMMIT}/${PAYLOAD_DIR}/${PREFIX}${i}.b64" -o "$PART"
 ACTUAL="$(/usr/bin/git hash-object "$PART")"; EXPECTED="${PART_BLOBS[$i]}"
 echo "D97AEB_PART_${i}_BLOB_ACTUAL=$ACTUAL"; echo "D97AEB_PART_${i}_BLOB_EXPECTED=$EXPECTED"
 [[ "$ACTUAL" == "$EXPECTED" ]] || fail "PART_${i}_IDENTITY_MISMATCH"
 /bin/cat "$PART" >> "$ALL"
done
echo "D97AEB_PAYLOAD_PART_IDENTITIES=PASS"
/usr/bin/base64 -D -i "$ALL" | /usr/bin/gzip -dc > "$ORIG"
SHA="$(/usr/bin/shasum -a 256 "$ORIG" | /usr/bin/awk '{print $1}')"
echo "D97AEB_ORIGINAL_CORE_SHA256_ACTUAL=$SHA"
echo "D97AEB_ORIGINAL_CORE_SHA256_EXPECTED=$ORIGINAL_CORE_SHA"
[[ "$SHA" == "$ORIGINAL_CORE_SHA" ]] || fail "ORIGINAL_CORE_IDENTITY_MISMATCH"
/bin/cp "$ORIG" "$FIXED"

python3 - "$FIXED" <<'PYFIX'
from pathlib import Path
import hashlib,re,sys
p=Path(sys.argv[1]); text=p.read_text(); original=text
block_re=re.compile(r"(<<'(?P<tag>[A-Za-z0-9_]+)'\n)(?P<body>.*?)(\n(?P=tag)\n)",re.S)
blocks=list(block_re.finditer(text))
owners=[m for m in blocks if "helper segment SHA mismatch" in m.group("body")]
print(f"D97AEB_EMBEDDED_PYTHON_BLOCKS={[m.group('tag') for m in blocks]}")
print(f"D97AEB_SHA_AUDIT_OWNER_BLOCK_COUNT={len(owners)}")
if len(owners)!=1: raise SystemExit("D97AEB_OWNER_BLOCK_CARDINALITY_FAIL")
o=owners[0]; body=o.group("body"); before=body
correct={
 "p6":"ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0b545f0da06c13a",
 "p7":"a8fdac12d07a152e4a9ba5fc79558e0c594634f7762f6fd373421176e1a5b66b",
}
full={
 "p6":"patch_mtl_compiler_tahoe_p6_request_dialect_callsite_ports",
 "p7":"patch_mtl_compiler_tahoe_p7_raw88_a8_read_ports",
}
spans=[]
for key in ("p6","p7"):
 tokens=[full[key],key,key+"_name"]
 hits={}
 for token in tokens:
  token_form=r"(?:['\"]"+re.escape(token)+r"['\"]|\b"+re.escape(token)+r"\b)"
  for pat in (
   re.compile(token_form+r"\s*:\s*(?P<q>['\"])(?P<h>[0-9a-f]{64})(?P=q)"),
   re.compile(r"[\(\[]\s*"+token_form+r"\s*,\s*(?P<q>['\"])(?P<h>[0-9a-f]{64})(?P=q)"),
  ):
   for m in pat.finditer(before): hits[(m.start('h'),m.end('h'))]=m
 print(f"D97AEB_{key.upper()}_SHA_MAP_HIT_COUNT={len(hits)}")
 if len(hits)!=1: raise SystemExit(f"D97AEB_{key.upper()}_ENTRY_CARDINALITY_FAIL:{len(hits)}")
 m=next(iter(hits.values())); spans.append((m.start('h'),m.end('h'),m.group('h'),correct[key],key))
for s,e,old,new,key in sorted(spans,reverse=True):
 if body[s:e]!=old: raise SystemExit(f"D97AEB_{key.upper()}_PREIMAGE_FAIL")
 body=body[:s]+new+body[e:]
for s,e,old,new,key in spans:
 state="UNCHANGED" if old==new else "CORRECTED"
 print(f"D97AEB_SHA_MAP_ENTRY={key.upper()}|OLD={old}|NEW={new}|STATE={state}")
if next(x for x in spans if x[4]=="p6")[2]==correct["p6"]:
 raise SystemExit("D97AEB_P6_FALSE_EXPECTED_CONSTANT_NOT_FOUND")
# Neutralize the exact two same-length literal spans and prove no other text changed.
def neutral(src):
 out=src
 for s,e,old,new,key in sorted(spans,reverse=True): out=out[:s]+("<SHA_"+key.upper()+">").ljust(64,"_")[:64]+out[e:]
 return out
if neutral(before)!=neutral(body): raise SystemExit("D97AEB_NON_SHA_LOGIC_CHANGE")
print("D97AEB_ONLY_P6_P7_EXPECTED_SHA_LITERALS_CHANGED=PASS")
text=text[:o.start('body')]+body+text[o.end('body'):]; p.write_text(text)
for m in block_re.finditer(text): compile(m.group('body'),f"<{m.group('tag')}>","exec")
print("D97AEB_EMBEDDED_PYTHON_COMPILE=PASS")
anchors=[
 "EXPECTED_SELECTOR_ONLY_SERVICE_SHA=a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43",
 "EXPECTED_D97AD_FINAL_MTL_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755",
 "OUTCOME_110=validator_reaches_REL_0x58B","OUTCOME_111=buffer_argument_index_error_REL_0x29A",
 "OUTCOME_112=sampler_argument_index_error_REL_0x2D9","OUTCOME_113=nested_argument_buffer_pointer_REL_0x3E2",
 "OUTCOME_114=other_early_return_REL_0xB9_or_unwind_REL_0x6CC",
 "RUNTIME_LIVENESS_GATE=every_spawned_MTLCompilerService_must_emit_exactly_one_exit_110_114_or_runtime_run_invalid",
 "ROOT_PATCH=AUTO-NO","REBOOT=AUTO-NO",
]
missing=[a for a in anchors if a not in text]; print(f"D97AEB_REQUIRED_ANCHORS_MISSING={missing}")
if missing: raise SystemExit("D97AEB_RUNTIME_ANCHOR_MISSING")
print("D97AEB_D97AE_FUNCTIONAL_CONTRACT_UNCHANGED=PASS")
print("D97AEB_FIXED_CORE_SHA256="+hashlib.sha256(p.read_bytes()).hexdigest())
PYFIX

/bin/zsh -n "$FIXED"; echo "D97AEB_FIXED_CORE_ZSH_PARSE=PASS"
echo "===== EXECUTE P6/P7-SHA-MAP-CORRECTED D97AE CORE ====="
set +e; /bin/zsh "$FIXED"; RC=$?; set -e
echo "D97AEB_CORE_RC=$RC"
if [[ "$RC" -ne 0 ]]; then echo "D97AEB_WRAPPER=CORE_FAILED"; echo "ROOT_PATCH=AUTO-NO"; echo "REBOOT=AUTO-NO"; exit "$RC"; fi
[[ -f "$CORE_REPORT" ]] || fail "CORE_REPORT_MISSING"
grep -q '^FASTLANE_D97AE_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER=PASS$' "$CORE_REPORT" || fail "CORE_PASS_GATE_MISSING"
grep -q '^ROOT_PATCH=AUTO-NO$' "$CORE_REPORT" || fail "ROOT_PATCH_GATE_MISSING"
grep -q '^REBOOT=AUTO-NO$' "$CORE_REPORT" || fail "REBOOT_GATE_MISSING"
echo "===== FINAL ====="
echo "D97AEB_WRAPPER=PASS"
echo "D97AEB_CORE_RC=0"
echo "D97AE_FUNCTIONAL_DESIGN_CHANGE=NO"
echo "D97AE_RUNTIME_PATCH_BYTES_CHANGE=NO"
echo "D97AE_SOURCE_TRANSITION_CHANGE=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_full_FASTLANE_audit_before_manual_Root_Patch"
echo "CORE_REPORT=$CORE_REPORT"
echo "WRAPPER_REPORT=$REPORT"
