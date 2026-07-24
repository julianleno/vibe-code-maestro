#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path
import sys

PLATFORM_FILES = {
    "codex": ["AGENTS.md", ".codex/skills/vibe-code-maestro/SKILL.md", ".maestro/prompts/codex.md"],
    "claude": ["CLAUDE.md", ".claude/skills/vibe-code-maestro/SKILL.md", ".maestro/prompts/claude.md"],
    "lovable": ["docs/LOVABLE.md", ".maestro/prompts/lovable.md"],
    "mimo": ["docs/MIMO.md", ".maestro/prompts/mimo.md"],
    "cursor": [".cursor/rules/maestro.mdc", ".maestro/prompts/cursor.md"],
    "gemini": ["GEMINI.md", ".gemini/skills/vibe-code-maestro/SKILL.md", ".maestro/prompts/gemini.md"],
}

COMMON_FILES = [
    ".maestro/START-HERE.md",
    ".maestro/install.json",
    ".maestro/project.spec.yaml",
    ".maestro/acceptance.md",
    ".maestro/HANDOFF.md",
    ".maestro/memory/INDEX.md",
    ".maestro/memory/PROJECT.md",
    ".maestro/memory/STATE.md",
    ".maestro/memory/DECISIONS.md",
    ".maestro/memory/LEARNINGS.md",
    ".maestro/tools/memory_checkpoint.py",
    ".maestro/tools/compact_memory.py",
    ".maestro/tools/install-agentmemory.sh",
    ".maestro/framework/SKILL.md",
    ".maestro/framework/core/constitution.md",
    ".maestro/framework/core/memory-protocol.md",
    ".maestro/framework/core/manager-agent.md",
    ".maestro/framework/core/question-engine.md",
    ".maestro/framework/skills/project-onboarding/SKILL.md",
    ".maestro/framework/skills/persistent-memory/SKILL.md",
    ".maestro/framework/skills/ui-ux-intelligence/SKILL.md",
    ".maestro/framework/skills/security-review/SKILL.md",
    ".maestro/framework/skills/smoke-testing/SKILL.md",
    ".maestro/framework/skills/ci-cd-delivery/SKILL.md",
]


def main() -> int:
    parser = argparse.ArgumentParser(description="Validate a Vibe Code Maestro target installation")
    parser.add_argument("target", type=Path)
    parser.add_argument("platform", choices=[*PLATFORM_FILES, "all"])
    args = parser.parse_args()

    target = args.target.resolve()
    required = list(COMMON_FILES)
    if args.platform == "all":
        for files in PLATFORM_FILES.values():
            required.extend(files)
    else:
        required.extend(PLATFORM_FILES[args.platform])

    missing = [item for item in required if not (target / item).is_file()]
    empty = [item for item in required if (target / item).is_file() and (target / item).stat().st_size == 0]

    if missing or empty:
        print("Vibe Code Maestro installation validation failed", file=sys.stderr)
        for item in missing:
            print(f"- missing: {item}", file=sys.stderr)
        for item in empty:
            print(f"- empty: {item}", file=sys.stderr)
        return 1

    start = (target / ".maestro/START-HERE.md").read_text(encoding="utf-8")
    state = (target / ".maestro/memory/STATE.md").read_text(encoding="utf-8")
    if "persistent memory" not in start.lower() or "Exact next action" not in state:
        print("Memory onboarding contract is incomplete", file=sys.stderr)
        return 1

    print(f"Installation validated for {args.platform}: {target}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
