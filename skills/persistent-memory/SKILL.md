---
name: persistent-memory
description: Maintain durable, repository-backed project memory so any coding agent can resume work without depending on the previous LLM context window; optionally integrate semantic memory through MCP.
---

# Persistent Memory

## Trigger

Use at session start, after material decisions, before handoff, after validation, and whenever the current context may be incomplete.

## Start-of-session protocol

1. Read `.maestro/memory/INDEX.md`.
2. Load `PROJECT.md`, `STATE.md`, `DECISIONS.md`, and `LEARNINGS.md`.
3. Inspect the repository and verify whether `STATE.md` is still accurate.
4. Read only the newest relevant session summaries.
5. State any conflict between memory and verified reality.

Do not ask the user to repeat information already present in canonical memory unless it is contradictory or stale.

## During work

- Add consequential decisions to `DECISIONS.md` with date, status, context, choice, rationale, and consequences.
- Keep `STATE.md` current when phase, blockers, validation, or next action changes.
- Save only verified reusable lessons in `LEARNINGS.md`.
- Never store secrets or raw chat dumps.

## End-of-session protocol

Create a concise file under `.maestro/memory/sessions/` containing:

- objective;
- completed work;
- files or systems changed;
- decisions;
- validation evidence;
- risks and blockers;
- exact next action.

Then update `STATE.md` and `.maestro/HANDOFF.md`.

## Optional semantic memory

When an external memory service is connected:

- search it for related incidents, decisions, and prior sessions;
- verify retrieved memories against the repository;
- promote durable verified facts into repository memory;
- keep sensitive material out unless the user explicitly approved storage.
