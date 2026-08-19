# Installing Vibe Code Maestro for AI agents

The installer has two explicit channels:

- `stable` installs the current V1 framework and remains the default.
- `next` installs the experimental Maestro Next framework from `v2/`.

Maestro Next is not production-ready yet. Independent Test C remains a separate release gate.

## Shell

```bash
./installers/bootstrap.sh codex .
./installers/bootstrap.sh codex . --channel stable
./installers/bootstrap.sh codex . --channel next
```

## PowerShell

```powershell
./installers/bootstrap.ps1 -Platform codex -Target .
./installers/bootstrap.ps1 -Platform codex -Target . -Channel stable
./installers/bootstrap.ps1 -Platform codex -Target . -Channel next
```

Supported platforms are `codex`, `claude`, `lovable`, `mimo`, `cursor`, `gemini`, and `all`.

## Installation layout

Both channels install their framework under `.maestro/framework/` and identify the channel in `.maestro/install.json`.

Stable retains the existing V1 project memory and onboarding layout. Next installs `v2/SKILL.md`, `v2/core/`, `v2/skills/`, and `v2/schemas/`. It creates an empty schema-derived control plane:

```text
.maestro/control-plane/
|-- state.json
|-- reservations.json
|-- workstreams/.gitkeep
|-- evidence/.gitkeep
`-- handoffs/.gitkeep
```

The example fixture under `v2/examples/` is never copied as project state.

## Existing repositories and reinstall

The installer does not touch application code. Existing `AGENTS.md`, `CLAUDE.md`, and `GEMINI.md` content is preserved outside the managed Maestro block.

Framework files are refreshed on reinstall. Project-owned V1 memory and Next control-plane state are not silently replaced. Invalid, missing, repeated, or unsupported channel arguments fail closed.

For Next, begin with `.maestro/START-HERE.md`. Its order follows `v2/SKILL.md`: workspace boundary, smallest state, live verification, reservations and dependencies, context packet, execution, audit, and gates.
