# Mimo Build Entry Point

Mimo Build uses a chat-first workflow rather than repository-local skill discovery. Copy the prompt from `docs/mimo-master-prompt.md` or the generated `docs/MIMO.md` in an installed project and paste it as the first message.

When the project is connected to GitHub, keep `.maestro/memory/` committed. At the start of a new Mimo conversation, provide `PROJECT.md` and `STATE.md` when Mimo cannot read them directly; at the end, require an updated state and checkpoint summary.
