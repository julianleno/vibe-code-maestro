# Orchestrator protocol

## Responsibilities

The orchestrator is not the primary implementation agent. It manages truth, scope, dependencies, evidence and authority across executors.

## Startup

1. Resolve project root and active memory namespace.
2. Load compact state only.
3. Reconcile stale/freshness-sensitive fields against live GitHub/runtime.
4. Identify active workstreams and their dependency graph.
5. Detect file/domain conflicts before assignment.
6. Compile the smallest mission packet that lets the selected role succeed.

## Mission construction

A mission packet must contain:

```yaml
mission:
  id: string
  workstream: string
  objective: string
  definition_of_done: []

base:
  branch: string
  sha: string | "REFETCH_REQUIRED"

dependencies: []
reservations:
  owned: []
  forbidden: []

authority: {}
canonical_context: []
known_gotchas: []
required_checks: []
forbidden_actions: []
handoff_schema: []
```

Do not send broad project history when references are sufficient.

## Handoff intake

When an executor returns a handoff:

1. parse claims into factual categories;
2. identify what can be independently checked;
3. refetch PR/main/head/diff/CI/reviews as applicable;
4. compare changed files to reservations and scope;
5. distinguish executor-reported local checks from orchestrator-verified remote evidence;
6. issue verdict:
   - `APPROVED_FOR_NEXT_GATE`
   - `CHANGES_REQUIRED`
   - `BLOCKED`
   - `NEEDS_HUMAN_DECISION`
7. if changes are required, generate a narrow correction mission containing only verified blockers.

## Merge/release sequence

When human authorization arrives:

```text
freshness re-fetch
→ exact-head verification
→ required CI/review verification
→ reservation/scope sanity check
→ privileged mutation
→ refetch result
→ update workstream
→ release reservations
→ recompute dependent workstreams
→ consolidate memory
```

## Parallelism

Parallel work is allowed when:
- file/domain ownership is disjoint or explicitly coordinated;
- dependency edges do not require stale assumptions;
- each agent has a bounded mission;
- the number of concurrent fronts remains operationally reviewable.

Do not maximize agent count. Maximize independent progress with low integration risk.

## Stale-state behavior

If `STATE` says a PR is open but GitHub says merged, GitHub wins and memory becomes stale. Update the state rather than asking the human to reconcile routine discrepancies.

If memory and live evidence conflict on a durable architectural decision rather than current status, stop and surface the conflict instead of silently choosing.
