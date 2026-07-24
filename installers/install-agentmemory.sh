#!/usr/bin/env bash
set -euo pipefail

PLATFORM="${1:-codex}"
case "$PLATFORM" in
  codex) AGENT="codex" ;;
  claude) AGENT="claude-code" ;;
  cursor) AGENT="cursor" ;;
  gemini) AGENT="gemini-cli" ;;
  lovable|mimo)
    echo "agentmemory MCP wiring is not supported by this installer for $PLATFORM." >&2
    echo "Use the built-in .maestro/memory repository files instead." >&2
    exit 2
    ;;
  *)
    echo "Use one of: codex, claude, cursor, gemini" >&2
    exit 2
    ;;
esac

command -v node >/dev/null 2>&1 || { echo "Node.js 20+ is required." >&2; exit 1; }
command -v npm >/dev/null 2>&1 || { echo "npm is required." >&2; exit 1; }
MAJOR="$(node -p 'process.versions.node.split(".")[0]')"
[ "$MAJOR" -ge 20 ] || { echo "Node.js 20+ is required; found $(node -v)." >&2; exit 1; }

npm install -g @agentmemory/agentmemory

if command -v agentmemory >/dev/null 2>&1; then
  AM=(agentmemory)
else
  AM=(npx -y @agentmemory/agentmemory@latest)
fi

"${AM[@]}" --version
"${AM[@]}" connect "$AGENT"
npx -y skills add rohitg00/agentmemory -y

cat <<EOF

agentmemory was installed and connected to: $AGENT

Next:
1. Start the service in a dedicated terminal: agentmemory
2. Restart or reload MCP in your coding agent.
3. Keep .maestro/memory/ as the canonical project memory.

Diagnostics:
  agentmemory status
  agentmemory doctor
EOF
