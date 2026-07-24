#!/usr/bin/env python3
from __future__ import annotations

import argparse
from datetime import datetime, timezone
from pathlib import Path


def bullets(values: list[str]) -> str:
    return "\n".join(f"- {value}" for value in values) if values else "- None recorded."


def main() -> int:
    parser = argparse.ArgumentParser(description="Create a Vibe Code Maestro memory checkpoint")
    parser.add_argument("--root", type=Path, default=Path.cwd())
    parser.add_argument("--objective", required=True)
    parser.add_argument("--summary", action="append", default=[])
    parser.add_argument("--changed", action="append", default=[])
    parser.add_argument("--decision", action="append", default=[])
    parser.add_argument("--validation", action="append", default=[])
    parser.add_argument("--risk", action="append", default=[])
    parser.add_argument("--next", required=True, dest="next_action")
    parser.add_argument("--phase", default="implementation")
    args = parser.parse_args()

    root = args.root.resolve()
    memory = root / ".maestro" / "memory"
    sessions = memory / "sessions"
    sessions.mkdir(parents=True, exist_ok=True)

    now = datetime.now(timezone.utc)
    stamp = now.strftime("%Y%m%dT%H%M%SZ")
    human = now.strftime("%Y-%m-%d %H:%M UTC")
    session = sessions / f"{stamp}.md"
    session.write_text(
        f"# Session Checkpoint — {human}\n\n"
        f"## Objective\n\n{args.objective}\n\n"
        f"## Completed\n\n{bullets(args.summary)}\n\n"
        f"## Files and systems changed\n\n{bullets(args.changed)}\n\n"
        f"## Decisions\n\n{bullets(args.decision)}\n\n"
        f"## Validation evidence\n\n{bullets(args.validation)}\n\n"
        f"## Risks and blockers\n\n{bullets(args.risk)}\n\n"
        f"## Exact next action\n\n{args.next_action}\n",
        encoding="utf-8",
    )

    state = memory / "STATE.md"
    state.write_text(
        "# Current Project State\n\n"
        f"- Phase: {args.phase}\n"
        "- Status: active\n"
        f"- Current objective: {args.objective}\n"
        f"- Last verified: {human}\n\n"
        f"## Completed\n\n{bullets(args.summary)}\n\n"
        f"## In progress\n\n- {args.next_action}\n\n"
        f"## Blockers and risks\n\n{bullets(args.risk)}\n\n"
        f"## Validation evidence\n\n{bullets(args.validation)}\n\n"
        f"## Exact next action\n\n{args.next_action}\n",
        encoding="utf-8",
    )

    index = memory / "INDEX.md"
    if index.exists():
        text = index.read_text(encoding="utf-8")
        lines = [line for line in text.splitlines() if not line.startswith("Last checkpoint:")]
        lines.extend(["", f"Last checkpoint: `{session.relative_to(root)}` — {human}."])
        index.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")

    print(session)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
