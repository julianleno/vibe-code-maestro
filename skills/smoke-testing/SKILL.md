---
name: smoke-testing
description: Verify critical user journeys and deployment health with fast deterministic tests.
---
# Smoke Testing

Create a minimal set of tests that prove:

- application boots
- public landing route renders
- authentication boundary behaves correctly
- primary user journey completes
- protected API rejects unauthorized access
- health endpoint and critical integrations respond
- production build starts with required environment variables

Keep smoke tests fast, isolated, idempotent, and safe for preview environments.
