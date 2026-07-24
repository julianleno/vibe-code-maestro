#!/usr/bin/env bash
set -euo pipefail

PLATFORM="${1:-codex}"
ROOT="${2:-.}"

command -v git >/dev/null || { echo "git is required" >&2; exit 1; }
command -v node >/dev/null || { echo "Node.js is required" >&2; exit 1; }

mkdir -p "$ROOT/.maestro/tasks" "$ROOT/.maestro/reports"
cp -n specs/project.spec.example.yaml "$ROOT/.maestro/project.spec.yaml" 2>/dev/null || true
cp -n specs/acceptance.md "$ROOT/.maestro/acceptance.md" 2>/dev/null || true

case "$PLATFORM" in
  codex) mkdir -p "$ROOT/.codex/skills" ;;
  claude) mkdir -p "$ROOT/.claude/skills" ;;
  lovable) mkdir -p "$ROOT/docs"; cp -n docs/lovable-master-prompt.md "$ROOT/docs/LOVABLE.md" 2>/dev/null || true ;;
  cursor) mkdir -p "$ROOT/.cursor/rules" ;;
  all) mkdir -p "$ROOT/.codex/skills" "$ROOT/.claude/skills" "$ROOT/.cursor/rules" ;;
  *) echo "Unsupported platform: $PLATFORM" >&2; exit 2 ;;
esac

echo "Maestro bootstrap initialized for $PLATFORM in $ROOT"
echo "Next: complete .maestro/project.spec.yaml, then run validation."
