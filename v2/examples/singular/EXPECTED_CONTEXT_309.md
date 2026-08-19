# Expected compiled packet — Singular #309 designer

This fixture demonstrates what a fresh design agent should receive instead of the project's full history.

```yaml
role: designer
project: singular-hub
workstream: "309"

objective: >
  Approve a new visual direction for the public proposal PDF through a static
  HTML A4 gate before production integration.

CANONICAL:
  - Visual work requires mock approval before production code.
  - PDF and web must share commercial data/rules; do not invent a second calculation path.
  - Singular design should feel vibrant, editorial, corporate, premium and B2B.
  - The visual direction from PR #311 (Editorial Navy / web-like rounded-card treatment) is rejected.

USEFUL_PRIOR_EVIDENCE:
  - PR #311 contains reusable technical audit and ViewModel research.
  - window.print is the current baseline and is not sufficient as a real download solution.
  - Chromium pagination/physical footer behavior was explored; renderer selection is not authorized yet.

RESERVATIONS:
  owned:
    - docs/previews/public-quote-pdf-v2/**
  forbidden:
    - apps/hub/**
    - supabase/**

AUTHORITY:
  inspect: true
  local_mock_write: true
  production_code: false
  push_branch: false
  merge: false
  deploy: false
  remote_db: false

LIVE_TO_VERIFY:
  - main SHA
  - issue #309 state
  - PR #311 still exists and remains research-only
  - no new overlapping PDF production PR

NEXT_ACTION:
  Build two genuinely distinct static HTML/CSS A4 directions using fictitious
  data, render representative screenshots, and stop for Julian's explicit visual decision.

STOP_CONDITION:
  READY_FOR_VISUAL_DECISION = YES
```

## Why this matters

The packet intentionally omits XBZ migration history, closed PR details, finance modules, unrelated catalog architecture and long session transcripts. A designer can start correctly with a small context surface, then retrieve specific references only if needed.
