---
name: ci-cd-delivery
description: Build gated CI/CD with reproducible checks, preview environments, controlled production releases, and rollback.
---
# CI/CD Delivery

Required pull-request gates:

- specification validation
- formatting and linting
- type checking
- unit and integration tests
- build
- smoke tests
- dependency and secret scanning
- accessibility and UI review evidence when interface changes

Production deployment requires protected environments, least-privilege credentials, migration safety, health checks, and documented rollback.
