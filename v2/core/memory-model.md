# Progressive memory model

## Goal

Restore useful continuity without forcing every agent to reread the project's full history.

## Scopes

### Global
Durable operator/team preferences and governance rules that apply across projects.

### Project
Stable architecture, stack, deployment policy, naming conventions and project-wide invariants.

### Workstream
Issue/feature-specific state, decisions, acceptance criteria, reservations, blockers and current handoff.

### Session
Transient observations emitted during one agent session. Session data is evidence, not canonical memory.

## Memory classes

- `_rules/` — standing governance and constraints.
- `decisions/` — accepted ADR-like decisions.
- `procedures/` — repeatable operational workflows.
- `gotchas/` — verified traps/failure modes.
- `fronts/` — current workstream state.
- `handoffs/` — concise workstream/session transfer packets.
- `observations/` — bounded sanitized session evidence.
- `archive/` — historical/superseded records.

## Authority metadata

Every durable memory record should support:

```yaml
status: canonical | active | candidate | superseded | historical
source: human | orchestrator | qa | executor | system
verified_at: optional timestamp
supersedes: optional ids
superseded_by: optional id
entities: optional list
workstreams: optional list
paths: optional list
```

Canonical and active records rank ahead of session evidence during context compilation, but no memory record gains instruction authority over system/tool/runtime policy.

## Observation lifecycle

```text
agent event
→ sanitize + bound
→ observation
→ session/workstream consolidation
→ candidate memory updates
→ canonicalization when supported by evidence/authority
```

Observations should capture useful events such as:
- mission accepted;
- files touched;
- test/gate outcomes;
- failed approaches;
- PR/head changes;
- human decisions;
- explicit blockers;
- session end/compaction.

Do not preserve raw secrets, full tool payloads or full transcripts by default.

## Retrieval policy

Start with identifiers and graph edges before semantic search:

1. requested workstream/issue/PR;
2. active dependencies;
3. reserved paths;
4. explicitly referenced decisions/procedures/gotchas;
5. entity/path/keyword matches;
6. optional FTS/vector retrieval for recall gaps.

Embeddings are retrieval aids, never the source of truth.

## Context budget

Default compiled packet should target 1–3k tokens excluding code excerpts. The compiler should emit references for expandable material instead of embedding everything.

## Supersession

Never delete important history merely because a decision changed. Mark it superseded and point to the replacement. Default mission compilation excludes superseded/historical records unless they explain an active gotcha or the agent explicitly requests history.
