---
name: maestro-next-orchestrator
description: Operate a persistent multi-agent software-delivery control plane with progressive memory loading, isolated worktrees, independent QA, GitHub reality checks, human authority gates, and compact cross-agent handoffs.
version: 0.2.1-lab
license: MIT
---

# Maestro Next Orchestrator

## Mission

Keep multiple AI coding agents aligned across long-running projects without relying on one model's context window or a shared mutable working tree.

## Boot order

0. Establish a clean workspace boundary using `core/workspace-model.md`:
   - verify the canonical remote;
   - `git fetch --prune origin`;
   - inspect cleanliness before reuse;
   - prefer one isolated worktree per agent/workstream/role;
   - record the refreshed `origin/main` SHA;
   - never hide dirty/diverged state with an opportunistic stash/reset.
1. Read the smallest available boot/state document.
2. Identify the requested project and workstream.
3. Load only memory referenced by that workstream.
4. Verify freshness-sensitive state against live sources before acting.
5. Inspect active reservations and dependency edges.
6. Compile a role-specific mission packet.

Do not preload full histories, transcripts, archived handoffs, or all decisions.

A local `main` checkout is not operational truth. GitHub/live remote state outranks it for freshness-sensitive facts.

## Memory hierarchy

Use these scopes:

`global → project → workstream → session`

Use these authority classes:

`canonical rule/decision > active procedure > verified handoff > observation/session evidence > superseded/history`

Authority affects retrieval priority, not truth. Historical memory is untrusted until it matches live reality where the claim is freshness-sensitive.

## Truth and evidence

Read `core/evidence-model.md` for technical verification and `core/control-plane-drift.md` when memory/reservations disagree with live reality.

Keep these classes distinct:

- `LIVE_VERIFIED` — freshly checked repository/CI/runtime facts;
- `CONTROL_PLANE_CANONICAL` — reservations, authority, accepted human/orchestrator decisions;
- `EXECUTOR_CLAIM` — PR body, handoff, comments, un-replayed local commands;
- `INFERENCE` — conclusion derived from evidence.

For technical QA use evidence levels E0–E4. Critical acceptance criteria require direct evidence; executor narrative cannot certify itself.

## Orchestration contract

For every workstream:

1. renew/verify the workspace boundary and remote base;
2. define objective and acceptance criteria;
3. declare dependencies and reserved files;
4. assign the narrowest suitable agent role and isolated workspace;
5. provide a bounded mission packet;
6. require a structured factual handoff including workspace/base/head provenance;
7. independently verify head/base/diff/tests/CI/runtime as applicable;
8. classify scope/reservation mismatches rather than assuming every mismatch is implementation scope creep;
9. issue a surgical correction mission for concrete blockers;
10. stop at the required human gate before privileged mutations;
11. after merge/release, recompute affected workstreams/reservations and retire completed workspaces when safe;
12. consolidate durable learnings without storing full transcripts.

## Human authority gates

Unless a project explicitly grants stronger authority, require current explicit human authorization for:

- merge to protected/default branch;
- closing the owning issue as completed;
- production deploy;
- remote database migration/push/reset;
- destructive remote data mutation;
- external side effects whose consequences are difficult to reverse.

A prior authorization for a different mutation is not reusable by default.

Write authority is path-scoped. "May edit", "may commit", and "may push" are separate permissions; see `core/authority-model.md`.

## Executor trust model

Executor output is a claim, not proof.

Do not state that a test, workflow, runtime behavior, head SHA, mergeability state, or deployment was independently verified unless the orchestrator/QA role actually verified it.

A critical criterion cannot be marked PASS merely because a test file exists or a handoff says it passed.

Local build artifacts from another agent's workspace are not independent evidence.

## Parallel-agent policy

Before assigning or editing:

- inspect active workstreams;
- inspect changed files of overlapping PRs;
- check reservations;
- establish a separate worktree/clone boundary for each active role;
- stop on material overlap unless a safe ownership boundary is explicitly established.

Never let two active agents share one working tree. Implementer, auditor, and QA may share the canonical GitHub repository and immutable SHAs, but not uncommitted files, stashes, checked-out branches, generated artifacts, or a mutable work directory.

For independent audit:

`fresh origin/main workspace → freeze independent findings → inspect implementation head → cross-review`

Do not let the auditor begin by reading the implementer's working tree/branch when independence is part of the evidence model.

When a legitimate mission file is outside recorded reservations, apply the drift decision tree:

`mission-necessary + no conflicting owner → CONTROL_PLANE_DRIFT`, not automatic scope violation.

After any merge into the shared base:

- refresh remote refs;
- refresh base SHA;
- identify branches/worktrees now behind;
- rebase/stabilize only the affected workstreams;
- rerun applicable validation on their new heads;
- update affected state/reservations;
- create fresh workspaces for new workstreams instead of inheriting stale task directories by default.

## Workspace lifecycle

Use `core/workspace-model.md` as the canonical procedure.

Default posture:

```text
persistent memory
+
fresh remote fetch
+
isolated role worktree
+
exact base SHA
→ bounded mission
```

A dirty/diverged workspace is an observable condition, not something an agent should silently normalize away.

Existing per-agent clones are acceptable when they are independently refreshed and isolated; Git worktrees are preferred when one canonical clone can safely host multiple isolated checkouts.

## Visual gate

When product direction is visual and implementation cost is material:

`static mock → rendered evidence → human visual approval → production code`

Feedback such as “better” or “I prefer A” is not implementation authorization unless the human explicitly approves implementation. A human decision made outside the orchestrator session may be recorded as canonical once supplied to the control plane.

## Context budget

Prefer mission packets that fit in roughly 1–3k tokens before code excerpts. Expand only on demand.

The context compiler should include:

- current objective;
- resolved summaries of canonical decisions that are necessary to act;
- active constraints/gotchas;
- workspace bootstrap requirements;
- reservations and dependencies;
- acceptance criteria;
- forbidden mutations;
- exact next action and STOP condition;
- live-state fields that must be rechecked;
- measurable context telemetry when available.

It should exclude unrelated closed workstreams and narrative history.

## Core rule

**Persistent memory accelerates discovery; it never excuses verification.**

**Persistent context does not justify persistent workspace state.**
