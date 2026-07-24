---
name: llm-handoff
description: Produce verified persistent context, memory checkpoints, and an operational handoff so another LLM can resume without the previous conversation window.
version: 1.1.0
---

# LLM Handoff

## Inputs

- `.maestro/memory/`;
- canonical specification and acceptance criteria;
- verified repository, database, CI, and deployment state;
- decisions, risks, and validation evidence.

## Process

1. Read and verify persistent memory against reality.
2. Separate verified facts, assumptions, decisions, and open questions.
3. Update `STATE.md`, new decision entries, and verified learnings.
4. Create a concise session checkpoint.
5. Update `.maestro/HANDOFF.md` with the exact next action.
6. Avoid secrets and full transcripts.

## Definition of done

- a new agent can resume without the prior chat window;
- current state and next action are explicit;
- validation evidence and blockers are recorded;
- conflicts are visible rather than silently resolved;
- memory remains compact and reviewable.
