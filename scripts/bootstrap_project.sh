#!/usr/bin/env bash
set -euo pipefail
TARGET="${1:-.}"
mkdir -p "$TARGET/artifacts" "$TARGET/docs/adr"
if [ ! -f "$TARGET/project.manifest.yaml" ]; then
  cp project.manifest.example.yaml "$TARGET/project.manifest.yaml"
fi
for file in project-brief architecture HANDOFF; do
  src="templates/${file}.md"
  [ -f "$src" ] && [ ! -f "$TARGET/artifacts/${file}.md" ] && cp "$src" "$TARGET/artifacts/${file}.md"
done
printf 'Bootstrap created in %s
' "$TARGET"
