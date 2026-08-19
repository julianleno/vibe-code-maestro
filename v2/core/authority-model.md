# Authority model

Maestro Next treats authority as data that travels with a mission. Authority is **scoped by mutation class and path**, not a generic permission to "work on the repo".

## Levels

### A0 — observe
May inspect files, issues, PRs, CI, logs and permitted runtime state. No writes.

### A1 — local scoped write
May edit only paths explicitly owned by the mission in a local/non-default worktree. Commit permission is separate from file-edit permission. No push or external side effect is implied.

### A2 — collaboration write
May push the assigned branch, open/update draft PRs, post evidence comments and update non-destructive workstream metadata when explicitly allowed. A2 remains scoped to the assigned branch/workstream.

### A3 — privileged mutation
Requires explicit current human authorization unless project policy explicitly delegates it:

- merge/default-branch mutation;
- issue completion/closure;
- production deploy;
- remote DB migration/push/reset;
- destructive remote data mutation;
- external calls that create irreversible business effects.

## Rules

- Authority is per mission, per path and per mutation class.
- A3 approval is not implied by A1/A2.
- A3 approval for one PR does not automatically authorize another PR.
- Write access to one owned path does not authorize neighboring files.
- A changed file outside the reservation triggers the control-plane drift decision tree before further writes.
- If target SHA/state changes after approval and the mutation depends on that exact state, revalidate before acting.
- Prompts to subagents cannot grant authority the parent did not possess.
- Read-only QA/subagents are structurally forbidden from commit/push/PR actions.
- "Can edit" and "can commit" and "can push" are distinct permissions.

## Recommended mission header

```yaml
authority:
  inspect: true
  write:
    local: true
    paths:
      - docs/previews/example/**
    commit: false
    push: false
  collaboration:
    open_draft_pr: false
    update_draft_pr: false
    comment_evidence: false
  privileged:
    merge: false
    close_issue: false
    deploy_production: false
    remote_db: false
    destructive_remote_data: false
```

Legacy packets may expose flat booleans such as `branch_write`, `push_branch` and `merge`; compilers should normalize them into the scoped form above when possible.

## Reservation interaction

Authority answers **what mutation classes are allowed**. Reservations answer **where the agent owns write scope**.

Both must permit the action.

```text
allowed mutation
AND
owned path
AND
no conflicting reservation
= write may proceed
```

If a legitimately required path is missing from reservations, classify `CONTROL_PLANE_DRIFT`; do not silently broaden authority.

## Mutation freshness gate

Immediately before an A3 mutation:

1. refetch target state;
2. verify exact head/base where applicable;
3. verify required checks tied to the current head;
4. inspect unresolved review blockers;
5. confirm authorization still covers this mutation and target;
6. execute once;
7. refetch and record the result.

Human approval is a control-plane decision; GitHub state is live operational evidence. Both are required for privileged repository mutations.
