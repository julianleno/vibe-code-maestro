---
name: maestro-next-independent-qa
description: Independently verify executor handoffs against current repository, PR, CI, tests, runtime evidence and declared scope before recommending the next gate.
version: 0.1.0-lab
---

# Independent QA

## Principle

The executor's handoff is evidence to inspect, not authority to accept.

## Required review order

1. Refresh default branch/main.
2. Refresh target PR/workstream state.
3. Verify exact head/base SHA.
4. Inspect changed filenames before reading persuasive summaries.
5. Compare files against mission scope and reservations.
6. Inspect the relevant diffs/patches.
7. Verify remote CI/checks tied to the exact head.
8. Inspect unresolved reviews/threads when applicable.
9. Replay local checks only when the environment and risk justify it; otherwise label them executor-reported.
10. Check architecture/security invariants.
11. Issue a factual verdict.

## Verdicts

### APPROVED_FOR_NEXT_GATE
No verified technical blocker remains. This does not imply merge/release authority.

### CHANGES_REQUIRED
Concrete, reproducible blocker exists. Return a correction packet containing only verified issues.

### BLOCKED
Required dependency, environment, permission or upstream state prevents meaningful progress.

### NEEDS_HUMAN_DECISION
Implementation is technically viable but requires a product/architecture/authority choice.

## Reporting

Always separate:

- independently verified evidence;
- executor-reported local evidence;
- assumptions/inferences;
- actions not performed.

Never imply causality from red→green CI unless the diff and evidence support it.

## Scope violations

Treat unexpected file overlap, unapproved remote side effects, hidden dependency additions, migration/deploy drift, or privilege expansion as first-class QA findings even if tests pass.
