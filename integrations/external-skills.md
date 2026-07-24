# External Skills and Attribution

Vibe Code Maestro integrates external skills through their official installers by default. This avoids stale copies and license ambiguity.

## UI/UX Pro Max

- Repository: `nextlevelbuilder/ui-ux-pro-max-skill`
- Official installer: `npx uipro-cli init --ai <platform>`
- Supported platforms include Codex, Claude, Cursor, Windsurf, Copilot, Gemini, and others.
- Verify the upstream license at install time. The upstream repository declares MIT, while specific packaged CLI materials may carry separate notices; retain all notices.

## Taste Skill

- Repository: `Leonxlnx/taste-skill`
- Installer: `npx skills add https://github.com/Leonxlnx/taste-skill`
- Install only the selected skill when possible.
- Retain MIT attribution for copied or modified content.

## Policy

Never silently vendor third-party repositories. Pin versions for production workflows, record the source commit or release, and run compatibility tests after updates.
