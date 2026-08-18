---
name: maestro-next-visual-gate
description: Require cheap, inspectable visual prototypes and explicit human approval before expensive production implementation when visual direction is a primary acceptance criterion.
version: 0.1.0-lab
---

# Visual Gate

## Sequence

```text
visual brief
→ static mock/prototype
→ rendered screenshots/evidence
→ human review
→ revisions if requested
→ explicit implementation approval
→ production code
```

## Default artifact

Prefer a static HTML/CSS mock for web/PDF/interface work when it lets the human inspect real layout behavior cheaply.

The mock should avoid:
- production API calls;
- real customer data;
- secrets;
- schema/database changes;
- heavy dependencies;
- production routing/integration.

## Approval semantics

These are feedback, not implementation authority by themselves:
- “better”;
- “I prefer A”;
- “this direction is closer”;
- requested visual adjustments.

Implementation begins only after an explicit approval such as:
- “Direction A approved; implement it”;
- “Pode implementar esta direção.”

## Gate handoff

Provide:
- mock paths/URLs;
- representative screenshots;
- known layout limitations;
- data assumptions;
- production files changed = NO, unless explicitly authorized;
- dependencies added = NO, unless explicitly authorized;
- `READY_FOR_VISUAL_DECISION = YES`.

Stop after the gate until the human decides.
