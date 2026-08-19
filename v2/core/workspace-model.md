# Workspace Model

## Principle

A fresh agent session must start from a fresh workspace boundary.

**Memory can persist. Working trees must not silently persist operational state.**

The control plane treats these as separate layers:

1. **live remote truth** — GitHub/default branch/PR/CI state;
2. **local repository anchor** — a clean clone used to fetch refs and create worktrees;
3. **agent worktree** — an isolated checkout for one agent + one workstream/role.

A local `main` branch is never authoritative merely because it exists.

## Preferred topology

Prefer one canonical local clone plus one Git worktree per active agent/workstream:

```text
singular/                         # clean repository anchor
../worktrees/
  singular-claude-hub-313/        # implementation
  singular-kimi-hub-313-audit/    # independent audit
  singular-codex-hub-313-qa/      # independent QA
```

Independent full clones such as `singular-claude`, `singular-kimi`, and `singular-codex` are also valid when already provisioned, but each clone must follow the same refresh/cleanliness rules and must never be treated as shared state.

**Never let two active agents share one working tree.**

## Clean-start protocol

Before loading a mission deeply or editing code:

1. verify the expected remote (`origin`) points to the canonical repository;
2. run `git fetch --prune origin`;
3. inspect `git status --porcelain` in any checkout that may be reused;
4. read `origin/main` (or the configured default branch) SHA;
5. verify freshness-sensitive branch/PR state against live GitHub when the mission depends on it;
6. inspect existing worktrees with `git worktree list --porcelain` when using worktrees;
7. create or select an isolated workspace for the assigned role;
8. record the exact base SHA before implementation/audit starts.

Recommended refresh for a clean repository anchor:

```bash
git fetch --prune origin
git switch main
git pull --ff-only origin main
git rev-parse origin/main
git status --porcelain
```

If `main` is dirty, diverged, or cannot fast-forward cleanly, **do not** repair it with a destructive reset or opportunistic stash merely to satisfy the bootstrap. Stop and create a fresh worktree/clone from the remote ref instead.

## Creating an implementation worktree

Create the task branch from the exact refreshed remote base, not from a possibly stale local branch:

```bash
git fetch --prune origin
git worktree add ../worktrees/<project>-<agent>-<workstream> \
  -b <task-branch> origin/main
```

Then inside the worktree:

```bash
git rev-parse HEAD
git status --porcelain
```

The recorded `HEAD` must equal the intended base before task commits begin unless the mission explicitly targets another ref.

## Read-only audit worktrees

Independent auditors should not begin from the implementer's branch.

For inventory/audit tasks:

```bash
git fetch --prune origin
git worktree add --detach ../worktrees/<project>-<agent>-audit origin/main
```

The auditor works read-only against the same canonical remote truth but a separate filesystem state.

Only after the independent inventory/verdict is frozen may the auditor inspect the implementation PR/head for cross-review.

This preserves independence:

```text
main audit first
      ↓
independent findings frozen
      ↓
implementation head loaded
      ↓
cross-review
```

## Reuse policy

Default behavior for a new mission is **renew, not inherit**.

Do not carry an old task worktree into a new workstream just because the directory already exists.

A worktree may be reused only when all are true:

- same active workstream and role;
- branch identity is still correct;
- no unexpected local changes;
- remote refs were freshly fetched;
- base/head drift was explicitly evaluated;
- reservations still authorize the paths being edited.

Otherwise create a fresh worktree from the current remote base.

## After merge or workstream completion

After the human-authorized merge/release:

1. refresh remote refs;
2. verify the merge/default-branch SHA live;
3. release/expire control-plane reservations whose conditions fired;
4. ensure the worktree has no uncommitted work that must be preserved;
5. remove the completed worktree when safe;
6. run `git worktree prune` when appropriate;
7. start the next mission from a newly refreshed remote base.

Do not delete branches/worktrees containing unpushed or unexplained work as automated cleanup.

## Multi-agent isolation

Each active role gets its own workspace boundary:

```text
implementer workspace  != auditor workspace
implementer workspace  != QA workspace
auditor workspace      != QA workspace
```

They may share:

- the canonical GitHub repository;
- Maestro control-plane memory;
- explicit handoffs/evidence;
- immutable commit SHAs.

They must not share implicitly:

- uncommitted files;
- build artifacts relied on as evidence;
- stashes;
- checked-out branches;
- local generated state;
- a mutable working directory.

## Evidence and handoff

Every implementation or QA handoff should report at least:

- canonical repository;
- workspace mode (`worktree` or independent clone);
- role/agent;
- branch or detached ref;
- refreshed `origin/main` SHA at start;
- task base SHA;
- final head SHA when applicable;
- `git status --porcelain` cleanliness at relevant gates;
- whether the workspace was newly created or intentionally reused;
- any local-state anomaly encountered.

This makes workspace provenance part of delivery evidence rather than invisible session state.

## Safety rule

**Refresh remote truth; isolate the role; branch from the exact base; never hide local contamination.**
