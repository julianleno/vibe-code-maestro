# Persistent Memory Protocol

Vibe Code Maestro must not depend on the current chat window as the only source of project context.

## Memory layers

### Layer 1 — Repository memory (mandatory)

The canonical memory lives under `.maestro/memory/` and is committed with the project when it contains no secrets.

Read in this order at the start of every session:

1. `.maestro/memory/INDEX.md`
2. `.maestro/memory/PROJECT.md`
3. `.maestro/memory/STATE.md`
4. `.maestro/memory/DECISIONS.md`
5. `.maestro/memory/LEARNINGS.md`
6. the newest relevant file under `.maestro/memory/sessions/`

Write a checkpoint before ending meaningful work or before handing execution to another agent.

### Layer 2 — External semantic memory (optional)

An MCP or local memory service such as `agentmemory` may index sessions and provide semantic retrieval. It supplements repository memory; it never replaces the canonical project files.

## What belongs in memory

- stable product facts and vocabulary;
- verified architecture and data contracts;
- decisions and their rationale;
- current implementation state;
- blockers, risks, and the next action;
- durable lessons discovered through tests, incidents, or debugging;
- links or identifiers required to resume work.

## What must not be stored

- secrets, tokens, private keys, passwords, or production credentials;
- full chat transcripts;
- unverified speculation presented as fact;
- large generated logs or build artifacts;
- personal or regulated data unless explicitly approved and protected.

## Conflict resolution

When sources disagree, use this precedence:

1. verified repository and runtime state;
2. approved specification and ADRs;
3. decision ledger;
4. current state file;
5. session summaries;
6. external semantic-memory results;
7. model recollection.

Record the conflict and resolution instead of silently choosing.

## Checkpoint contract

A checkpoint must update:

- `STATE.md`: current phase, completed work, blockers, next action, validation state;
- `DECISIONS.md`: only new consequential decisions;
- `LEARNINGS.md`: only verified reusable lessons;
- `sessions/<timestamp>.md`: concise session summary and evidence.

Keep memory compact. Archive old session summaries rather than injecting all history into every prompt.
