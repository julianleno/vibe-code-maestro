#!/usr/bin/env python3
import json
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SHELL = ROOT / "installers" / "bootstrap.sh"
POWERSHELL = ROOT / "installers" / "bootstrap.ps1"
PLATFORMS = ("codex", "claude", "all")

def run(command, *, expect=0):
    result = subprocess.run(command, cwd=ROOT, text=True, capture_output=True)
    if result.returncode != expect:
        print(result.stdout)
        print(result.stderr, file=sys.stderr)
        raise AssertionError(f"{command} returned {result.returncode}, expected {expect}")
    return result

def assert_preserved(target: Path, platform: str):
    assert "KEEP-AGENTS" in (target / "AGENTS.md").read_text(encoding="utf-8")
    assert "KEEP-CLAUDE" in (target / "CLAUDE.md").read_text(encoding="utf-8")
    agents_blocks = (target / "AGENTS.md").read_text(encoding="utf-8").count("VIBE-CODE-MAESTRO:START")
    claude_blocks = (target / "CLAUDE.md").read_text(encoding="utf-8").count("VIBE-CODE-MAESTRO:START")
    assert agents_blocks == (1 if platform in {"codex", "all"} else 0)
    assert claude_blocks == (1 if platform in {"claude", "all"} else 0)

def bash_path(path: Path) -> str:
    value = path.resolve().as_posix()
    if len(value) > 2 and value[1] == ":":
        return f"/mnt/{value[0].lower()}{value[2:]}"
    return value

def exercise(installer, platform: str, channel: str):
    with tempfile.TemporaryDirectory() as temporary:
        target = Path(temporary)
        (target / "AGENTS.md").write_text("KEEP-AGENTS\n", encoding="utf-8")
        (target / "CLAUDE.md").write_text("KEEP-CLAUDE\n", encoding="utf-8")
        command = installer(target, platform, channel)
        run(command)
        metadata = json.loads((target / ".maestro/install.json").read_text(encoding="utf-8"))
        assert metadata["channel"] == channel
        assert metadata["framework_path"] == ".maestro/framework"
        assert metadata["control_plane_path"] == ".maestro/control-plane"
        if channel == "stable":
            assert (target / ".maestro/framework/core/constitution.md").is_file()
            state_path = target / ".maestro/memory/STATE.md"
            assert state_path.is_file()
            with state_path.open("a", encoding="utf-8") as state_file:
                state_file.write("\nREINSTALL-SENTINEL\n")
        else:
            assert (target / ".maestro/framework/core/workspace-model.md").is_file()
            assert (target / ".maestro/framework/skills").is_dir()
            assert (target / ".maestro/framework/schemas/evidence.schema.json").is_file()
            state_path = target / ".maestro/control-plane/state.json"
            state = json.loads(state_path.read_text(encoding="utf-8"))
            state["project"] = "REINSTALL-SENTINEL"
            state_path.write_text(json.dumps(state, indent=2) + "\n", encoding="utf-8")
        run(command)
        assert_preserved(target, platform)
        if channel == "next":
            state = json.loads((target / ".maestro/control-plane/state.json").read_text(encoding="utf-8"))
            assert state["project"] == "REINSTALL-SENTINEL"
        else:
            assert "REINSTALL-SENTINEL" in (target / ".maestro/memory/STATE.md").read_text(encoding="utf-8")

def shell_installer(target: Path, platform: str, channel: str):
    command = ["bash", bash_path(SHELL), platform, bash_path(target)]
    if channel == "next":
        command += ["--channel", "next"]
    return command

def powershell_installer(executable: str):
    return lambda target, platform, channel: [
        executable, "-NoProfile", "-File", str(POWERSHELL),
        "-Platform", platform, "-Target", str(target), "-Channel", channel,
    ]

def validate_schema_documents():
    for path in sorted((ROOT / "v2/schemas").glob("*.json")):
        schema = json.loads(path.read_text(encoding="utf-8"))
        assert schema.get("$schema", "").startswith("https://json-schema.org/")
        assert schema.get("type") == "object"

def main():
    validate_schema_documents()
    for channel in ("stable", "next"):
        for platform in PLATFORMS:
            exercise(shell_installer, platform, channel)
    with tempfile.TemporaryDirectory() as temporary:
        target = Path(temporary)
        shell = bash_path(SHELL)
        destination = bash_path(target)
        run(["bash", shell, "codex", destination, "--channel", "future"], expect=2)
        run(["bash", shell, "codex", destination, "--channel"], expect=2)
        run(["bash", shell, "codex", destination, "--channel", "next", "--channel", "stable"], expect=2)
        run(["bash", shell, "codex", destination, "--channel", "next"])
        assert not (target / ".maestro/framework/agents").exists()
        run(["bash", shell, "codex", destination, "--channel", "stable"])
        assert not (target / ".maestro/framework/schemas").exists()

    executable = shutil.which("pwsh") or shutil.which("powershell")
    if executable:
        ps = powershell_installer(executable)
        for channel in ("stable", "next"):
            for platform in PLATFORMS:
                exercise(ps, platform, channel)
        with tempfile.TemporaryDirectory() as temporary:
            run([executable, "-NoProfile", "-File", str(POWERSHELL), "-Target", temporary, "-Channel", "future"], expect=1)
    else:
        print("PowerShell unavailable; PowerShell installer tests skipped.")
    print("Bootstrap installer tests passed.")

if __name__ == "__main__":
    main()
