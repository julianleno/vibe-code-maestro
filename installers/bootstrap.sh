#!/usr/bin/env bash
set -euo pipefail

PLATFORM="${1:-all}"
TARGET_INPUT="${2:-.}"
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
SOURCE_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"

SUPPORTED="codex claude lovable mimo cursor gemini all"
case " $SUPPORTED " in
  *" $PLATFORM "*) ;;
  *)
    echo "Unsupported platform: $PLATFORM" >&2
    echo "Use one of: $SUPPORTED" >&2
    exit 2
    ;;
esac

mkdir -p "$TARGET_INPUT"
TARGET_ROOT="$(CDPATH= cd -- "$TARGET_INPUT" && pwd)"
MAESTRO_ROOT="$TARGET_ROOT/.maestro"
FRAMEWORK_ROOT="$MAESTRO_ROOT/framework"
MEMORY_ROOT="$MAESTRO_ROOT/memory"
TOOLS_ROOT="$MAESTRO_ROOT/tools"

mkdir -p \
  "$MAESTRO_ROOT/tasks" \
  "$MAESTRO_ROOT/reports" \
  "$MAESTRO_ROOT/decisions" \
  "$MAESTRO_ROOT/prompts" \
  "$MEMORY_ROOT/sessions" \
  "$MEMORY_ROOT/archive" \
  "$TOOLS_ROOT" \
  "$FRAMEWORK_ROOT"

# Re-running refreshes the framework but preserves project-specific specs and memory.
FRAMEWORK_ITEMS=(
  core agents skills pipelines playbooks standards checklists specs templates
  prompts adapters integrations tests docs
)
for item in "${FRAMEWORK_ITEMS[@]}"; do
  rm -rf "$FRAMEWORK_ROOT/$item"
  cp -R "$SOURCE_ROOT/$item" "$FRAMEWORK_ROOT/$item"
done
cp "$SOURCE_ROOT/SKILL.md" "$FRAMEWORK_ROOT/SKILL.md"
cp "$SOURCE_ROOT/LICENSE" "$FRAMEWORK_ROOT/LICENSE"

copy_if_missing() {
  local source="$1"
  local destination="$2"
  if [ ! -e "$destination" ]; then
    mkdir -p "$(dirname -- "$destination")"
    cp "$source" "$destination"
  fi
}

copy_if_missing "$SOURCE_ROOT/specs/project.spec.example.yaml" "$MAESTRO_ROOT/project.spec.yaml"
copy_if_missing "$SOURCE_ROOT/specs/acceptance.md" "$MAESTRO_ROOT/acceptance.md"
copy_if_missing "$SOURCE_ROOT/templates/HANDOFF.md" "$MAESTRO_ROOT/HANDOFF.md"
copy_if_missing "$SOURCE_ROOT/project.manifest.example.yaml" "$MAESTRO_ROOT/project.manifest.yaml"

for file in reality-check.md implementation-plan.md risk-register.md; do
  if [ ! -e "$MAESTRO_ROOT/$file" ]; then
    printf '# %s\n\nPending first-run onboarding.\n' "${file%.md}" > "$MAESTRO_ROOT/$file"
  fi
done

for file in INDEX.md PROJECT.md STATE.md DECISIONS.md LEARNINGS.md; do
  copy_if_missing "$SOURCE_ROOT/templates/memory/$file" "$MEMORY_ROOT/$file"
done
copy_if_missing "$SOURCE_ROOT/templates/memory/SESSION-TEMPLATE.md" "$MEMORY_ROOT/SESSION-TEMPLATE.md"

cp "$SOURCE_ROOT/scripts/memory_checkpoint.py" "$TOOLS_ROOT/memory_checkpoint.py"
cp "$SOURCE_ROOT/scripts/compact_memory.py" "$TOOLS_ROOT/compact_memory.py"
cp "$SOURCE_ROOT/installers/install-agentmemory.sh" "$TOOLS_ROOT/install-agentmemory.sh"
chmod +x "$TOOLS_ROOT"/*.py "$TOOLS_ROOT"/*.sh 2>/dev/null || true

touch "$MEMORY_ROOT/sessions/.gitkeep" "$MEMORY_ROOT/archive/.gitkeep"

cat > "$MAESTRO_ROOT/START-HERE.md" <<'EOF_START'
# Start Here — Vibe Code Maestro

You do not need to understand every file. The AI manager must follow this order.

## Mandatory boot sequence

1. Read `.maestro/memory/INDEX.md`.
2. Read `.maestro/memory/PROJECT.md`, `STATE.md`, `DECISIONS.md`, and `LEARNINGS.md`.
3. Verify that memory still matches the repository and runtime. Report conflicts.
4. Read `.maestro/framework/core/constitution.md`.
5. Read `.maestro/framework/core/memory-protocol.md`.
6. Read `.maestro/framework/core/manager-agent.md` and `question-engine.md`.
7. Read `.maestro/framework/skills/project-onboarding/SKILL.md`.
8. Inspect the repository before proposing a stack or writing code.
9. Ask only unanswered, high-leverage questions using simple language.
10. Update the specification, acceptance criteria, plan, risks, memory, and handoff before scaffolding.

## First message to paste

Replace the last line with your idea:

```text
Initialize Vibe Code Maestro in this repository.
Read .maestro/START-HERE.md and load persistent memory before acting.
Inspect the repository first. Do not write production code yet.
Ask only the questions that are still necessary, using simple language and examples.
Do not ask me to repeat information already stored in .maestro/memory/.
When safe, recommend defaults instead of asking me technical questions I may not know.
Create the canonical specification and acceptance criteria before scaffolding.
After the specification is ready, show me a concise summary. If I already authorized autonomous execution, continue with the scaffold and first vertical slice; otherwise ask for approval.
Before ending, update project memory and leave the exact next action.

Project idea: DESCRIBE YOUR IDEA HERE.
```

## Approval phrase

After reviewing the specification:

```text
Specification approved. Scaffold the project and implement the first complete vertical slice. Run the applicable tests, update persistent memory, and show evidence before marking it done.
```

## Resume phrase for a new chat

```text
Resume this project using Vibe Code Maestro. Read .maestro/START-HERE.md and all canonical memory files. Verify the current repository state, explain where the previous agent stopped, then execute the exact next action unless a blocker or contradiction requires my decision.
```
EOF_START

cat > "$MAESTRO_ROOT/prompts/codex.md" <<'EOF_CODEX'
Initialize Vibe Code Maestro in this repository. Read AGENTS.md and `.maestro/START-HERE.md`. Load persistent memory before acting, inspect reality first, run beginner-friendly onboarding, create the canonical specification and acceptance criteria, and do not write production code before the specification is ready. Before ending, checkpoint memory and leave the exact next action. My project idea is: REPLACE THIS TEXT.
EOF_CODEX

cat > "$MAESTRO_ROOT/prompts/claude.md" <<'EOF_CLAUDE'
Initialize Vibe Code Maestro in this repository. Read CLAUDE.md and `.maestro/START-HERE.md`. Load persistent memory, act as the manager of specialist agents, inspect the repository, ask only unanswered high-leverage questions in simple language, create the canonical specification, and do not implement before it is ready. Before ending, checkpoint memory and leave the exact next action. My project idea is: REPLACE THIS TEXT.
EOF_CLAUDE

cat > "$MAESTRO_ROOT/prompts/cursor.md" <<'EOF_CURSOR_PROMPT'
Initialize Vibe Code Maestro in this repository. Read `.maestro/START-HERE.md`, load persistent memory, inspect the repository, complete beginner-friendly onboarding and specification before implementation, then work in vertical slices with validation evidence and memory checkpoints. My project idea is: REPLACE THIS TEXT.
EOF_CURSOR_PROMPT

cat > "$MAESTRO_ROOT/prompts/gemini.md" <<'EOF_GEMINI_PROMPT'
Initialize Vibe Code Maestro in this repository. Read GEMINI.md and `.maestro/START-HERE.md`, load persistent memory, inspect reality, ask only unanswered questions, create the specification before implementation, and checkpoint memory with the exact next action. My project idea is: REPLACE THIS TEXT.
EOF_GEMINI_PROMPT

cp "$SOURCE_ROOT/docs/lovable-master-prompt.md" "$MAESTRO_ROOT/prompts/lovable.md"
cp "$SOURCE_ROOT/docs/mimo-master-prompt.md" "$MAESTRO_ROOT/prompts/mimo.md"

replace_managed_block() {
  local file="$1"
  local title="$2"
  local body="$3"
  local start_marker='<!-- VIBE-CODE-MAESTRO:START -->'
  local end_marker='<!-- VIBE-CODE-MAESTRO:END -->'
  local temp

  mkdir -p "$(dirname -- "$file")"
  touch "$file"
  temp="$(mktemp)"
  awk -v start="$start_marker" -v end="$end_marker" '
    $0 == start { skipping=1; next }
    $0 == end { skipping=0; next }
    !skipping { print }
  ' "$file" > "$temp"
  mv "$temp" "$file"
  {
    printf '\n%s\n' "$start_marker"
    printf '## %s\n\n' "$title"
    printf '%s\n' "$body"
    printf '%s\n' "$end_marker"
  } >> "$file"
}

install_portable_skill() {
  local destination="$1"
  mkdir -p "$(dirname -- "$destination")"
  cat > "$destination" <<'EOF_SKILL'
---
name: vibe-code-maestro
description: Initialize and manage a spec-driven software project with beginner-friendly onboarding, persistent memory, specialist-agent delegation, UI/UX, security, tests, CI/CD, release gates, and handoff.
---

Read `.maestro/START-HERE.md`, load `.maestro/memory/`, then use `.maestro/framework/` as the operating source of truth. Do not write production code before the specification and acceptance criteria are ready. Before ending meaningful work, update memory, handoff, and the exact next action.
EOF_SKILL
}

install_codex() {
  replace_managed_block "$TARGET_ROOT/AGENTS.md" "Vibe Code Maestro" \
    'Read `.maestro/START-HERE.md`. Load `.maestro/memory/` before acting, use `.maestro/framework/` as the source of truth, inspect the repository, and complete onboarding before production code. Maintain specification, acceptance criteria, risks, validation evidence, memory, and handoff.'
  install_portable_skill "$TARGET_ROOT/.codex/skills/vibe-code-maestro/SKILL.md"
}

install_claude() {
  replace_managed_block "$TARGET_ROOT/CLAUDE.md" "Vibe Code Maestro" \
    'Read `.maestro/START-HERE.md`, load `.maestro/memory/`, and act as the manager of specialist agents. Ask only unanswered questions, create the specification before implementation, work in vertical slices, require validation evidence, and checkpoint memory.'
  install_portable_skill "$TARGET_ROOT/.claude/skills/vibe-code-maestro/SKILL.md"
}

install_lovable() {
  mkdir -p "$TARGET_ROOT/docs"
  cp "$SOURCE_ROOT/docs/lovable-master-prompt.md" "$TARGET_ROOT/docs/LOVABLE.md"
}

install_mimo() {
  mkdir -p "$TARGET_ROOT/docs"
  cp "$SOURCE_ROOT/docs/mimo-master-prompt.md" "$TARGET_ROOT/docs/MIMO.md"
}

install_cursor() {
  mkdir -p "$TARGET_ROOT/.cursor/rules"
  cat > "$TARGET_ROOT/.cursor/rules/maestro.mdc" <<'EOF_CURSOR'
---
description: Vibe Code Maestro orchestration, persistent memory, and spec-driven development rules
alwaysApply: true
---
Read `.maestro/START-HERE.md`, load `.maestro/memory/`, and use `.maestro/framework/` as the operating source of truth. Complete onboarding and specification before implementation. Work in bounded vertical slices, report validation evidence, and checkpoint memory before ending.
EOF_CURSOR
}

install_gemini() {
  replace_managed_block "$TARGET_ROOT/GEMINI.md" "Vibe Code Maestro" \
    'Read `.maestro/START-HERE.md`, load `.maestro/memory/`, and use `.maestro/framework/` as the source of truth. Complete onboarding and specification before implementation. Work in bounded vertical slices, report validation evidence, and checkpoint memory.'
  install_portable_skill "$TARGET_ROOT/.gemini/skills/vibe-code-maestro/SKILL.md"
}

case "$PLATFORM" in
  codex) install_codex ;;
  claude) install_claude ;;
  lovable) install_lovable ;;
  mimo) install_mimo ;;
  cursor) install_cursor ;;
  gemini) install_gemini ;;
  all)
    install_codex
    install_claude
    install_lovable
    install_mimo
    install_cursor
    install_gemini
    ;;
esac

if command -v git >/dev/null 2>&1 && [ ! -d "$TARGET_ROOT/.git" ]; then
  git -C "$TARGET_ROOT" init -q || true
fi

INSTALLED_AT="$(date -u +'%Y-%m-%dT%H:%M:%SZ' 2>/dev/null || date)"
cat > "$MAESTRO_ROOT/install.json" <<EOF_JSON
{
  "framework": "vibe-code-maestro",
  "platform": "$PLATFORM",
  "installed_at": "$INSTALLED_AT",
  "framework_path": ".maestro/framework",
  "start_file": ".maestro/START-HERE.md",
  "memory": {
    "mode": "repository",
    "path": ".maestro/memory",
    "optional_semantic_provider": "agentmemory"
  }
}
EOF_JSON

if command -v python3 >/dev/null 2>&1; then
  python3 "$SOURCE_ROOT/scripts/validate_installation.py" "$TARGET_ROOT" "$PLATFORM"
else
  test -f "$MAESTRO_ROOT/START-HERE.md"
  test -f "$FRAMEWORK_ROOT/core/constitution.md"
  test -f "$FRAMEWORK_ROOT/core/memory-protocol.md"
  test -f "$MAESTRO_ROOT/project.spec.yaml"
  test -f "$MEMORY_ROOT/STATE.md"
  echo "Python 3 not found; completed basic file validation only."
fi

PROMPT_PLATFORM="$PLATFORM"
[ "$PLATFORM" = "all" ] && PROMPT_PLATFORM="codex"

cat <<EOF_DONE

Vibe Code Maestro installed successfully.

Target: $TARGET_ROOT
Platform: $PLATFORM
Persistent memory: $MEMORY_ROOT

Next:
1. Open the TARGET folder in your AI tool, not the Maestro source folder.
2. Read .maestro/START-HERE.md.
3. Paste .maestro/prompts/$PROMPT_PLATFORM.md and replace the project idea.

Lovable prompt: docs/LOVABLE.md
Mimo prompt: docs/MIMO.md
Optional semantic memory: .maestro/tools/install-agentmemory.sh
EOF_DONE
