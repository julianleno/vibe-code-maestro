# External Skills and Attribution

Vibe Code Maestro integrates external skills through their official installers by default. This avoids stale copies and license ambiguity.

## UI/UX Pro Max

- Repository: `nextlevelbuilder/ui-ux-pro-max-skill`
- Official installer: `npx uipro-cli init --ai <platform>`
- Supported platforms include Codex, Claude, Cursor, Windsurf, Copilot, Gemini, and others.
- Verify the upstream license at install time and retain notices.

## Taste Skill

- Repository: `Leonxlnx/taste-skill`
- Installer: `npx skills add https://github.com/Leonxlnx/taste-skill`
- Install only the selected skill when possible.
- Retain MIT attribution for copied or modified content.

## Agentmemory

- Repository: `rohitg00/agentmemory`
- Purpose: optional local semantic memory through MCP and REST.
- License: Apache License 2.0.
- Maestro keeps repository memory canonical and uses agentmemory only as an optional retrieval layer.
- Installation guidance: `integrations/agentmemory.md`.

## Policy

Never silently vendor third-party repositories. Pin versions for production workflows, record the source release, retain attribution, and run compatibility tests after updates. External memories and skills never override verified repository state or approved specifications.
