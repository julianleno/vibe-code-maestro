# Install Vibe Code Maestro — Agent Runbook

You are a coding agent. Install Vibe Code Maestro into the user's target repository, verify it, and report the result. Do not edit application code during installation.

## 1. Determine the target

Use the current repository unless the user explicitly named another folder. Detect the platform from the current agent:

- Codex → `codex`
- Claude Code → `claude`
- Lovable → `lovable`
- Mimo Build → `mimo`
- Cursor → `cursor`
- Gemini CLI → `gemini`

If uncertain and shell access exists, use `all`.

## 2. Install from a temporary clone

```bash
SOURCE_DIR="$(mktemp -d)/vibe-code-maestro"
git clone --depth 1 https://github.com/julianleno/vibe-code-maestro.git "$SOURCE_DIR"
bash "$SOURCE_DIR/installers/bootstrap.sh" <platform> .
```

On Windows PowerShell:

```powershell
$source = Join-Path $env:TEMP "vibe-code-maestro"
Remove-Item -Recurse -Force $source -ErrorAction SilentlyContinue
git clone --depth 1 https://github.com/julianleno/vibe-code-maestro.git $source
powershell -ExecutionPolicy Bypass -File "$source\installers\bootstrap.ps1" <platform> .
```

## 3. Verify

Confirm that these exist:

```text
.maestro/START-HERE.md
.maestro/project.spec.yaml
.maestro/memory/INDEX.md
.maestro/memory/PROJECT.md
.maestro/memory/STATE.md
.maestro/framework/core/constitution.md
.maestro/framework/core/memory-protocol.md
.maestro/framework/skills/project-onboarding/SKILL.md
.maestro/framework/skills/persistent-memory/SKILL.md
```

Also confirm the platform-specific file, such as `AGENTS.md`, `CLAUDE.md`, `docs/LOVABLE.md`, or `docs/MIMO.md`.

## 4. Start onboarding

Read `.maestro/START-HERE.md`, load repository memory, inspect the repository, and ask only unanswered beginner-friendly questions. Do not scaffold production code before the specification and acceptance criteria are ready.

## 5. Optional semantic memory

Do not install external services without explicit user approval. When approved and the platform is Codex, Claude, Cursor, or Gemini, run:

```bash
bash "$SOURCE_DIR/installers/install-agentmemory.sh" <platform>
```

Repository memory remains canonical.

## 6. Report

Report:

- target path;
- selected platform;
- validation result;
- files created or updated;
- whether existing instructions were preserved;
- exact next prompt the user should send.
