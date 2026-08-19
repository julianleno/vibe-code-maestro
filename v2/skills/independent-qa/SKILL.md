---
name: maestro-next-independent-qa
description: Independently verify executor handoffs against current repository, PR, CI, tests, runtime evidence and declared scope before recommending the next gate.
version: 0.2.0-lab
---

# Independent QA

## Principle

The executor's handoff is a **claim source**, not authority to accept. A correct verdict reached through weak evidence is still a QA defect.

Read `v2/core/evidence-model.md` and `v2/core/control-plane-drift.md` when this skill is invoked.

## Required review order

1. Refresh default branch/main.
2. Refresh target issue/PR/workstream state.
3. Verify exact head/base SHA.
4. Inspect changed filenames before reading persuasive summaries.
5. Compare files against mission scope and reservations.
6. Classify unexpected paths as `SCOPE_VIOLATION`, `OWNERSHIP_CONFLICT`, or `CONTROL_PLANE_DRIFT`.
7. Inspect the relevant diffs/patches directly.
8. Map each critical acceptance criterion to concrete code and/or test assertions.
9. Verify remote CI/checks tied to the **exact current head**.
10. When critical gates are aggregated, inspect workflow jobs and relevant steps.
11. Inspect unresolved reviews/threads when applicable.
12. Replay local checks only when the environment and risk justify it; otherwise label them executor-reported.
13. Check architecture/security/business invariants.
14. Issue a factual verdict.

## Evidence threshold

Use E0–E4 from the evidence model.

Critical criteria require at least **E2 direct inspection** to be marked PASS.

When a relevant automated test exists and exact-head CI is available, prefer **E3**:

```text
implementation/assertion directly inspected
+
relevant test/gate executed by exact-head CI
```

The following are insufficient by themselves for a critical PASS:

- PR body says it works;
- executor handoff says tests passed;
- test filename exists;
- grep finds a symbol;
- aggregate workflow badge is green but the relevant job/step was not established.

For local commands that QA did not rerun, write exactly:

`NOT INDEPENDENTLY REPLAYED`

## Truth classes

Every important finding should be recognizable as one of:

- `LIVE_VERIFIED`;
- `CONTROL_PLANE_CANONICAL`;
- `EXECUTOR_CLAIM`;
- `INFERENCE`.

Do not call reservations, human approvals, or agent assignments "GitHub verified" merely because no GitHub contradiction was found.

## CI protocol

For the current PR head:

1. obtain exact head SHA;
2. obtain associated workflow run(s);
3. confirm run head matches;
4. inspect required jobs;
5. inspect relevant steps when jobs aggregate typecheck/lint/test/build/security gates;
6. distinguish `success`, `skipped`, `cancelled`, and `not run`;
7. do not reuse green evidence from a previous SHA.

## Verdicts

### APPROVED_FOR_NEXT_GATE
No verified technical blocker remains and critical acceptance criteria meet the required evidence threshold. This does not imply merge/release authority.

### CHANGES_REQUIRED
Concrete, reproducible blocker exists. Return a correction packet containing only verified issues.

### BLOCKED
Required dependency, environment, permission or upstream state prevents meaningful progress.

### NEEDS_HUMAN_DECISION
Implementation is technically viable but requires a product/architecture/authority choice.

### QA_INCONCLUSIVE
Use when evidence is insufficient to support either approval or a concrete blocker. Do not manufacture confidence to avoid this verdict.

## Reporting minimum

For each critical criterion record:

- criterion;
- result;
- truth class;
- evidence level;
- implementation/test source inspected;
- exact-head execution evidence if applicable;
- uncertainty.

Then report:

- exact main/base/head;
- changed files;
- scope/reservation verdict;
- unresolved reviews;
- exact-head CI/jobs/steps;
- executor claims not independently verified;
- blockers;
- residual risks;
- authority available;
- recommended human next action.

## Scope violations and drift

Unexpected file overlap, unapproved remote side effects, hidden dependency additions, migration/deploy drift, or privilege expansion are first-class QA findings even if tests pass.

However, a legitimately required changed file missing from reservation metadata is not automatically implementation scope creep. Apply the drift decision tree. If no conflicting owner exists and the file is mission-necessary, report `CONTROL_PLANE_DRIFT` and require the orchestration metadata to be corrected.

## Merge language

Use phrasing such as:

`READY_FOR_HUMAN_MERGE_CONSIDERATION`

only when the evidence threshold is met. State explicitly that the verdict does **not** authorize merge.
