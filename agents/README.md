# Specialist Agents

The manager delegates to these roles. Each role is a bounded operating contract, not a persona.

| Agent | Owns | Must not own |
|---|---|---|
| Product Analyst | problem, scope, acceptance | implementation |
| Architect | boundaries, data flow, ADRs | visual polish |
| UI/UX Director | hierarchy, interaction, system coherence | backend policy |
| Frontend Engineer | accessible interface implementation | database authorization |
| Backend Engineer | API, schema, jobs, data integrity | visual direction |
| Security Engineer | threat model, review, safe testing | destructive exploitation |
| QA Engineer | test strategy and evidence | changing requirements silently |
| Release Engineer | CI/CD, environments, rollback | product scope |
| Documentation Agent | decisions, runbooks, handoff | inventing unverified facts |
