# Optional Agentmemory Integration

Vibe Code Maestro includes repository-backed memory by default. This is the canonical layer and works without a server, API key, or MCP support.

For semantic recall across sessions and multiple coding agents, the project can optionally integrate [`rohitg00/agentmemory`](https://github.com/rohitg00/agentmemory).

## Why it is optional

- Codex, Claude Code, Cursor, and Gemini CLI can use MCP integrations.
- Lovable and Mimo use chat-first workflows and may not expose the same local MCP wiring.
- A local memory service adds installation and runtime requirements.
- Repository memory remains readable, reviewable, and versioned even when the service is offline.

## Install

From the Vibe Code Maestro source repository on macOS, Linux, or WSL2:

```bash
./installers/install-agentmemory.sh codex
```

Supported values:

```text
codex | claude | cursor | gemini
```

The installer follows the upstream public setup path:

- installs `@agentmemory/agentmemory`;
- connects it to the selected agent;
- installs the upstream native skills;
- leaves server startup under user control.

Then start the local service:

```bash
agentmemory
```

## Operating rule

External memories are retrieval hints. Verify them against the repository, then promote durable facts into `.maestro/memory/`. Never let an external memory result silently override the specification, ADRs, or verified code state.

## License and attribution

Agentmemory is maintained by Rohit Ghumare and distributed under Apache License 2.0. Vibe Code Maestro does not vendor its source code; it invokes the upstream package and retains attribution in documentation.
