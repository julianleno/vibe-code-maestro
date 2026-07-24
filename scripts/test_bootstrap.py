#!/usr/bin/env python3
from __future__ import annotations

from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
BOOTSTRAP = ROOT / "installers" / "bootstrap.sh"
VALIDATOR = ROOT / "scripts" / "validate_installation.py"
PLATFORMS = ["codex", "claude", "lovable", "mimo", "cursor", "gemini", "all"]


def run(*args: str) -> None:
    subprocess.run(args, cwd=ROOT, check=True, text=True)


def main() -> int:
    with tempfile.TemporaryDirectory(prefix="maestro-bootstrap-") as temp:
        base = Path(temp)
        for platform in PLATFORMS:
            target = base / platform
            target.mkdir()
            if platform in {"codex", "all"}:
                (target / "AGENTS.md").write_text("# Existing project instructions\n", encoding="utf-8")
            if platform in {"claude", "all"}:
                (target / "CLAUDE.md").write_text("# Existing Claude instructions\n", encoding="utf-8")

            run("bash", str(BOOTSTRAP), platform, str(target))
            state = target / ".maestro/memory/STATE.md"
            state.write_text("# Current Project State\n\n## Exact next action\n\nPreserve this custom state.\n", encoding="utf-8")
            run("bash", str(BOOTSTRAP), platform, str(target))
            run("python3", str(VALIDATOR), str(target), platform)

            assert "Preserve this custom state" in state.read_text(encoding="utf-8")
            assert (target / ".maestro/framework/core/memory-protocol.md").is_file()
            assert (target / ".maestro/framework/skills/persistent-memory/SKILL.md").is_file()

            if platform in {"codex", "all"}:
                agents = (target / "AGENTS.md").read_text(encoding="utf-8")
                assert "Existing project instructions" in agents
                assert agents.count("VIBE-CODE-MAESTRO:START") == 1
            if platform in {"claude", "all"}:
                claude = (target / "CLAUDE.md").read_text(encoding="utf-8")
                assert "Existing Claude instructions" in claude
                assert claude.count("VIBE-CODE-MAESTRO:START") == 1

    print("Bootstrap smoke tests passed for:", ", ".join(PLATFORMS))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
