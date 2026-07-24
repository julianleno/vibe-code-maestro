#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path
import shutil


def main() -> int:
    parser = argparse.ArgumentParser(description="Archive old Maestro session checkpoints")
    parser.add_argument("--root", type=Path, default=Path.cwd())
    parser.add_argument("--keep", type=int, default=20)
    args = parser.parse_args()
    if args.keep < 1:
        raise SystemExit("--keep must be at least 1")

    memory = args.root.resolve() / ".maestro" / "memory"
    sessions = memory / "sessions"
    archive = memory / "archive"
    archive.mkdir(parents=True, exist_ok=True)
    files = sorted((p for p in sessions.glob("*.md") if p.is_file()), reverse=True)
    moved = 0
    for path in files[args.keep:]:
        shutil.move(str(path), archive / path.name)
        moved += 1
    print(f"Archived {moved} session checkpoint(s); kept {min(len(files), args.keep)}.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
