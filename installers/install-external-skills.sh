#!/usr/bin/env bash
set -euo pipefail
PLATFORM="${1:-codex}"

if command -v npx >/dev/null; then
  npx --yes uipro-cli init --ai "$PLATFORM"
  npx --yes skills add https://github.com/Leonxlnx/taste-skill --skill design-taste-frontend
else
  echo "npx is required to install external skills" >&2
  exit 1
fi
