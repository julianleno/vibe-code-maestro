#!/usr/bin/env python3
import json
import sys
from pathlib import Path

PLATFORM_FILES = {
    "codex": ["AGENTS.md", ".codex/skills/vibe-code-maestro/SKILL.md"],
    "claude": ["CLAUDE.md", ".claude/skills/vibe-code-maestro/SKILL.md"],
    "lovable": ["docs/LOVABLE.md"],
    "mimo": ["docs/MIMO.md"],
    "cursor": [".cursor/rules/maestro.mdc"],
    "gemini": ["GEMINI.md", ".gemini/skills/vibe-code-maestro/SKILL.md"],
}
STABLE_FILES = [
    ".maestro/framework/SKILL.md",
    ".maestro/framework/core/constitution.md",
    ".maestro/framework/core/memory-protocol.md",
    ".maestro/framework/core/manager-agent.md",
    ".maestro/framework/core/question-engine.md",
    ".maestro/framework/skills/project-onboarding/SKILL.md",
    ".maestro/framework/skills/persistent-memory/SKILL.md",
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
]
NEXT_FILES = [
    ".maestro/framework/SKILL.md",
    ".maestro/framework/core/workspace-model.md",
    ".maestro/framework/skills",
    ".maestro/framework/schemas/state.schema.json",
    ".maestro/framework/schemas/workstream.schema.json",
    ".maestro/framework/schemas/reservations.schema.json",
    ".maestro/framework/schemas/evidence.schema.json",
    ".maestro/framework/schemas/context-packet.schema.json",
    ".maestro/control-plane/state.json",
    ".maestro/control-plane/reservations.json",
    ".maestro/control-plane/workstreams/.gitkeep",
    ".maestro/control-plane/evidence/.gitkeep",
    ".maestro/control-plane/handoffs/.gitkeep",
]

def fail(message: str) -> None:
    print(f"ERROR: {message}", file=sys.stderr)
    raise SystemExit(1)

def main() -> None:
    if len(sys.argv) not in (3, 4):
        fail("usage: validate_installation.py TARGET PLATFORM [stable|next]")
    root = Path(sys.argv[1]).resolve()
    platform = sys.argv[2]
    channel = sys.argv[3] if len(sys.argv) == 4 else "stable"
    if platform not in {*PLATFORM_FILES, "all"}:
        fail(f"unsupported platform: {platform}")
    if channel not in {"stable", "next"}:
        fail(f"unsupported channel: {channel}")

    required = [".maestro/START-HERE.md", ".maestro/install.json"]
    required += STABLE_FILES if channel == "stable" else NEXT_FILES
    platforms = PLATFORM_FILES if platform == "all" else {platform: PLATFORM_FILES[platform]}
    for files in platforms.values():
        required += files
    missing = [path for path in required if not (root / path).exists()]
    if missing:
        fail("missing required paths: " + ", ".join(missing))

    metadata = json.loads((root / ".maestro/install.json").read_text(encoding="utf-8"))
    expected_version = "1" if channel == "stable" else "0.2.1-lab"
    expected_control_plane = ".maestro/control-plane" if channel == "next" else None
    expected = {
        "framework": "vibe-code-maestro",
        "version": expected_version,
        "channel": channel,
        "framework_path": ".maestro/framework",
        "control_plane_path": expected_control_plane,
    }
    for key, value in expected.items():
        if metadata.get(key) != value:
            fail(f"install.json {key!r} must be {value!r}")
    if not metadata.get("installed_at"):
        fail("install.json must declare installed_at")

    if channel == "next":
        state = json.loads((root / ".maestro/control-plane/state.json").read_text(encoding="utf-8"))
        reservations = json.loads((root / ".maestro/control-plane/reservations.json").read_text(encoding="utf-8"))
        state_required = {"project", "default_branch", "active_workstreams", "updated_at"}
        if not state_required.issubset(state):
            fail("control-plane state is missing schema-required properties")
        if not isinstance(state["active_workstreams"], list):
            fail("active_workstreams must be an array")
        if not isinstance(reservations.get("reservations"), list) or "updated_at" not in reservations:
            fail("reservations file does not match its schema contract")

    print(f"Installation validation passed for platform={platform}, channel={channel}.")

if __name__ == "__main__":
    main()
