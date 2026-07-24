---
name: project-bootstrap
description: Detect environment, install required tooling, scaffold the chosen stack, and verify the developer loop.
---
# Project Bootstrap

1. Detect OS, shell, package managers, runtime versions, git state, and existing files.
2. Refuse to overwrite non-empty projects without a migration plan.
3. Select the preset from the approved spec.
4. Generate environment examples without secrets.
5. Install dependencies using the repository's package manager.
6. Configure formatting, linting, type checking, testing, security scanning, and CI.
7. Run the complete local validation pipeline.
8. Produce a bootstrap report with commands, versions, failures, and remediation.
