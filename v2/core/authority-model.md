# Authority model

Maestro Next treats authority as data that travels with a mission.

## Levels

### A0 — observe
May inspect files, issues, PRs, CI, logs and runtime state. No writes.

### A1 — local/branch write
May edit files and create commits on the assigned non-default branch. No remote side effects outside source control.

### A2 — collaboration write
May push assigned branch, open/update draft PRs, post evidence comments and update non-destructive workstream metadata.

### A3 — privileged mutation
Requires explicit current human authorization unless project policy explicitly delegates it:
- merge/default-branch mutation;
- issue completion/closure;
- production deploy;
- remote DB migration/push/reset;
- destructive remote data mutation;
- external calls that create irreversible business effects.

## Rules

- Authority is per mission and per mutation class.
- A3 approval is not implied by A1/A2.
- A3 approval for one PR does not automatically authorize another PR.
- If target SHA/state changes after approval and the mutation depends on that exact state, revalidate before acting.
- Prompts to subagents cannot grant authority the parent did not possess.
- Read-only subagents are structurally forbidden from commit/push/PR actions.

## Required mission header

Every executable mission packet should expose:

```yaml
authority:
  inspect: true
  branch_write: true
  push_branch: true
  open_draft_pr: true
  merge: false
  close_issue: false
  deploy_production: false
  remote_db: false
  destructive_remote_data: false
```

## Mutation freshness gate

Immediately before an A3 mutation:

1. refetch target state;
2. verify exact head/base where applicable;
3. verify required checks tied to the current head;
4. inspect unresolved review blockers;
5. confirm authorization still covers this mutation;
6. execute once;
7. refetch and record the result.
