#!/usr/bin/env bash
set -euo pipefail

PLATFORM="${1:-all}"
TARGET_INPUT="${2:-.}"
shift "$(( $# >= 2 ? 2 : $# ))"
CHANNEL="stable"
CHANNEL_SEEN=0
while [ "$#" -gt 0 ]; do
  case "$1" in
    --channel)
      [ "$#" -ge 2 ] || { echo "Missing value for --channel" >&2; exit 2; }
      [ "$CHANNEL_SEEN" -eq 0 ] || { echo "Channel may be specified only once" >&2; exit 2; }
      CHANNEL="$2"
      CHANNEL_SEEN=1
      shift 2
      ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
done

SUPPORTED="codex claude lovable mimo cursor gemini all"
case " $SUPPORTED " in *" $PLATFORM "*) ;; *) echo "Unsupported platform: $PLATFORM" >&2; exit 2 ;; esac
case "$CHANNEL" in stable|next) ;; *) echo "Unsupported channel: $CHANNEL (use stable or next)" >&2; exit 2 ;; esac

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
SOURCE_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"
mkdir -p "$TARGET_INPUT"
TARGET_ROOT="$(CDPATH= cd -- "$TARGET_INPUT" && pwd)"
MAESTRO_ROOT="$TARGET_ROOT/.maestro"
FRAMEWORK_ROOT="$MAESTRO_ROOT/framework"
MEMORY_ROOT="$MAESTRO_ROOT/memory"
TOOLS_ROOT="$MAESTRO_ROOT/tools"
CONTROL_ROOT="$MAESTRO_ROOT/control-plane"
mkdir -p "$MAESTRO_ROOT/tasks" "$MAESTRO_ROOT/reports" "$MAESTRO_ROOT/decisions" \
  "$MAESTRO_ROOT/prompts" "$TOOLS_ROOT" "$FRAMEWORK_ROOT"

copy_if_missing() {
  [ -e "$2" ] || { mkdir -p "$(dirname -- "$2")"; cp "$1" "$2"; }
}

install_stable_framework() {
  local item
  mkdir -p "$MEMORY_ROOT/sessions" "$MEMORY_ROOT/archive"
  for item in core agents skills pipelines playbooks standards checklists specs templates prompts adapters integrations tests docs; do
    rm -rf "$FRAMEWORK_ROOT/$item"
    cp -R "$SOURCE_ROOT/$item" "$FRAMEWORK_ROOT/$item"
  done
  cp "$SOURCE_ROOT/SKILL.md" "$FRAMEWORK_ROOT/SKILL.md"
  cp "$SOURCE_ROOT/LICENSE" "$FRAMEWORK_ROOT/LICENSE"
  copy_if_missing "$SOURCE_ROOT/specs/project.spec.example.yaml" "$MAESTRO_ROOT/project.spec.yaml"
  copy_if_missing "$SOURCE_ROOT/specs/acceptance.md" "$MAESTRO_ROOT/acceptance.md"
  copy_if_missing "$SOURCE_ROOT/templates/HANDOFF.md" "$MAESTRO_ROOT/HANDOFF.md"
  copy_if_missing "$SOURCE_ROOT/project.manifest.example.yaml" "$MAESTRO_ROOT/project.manifest.yaml"
  for item in reality-check.md implementation-plan.md risk-register.md; do
    [ -e "$MAESTRO_ROOT/$item" ] || printf '# %s\n\nPending first-run onboarding.\n' "${item%.md}" > "$MAESTRO_ROOT/$item"
  done
  for item in INDEX.md PROJECT.md STATE.md DECISIONS.md LEARNINGS.md; do
    copy_if_missing "$SOURCE_ROOT/templates/memory/$item" "$MEMORY_ROOT/$item"
  done
  copy_if_missing "$SOURCE_ROOT/templates/memory/SESSION-TEMPLATE.md" "$MEMORY_ROOT/SESSION-TEMPLATE.md"
  cp "$SOURCE_ROOT/scripts/memory_checkpoint.py" "$TOOLS_ROOT/memory_checkpoint.py"
  cp "$SOURCE_ROOT/scripts/compact_memory.py" "$TOOLS_ROOT/compact_memory.py"
  cp "$SOURCE_ROOT/installers/install-agentmemory.sh" "$TOOLS_ROOT/install-agentmemory.sh"
  chmod +x "$TOOLS_ROOT"/*.py "$TOOLS_ROOT"/*.sh 2>/dev/null || true
  touch "$MEMORY_ROOT/sessions/.gitkeep" "$MEMORY_ROOT/archive/.gitkeep"
  cat > "$MAESTRO_ROOT/START-HERE.md" <<'EOF'
# Start Here - Vibe Code Maestro Stable

## Mandatory boot sequence

1. Read `.maestro/memory/INDEX.md`, then `PROJECT.md`, `STATE.md`, `DECISIONS.md`, and `LEARNINGS.md`.
2. Verify memory against the repository and runtime; report conflicts.
3. Read `.maestro/framework/core/constitution.md`, `memory-protocol.md`, `manager-agent.md`, and `question-engine.md`.
4. Read `.maestro/framework/skills/project-onboarding/SKILL.md`.
5. Inspect the repository and complete specification and acceptance criteria before implementation.
6. Maintain risks, validation evidence, memory, and handoff.
EOF
}

install_next_framework() {
  local item
  for item in core skills schemas; do
    rm -rf "$FRAMEWORK_ROOT/$item"
    cp -R "$SOURCE_ROOT/v2/$item" "$FRAMEWORK_ROOT/$item"
  done
  cp "$SOURCE_ROOT/v2/SKILL.md" "$FRAMEWORK_ROOT/SKILL.md"
  mkdir -p "$CONTROL_ROOT/workstreams" "$CONTROL_ROOT/evidence" "$CONTROL_ROOT/handoffs"
  touch "$CONTROL_ROOT/workstreams/.gitkeep" "$CONTROL_ROOT/evidence/.gitkeep" "$CONTROL_ROOT/handoffs/.gitkeep"
  if [ ! -e "$CONTROL_ROOT/state.json" ]; then
    cat > "$CONTROL_ROOT/state.json" <<'EOF'
{
  "project": "",
  "repository": null,
  "default_branch": "main",
  "default_branch_sha": null,
  "freshness": {"verified_at": null, "requires_live_recheck": true},
  "priority_order": [],
  "active_workstreams": [],
  "next_human_decisions": [],
  "updated_at": ""
}
EOF
  fi
  if [ ! -e "$CONTROL_ROOT/reservations.json" ]; then
    printf '{\n  "reservations": [],\n  "updated_at": ""\n}\n' > "$CONTROL_ROOT/reservations.json"
  fi
  cat > "$MAESTRO_ROOT/START-HERE.md" <<'EOF'
# Start Here - Maestro Next (experimental)

This installation is for an existing repository. Do not reset project configuration or application code.

## Mandatory boot order

1. Establish the workspace boundary using `.maestro/framework/core/workspace-model.md`.
2. Read the smallest relevant state: `.maestro/control-plane/state.json` and the applicable workstream file.
3. Verify live repository and provider facts before trusting cached state.
4. Read `.maestro/control-plane/reservations.json`; resolve reservations and dependencies before editing.
5. Compile the minimum context packet using `.maestro/framework/core/context-compiler.md` and the schemas.
6. Execute within the boundary, retain audit evidence under `.maestro/control-plane/evidence/`, and run applicable gates.
7. Write handoffs under `.maestro/control-plane/handoffs/` when ownership changes.

Read `.maestro/framework/SKILL.md` for the complete operating contract. Maestro Next remains experimental.
EOF
}

rm -rf "$FRAMEWORK_ROOT"
mkdir -p "$FRAMEWORK_ROOT"
if [ "$CHANNEL" = "next" ]; then install_next_framework; else install_stable_framework; fi

cat > "$MAESTRO_ROOT/prompts/codex.md" <<'EOF'
Read AGENTS.md, `.maestro/START-HERE.md`, and the installed framework skill before acting. Inspect and verify the existing repository, preserve its instructions, and follow the selected Maestro channel contract.
EOF
cat > "$MAESTRO_ROOT/prompts/claude.md" <<'EOF'
Read CLAUDE.md, `.maestro/START-HERE.md`, and the installed framework skill before acting. Inspect and verify the existing repository, preserve its instructions, and follow the selected Maestro channel contract.
EOF
cat > "$MAESTRO_ROOT/prompts/cursor.md" <<'EOF'
Read `.maestro/START-HERE.md` and the installed framework skill. Verify live state before execution and preserve existing project configuration.
EOF
cat > "$MAESTRO_ROOT/prompts/gemini.md" <<'EOF'
Read GEMINI.md, `.maestro/START-HERE.md`, and the installed framework skill. Verify live state before execution and preserve existing project configuration.
EOF
cp "$SOURCE_ROOT/docs/lovable-master-prompt.md" "$MAESTRO_ROOT/prompts/lovable.md"
cp "$SOURCE_ROOT/docs/mimo-master-prompt.md" "$MAESTRO_ROOT/prompts/mimo.md"

replace_managed_block() {
  local file="$1" title="$2" body="$3" temp start='<!-- VIBE-CODE-MAESTRO:START -->' end='<!-- VIBE-CODE-MAESTRO:END -->'
  mkdir -p "$(dirname -- "$file")"; touch "$file"; temp="$(mktemp)"
  awk -v start="$start" -v end="$end" '$0 == start {skip=1; next} $0 == end {skip=0; next} !skip {print}' "$file" > "$temp"
  mv "$temp" "$file"
  printf '\n%s\n## %s\n\n%s\n%s\n' "$start" "$title" "$body" "$end" >> "$file"
}

install_portable_skill() {
  mkdir -p "$(dirname -- "$1")"
  cat > "$1" <<'EOF'
---
name: vibe-code-maestro
description: Operate the installed Vibe Code Maestro channel.
---

Read `.maestro/START-HERE.md`, then `.maestro/framework/SKILL.md`, and follow the installed channel contract.
EOF
}
install_codex() { replace_managed_block "$TARGET_ROOT/AGENTS.md" "Vibe Code Maestro" 'Read `.maestro/START-HERE.md` and `.maestro/framework/SKILL.md`; preserve existing project instructions and operate only within the verified workspace boundary.'; install_portable_skill "$TARGET_ROOT/.codex/skills/vibe-code-maestro/SKILL.md"; }
install_claude() { replace_managed_block "$TARGET_ROOT/CLAUDE.md" "Vibe Code Maestro" 'Read `.maestro/START-HERE.md` and `.maestro/framework/SKILL.md`; preserve existing project instructions and operate only within the verified workspace boundary.'; install_portable_skill "$TARGET_ROOT/.claude/skills/vibe-code-maestro/SKILL.md"; }
install_lovable() { mkdir -p "$TARGET_ROOT/docs"; cp "$SOURCE_ROOT/docs/lovable-master-prompt.md" "$TARGET_ROOT/docs/LOVABLE.md"; }
install_mimo() { mkdir -p "$TARGET_ROOT/docs"; cp "$SOURCE_ROOT/docs/mimo-master-prompt.md" "$TARGET_ROOT/docs/MIMO.md"; }
install_cursor() { mkdir -p "$TARGET_ROOT/.cursor/rules"; printf '%s\n' '---' 'description: Vibe Code Maestro operating rules' 'alwaysApply: true' '---' 'Read `.maestro/START-HERE.md` and `.maestro/framework/SKILL.md`; preserve existing project state.' > "$TARGET_ROOT/.cursor/rules/maestro.mdc"; }
install_gemini() { replace_managed_block "$TARGET_ROOT/GEMINI.md" "Vibe Code Maestro" 'Read `.maestro/START-HERE.md` and `.maestro/framework/SKILL.md`; preserve existing project instructions and operate only within the verified workspace boundary.'; install_portable_skill "$TARGET_ROOT/.gemini/skills/vibe-code-maestro/SKILL.md"; }
case "$PLATFORM" in
  codex) install_codex ;; claude) install_claude ;; lovable) install_lovable ;; mimo) install_mimo ;;
  cursor) install_cursor ;; gemini) install_gemini ;;
  all) install_codex; install_claude; install_lovable; install_mimo; install_cursor; install_gemini ;;
esac

command -v git >/dev/null 2>&1 && [ ! -d "$TARGET_ROOT/.git" ] && git -C "$TARGET_ROOT" init -q || true
INSTALLED_AT="$(date -u +'%Y-%m-%dT%H:%M:%SZ' 2>/dev/null || date)"
VERSION="1"
[ "$CHANNEL" = "next" ] && VERSION="0.2.1-lab"
cat > "$MAESTRO_ROOT/install.json" <<EOF
{
  "framework": "vibe-code-maestro",
  "version": "$VERSION",
  "channel": "$CHANNEL",
  "platform": "$PLATFORM",
  "installed_at": "$INSTALLED_AT",
  "framework_path": ".maestro/framework",
  "control_plane_path": ".maestro/control-plane",
  "start_file": ".maestro/START-HERE.md"
}
EOF

if command -v python3 >/dev/null 2>&1; then
  python3 "$SOURCE_ROOT/scripts/validate_installation.py" "$TARGET_ROOT" "$PLATFORM" "$CHANNEL"
else
  test -f "$FRAMEWORK_ROOT/SKILL.md"; test -f "$MAESTRO_ROOT/install.json"
fi
printf '\nVibe Code Maestro installed successfully.\nTarget: %s\nPlatform: %s\nChannel: %s\n' "$TARGET_ROOT" "$PLATFORM" "$CHANNEL"
