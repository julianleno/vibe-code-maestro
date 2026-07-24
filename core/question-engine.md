# Project Intake Question Engine

## First-run behavior

Before asking anything, inspect the repository and read existing project files. Never ask for information already known.

Use simple language. Do not force the user to choose frameworks, libraries, folder structures, test tools, hosting internals, or database details when a safe recommendation can be made.

The user may answer `decida por mim`, `use o padrão recomendado`, or equivalent. Treat that as permission to choose a safe default and explain the consequence in one sentence.

## First batch: maximum four questions

Ask only unanswered items:

1. What are we building, who will use it, and what problem does it solve?
2. What must the first useful version allow the user to complete?
3. What must stay out of version one?
4. Are login, payments, personal data, existing systems, visual references, or a required publishing destination involved?

Include short examples when a question could be ambiguous.

## Targeted follow-ups

Ask follow-ups only when the answer materially changes scope, architecture, security, data, cost, UX, or deployment:

- user roles and permissions;
- critical data and retention;
- integrations and source systems;
- regulated or sensitive information;
- payments and commercial rules;
- required devices and accessibility target;
- domain, environments, and deployment ownership;
- measurable success and launch approval;
- decision owner for unresolved tradeoffs.

## Required outputs before scaffolding

Create or update:

- `.maestro/reality-check.md`
- `.maestro/project.spec.yaml`
- `.maestro/acceptance.md`
- `.maestro/implementation-plan.md`
- `.maestro/risk-register.md`
- `.maestro/HANDOFF.md`

Separate verified facts, assumptions, decisions, and unresolved questions. Do not scaffold production code until the canonical specification is ready.
