#!/bin/zsh
set -euo pipefail

REPORT="$HOME/Desktop/OCLP7_D97AC_SCC_SINK_AND_RESIDUAL_TERMINAL_HARDENED_WRAPPER_REPORT.txt"
CORE_REPORT="$HOME/Desktop/OCLP7_D97AC_READONLY_PRE_D97_VALIDATOR_SCC_FINITE_OUTCOME_AUDIT_REPORT.txt"
BASE_COMMIT="e0519e5b38c029e5bfd6ba141c422b43ca64246e"
BASE_BLOB="366fb2a45895723d103b7edb31679a4cd5dd9a16"
BASE_NAME="OCLP7_D97AB_READONLY_PRE_D97_VALIDATOR_WHOLE_STAGE_OUTCOME_MAP.command"
TMPDIR_D97AC="$(/usr/bin/mktemp -d -t oclp-d97ac)"
BASE="$TMPDIR_D97AC/$BASE_NAME"
CORE="$TMPDIR_D97AC/OCLP7_D97AC_READONLY_PRE_D97_VALIDATOR_SCC_FINITE_OUTCOME_AUDIT.command"
trap '/bin/rm -rf "$TMPDIR_D97AC"' EXIT
exec > >(tee "$REPORT") 2>&1
fail(){ echo "D97AC_FAIL=$*"; echo "REPORT=$REPORT"; exit 2; }

echo "===== OCLP7 D97AC — SCC/SINK + RESIDUAL-TERMINAL HARDENED WRAPPER ====="
echo "PURPOSE=correct_D97AB_cycle_equals_unclassified_outcome_false_negative_and_prove_or_reject_finite_outcome_classifier_coverage"
echo "INPUT_D97AB=two_residual_cycles_plus_two_residual_terminals_partition_marked_incomplete"
echo "CORRECTION_1=Tarjan_SCC_condensation_and_closed_nonterminal_SCC_detection"
echo "CORRECTION_2=reverse_reachability_from_all_known_and_residual_finite_outcomes"
echo "CORRECTION_3=explicit_reachable_outside_or_unresolved_edge_gate"
echo "CORRECTION_4=residual_terminal_inbound_and_raw_byte_provenance"
echo "STATIC_TERMINATION_CLAIM=NO_when_cyclic_SCCs_exist"
echo "RUNTIME_COVERAGE_GATE=every_spawned_service_must_emit_exactly_one_classifier_exit_or_run_is_invalid"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "GOLDEN_MUTATION=NO"
echo "SERVICE_LAUNCH=AUTO-NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "D82_EXECUTION=NO"
echo "PATCH8_AUTO_INTEGRATION=NO"
echo "REPORT=$REPORT"
echo "CORE_REPORT=$CORE_REPORT"

for t in curl git python3 zsh; do
  P="$(command -v "$t" 2>/dev/null || true)"
  echo "TOOL_${t}=${P:-MISSING}"
  [[ -n "$P" ]] || fail "MISSING_TOOL:$t"
done
PY="$(command -v python3)"
"$PY" --version 2>&1

URL="https://raw.githubusercontent.com/StefanAlMare/StefanAlMare/$BASE_COMMIT/$BASE_NAME"
/usr/bin/curl -fL "$URL" -o "$BASE"
ACTUAL_BLOB="$(/usr/bin/git hash-object "$BASE")"
echo "D97AC_BASE_BLOB_ACTUAL=$ACTUAL_BLOB"
[[ "$ACTUAL_BLOB" == "$BASE_BLOB" ]] || fail "BASE_BLOB_MISMATCH:$ACTUAL_BLOB"
echo "D97AC_BASE_IDENTITY=PASS"

"$PY" - "$BASE" "$CORE" <<'PYTRANSFORM'
from pathlib import Path
import sys
src=Path(sys.argv[1]); dst=Path(sys.argv[2]); s=src.read_text()
old_report='REPORT="$HOME/Desktop/OCLP7_D97AB_READONLY_PRE_D97_VALIDATOR_WHOLE_STAGE_OUTCOME_MAP_REPORT.txt"'
new_report='REPORT="$HOME/Desktop/OCLP7_D97AC_READONLY_PRE_D97_VALIDATOR_SCC_FINITE_OUTCOME_AUDIT_REPORT.txt"'
if s.count(old_report)!=1: raise SystemExit('REPORT_TRANSFORM_CARDINALITY_FAIL')
s=s.replace(old_report,new_report,1)
s=s.replace('OCLP7 D97AB — READ-ONLY PRE-D97 VALIDATOR WHOLE-STAGE OUTCOME MAP','OCLP7 D97AC — READ-ONLY PRE-D97 VALIDATOR SCC / FINITE-OUTCOME AUDIT',1)
s=s.replace('D97AB_','D97AC_')
start_marker='    # Partition all entry paths by treating candidate and the three known early outcomes as terminals.\n'
end_marker='    # Patch-window safety for an 8-byte terminal marker trampoline.\n'
if s.count(start_marker)!=1 or s.count(end_marker)!=1:
    raise SystemExit('PARTITION_MARKER_CARDINALITY_FAIL')
a=s.index(start_marker); b=s.index(end_marker,a)
new_block=r'''    # Partition finite outcomes, then analyze cyclic SCCs separately from outcomes.
    # A cycle is not itself an outcome.  Only a closed nonterminal SCC, an
    # unresolved/outside edge, or a reachable block with no path to a known
    # finite outcome blocks classifier design.
    stop={cand_b,*marker_bs}
    partition_reach=reach(stop)
    residual_terms=[]
    for b in sorted(partition_reach):
        if b in stop: continue
        succ=[n for n in edges[b] if n in partition_reach]
        if not succ: residual_terms.append(b)

    residual_nodes=set(partition_reach)-stop

    # Tarjan SCC over the residual graph.
    tarjan_index=0; tarjan_stack=[]; tarjan_on=set(); tarjan_idx={}; tarjan_low={}; sccs=[]
    def strongconnect(v):
        nonlocal_tarjan[0]+=1
        tarjan_idx[v]=tarjan_low[v]=nonlocal_tarjan[0]
        tarjan_stack.append(v); tarjan_on.add(v)
        for w in edges[v]:
            if w not in residual_nodes: continue
            if w not in tarjan_idx:
                strongconnect(w); tarjan_low[v]=min(tarjan_low[v],tarjan_low[w])
            elif w in tarjan_on:
                tarjan_low[v]=min(tarjan_low[v],tarjan_idx[w])
        if tarjan_low[v]==tarjan_idx[v]:
            comp=[]
            while True:
                w=tarjan_stack.pop(); tarjan_on.remove(w); comp.append(w)
                if w==v: break
            sccs.append(sorted(comp))
    nonlocal_tarjan=[-1]
    for v in sorted(residual_nodes):
        if v not in tarjan_idx: strongconnect(v)

    cyclic_sccs=[]; closed_nonterminal_sccs=[]
    for comp in sccs:
        cs=set(comp)
        cyclic=(len(comp)>1 or any(v in edges[v] for v in comp))
        if not cyclic: continue
        out=sorted({n for v in comp for n in edges[v] if n not in cs})
        cyclic_sccs.append((comp,out))
        if not out: closed_nonterminal_sccs.append(comp)

    outcome_name={cand_b:'CANDIDATE_REACHED'}
    for lab,b in zip(labels,marker_bs): outcome_name[b]=lab
    for j,b in enumerate(residual_terms,1): outcome_name[b]=f'OTHER_EARLY_{j}'
    outcome_blocks=set(outcome_name)

    # Reverse reachability proves whether every reachable block has at least
    # one finite path to a classified outcome.  It deliberately does not claim
    # that loops terminate for all machine states.
    reverse={b:set() for b in partition_reach}
    for v in partition_reach:
        for w in edges[v]:
            if w in partition_reach: reverse[w].add(v)
    can_reach_outcome=set(); q=collections.deque(sorted(outcome_blocks))
    while q:
        v=q.popleft()
        if v in can_reach_outcome: continue
        can_reach_outcome.add(v)
        for p in reverse.get(v,()):
            if p not in can_reach_outcome: q.append(p)
    uncovered=sorted(set(partition_reach)-can_reach_outcome)
    reachable_outside=[x for x in outside if x[0] in partition_reach and x[0] not in stop]

    def outcomes_from(starts):
        seen=set(); found=set(); q=collections.deque(starts)
        while q:
            v=q.popleft()
            if v in seen: continue
            seen.add(v)
            if v in outcome_name:
                found.add(outcome_name[v]); continue
            for w in edges[v]:
                if w in partition_reach and w not in seen: q.append(w)
        return sorted(found)

    print('\n===== SCC-HARDENED WHOLE-STAGE FINITE-OUTCOME PARTITION =====')
    print('KNOWN_TERMINAL_MARKER_COUNT=4')
    print('KNOWN_TERMINAL_MARKERS=CANDIDATE_REL_0x58B,BUFFER_INDEX_REL_0x29A,SAMPLER_INDEX_REL_0x2D9,NESTED_ARG_BUFFER_REL_0x3E2')
    print('RESIDUAL_OTHER_EARLY_TERMINAL_BLOCK_COUNT='+str(len(residual_terms)))
    for j,b in enumerate(residual_terms,1):
        l,r,ins=blocks[b]
        inbound=sorted(p for p in partition_reach if b in edges[p])
        fo=tfo+(l-tvm)
        raw=bytes(data[fo:min(len(data),fo+48)]).hex()
        print(f'RESIDUAL_TERMINAL_{j}=B{b}|REL=0x{l-fstart:X}..0x{r-fstart:X}|LAST={ins[-1][1]}')
        print(f'RESIDUAL_TERMINAL_{j}_INBOUND_COUNT={len(inbound)}|INBOUND='+','.join(f'B{x}@0x{blocks[x][0]-fstart:X}' for x in inbound))
        print(f'RESIDUAL_TERMINAL_{j}_RAW48={raw}')
        for a,t in ins[:8]: print(f'RESIDUAL_TERMINAL_{j}_HEAD_INSN=REL+0x{a-fstart:X}|{t}')
        if len(ins)>8:
            for a,t in ins[-8:]: print(f'RESIDUAL_TERMINAL_{j}_TAIL_INSN=REL+0x{a-fstart:X}|{t}')

    print('CYCLIC_SCC_COUNT='+str(len(cyclic_sccs)))
    for j,(comp,out) in enumerate(cyclic_sccs,1):
        print(f'CYCLIC_SCC_{j}_BLOCKS='+','.join(f'B{x}@0x{blocks[x][0]-fstart:X}' for x in comp))
        print(f'CYCLIC_SCC_{j}_OUT_EDGES='+','.join(f'B{x}@0x{blocks[x][0]-fstart:X}' for x in out))
        print(f'CYCLIC_SCC_{j}_REACHABLE_OUTCOMES='+','.join(outcomes_from(comp)))
        for x in comp:
            l,r,ins=blocks[x]
            print(f'CYCLIC_SCC_{j}_BLOCK=B{x}|REL=0x{l-fstart:X}..0x{r-fstart:X}|LAST={ins[-1][1]}')
    print('CLOSED_NONTERMINAL_SCC_COUNT='+str(len(closed_nonterminal_sccs)))
    for j,comp in enumerate(closed_nonterminal_sccs,1):
        print(f'CLOSED_NONTERMINAL_SCC_{j}='+','.join(f'B{x}@0x{blocks[x][0]-fstart:X}' for x in comp))
    print('REACHABLE_OUTSIDE_OR_UNRESOLVED_EDGE_COUNT='+str(len(reachable_outside)))
    for j,(b,target,text) in enumerate(reachable_outside,1):
        print(f'REACHABLE_OUTSIDE_OR_UNRESOLVED_{j}=SOURCE=B{b}@0x{blocks[b][0]-fstart:X}|TARGET={"UNKNOWN" if target is None else hex(target)}|INSN={text}')
    print('BLOCKS_WITHOUT_PATH_TO_CLASSIFIED_FINITE_OUTCOME_COUNT='+str(len(uncovered)))
    if uncovered:
        print('BLOCKS_WITHOUT_PATH_TO_CLASSIFIED_FINITE_OUTCOME='+','.join(f'B{x}@0x{blocks[x][0]-fstart:X}' for x in uncovered))

    outcome_reachability_pass=(len(uncovered)==0)
    finite_path_partition=(outcome_reachability_pass and len(reachable_outside)==0)
    classifier_static_ready=(finite_path_partition and len(closed_nonterminal_sccs)==0)
    exhaustive=classifier_static_ready
    print('ALL_REACHABLE_BLOCKS_HAVE_CLASSIFIED_FINITE_OUTCOME_PATH=' + ('PASS' if outcome_reachability_pass else 'FAIL'))
    print('FINITE_PATH_OUTCOME_PARTITION_EXHAUSTIVE_STATIC=' + ('PASS' if finite_path_partition else 'FAIL'))
    print('STATIC_TERMINATION_PROOF=' + ('ACYCLIC' if not cyclic_sccs else 'NOT_CLAIMED_CYCLIC_SCCS_PRESENT'))
    print('RUNTIME_LIVENESS_COVERAGE_GATE=every_spawned_MTLCompilerService_must_emit_exactly_one_exit_110_114;spawn_without_classifier_exit_invalidates_runtime_classification')
    print('SCC_HARDENED_CLASSIFIER_STATIC_READY=' + ('YES' if classifier_static_ready else 'NO'))

'''
s=s[:a]+new_block+s[b:]
old='    all_safe=cave_safe and exhaustive\n'
new='    all_safe=cave_safe and classifier_static_ready\n'
if s.count(old)!=1: raise SystemExit('ALL_SAFE_TRANSFORM_CARDINALITY_FAIL')
s=s.replace(old,new,1)
s=s.replace("print('D97AC_WHOLE_STAGE_OUTCOME_PARTITION=' + ('STATIC_MAPPED_EXHAUSTIVE' if exhaustive else 'INCOMPLETE'))",
            "print('D97AC_FINITE_PATH_OUTCOME_PARTITION=' + ('STATIC_PROVEN' if finite_path_partition else 'INCOMPLETE'))")
s=s.replace("print('D97AC_TERMINAL_CLASSIFIER_DESIGN_SAFETY=' + ('STATIC_PROVEN_FOR_FASTLANE_DESIGN_ONLY' if all_safe else 'NOT_AUTHORIZED'))",
            "print('D97AC_TERMINAL_CLASSIFIER_DESIGN_SAFETY=' + ('STATIC_PROVEN_FOR_FASTLANE_DESIGN_ONLY_WITH_RUNTIME_LIVENESS_GATE' if all_safe else 'NOT_AUTHORIZED'))")
dst.write_text(s); dst.chmod(0o755)
print('D97AC_TRANSFORM=PASS')
print('D97AC_GENERATED_SIZE='+str(dst.stat().st_size))
PYTRANSFORM

/bin/zsh -n "$CORE"
echo "D97AC_CORE_ZSH_PARSE=PASS"
"$PY" - "$CORE" <<'PYAUD'
from pathlib import Path
import re,sys
s=Path(sys.argv[1]).read_text()
blocks=re.findall(r"<<'([A-Z0-9_]+)'\n(.*?)\n\1\n",s,re.S)
print('D97AC_EMBEDDED_PYTHON_BLOCKS='+repr([x[0] for x in blocks]))
for name,code in blocks: compile(code,str(sys.argv[1])+'::<'+name+'>','exec')
print('D97AC_EMBEDDED_PYTHON_COMPILE=PASS')
required=(
 'Tarjan SCC over the residual graph',
 'CLOSED_NONTERMINAL_SCC_COUNT=',
 'BLOCKS_WITHOUT_PATH_TO_CLASSIFIED_FINITE_OUTCOME_COUNT=',
 'FINITE_PATH_OUTCOME_PARTITION_EXHAUSTIVE_STATIC=',
 'STATIC_TERMINATION_PROOF=',
 'RUNTIME_LIVENESS_COVERAGE_GATE=',
 'STATIC_PROVEN_FOR_FASTLANE_DESIGN_ONLY_WITH_RUNTIME_LIVENESS_GATE',
 'ROOT_PATCH=AUTO-NO','REBOOT=AUTO-NO')
missing=[x for x in required if x not in s]
print('D97AC_REQUIRED_ANCHORS_MISSING='+repr(missing))
if missing: raise SystemExit('D97AC_STATIC_CONTRACT_FAIL')
forbidden=('exhaustive=(len(cyc_unique)==0)','ENTRY_PATH_PARTITION_EXHAUSTIVE_STATIC=')
hits=[x for x in forbidden if x in s]
print('D97AC_RETIRED_FALSE_NEGATIVE_ANCHORS='+repr(hits))
if hits: raise SystemExit('D97AC_RETIRED_LOGIC_STILL_PRESENT')
print('D97AC_STATIC_CONTRACT_AUDIT=PASS')
PYAUD

echo "===== EXECUTE HARDENED D97AC CORE ====="
set +e
/bin/zsh "$CORE"
RC=$?
set -e
echo "D97AC_CORE_RC=$RC"
[[ "$RC" -eq 0 ]] || fail "CORE_FAILED_RC:$RC"
[[ -f "$CORE_REPORT" ]] || fail "CORE_REPORT_MISSING"
/usr/bin/grep -Fq 'D97AC_READONLY_PRE_D97_VALIDATOR_WHOLE_STAGE_OUTCOME_MAP=PASS' "$CORE_REPORT" || fail "CORE_FINAL_PASS_GATE_MISSING"
/usr/bin/grep -Fq 'ROOT_PATCH=AUTO-NO' "$CORE_REPORT" || fail "CORE_ROOT_PATCH_GATE_MISSING"
/usr/bin/grep -Fq 'REBOOT=AUTO-NO' "$CORE_REPORT" || fail "CORE_REBOOT_GATE_MISSING"

echo "===== FINAL ====="
echo "D97AC_WRAPPER=PASS"
echo "D97AC_CORE_RC=0"
echo "SOURCE_MUTATION=NO"
echo "SYSTEM_MUTATION=NO"
echo "ROOT_PATCH=AUTO-NO"
echo "REBOOT=AUTO-NO"
echo "NEXT=assistant_audit_SCC_sink_finite_outcome_coverage_before_any_FASTLANE"
echo "CORE_REPORT=$CORE_REPORT"
echo "WRAPPER_REPORT=$REPORT"
