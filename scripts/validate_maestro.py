#!/usr/bin/env python3
from pathlib import Path
import sys

root = Path(__file__).resolve().parents[1]
required = [
    "README.md", "AGENTS.md", "core/constitution.md", "core/manager-agent.md",
    "core/question-engine.md", "specs/project.spec.example.yaml",
    "skills/manager-orchestration/SKILL.md", "skills/spec-driven-development/SKILL.md",
    "skills/ui-ux-intelligence/SKILL.md", "skills/smoke-testing/SKILL.md",
    "skills/security-review/SKILL.md", "skills/pentest-safe/SKILL.md",
    "skills/ci-cd-delivery/SKILL.md", "installers/bootstrap.sh",
    "adapters/platform-map.yaml", "integrations/external-skills.md",
]
missing = [p for p in required if not (root / p).is_file()]
empty = [p for p in required if (root / p).is_file() and (root / p).stat().st_size == 0]
if missing or empty:
    print("Validation failed")
    if missing: print("Missing:", *missing, sep="\n- ")
    if empty: print("Empty:", *empty, sep="\n- ")
    sys.exit(1)
for skill in (root / "skills").glob("*/SKILL.md"):
    text = skill.read_text(encoding="utf-8")
    if not text.startswith("---\n") or "name:" not in text[:500] or "description:" not in text[:500]:
        print(f"Invalid skill frontmatter: {skill.relative_to(root)}")
        sys.exit(1)
print(f"Vibe Code Maestro validated: {len(list(root.rglob('*')))} paths")
