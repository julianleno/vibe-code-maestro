# Control-plane drift

Control-plane memory is useful only if it can disagree with reality safely.

## Definition

`CONTROL_PLANE_DRIFT` means the implementation or live repository has moved beyond orchestration metadata without necessarily violating the mission itself.

Examples:

- a legitimate required file is changed but was omitted from the reservation list;
- main advanced after a workstream packet was compiled;
- a PR head changed while memory still points at the previous SHA;
- an agent assignment ended but STATE still marks it active;
- a dependency was merged and the downstream workstream still records it as blocked.

Drift is not automatically a code defect.

## Reservation decision tree

When a changed file is outside the declared owned reservation:

```text
changed file outside reservation
        |
        v
is the file necessary to the mission?
   | no                     | yes
   v                        v
SCOPE_VIOLATION       does another active owner reserve it?
                           | yes            | no
                           v                v
                      OWNERSHIP_CONFLICT  CONTROL_PLANE_DRIFT
```

### SCOPE_VIOLATION
The file is not required for the mission or expands product/architecture scope without authorization. Treat as a QA finding and normally require correction.

### OWNERSHIP_CONFLICT
The file is materially owned by another active workstream. Stop writes until ownership is resolved.

### CONTROL_PLANE_DRIFT
The file is legitimately necessary, no conflicting owner exists, and the reservation metadata is incomplete/stale. Update orchestration state before the next assignment or mutation.

## Drift classes

- `STATE_DRIFT` — default branch, PR status/head/base, issue status or dependency status changed.
- `RESERVATION_DRIFT` — legitimate touched paths are missing/stale in reservations.
- `AUTHORITY_DRIFT` — mission needs a mutation not represented by current authority; never infer permission.
- `DEPENDENCY_DRIFT` — dependency graph no longer matches merged/blocked reality.
- `ASSIGNMENT_DRIFT` — agent/workstream ownership metadata is stale.

## Required handling

1. Detect the contradiction.
2. Classify it.
3. Prefer live repository/runtime truth for freshness-sensitive facts.
4. Preserve human/control-plane authority for permissions and decisions.
5. Do not silently rewrite canonical memory from an executor claim.
6. Record the correction or candidate correction.
7. Recompile affected mission packets.

## Important distinction

Absence of a GitHub conflict does not independently verify a reservation. Reservations are control-plane state. A reviewer may report:

```text
reservation: CONTROL_PLANE_CANONICAL
live conflict detected: false
```

but should not report:

```text
reservation: GitHub verified
```

unless the project has an explicit GitHub-backed reservation mechanism.

## Stale-memory test

A healthy Maestro deployment must deliberately pass this test:

> Given a memory packet containing an old main SHA or PR head, a fresh agent detects the mismatch, reports the stale record, uses current live state for operational conclusions, and does not discard unrelated canonical human decisions.
