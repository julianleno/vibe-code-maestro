param(
    [ValidateSet('codex','claude','lovable','mimo','cursor','gemini','all')]
    [string]$Platform = 'all',
    [string]$Target = '.'
)

$ErrorActionPreference = 'Stop'
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceRoot = (Resolve-Path (Join-Path $ScriptDir '..')).Path
New-Item -ItemType Directory -Force -Path $Target | Out-Null
$TargetRoot = (Resolve-Path $Target).Path
$MaestroRoot = Join-Path $TargetRoot '.maestro'
$FrameworkRoot = Join-Path $MaestroRoot 'framework'
$MemoryRoot = Join-Path $MaestroRoot 'memory'
$ToolsRoot = Join-Path $MaestroRoot 'tools'

@(
    $MaestroRoot,
    (Join-Path $MaestroRoot 'tasks'),
    (Join-Path $MaestroRoot 'reports'),
    (Join-Path $MaestroRoot 'decisions'),
    (Join-Path $MaestroRoot 'prompts'),
    $MemoryRoot,
    (Join-Path $MemoryRoot 'sessions'),
    (Join-Path $MemoryRoot 'archive'),
    $ToolsRoot,
    $FrameworkRoot
) | ForEach-Object { New-Item -ItemType Directory -Force -Path $_ | Out-Null }

$FrameworkItems = @('core','agents','skills','pipelines','playbooks','standards','checklists','specs','templates','prompts','adapters','integrations','tests','docs')
foreach ($Item in $FrameworkItems) {
    $Destination = Join-Path $FrameworkRoot $Item
    Remove-Item -Recurse -Force $Destination -ErrorAction SilentlyContinue
    Copy-Item -Recurse -Force (Join-Path $SourceRoot $Item) $Destination
}
Copy-Item -Force (Join-Path $SourceRoot 'SKILL.md') (Join-Path $FrameworkRoot 'SKILL.md')
Copy-Item -Force (Join-Path $SourceRoot 'LICENSE') (Join-Path $FrameworkRoot 'LICENSE')

function Copy-IfMissing([string]$Source, [string]$Destination) {
    if (-not (Test-Path $Destination)) {
        New-Item -ItemType Directory -Force -Path (Split-Path $Destination) | Out-Null
        Copy-Item $Source $Destination
    }
}

Copy-IfMissing (Join-Path $SourceRoot 'specs/project.spec.example.yaml') (Join-Path $MaestroRoot 'project.spec.yaml')
Copy-IfMissing (Join-Path $SourceRoot 'specs/acceptance.md') (Join-Path $MaestroRoot 'acceptance.md')
Copy-IfMissing (Join-Path $SourceRoot 'templates/HANDOFF.md') (Join-Path $MaestroRoot 'HANDOFF.md')
Copy-IfMissing (Join-Path $SourceRoot 'project.manifest.example.yaml') (Join-Path $MaestroRoot 'project.manifest.yaml')

foreach ($Name in @('reality-check.md','implementation-plan.md','risk-register.md')) {
    $Path = Join-Path $MaestroRoot $Name
    if (-not (Test-Path $Path)) {
        "# $($Name.Replace('.md',''))`n`nPending first-run onboarding.`n" | Set-Content -Encoding UTF8 $Path
    }
}

foreach ($Name in @('INDEX.md','PROJECT.md','STATE.md','DECISIONS.md','LEARNINGS.md')) {
    Copy-IfMissing (Join-Path $SourceRoot "templates/memory/$Name") (Join-Path $MemoryRoot $Name)
}
Copy-IfMissing (Join-Path $SourceRoot 'templates/memory/SESSION-TEMPLATE.md') (Join-Path $MemoryRoot 'SESSION-TEMPLATE.md')
New-Item -ItemType File -Force -Path (Join-Path $MemoryRoot 'sessions/.gitkeep') | Out-Null
New-Item -ItemType File -Force -Path (Join-Path $MemoryRoot 'archive/.gitkeep') | Out-Null

Copy-Item -Force (Join-Path $SourceRoot 'scripts/memory_checkpoint.py') (Join-Path $ToolsRoot 'memory_checkpoint.py')
Copy-Item -Force (Join-Path $SourceRoot 'scripts/compact_memory.py') (Join-Path $ToolsRoot 'compact_memory.py')
Copy-Item -Force (Join-Path $SourceRoot 'installers/install-agentmemory.sh') (Join-Path $ToolsRoot 'install-agentmemory.sh')

@'
# Start Here — Vibe Code Maestro

You do not need to understand every file. The AI manager must follow this order.

## Mandatory boot sequence

1. Read `.maestro/memory/INDEX.md`.
2. Read `.maestro/memory/PROJECT.md`, `STATE.md`, `DECISIONS.md`, and `LEARNINGS.md`.
3. Verify that memory still matches the repository and runtime. Report conflicts.
4. Read `.maestro/framework/core/constitution.md`.
5. Read `.maestro/framework/core/memory-protocol.md`.
6. Read `.maestro/framework/core/manager-agent.md` and `question-engine.md`.
7. Read `.maestro/framework/skills/project-onboarding/SKILL.md`.
8. Inspect the repository before proposing a stack or writing code.
9. Ask only unanswered, high-leverage questions using simple language.
10. Update the specification, acceptance criteria, plan, risks, memory, and handoff before scaffolding.

## First message to paste

```text
Initialize Vibe Code Maestro in this repository.
Read .maestro/START-HERE.md and load persistent memory before acting.
Inspect the repository first. Do not write production code yet.
Ask only the questions that are still necessary, using simple language and examples.
Do not ask me to repeat information already stored in .maestro/memory/.
When safe, recommend defaults instead of asking me technical questions I may not know.
Create the canonical specification and acceptance criteria before scaffolding.
After the specification is ready, show me a concise summary. If I already authorized autonomous execution, continue with the scaffold and first vertical slice; otherwise ask for approval.
Before ending, update project memory and leave the exact next action.

Project idea: DESCRIBE YOUR IDEA HERE.
```

## Resume phrase for a new chat

```text
Resume this project using Vibe Code Maestro. Read .maestro/START-HERE.md and all canonical memory files. Verify the current repository state, explain where the previous agent stopped, then execute the exact next action unless a blocker or contradiction requires my decision.
```
'@ | Set-Content -Encoding UTF8 (Join-Path $MaestroRoot 'START-HERE.md')

$PromptDir = Join-Path $MaestroRoot 'prompts'
@'
Initialize Vibe Code Maestro in this repository. Read AGENTS.md and `.maestro/START-HERE.md`. Load persistent memory before acting, inspect reality first, run beginner-friendly onboarding, create the canonical specification and acceptance criteria, and do not write production code before the specification is ready. Before ending, checkpoint memory and leave the exact next action. My project idea is: REPLACE THIS TEXT.
'@ | Set-Content -Encoding UTF8 (Join-Path $PromptDir 'codex.md')
@'
Initialize Vibe Code Maestro in this repository. Read CLAUDE.md and `.maestro/START-HERE.md`. Load persistent memory, act as the manager of specialist agents, inspect the repository, ask only unanswered high-leverage questions in simple language, create the canonical specification, and do not implement before it is ready. Before ending, checkpoint memory and leave the exact next action. My project idea is: REPLACE THIS TEXT.
'@ | Set-Content -Encoding UTF8 (Join-Path $PromptDir 'claude.md')
@'
Initialize Vibe Code Maestro in this repository. Read `.maestro/START-HERE.md`, load persistent memory, inspect the repository, complete beginner-friendly onboarding and specification before implementation, then work in vertical slices with validation evidence and memory checkpoints. My project idea is: REPLACE THIS TEXT.
'@ | Set-Content -Encoding UTF8 (Join-Path $PromptDir 'cursor.md')
@'
Initialize Vibe Code Maestro in this repository. Read GEMINI.md and `.maestro/START-HERE.md`, load persistent memory, inspect reality, ask only unanswered questions, create the specification before implementation, and checkpoint memory with the exact next action. My project idea is: REPLACE THIS TEXT.
'@ | Set-Content -Encoding UTF8 (Join-Path $PromptDir 'gemini.md')
Copy-Item -Force (Join-Path $SourceRoot 'docs/lovable-master-prompt.md') (Join-Path $PromptDir 'lovable.md')
Copy-Item -Force (Join-Path $SourceRoot 'docs/mimo-master-prompt.md') (Join-Path $PromptDir 'mimo.md')

function Set-ManagedBlock([string]$File, [string]$Title, [string]$Body) {
    $Start = '<!-- VIBE-CODE-MAESTRO:START -->'
    $End = '<!-- VIBE-CODE-MAESTRO:END -->'
    New-Item -ItemType Directory -Force -Path (Split-Path $File) | Out-Null
    if (-not (Test-Path $File)) { New-Item -ItemType File -Path $File | Out-Null }
    $Current = Get-Content -Raw $File
    $Pattern = '(?s)\s*' + [regex]::Escape($Start) + '.*?' + [regex]::Escape($End) + '\s*'
    $Clean = [regex]::Replace($Current, $Pattern, "`n")
    $Block = "`n$Start`n## $Title`n`n$Body`n$End`n"
    ($Clean.TrimEnd() + $Block) | Set-Content -Encoding UTF8 $File
}

function Install-PortableSkill([string]$Destination) {
    New-Item -ItemType Directory -Force -Path (Split-Path $Destination) | Out-Null
@'
---
name: vibe-code-maestro
description: Initialize and manage a spec-driven software project with beginner-friendly onboarding, persistent memory, specialist-agent delegation, UI/UX, security, tests, CI/CD, release gates, and handoff.
---

Read `.maestro/START-HERE.md`, load `.maestro/memory/`, then use `.maestro/framework/` as the operating source of truth. Do not write production code before the specification and acceptance criteria are ready. Before ending meaningful work, update memory, handoff, and the exact next action.
'@ | Set-Content -Encoding UTF8 $Destination
}

function Install-Codex {
    Set-ManagedBlock (Join-Path $TargetRoot 'AGENTS.md') 'Vibe Code Maestro' 'Read `.maestro/START-HERE.md`. Load `.maestro/memory/` before acting, use `.maestro/framework/` as the source of truth, inspect the repository, and complete onboarding before production code. Maintain specification, acceptance criteria, risks, validation evidence, memory, and handoff.'
    Install-PortableSkill (Join-Path $TargetRoot '.codex/skills/vibe-code-maestro/SKILL.md')
}
function Install-Claude {
    Set-ManagedBlock (Join-Path $TargetRoot 'CLAUDE.md') 'Vibe Code Maestro' 'Read `.maestro/START-HERE.md`, load `.maestro/memory/`, and act as the manager of specialist agents. Ask only unanswered questions, create the specification before implementation, work in vertical slices, require validation evidence, and checkpoint memory.'
    Install-PortableSkill (Join-Path $TargetRoot '.claude/skills/vibe-code-maestro/SKILL.md')
}
function Install-Lovable {
    New-Item -ItemType Directory -Force -Path (Join-Path $TargetRoot 'docs') | Out-Null
    Copy-Item -Force (Join-Path $SourceRoot 'docs/lovable-master-prompt.md') (Join-Path $TargetRoot 'docs/LOVABLE.md')
}
function Install-Mimo {
    New-Item -ItemType Directory -Force -Path (Join-Path $TargetRoot 'docs') | Out-Null
    Copy-Item -Force (Join-Path $SourceRoot 'docs/mimo-master-prompt.md') (Join-Path $TargetRoot 'docs/MIMO.md')
}
function Install-Cursor {
    $Path = Join-Path $TargetRoot '.cursor/rules/maestro.mdc'
    New-Item -ItemType Directory -Force -Path (Split-Path $Path) | Out-Null
    "---`ndescription: Vibe Code Maestro orchestration, persistent memory, and spec-driven development rules`nalwaysApply: true`n---`nRead ``.maestro/START-HERE.md``, load ``.maestro/memory/``, and use ``.maestro/framework/``. Complete onboarding and specification before implementation, validate work, and checkpoint memory.`n" | Set-Content -Encoding UTF8 $Path
}
function Install-Gemini {
    Set-ManagedBlock (Join-Path $TargetRoot 'GEMINI.md') 'Vibe Code Maestro' 'Read `.maestro/START-HERE.md`, load `.maestro/memory/`, and use `.maestro/framework/` as the source of truth. Complete onboarding and specification before implementation. Work in bounded vertical slices, report validation evidence, and checkpoint memory.'
    Install-PortableSkill (Join-Path $TargetRoot '.gemini/skills/vibe-code-maestro/SKILL.md')
}

switch ($Platform) {
    'codex' { Install-Codex }
    'claude' { Install-Claude }
    'lovable' { Install-Lovable }
    'mimo' { Install-Mimo }
    'cursor' { Install-Cursor }
    'gemini' { Install-Gemini }
    'all' { Install-Codex; Install-Claude; Install-Lovable; Install-Mimo; Install-Cursor; Install-Gemini }
}

@{
    framework = 'vibe-code-maestro'
    platform = $Platform
    installed_at = (Get-Date).ToUniversalTime().ToString('o')
    framework_path = '.maestro/framework'
    start_file = '.maestro/START-HERE.md'
    memory = @{
        mode = 'repository'
        path = '.maestro/memory'
        optional_semantic_provider = 'agentmemory'
    }
} | ConvertTo-Json -Depth 3 | Set-Content -Encoding UTF8 (Join-Path $MaestroRoot 'install.json')

$Python = Get-Command python -ErrorAction SilentlyContinue
if (-not $Python) { $Python = Get-Command python3 -ErrorAction SilentlyContinue }
if ($Python) {
    & $Python.Source (Join-Path $SourceRoot 'scripts/validate_installation.py') $TargetRoot $Platform
}

$PromptPlatform = if ($Platform -eq 'all') { 'codex' } else { $Platform }
Write-Host "`nVibe Code Maestro installed successfully."
Write-Host "Target: $TargetRoot"
Write-Host "Platform: $Platform"
Write-Host "Persistent memory: $MemoryRoot"
Write-Host "Next: open the TARGET folder and read .maestro/START-HERE.md"
Write-Host "Start prompt: .maestro/prompts/$PromptPlatform.md"
Write-Host "Lovable prompt: docs/LOVABLE.md"
Write-Host "Mimo prompt: docs/MIMO.md"
Write-Host "Optional semantic memory requires WSL2/macOS/Linux: .maestro/tools/install-agentmemory.sh"
