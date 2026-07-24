[Português (Brasil)](README.md) | [English](README.en-EN.md)

# Vibe Code Maestro

**An AI development operating system.** Install it in a project, describe the idea, and the AI starts working as a manager for product, architecture, UI/UX, engineering, QA, security, and release — with specifications, persistent memory, tests, and CI/CD.

> You do not need to understand the whole repository. Choose your tool, copy the install command, then paste the provided starter prompt.

## What Maestro solves

Without a process, an AI agent tends to code too early, forget decisions when the chat grows, and claim completion without evidence. Maestro enforces this sequence:

```text
memory → inspection → simple questions → specification → architecture → UX
→ scaffold → complete implementation slices → tests → security
→ memory checkpoint → CI/CD → release → handoff
```

## What the installer does

The bootstrap:

1. installs the complete framework under `.maestro/framework/`;
2. creates the specification, acceptance criteria, plan, risks, and handoff files;
3. creates persistent project memory under `.maestro/memory/`;
4. configures Codex, Claude, Lovable, Mimo, Cursor, or Gemini;
5. preserves existing `AGENTS.md`, `CLAUDE.md`, and other project instructions;
6. creates ready-to-paste starter prompts;
7. validates the installation automatically.

---

# Easiest path

## Option A — ask the coding agent to install it

In Codex or Claude Code, open the project you want to work on and paste:

```text
Retrieve and follow the instructions at:
https://raw.githubusercontent.com/julianleno/vibe-code-maestro/main/INSTALL_FOR_AGENTS.md

Install Vibe Code Maestro in this repository for my current coding agent.
Do not edit application code during installation.
```

The agent should install Maestro, validate the result, and show the exact next prompt.

## Option B — install manually for every supported tool

### macOS, Linux, or Git Bash

```bash
git clone https://github.com/julianleno/vibe-code-maestro.git
cd vibe-code-maestro
./installers/bootstrap.sh all ../my-project
```

### Windows PowerShell

```powershell
git clone https://github.com/julianleno/vibe-code-maestro.git
cd vibe-code-maestro
powershell -ExecutionPolicy Bypass -File .\installers\bootstrap.ps1 all ..\my-project
```

**Then open `my-project` in the AI tool. Do not open the `vibe-code-maestro` source folder.**

---

# Codex — step by step

## 1. Install

### macOS, Linux, or Git Bash

```bash
git clone https://github.com/julianleno/vibe-code-maestro.git
cd vibe-code-maestro
./installers/bootstrap.sh codex ../my-project
```

### Windows PowerShell

```powershell
git clone https://github.com/julianleno/vibe-code-maestro.git
cd vibe-code-maestro
powershell -ExecutionPolicy Bypass -File .\installers\bootstrap.ps1 codex ..\my-project
```

## 2. Open the correct folder

Open this folder in Codex:

```text
my-project
```

Do not open:

```text
vibe-code-maestro
```

## 3. Paste this prompt

```text
Initialize Vibe Code Maestro in this repository.
Read AGENTS.md and .maestro/START-HERE.md.
Load persistent memory before acting.
Inspect the project before writing code.
Ask only the questions that are still unanswered, using simple language.
When I do not know a technical decision, recommend the safest and simplest default.
Create the specification and acceptance criteria before scaffolding.
Before ending, update persistent memory and leave the exact next action.

My idea: describe what you want to build here.
```

## 4. Answer the questions

You may answer normally or say:

```text
I do not know. Decide for me using the recommended default.
```

## 5. Approve the specification

When Codex presents the summary, paste:

```text
The specification is approved. Scaffold the project and implement the first complete vertical slice. Run the applicable tests, update persistent memory, and show validation evidence before marking the work complete.
```

---

# Claude Code — step by step

## 1. Install

```bash
git clone https://github.com/julianleno/vibe-code-maestro.git
cd vibe-code-maestro
./installers/bootstrap.sh claude ../my-project
```

On Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\installers\bootstrap.ps1 claude ..\my-project
```

## 2. Open `my-project` in Claude Code

## 3. Paste

```text
Initialize Vibe Code Maestro.
Read CLAUDE.md and .maestro/START-HERE.md.
Load persistent memory and verify that it matches the current repository.
Act as the manager of specialist agents.
Ask only the questions that are still needed and use simple language.
Do not implement before creating the specification, acceptance criteria, and the plan for the first complete delivery slice.
Before ending, update memory, handoff, and the exact next action.

My idea: describe what you want to build here.
```

The installer creates:

```text
CLAUDE.md
.claude/skills/vibe-code-maestro/SKILL.md
.maestro/
```

---

# Lovable — step by step

Lovable uses a chat-first workflow rather than the same repository-local skill discovery used by Codex and Claude. Maestro generates a ready-to-paste master prompt.

## 1. Install

```bash
./installers/bootstrap.sh lovable ../my-project
```

On Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\installers\bootstrap.ps1 lovable ..\my-project
```

## 2. Open

```text
my-project/docs/LOVABLE.md
```

## 3. Copy the whole file

Paste it as the first message in Lovable and replace:

```text
Project idea: REPLACE THIS TEXT.
```

with the real project idea.

## 4. Memory in Lovable

When the project is connected to GitHub, keep `.maestro/memory/` committed. The master prompt instructs Lovable to read and update those files. If Lovable cannot edit them, it must return the replacement contents for you to save.

---

# Mimo Build — step by step

Mimo also uses a chat-oriented workflow. Maestro generates a Mimo-specific prompt.

## 1. Install

```bash
./installers/bootstrap.sh mimo ../my-project
```

On Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\installers\bootstrap.ps1 mimo ..\my-project
```

## 2. Open

```text
my-project/docs/MIMO.md
```

## 3. Copy the whole file and paste it as the first message in Mimo

Replace the project idea at the end of the prompt.

## 4. Memory in Mimo

When Mimo cannot read repository files directly, paste these at the beginning of a new conversation:

```text
.maestro/memory/PROJECT.md
.maestro/memory/STATE.md
```

At the end, require Mimo to return the updated `STATE.md`, any new decisions, and the session checkpoint.

---

# Persistent memory

Local memory is installed automatically and does not depend on the LLM context window.

```text
.maestro/memory/
├── INDEX.md       # read order and latest checkpoint
├── PROJECT.md     # product, users, domain language, technical baseline
├── STATE.md       # current status and exact next action
├── DECISIONS.md   # decisions and rationale
├── LEARNINGS.md   # verified reusable lessons
├── sessions/      # short session summaries
└── archive/       # compacted older sessions
```

## Resume in a fresh conversation

Paste:

```text
Resume this project using Vibe Code Maestro.
Read .maestro/START-HERE.md and all canonical memory files.
Verify the current repository state, explain where the previous agent stopped, and execute the exact next action unless there is a blocker or contradiction that requires my decision.
```

## Create a manual checkpoint

```bash
python .maestro/tools/memory_checkpoint.py \
  --objective "Implement customer registration" \
  --summary "Registration and customer list completed" \
  --changed "src/features/customers" \
  --validation "Tests and production build passed" \
  --next "Implement customer editing"
```

## Compact old session summaries

```bash
python .maestro/tools/compact_memory.py --keep 20
```

Maestro must not store secrets, tokens, private data, or full conversation transcripts in this memory.

---

# Optional agentmemory integration

The native memory above already works by itself. For semantic search across sessions and agents, you may optionally install `rohitg00/agentmemory`.

It is best suited to Codex, Claude Code, Cursor, and Gemini CLI. Lovable and Mimo continue using repository-backed memory.

## Install for Codex

```bash
./installers/install-agentmemory.sh codex
```

## Install for Claude Code

```bash
./installers/install-agentmemory.sh claude
```

Other supported values:

```text
cursor | gemini
```

Then start the service:

```bash
agentmemory
```

Use WSL2 on Windows for this optional installer.

**Rule:** agentmemory results are retrieval hints. The code, specification, ADRs, and `.maestro/memory/` remain canonical.

---

# What the AI should ask

It should not begin by asking which library or folder structure you prefer. It should first understand:

1. what is being built and who will use it;
2. which main task must work end to end;
3. what is in and out of version one;
4. whether login, payments, personal data, or integrations are involved;
5. visual references and the publishing destination.

Onboarding asks no more than four questions in the first batch and skips information already found in memory or the repository.

---

# What is a vertical slice?

A small but complete product outcome:

```text
login → create customer → save to database → list customers → tests
```

It is not only a screen without data or an API without a user interface.

---

# New or existing project

The same command works for both.

- **New project:** the agent creates the specification and recommends the scaffold.
- **Existing project:** the agent reads the code, dependencies, database, CI, deployment, and memory before suggesting changes.

The installer does not erase project files. If `AGENTS.md`, `CLAUDE.md`, or `GEMINI.md` already exists, it updates only the delimited Maestro block and preserves the remaining content.

---

# Update Maestro inside a project

```bash
cd vibe-code-maestro
git pull
./installers/bootstrap.sh codex ../my-project
```

The update:

- refreshes `.maestro/framework/`;
- preserves the specification, memory, decisions, and reports;
- does not duplicate instruction blocks;
- runs validation again.

---

# Validate an installation

```bash
python scripts/validate_installation.py ../my-project codex
```

Replace `codex` with:

```text
claude | lovable | mimo | cursor | gemini | all
```

The bootstrap runs this validation automatically when Python is available.

---

# Generated structure

```text
my-project/
├── .maestro/
│   ├── START-HERE.md
│   ├── project.spec.yaml
│   ├── acceptance.md
│   ├── implementation-plan.md
│   ├── risk-register.md
│   ├── HANDOFF.md
│   ├── memory/
│   ├── prompts/
│   ├── tools/
│   └── framework/
├── AGENTS.md                 # Codex
├── CLAUDE.md                 # Claude
├── .codex/skills/
├── .claude/skills/
├── docs/LOVABLE.md
└── docs/MIMO.md
```

---

# Quality and CI/CD

A delivery cannot be marked ready when:

- the specification is stale;
- authorization or RLS checks fail;
- critical security or accessibility issues remain;
- the production build is unverified;
- migrations lack recovery;
- smoke tests fail;
- memory does not clearly show the current state and exact next action;
- CI/CD is red.

The framework repository runs:

```bash
python scripts/validate_maestro.py
python scripts/test_bootstrap.py
python scripts/validate_pack.py
```

The bootstrap smoke test installs Maestro twice into temporary projects to verify idempotency and preservation of memory and existing instructions.

---

# Common problems

## “The AI cannot find Maestro”

You probably opened the wrong folder. Open `my-project`, where `.maestro/START-HERE.md` exists.

## “It started coding without asking questions”

Paste `.maestro/prompts/<platform>.md` and say:

```text
Stop implementation. Run onboarding and create the specification first.
```

## “A new conversation forgot everything”

Ask it to read `.maestro/memory/` before acting. Confirm that `STATE.md` contains the exact next action and that the memory files were committed.

## “I already have AGENTS.md or CLAUDE.md”

The installer preserves existing content and manages only the block between:

```text
<!-- VIBE-CODE-MAESTRO:START -->
<!-- VIBE-CODE-MAESTRO:END -->
```

---

# External references

This is an original framework that integrates, without claiming authorship of:

- UI/UX Pro Max by NextLevelBuilder;
- Taste Skill by Leonxlnx;
- Agentmemory by Rohit Ghumare.

See `integrations/` for policy, attribution, and optional installation instructions.
