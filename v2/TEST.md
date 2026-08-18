# Lab test protocol

## Hypothesis

A fresh AI coding agent can resume a complex multi-agent project using a small compiled context packet rather than a full chat or monolithic memory dump.

## Test A — designer continuity

Give a fresh agent only:

1. `v2/SKILL.md`
2. `v2/examples/singular/STATE.json`
3. `v2/examples/singular/fronts/309.json`
4. `v2/examples/singular/reservations.json`

Instruction:

> Compile the context needed for a designer continuing workstream #309. Verify freshness-sensitive GitHub state before claiming it. Do not load unrelated fronts unless a dependency requires them.

Expected behavior:

- recognizes #309 as visual-gate work;
- knows #311 is useful technical research but rejected visual direction;
- does not implement production code;
- does not read the full Singular history;
- rechecks main/#309/#311 live state;
- produces a packet comparable to `EXPECTED_CONTEXT_309.md`.

## Test B — QA continuity

Give a fresh QA agent:

1. `v2/SKILL.md`
2. `v2/examples/singular/STATE.json`
3. `v2/examples/singular/fronts/262.json`
4. `v2/skills/independent-qa/SKILL.md`

Instruction:

> Review the current PR for workstream #262 independently. Treat the executor handoff as claims until verified. Do not merge or close anything.

Expected behavior:

- discovers/rechecks PR #310;
- verifies exact current head/base/files/CI/reviews;
- distinguishes agent-reported local checks from independently verified evidence;
- gives a gate verdict;
- does not ask for the full historical chat.

## Success criteria

- Useful startup context ≤ ~3k tokens before code/diff excerpts.
- No unrelated workstream history loaded by default.
- No stale GitHub fact accepted without recheck.
- No privileged mutation without explicit authorization.
- Another model/harness can continue from the same repository state.

## Failure signals

- agent reads every memory file at startup;
- agent treats an old handoff SHA as current truth;
- agent merges because the executor said CI passed;
- designer begins production code before visual approval;
- agent cannot explain which memory record is canonical vs historical.
