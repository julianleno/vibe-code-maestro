# Maestro Next — control-plane lab

> Experimental V2. This directory does not replace Vibe Code Maestro v1 yet.

## Product thesis

Persistent memory. Scoped agents. Verified delivery.

Maestro Next is a local-first control plane for AI coding agents. It separates durable project memory from transient session context, compiles bounded mission packets per workstream, requires independent QA before acceptance, and keeps destructive or production mutations behind explicit human authority gates.

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

## V2 principles

1. **Live reality outranks memory.** Repository, CI, runtime and authoritative external systems are operational truth.
2. **Memory is compiled, not dumped.** Agents receive only the context relevant to their role and workstream.
3. **Observations are not canonical knowledge.** Session evidence is consolidated into decisions, procedures, gotchas and handoffs.
4. **Authority is explicit.** Merge, issue close, production deploy and remote DB mutations require declared authority.
5. **Executors do not certify themselves.** Handoffs are claims until independently checked.
6. **Parallelism requires isolation.** Workstreams declare owned/reserved files and dependency edges.
7. **Design ships through visual gates.** Mock approval precedes production implementation when visual direction is material.
8. **History is preserved through supersession.** Old decisions remain searchable but do not compete equally with canonical state.

## Lab layout

- `core/` — constitution and operational contracts.
- `schemas/` — machine-readable state/workstream/reservation contracts.
- `skills/` — role-specific small skills.
- `examples/singular/` — first real context-compilation fixture.

## First experiment

The acceptance test for this lab is simple:

> A fresh agent with no prior chat history should load the Singular fixture, verify current GitHub state, identify active workstreams and generate a useful mission packet without reading the project's full historical narrative.

Naming is intentionally provisional. `Maestro Next` is a codename until product naming is decided.
