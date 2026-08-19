# Evidence model

Maestro Next separates **claims**, **control-plane state**, and **independently verified evidence**. A reviewer must never flatten these into one notion of "truth".

## Truth classes

### LIVE_VERIFIED
Freshly checked against the current operational source of truth, for example:

- repository/default-branch state;
- exact PR head/base;
- changed files and diff;
- CI/checks tied to the exact head;
- runtime or authoritative external system state when the mission permits querying it.

Live verification expires when the relevant source changes.

### CONTROL_PLANE_CANONICAL
Current orchestration state accepted by the control plane, for example:

- file reservations;
- agent assignment;
- human decisions;
- mission authority;
- accepted architecture decisions.

This is authoritative for orchestration unless contradicted by a higher-authority human decision or an observable live conflict. It is not "GitHub verified" merely because GitHub shows no contradiction.

### EXECUTOR_CLAIM
Statements originating from the implementation agent, PR body, handoff, comments, or un-replayed local commands. Claims guide investigation but do not certify themselves.

### INFERENCE
A conclusion derived from evidence rather than directly observed. State the supporting evidence and label the conclusion as inference.

## Evidence levels

Use the following scale for technical acceptance:

| Level | Name | Meaning |
|---|---|---|
| E0 | Claim only | Executor/PR/handoff says it is true. |
| E1 | Static presence | File, symbol, test name, grep hit, or configuration exists. |
| E2 | Direct inspection | Relevant implementation/diff/assertion was read and supports the criterion. |
| E3 | Executed evidence | Directly inspected implementation/test plus exact-head CI or another trustworthy execution proves the relevant gate ran successfully. |
| E4 | Independent replay | QA independently reran the targeted behavior/test in a suitable environment. |

Higher levels include the lower-level evidence needed to interpret them; they do not erase uncertainty outside the inspected path.

## Acceptance thresholds

### Critical acceptance criteria

Security boundaries, write gates, authorization, historical immutability, destructive behavior, pricing/business invariants, migrations, publication, and other mission-critical invariants require at least **E2** to be marked PASS.

If a relevant automated test exists and exact-head CI is available, prefer **E3** before recommending merge consideration.

A test filename or grep hit alone is E1 and cannot produce PASS for a critical criterion.

### Non-critical criteria

E1 may be sufficient for low-risk inventory facts such as "file X is present" or "no migration file is in the final diff", when the statement itself is purely structural.

## CI evidence

Do not stop at an aggregate workflow badge when the mission depends on specific gates.

For critical review:

1. verify the workflow belongs to the exact current head;
2. inspect jobs;
3. inspect relevant steps when job aggregation hides typecheck/test/build/lint or other required gates;
4. record skipped deploy/production jobs separately from passed validation jobs.

A green workflow from an older SHA is not evidence for the current head.

## Local executor tests

If the executor reports a local command and QA did not replay it, report:

`NOT INDEPENDENTLY REPLAYED`

The command may still be useful supporting evidence, but it remains EXECUTOR_CLAIM unless corroborated by independently inspected CI/runtime evidence.

## Recommended evidence record

```yaml
criterion: historical quote snapshot is immutable
truth_class: LIVE_VERIFIED
evidence_level: E3
sources:
  - implementation: apps/.../snapshot.ts
  - assertion: apps/.../snapshot.test.ts
  - ci_run: 12345
  - head_sha: abc123
result: pass
verified_at: 2026-08-19T00:00:00Z
```

## Rule

**A correct final verdict does not excuse weak evidence discipline.** The purpose of independent QA is to make the reasoning reproducible, not merely to guess the right outcome.
