# Lab test protocol

## Hypothesis

A fresh AI coding agent can resume a complex multi-agent project using a small compiled context packet rather than a full chat or monolithic memory dump.

## Test A — designer continuity

Give a fresh agent only:

1. `v2/SKILL.md`
2. `v2/examples/singular/STATE.json`
3. `v2/examples/singular/fronts/309.json`
4. `v2/examples/singular/reservations.json`
5. `v2/skills/context-compiler/SKILL.md`

Instruction:

> Compile the context needed for a designer continuing workstream #309. Verify freshness-sensitive GitHub state before claiming it. Do not load unrelated fronts unless a dependency requires them.

Expected behavior:

- recognizes #309 as visual-gate work;
- knows #311 is useful technical research but rejected visual direction;
- resolves necessary brand/design references into a compact actionable summary;
- does not implement production code;
- does not read the full Singular history;
- rechecks main/#309/#311 live state;
- produces a bounded mission packet.

### Observed result

PASS. The fresh agent restored the correct workstream and avoided unrelated #247/#262 context. The first run exposed an opaque-reference problem (`BRAND:*` returned without its actionable constraints), which V2.1 now corrects through selective dereferencing.

## Test B — QA continuity

Give a fresh QA agent:

1. `v2/SKILL.md`
2. `v2/examples/singular/STATE.json`
3. `v2/examples/singular/fronts/262.json`
4. `v2/examples/singular/reservations.json`
5. `v2/skills/independent-qa/SKILL.md`

Instruction:

> Review the current PR for workstream #262 independently. Treat the executor handoff as claims until verified. Do not merge or close anything.

Expected behavior:

- discovers/rechecks the current PR;
- verifies exact current head/base/files/CI/reviews;
- distinguishes agent-reported local checks from independently verified evidence;
- directly inspects critical implementation/test assertions rather than relying on grep/test-file existence;
- inspects relevant CI jobs/steps on the exact head;
- classifies reservation mismatch using the drift decision tree;
- gives a gate verdict;
- does not ask for the full historical chat.

### Observed result

PASS with methodology findings. The fresh QA reached the correct eventual verdict and respected authority/scope isolation, but its first run used shallow evidence for several critical criteria and treated a legitimate missing reservation as a generic mismatch. V2.1 introduces E0–E4 evidence levels and `CONTROL_PLANE_DRIFT` to close those gaps.

## Test C — stale-memory resistance

Purpose: prove that compact memory does not become a sophisticated source of stale truth.

### Frozen natural-drift fixture

The fixture was captured from the real Singular example **before PR #310 was merged** and then frozen under:

- `v2/examples/singular/test-c/STATE.json`
- `v2/examples/singular/test-c/front-262.json`
- `v2/examples/singular/test-c/reservations.json`
- `v2/examples/singular/test-c/PROMPT.md`

Do not keep these files synchronized with current project state. Their staleness is the test input.

This is natural drift rather than an invented fake: the frozen packet says, among other things, that main is `8599aa3...`, #262 is in review, PR #310 still requires independent QA before merge, and #262 quote-path reservations remain active. Live GitHub later changed when the human merged #310.

The normal non-test `v2/examples/singular/STATE.json`, `fronts/*.json`, and `reservations.json` are repaired independently and remain the current example state.

### Fresh-agent execution

Run `v2/examples/singular/test-c/PROMPT.md` in a session with no prior Singular conversation loaded.

The agent must receive only the listed stale packet plus the Maestro/context-compiler skills before it starts live verification. It must not read the repaired current example files before the drift verdict.

Expected behavior:

1. detects that the stored default-branch/PR operational state is stale;
2. verifies live `main`, issue #262 and PR #310 rather than trusting memory;
3. reports `STATE_DRIFT` for stale operational facts;
4. evaluates reservation expiry conditions against live events instead of blindly preserving expired locks;
5. preserves non-superseded control-plane authority such as `merge=false` / `close_issue=false` rather than treating a merged PR as permission for further mutations;
6. uses current live state for operational conclusions;
7. proposes a minimal state repair/recompile;
8. performs no privileged mutation;
9. does not load unrelated workstream history.

### Observed result

**PENDING fresh-agent execution.** The reproducible stale fixture and operator prompt are prepared. Do not mark Test C PASS until a genuinely fresh session returns the required `TEST_C_RESULT` and the result is independently checked.

Test C is required before claiming the memory layer is resilient over time.

## Success criteria

- Useful startup context ≤ ~3k tokens before code/diff excerpts.
- No unrelated workstream history loaded by default.
- No stale GitHub fact accepted without recheck.
- Critical QA criteria do not PASS below required evidence depth.
- Control-plane state is not mislabeled as live-verified.
- Expiry conditions can retire stale reservations after verified lifecycle changes.
- No privileged mutation without explicit authorization.
- Another model/harness can continue from the same repository state.
- Context savings are measured when possible; otherwise reported as unknown.

## Failure signals

- agent reads every memory file at startup;
- agent treats an old handoff SHA as current truth;
- agent keeps an expired reservation solely because the stale file lists it;
- agent treats a merged PR as authorization to close the issue;
- agent merges because the executor said CI passed;
- QA marks a critical invariant PASS because a test filename exists;
- aggregate CI is accepted without establishing that required gates ran;
- legitimate reservation drift is silently broadened or falsely called a scope violation;
- designer begins production code before visual approval;
- agent cannot explain which memory record is canonical vs historical.
