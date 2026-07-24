# Vibe Code Maestro

**A portable AI Development Operating System for Codex, Claude Code, Lovable, Cursor, Gemini, and other coding agents.**

Vibe Code Maestro turns an idea into a governed software project: it asks the right questions, writes an executable specification, chooses a stack, scaffolds the repository, delegates work to specialist agents, validates quality, and drives CI/CD through release and handoff.

## What this repository solves

AI coding often fails because it starts coding before resolving product scope, architecture, UX, security, testing, and deployment decisions. Maestro makes those decisions explicit and enforces a sequence:

```text
idea
  -> intake
  -> reality check
  -> product specification
  -> architecture and threat model
  -> UI/UX direction
  -> delivery slices
  -> scaffold
  -> implementation by specialist agents
  -> automated and manual validation
  -> preview
  -> release decision
  -> production and handoff
```

## Core capabilities

- Manager agent that coordinates bounded specialist agents
- Spec-driven development and acceptance contracts
- Stack-aware project bootstrap
- UI/UX intelligence and anti-generic design review
- Accessibility auditing
- Unit, integration, smoke, and visual validation contracts
- Secure design review and authorized non-destructive pentesting
- CI/CD gates, preview environments, rollback, and release readiness
- Codex, Claude, Lovable, Cursor, and Gemini adapter guidance
- Optional integration with UI/UX Pro Max and Taste Skill through official installers

## Start a new project

```bash
git clone https://github.com/julianleno/Vibe-Code-Maestro.git
cd Vibe-Code-Maestro
./installers/bootstrap.sh codex ../my-project
```

Then give the target agent this instruction:

```text
Read AGENTS.md, core/constitution.md, core/manager-agent.md and core/question-engine.md.
Initialize the Maestro workflow for this repository. Inspect reality first, ask only unanswered high-leverage questions, create the canonical project specification, and do not scaffold until the specification is ready.
```

## Platform entry points

| Platform | Entry point |
|---|---|
| Codex | `AGENTS.md` + `.codex/skills/` adapter |
| Claude Code | `CLAUDE.md` + `.claude/skills/` adapter |
| Lovable | `docs/lovable-master-prompt.md` + canonical spec |
| Cursor | `.cursor/rules/maestro.mdc` adapter |
| Gemini | `GEMINI.md` adapter |

Run `./installers/bootstrap.sh all <target>` to prepare multiple coding-agent directories.

## Optional design intelligence

Install upstream integrations rather than silently vendoring them:

```bash
./installers/install-external-skills.sh codex
```

This invokes the official UI/UX Pro Max installer and the public Taste Skill installer. Review `integrations/external-skills.md` for licensing, pinning, and update policy.

## Repository map

```text
core/          Constitution, manager contract, intake engine
agents/        Specialist agent contracts
skills/        Portable capabilities
specs/         Canonical specification templates
pipelines/     Phase and gate definitions
presets/       Product-type defaults
playbooks/     Delivery playbooks
standards/     Engineering and product standards
checklists/    Operational gates
adapters/      Platform mapping
installers/    Bootstrap and optional integration scripts
integrations/  External-skill policy and attribution
scripts/       Framework validators
tests/         Smoke, security, and UI/UX test contracts
.github/       CI and collaboration templates
```

## Non-negotiable release gates

A release cannot be marked ready when the specification is stale, authorization tests fail, critical accessibility or security issues remain, the production build is unverified, migrations lack a rollback strategy, or smoke tests fail in preview.

## Validate the framework

```bash
python scripts/validate_maestro.py
```

GitHub Actions runs the same structural validation and an initial secret-pattern check on every pull request.

## External references

This project is an original orchestration framework. It integrates, but does not claim authorship of:

- UI/UX Pro Max by NextLevelBuilder
- Taste Skill by Leonxlnx

Retain upstream notices when installing, copying, or modifying third-party materials. See `integrations/external-skills.md`.

## Status

Foundation release. The repository supplies contracts, skills, pipelines, adapters, installers, and CI. Application-specific generators and stack presets should evolve through versioned releases and compatibility tests.
