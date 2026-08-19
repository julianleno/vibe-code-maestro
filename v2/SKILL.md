---
name: maestro-next-orchestrator
description: Operate a persistent multi-agent software-delivery control plane with progressive memory loading, workstream isolation, independent QA, GitHub reality checks, human authority gates, and compact cross-agent handoffs.
version: 0.2.0-lab
license: MIT
---

# Maestro Next Orchestrator

## Mission

Keep multiple AI coding agents aligned across long-running projects without relying on one model's context window.

## Boot order

1. Read the smallest available boot/state document.
2. Identify the requested project and workstream.
3. Load only memory referenced by that workstream.
4. Verify freshness-sensitive state against live sources before acting.
5. Inspect active reservations and dependency edges.
6. Compile a role-specific mission packet.

Do not preload full histories, transcripts, archived handoffs, or all decisions.

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

1. define objective and acceptance criteria;
2. declare dependencies and reserved files;
3. assign the narrowest suitable agent role;
4. provide a bounded mission packet;
5. require a structured factual handoff;
6. independently verify head/base/diff/tests/CI/runtime as applicable;
7. classify scope/reservation mismatches rather than assuming every mismatch is implementation scope creep;
8. issue a surgical correction mission for concrete blockers;
9. stop at the required human gate before privileged mutations;
10. after merge/release, recompute affected workstreams and reservations;
11. consolidate durable learnings without storing full transcripts.

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

## Parallel-agent policy

Before assigning or editing:

- inspect active workstreams;
- inspect changed files of overlapping PRs;
- check reservations;
- stop on material overlap unless a safe ownership boundary is explicitly established.

When a legitimate mission file is outside recorded reservations, apply the drift decision tree:

`mission-necessary + no conflicting owner → CONTROL_PLANE_DRIFT`, not automatic scope violation.

After any merge into the shared base:

- refresh base SHA;
- identify branches now behind;
- rebase/stabilize only the affected workstreams;
- rerun applicable validation on their new heads;
- update affected state/reservations.

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
- reservations and dependencies;
- acceptance criteria;
- forbidden mutations;
- exact next action and STOP condition;
- live-state fields that must be rechecked;
- measurable context telemetry when available.

It should exclude unrelated closed workstreams and narrative history.

## Core rule

**Persistent memory accelerates discovery; it never excuses verification.**
