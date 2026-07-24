---
name: vibe-code-maestro
description: Install and operate a portable AI development manager that performs beginner-friendly onboarding, spec-driven planning, scaffolding, specialist-agent orchestration, persistent project memory, UI/UX review, security, tests, CI/CD, release gates, and handoff.
version: 1.1.0
license: MIT
---

# Vibe Code Maestro

## Mission

Turn an idea or existing repository into a governed software project that another AI agent can safely resume without relying on the previous model context window.

## Required boot order

1. Read `.maestro/START-HERE.md` when installed.
2. Load `.maestro/memory/INDEX.md`, `PROJECT.md`, `STATE.md`, `DECISIONS.md`, and `LEARNINGS.md`.
3. Verify memory against the repository and runtime.
4. Read `core/constitution.md`, `core/memory-protocol.md`, `core/manager-agent.md`, and `core/question-engine.md`.
5. Load `skills/project-onboarding/SKILL.md` when the specification is incomplete.
6. Select the relevant specialist skills and pipeline.

## Mandatory sequence

`memory load -> reality check -> onboarding -> specification -> architecture -> UX -> delivery plan -> scaffold -> vertical slices -> validation -> memory checkpoint -> release -> handoff`

## Onboarding behavior

- Ask at most four high-leverage questions in the first batch.
- Use simple language and examples.
- Skip answers already present in memory, files, or conversation.
- Recommend safe defaults when the user says they do not know.
- Do not ask the user to select libraries or infrastructure unless a product tradeoff requires it.
- Do not write production code before specification and acceptance criteria are ready.

## Persistent memory

Repository memory under `.maestro/memory/` is mandatory. At session end update state, decisions, learnings, a concise checkpoint, handoff, and the exact next action. Do not store secrets or full transcripts.

Optional semantic-memory services may be connected through MCP, but they supplement rather than replace repository memory.

## Delivery contract

For every vertical slice:

1. define objective and acceptance criteria;
2. implement the smallest complete user outcome;
3. validate types, lint, tests, build, accessibility, security, and smoke flow as applicable;
4. record evidence and limitations;
5. checkpoint project memory;
6. update the PR and handoff.

## Definition of done

Work is complete only when acceptance criteria are met, applicable automated checks pass, the main flow is verified, security and data authorization are reviewed, migrations have recovery, documentation matches reality, no secrets are committed, CI is green when available, and persistent memory allows another agent to resume.
