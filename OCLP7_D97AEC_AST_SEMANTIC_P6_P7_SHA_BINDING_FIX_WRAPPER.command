#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AEC_AST_SEMANTIC_P6_P7_SHA_BINDING_FIX_WRAPPER_REPORT.txt"
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
TMP="$(/usr/bin/mktemp -d -t oclp-d97aec)"
ORIG="$TMP/original.command"
FIXED="$TMP/fixed.command"
trap '/bin/rm -rf "$TMP"' EXIT
exec > >(tee "$REPORT") 2>&1
fail(){ echo "D97AEC_FAIL=$*"; echo "REPORT=$REPORT"; exit 2; }

echo "===== OCLP7 D97AEC — AST-SEMANTIC P6/P7 SHA-BINDING FIX WRAPPER ====="
echo "CLASSIFICATION=D97AEB_MATCHER_FALSE_NEGATIVE_REAL_PYINTEGRATE_BINDING_SHAPE_NOT_REGEX_MAP_SHAPE"
echo "CORRECTION_SCOPE=owner_PYINTEGRATE_expected_P6_P7_SHA_string_literals_only_via_AST_semantic_binding"
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
 echo "D97AEC_PART_${i}_BLOB_ACTUAL=$ACTUAL"; echo "D97AEC_PART_${i}_BLOB_EXPECTED=$EXPECTED"
 [[ "$ACTUAL" == "$EXPECTED" ]] || fail "PART_${i}_IDENTITY_MISMATCH"
 /bin/cat "$PART" >> "$ALL"
done
echo "D97AEC_PAYLOAD_PART_IDENTITIES=PASS"
/usr/bin/base64 -D -i "$ALL" | /usr/bin/gzip -dc > "$ORIG"
SHA="$(/usr/bin/shasum -a 256 "$ORIG" | /usr/bin/awk '{print $1}')"
echo "D97AEC_ORIGINAL_CORE_SHA256_ACTUAL=$SHA"
echo "D97AEC_ORIGINAL_CORE_SHA256_EXPECTED=$ORIGINAL_CORE_SHA"
[[ "$SHA" == "$ORIGINAL_CORE_SHA" ]] || fail "ORIGINAL_CORE_IDENTITY_MISMATCH"
/bin/cp "$ORIG" "$FIXED"

python3 - "$FIXED" <<'PYFIX'
from pathlib import Path
import ast, hashlib, re, sys

p=Path(sys.argv[1])
text=p.read_text()
block_re=re.compile(r"(<<'(?P<tag>[A-Za-z0-9_]+)'\n)(?P<body>.*?)(\n(?P=tag)\n)",re.S)
blocks=list(block_re.finditer(text))
owners=[m for m in blocks if "helper segment SHA mismatch" in m.group("body")]
print(f"D97AEC_EMBEDDED_PYTHON_BLOCKS={[m.group('tag') for m in blocks]}")
print(f"D97AEC_SHA_AUDIT_OWNER_BLOCK_COUNT={len(owners)}")
if len(owners)!=1:
    raise SystemExit("D97AEC_OWNER_BLOCK_CARDINALITY_FAIL")

o=owners[0]
body=o.group("body")
before=body
tree=ast.parse(body)
lines=body.splitlines(keepends=True)
line_starts=[]
pos=0
for line in lines:
    line_starts.append(pos)
    pos += len(line)

def abs_start(node):
    return line_starts[node.lineno-1] + node.col_offset

def abs_end(node):
    return line_starts[node.end_lineno-1] + node.end_col_offset

def source_span(node):
    return abs_start(node), abs_end(node)

def strings_and_names(node):
    out=[]
    for x in ast.walk(node):
        if isinstance(x,ast.Constant) and isinstance(x.value,str):
            out.append(x.value)
        elif isinstance(x,ast.Name):
            out.append(x.id)
        elif isinstance(x,ast.keyword) and x.arg:
            out.append(x.arg)
    return out

hex64=re.compile(r"^[0-9a-f]{64}$")
def hash_nodes(node):
    return [x for x in ast.walk(node) if isinstance(x,ast.Constant) and isinstance(x.value,str) and hex64.fullmatch(x.value)]

def literal_span(node):
    seg=ast.get_source_segment(body,node)
    if seg is None:
        raise SystemExit("D97AEC_SOURCE_SEGMENT_MISSING")
    rel=seg.find(node.value)
    if rel<0:
        raise SystemExit("D97AEC_HASH_LITERAL_NOT_IN_SOURCE_SEGMENT")
    s=abs_start(node)+rel
    return s,s+len(node.value)

specs={
 "p6":{
   "full":"patch_mtl_compiler_tahoe_p6_request_dialect_callsite_ports",
   "correct":"ed38a8a0efad5b105f04d0ab76a4342d6fe682a33a0bf341f0b545f0da06c13a",
 },
 "p7":{
   "full":"patch_mtl_compiler_tahoe_p7_raw88_a8_read_ports",
   "correct":"a8fdac12d07a152e4a9ba5fc79558e0c594634f7762f6fd373421176e1a5b66b",
 },
}

def strength(tokens,key):
    full=specs[key]["full"]
    low=[t.lower() for t in tokens]
    score=0
    if full in tokens: score=max(score,60)
    aliases={key,key+"_name",key+"_sha",key+"_seg_sha",key+"_expected_sha","expected_"+key+"_sha",key+"_hash"}
    if any(t in aliases for t in low): score=max(score,50)
    if any(re.search(r"(?:^|_)"+key+r"(?:_|$)",t) and ("sha" in t or "hash" in t) for t in low): score=max(score,45)
    if any(re.search(r"(?:^|_)"+key+r"(?:_|$)",t) for t in low): score=max(score,30)
    return score

def add_candidate(store,key,hnode,score,kind,container):
    s,e=literal_span(hnode)
    cs,ce=source_span(container)
    rec=(score,-(ce-cs),s,e,hnode.value,kind,getattr(container,"lineno",0))
    old=store.get((s,e))
    if old is None or rec[:2]>old[:2]:
        store[(s,e)]=rec

stores={"p6":{},"p7":{}}

# Highest confidence: a named assignment whose value contains exactly one SHA.
for n in ast.walk(tree):
    if isinstance(n,ast.Assign):
        target_tokens=[]
        for t in n.targets: target_tokens.extend(strings_and_names(t))
        vals=hash_nodes(n.value)
        if len(vals)==1:
            for key in specs:
                st=strength(target_tokens,key)
                if st: add_candidate(stores[key],key,vals[0],160+st,"ASSIGNMENT",n)
    elif isinstance(n,ast.AnnAssign):
        target_tokens=strings_and_names(n.target)
        vals=hash_nodes(n.value) if n.value is not None else []
        if len(vals)==1:
            for key in specs:
                st=strength(target_tokens,key)
                if st: add_candidate(stores[key],key,vals[0],160+st,"ANN_ASSIGNMENT",n)

# Dictionary item semantic binding: key/name side identifies helper, value side supplies expected SHA.
for d in [n for n in ast.walk(tree) if isinstance(n,ast.Dict)]:
    for k,v in zip(d.keys,d.values):
        if k is None: continue
        kt=strings_and_names(k); vt=strings_and_names(v)
        vh=hash_nodes(v)
        combined=kt+vt
        for key in specs:
            sk=strength(kt,key); sc=strength(combined,key)
            if sk and len(vh)==1:
                add_candidate(stores[key],key,vh[0],145+sk,"DICT_KEY_TO_VALUE",v)
            elif sc and len(vh)==1:
                add_candidate(stores[key],key,vh[0],125+sc,"DICT_ITEM_COMBINED",v)

# Entry objects/tuples/lists/calls: nearest compact container holding helper identity plus one SHA.
for n in ast.walk(tree):
    if not isinstance(n,(ast.Tuple,ast.List,ast.Set,ast.Call)):
        continue
    hs=hash_nodes(n)
    if len(hs)!=1: continue
    toks=strings_and_names(n)
    for key in specs:
        st=strength(toks,key)
        if st:
            base=115 if isinstance(n,ast.Call) else 105
            add_candidate(stores[key],key,hs[0],base+st,"COMPACT_ENTRY_"+type(n).__name__.upper(),n)

selected={}
for key in ("p6","p7"):
    vals=sorted(stores[key].values(),reverse=True)
    print(f"D97AEC_{key.upper()}_AST_CANDIDATE_COUNT={len(vals)}")
    for idx,r in enumerate(vals[:12],1):
        score,negspan,s,e,old,kind,line=r
        print(f"D97AEC_{key.upper()}_CANDIDATE_{idx}=SCORE={score}|SPAN={-negspan}|LINE={line}|KIND={kind}|OLD={old}|OFFSET={s}")
    if not vals:
        raise SystemExit(f"D97AEC_{key.upper()}_NO_SEMANTIC_SHA_BINDING")
    top=vals[0]
    if len(vals)>1 and vals[1][:2]==top[:2] and vals[1][2:4]!=top[2:4]:
        raise SystemExit(f"D97AEC_{key.upper()}_AMBIGUOUS_TOP_BINDING")
    selected[key]=top

if selected["p6"][2:4]==selected["p7"][2:4]:
    raise SystemExit("D97AEC_P6_P7_SAME_LITERAL_BINDING")
if selected["p6"][4]==specs["p6"]["correct"]:
    raise SystemExit("D97AEC_P6_FALSE_EXPECTED_LITERAL_NOT_FOUND")

spans=[]
for key in ("p6","p7"):
    _,_,s,e,old,kind,line=selected[key]
    new=specs[key]["correct"]
    spans.append((s,e,old,new,key,kind,line))
    state="UNCHANGED" if old==new else "CORRECTED"
    print(f"D97AEC_SHA_BINDING={key.upper()}|LINE={line}|KIND={kind}|OLD={old}|NEW={new}|STATE={state}")

patched=body
for s,e,old,new,key,kind,line in sorted(spans,reverse=True):
    if patched[s:e]!=old:
        raise SystemExit(f"D97AEC_{key.upper()}_LITERAL_PREIMAGE_FAIL")
    patched=patched[:s]+new+patched[e:]

def neutral(src):
    out=src
    for s,e,old,new,key,kind,line in sorted(spans,reverse=True):
        token=("<D97AEC_"+key.upper()+"_SHA>").ljust(64,"_")[:64]
        out=out[:s]+token+out[e:]
    return out
if neutral(before)!=neutral(patched):
    raise SystemExit("D97AEC_NON_SHA_OWNER_BLOCK_CHANGE")
changed=sum(old!=new for _,_,old,new,_,_,_ in spans)
print(f"D97AEC_CHANGED_SHA_LITERAL_COUNT={changed}")
if changed not in (1,2):
    raise SystemExit("D97AEC_CHANGED_LITERAL_COUNT_INVALID")
print("D97AEC_ONLY_SEMANTIC_P6_P7_EXPECTED_SHA_LITERALS_CHANGED=PASS")

text=text[:o.start("body")]+patched+text[o.end("body"):]
p.write_text(text)
for m in block_re.finditer(text):
    compile(m.group("body"),f"<{m.group('tag')}>","exec")
print("D97AEC_EMBEDDED_PYTHON_COMPILE=PASS")

anchors=[
 "EXPECTED_SELECTOR_ONLY_SERVICE_SHA=a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43",
 "EXPECTED_D97AD_FINAL_MTL_SHA=524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755",
 "OUTCOME_110=validator_reaches_REL_0x58B",
 "OUTCOME_111=buffer_argument_index_error_REL_0x29A",
 "OUTCOME_112=sampler_argument_index_error_REL_0x2D9",
 "OUTCOME_113=nested_argument_buffer_pointer_REL_0x3E2",
 "OUTCOME_114=other_early_return_REL_0xB9_or_unwind_REL_0x6CC",
 "RUNTIME_LIVENESS_GATE=every_spawned_MTLCompilerService_must_emit_exactly_one_exit_110_114_or_runtime_run_invalid",
 "ROOT_PATCH=AUTO-NO","REBOOT=AUTO-NO",
]
missing=[a for a in anchors if a not in text]
print(f"D97AEC_REQUIRED_ANCHORS_MISSING={missing}")
if missing:
    raise SystemExit("D97AEC_RUNTIME_ANCHOR_MISSING")
print("D97AEC_D97AE_FUNCTIONAL_CONTRACT_UNCHANGED=PASS")
print("D97AEC_FIXED_CORE_SHA256="+hashlib.sha256(p.read_bytes()).hexdigest())
PYFIX

/bin/zsh -n "$FIXED"; echo "D97AEC_FIXED_CORE_ZSH_PARSE=PASS"
echo "===== EXECUTE AST-SEMANTIC-SHA-CORRECTED D97AE CORE ====="
set +e
/bin/zsh "$FIXED"
RC=$?
set -e
echo "D97AEC_CORE_RC=$RC"
if [[ "$RC" -ne 0 ]]; then
 echo "D97AEC_WRAPPER=CORE_FAILED"
 echo "ROOT_PATCH=AUTO-NO"
 echo "REBOOT=AUTO-NO"
 exit "$RC"
fi
[[ -f "$CORE_REPORT" ]] || fail "CORE_REPORT_MISSING"
grep -q '^FASTLANE_D97AE_PRE_D97_WHOLE_STAGE_EXIT_CLASSIFIER=PASS$' "$CORE_REPORT" || fail "CORE_PASS_GATE_MISSING"
grep -q '^ROOT_PATCH=AUTO-NO$' "$CORE_REPORT" || fail "ROOT_PATCH_GATE_MISSING"
grep -q '^REBOOT=AUTO-NO$' "$CORE_REPORT" || fail "REBOOT_GATE_MISSING"

echo "===== FINAL ====="
echo "D97AEC_WRAPPER=PASS"
echo "D97AEC_CORE_RC=0"
echo "D97AE_FUNCTIONAL_DESIGN_CHANGE=NO"
echo "D97AE_RUNTIME_PATCH_BYTES_CHANGE=NO"
echo "D97AE_SOURCE_TRANSITION_CHANGE=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_full_FASTLANE_audit_before_manual_Root_Patch"
echo "CORE_REPORT=$CORE_REPORT"
echo "WRAPPER_REPORT=$REPORT"
