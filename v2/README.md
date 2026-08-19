# Maestro Next — control-plane lab

> Experimental V2. This directory does not replace Vibe Code Maestro v1 yet.

## Product thesis

**Persistent memory. Scoped agents. Verified delivery.**

Maestro Next is a local-first control plane for AI coding agents. It separates durable project memory from transient session context, compiles bounded mission packets per workstream, requires independent QA before acceptance, and keeps privileged mutations behind explicit human authority gates.

## Core loop

```text
human intent
→ orchestrator reality check
→ dependency + reservation check
→ bounded mission packet
→ executor
→ structured handoff
→ independent QA against live repo/CI
→ correction loop OR human approval gate
→ merge/release mutation
→ recompute dependent workstreams
→ memory consolidation
```

## V2.1 principles

1. **Live reality outranks stale memory for operational facts.** Repository, CI, runtime and authoritative external systems are freshness-sensitive truth.
2. **Control-plane state remains explicit.** Human decisions, authority, reservations and assignments are canonical orchestration state, not automatically "GitHub verified".
3. **Memory is compiled, not dumped.** Agents receive only the context relevant to their role and workstream.
4. **Important references are selectively resolved.** A designer receives actionable brand constraints, not only an opaque brand-memory ID.
5. **Observations are not canonical knowledge.** Session evidence is consolidated into decisions, procedures, gotchas and handoffs.
6. **Authority is path-scoped and mutation-scoped.** Edit, commit, push, merge, close, deploy and remote DB permissions are distinct.
7. **Executors do not certify themselves.** Handoffs are claims until independently checked.
8. **Critical QA requires direct evidence.** E0–E4 evidence levels prevent grep/test-file existence from masquerading as proof.
9. **Parallelism requires isolation.** Workstreams declare owned/reserved files and dependency edges.
10. **Reservation mismatches are classified.** Legitimate `CONTROL_PLANE_DRIFT` is distinct from scope violation and ownership conflict.
11. **Design ships through visual gates.** Mock approval precedes production implementation when visual direction is material.
12. **History is preserved through supersession.** Old decisions remain searchable but do not compete equally with canonical state.

## Truth classes

- `LIVE_VERIFIED` — freshly checked operational state.
- `CONTROL_PLANE_CANONICAL` — accepted orchestration state.
- `EXECUTOR_CLAIM` — handoff/PR narrative or un-replayed local evidence.
- `INFERENCE` — conclusion derived from evidence.

See `core/evidence-model.md`.

## Evidence levels

- `E0` claim only;
- `E1` static presence/grep;
- `E2` direct implementation/assertion inspection;
- `E3` direct inspection plus trustworthy exact-head execution;
- `E4` independent replay.

Critical acceptance criteria require at least E2; prefer E3 when a relevant automated test and exact-head CI exist.

## Lab layout

- `core/` — constitution, authority, memory, evidence and drift contracts.
- `schemas/` — machine-readable state/workstream/reservation/evidence/context contracts.
- `skills/` — role-specific small skills.
- `examples/singular/` — first real context-compilation fixture.

## Dogfood status

Two fresh-agent tests using the real Singular project have passed the core hypothesis:

- designer continuity restored from a small #309 packet without loading unrelated workstreams;
- independent QA reconstructed and reviewed the #262/#310 workstream from compact state plus live GitHub evidence.

Those tests exposed the V2.1 changes above: selective reference resolution, evidence levels, exact-head CI depth, truth classes and control-plane drift.

The next required experiment is **stale-memory resistance**: intentionally provide an outdated SHA/status and verify that a fresh agent detects the contradiction, prefers live operational state, and preserves unrelated canonical human decisions.

## Context efficiency

Default compiled packets target roughly 1–3k tokens before code excerpts. When possible, the compiler should report measurable file/byte/token telemetry. If savings cannot be measured, report `unknown` rather than inventing a percentage.

## Current maturity

This lab validates the control-plane contracts and cross-agent workflow. It does not yet provide a background daemon, automatic lifecycle hook capture, or semantic-vector service. Those are optional later layers; Git-versioned project state remains the intended durable source of truth.

Naming is intentionally provisional. `Maestro Next` is a codename until product naming is decided.
