---
name: project-onboarding
description: Run the first-use onboarding for a new or existing software project, recover existing persistent context, ask beginner-friendly high-leverage questions, recommend safe defaults, and produce the canonical specification before scaffolding.
---

# Project Onboarding

## Trigger

Use when `.maestro/project.spec.yaml` is missing, contains placeholders, or the user asks to start, initialize, scaffold, plan, rebuild, or migrate a project.

## Goal

Turn an idea or existing repository into an implementation-ready specification without forcing the user to make technical decisions they do not understand or repeat facts already stored in project memory.

## Before asking anything

1. Read `.maestro/memory/INDEX.md`, `PROJECT.md`, `STATE.md`, `DECISIONS.md`, and `LEARNINGS.md` when present.
2. Inspect the repository, dependencies, database, CI, and deployment evidence.
3. Mark memory conflicts or stale claims.
4. Skip every question already answered by verified files, memory, or the current conversation.

## Operating rules

- Ask in simple language and include a short example when useful.
- Ask at most four questions in the first batch.
- Ask follow-ups only when the answer changes scope, architecture, security, data, UX, cost, or deployment.
- Accept `decida por mim`, `use o padrão recomendado`, or equivalent as authorization to choose a safe default.
- Explain each consequential default in one sentence.
- Never scaffold production code before the specification is ready.
- Do not ask the user to choose libraries, folder structures, test runners, or infrastructure unless a genuine tradeoff requires their decision.

## First question batch

Ask only unanswered items:

1. What are we building, who will use it, and what problem does it solve?
2. What must the first useful version allow the user to complete?
3. What is explicitly out of scope for version one?
4. Are login, payments, personal data, existing systems, visual references, or a required publishing destination involved?

## Targeted follow-ups

Resolve only material gaps involving roles, permissions, critical data, integrations, sensitive information, commercial rules, devices, accessibility, deployment ownership, launch approval, and measurable success.

## Required outputs

Before scaffolding, create or update:

- `.maestro/reality-check.md`
- `.maestro/project.spec.yaml`
- `.maestro/acceptance.md`
- `.maestro/implementation-plan.md`
- `.maestro/risk-register.md`
- `.maestro/memory/PROJECT.md`
- `.maestro/memory/STATE.md`
- `.maestro/memory/DECISIONS.md`
- `.maestro/HANDOFF.md`

The specification must contain verified facts, explicit assumptions, decisions, open questions, non-goals, acceptance criteria, and a first vertical slice.

## Completion behavior

Present a concise summary of product, scope, stack, critical flows, data, UX, risks, first implementation slice, and unresolved decisions. If autonomous execution was already authorized, continue to scaffolding. Otherwise request approval of the specification.
