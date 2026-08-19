[CmdletBinding()]
param(
    [ValidateSet('codex','claude','lovable','mimo','cursor','gemini','all')]
    [string]$Platform = 'all',
    [string]$Target = '.',
    [ValidateSet('stable','next')]
    [string]$Channel = 'stable'
)

$ErrorActionPreference = 'Stop'
$sourceRoot = Split-Path -Parent $PSScriptRoot
$targetRoot = [System.IO.Path]::GetFullPath($Target)
$maestroRoot = Join-Path $targetRoot '.maestro'
$frameworkRoot = Join-Path $maestroRoot 'framework'
$memoryRoot = Join-Path $maestroRoot 'memory'
$toolsRoot = Join-Path $maestroRoot 'tools'
$controlRoot = Join-Path $maestroRoot 'control-plane'

function Ensure-Directory([string]$Path) {
    New-Item -ItemType Directory -Force -Path $Path | Out-Null
}
function Copy-IfMissing([string]$Source, [string]$Destination) {
    if (-not (Test-Path -LiteralPath $Destination)) {
        Ensure-Directory (Split-Path -Parent $Destination)
        Copy-Item -LiteralPath $Source -Destination $Destination
    }
}
function Write-Utf8([string]$Path, [string]$Content) {
    Ensure-Directory (Split-Path -Parent $Path)
    [System.IO.File]::WriteAllText($Path, $Content, [System.Text.UTF8Encoding]::new($false))
}
function Replace-ManagedBlock([string]$Path, [string]$Title, [string]$Body) {
    $start = '<!-- VIBE-CODE-MAESTRO:START -->'
    $end = '<!-- VIBE-CODE-MAESTRO:END -->'
    $existing = if (Test-Path -LiteralPath $Path) { Get-Content -Raw -LiteralPath $Path } else { '' }
    $pattern = '(?ms)^' + [regex]::Escape($start) + '.*?^' + [regex]::Escape($end) + '\r?\n?'
    $preserved = [regex]::Replace($existing, $pattern, '').TrimEnd()
    $block = "$start`n## $Title`n`n$Body`n$end`n"
    Write-Utf8 $Path (($preserved + "`n`n" + $block).TrimStart())
}
function Install-PortableSkill([string]$Path) {
    Write-Utf8 $Path @'
---
name: vibe-code-maestro
description: Operate the installed Vibe Code Maestro channel.
---

Read `.maestro/START-HERE.md`, then `.maestro/framework/SKILL.md`, and follow the installed channel contract.
'@
}

Ensure-Directory $targetRoot
@('tasks','reports','decisions','prompts','tools','framework') | ForEach-Object {
    Ensure-Directory (Join-Path $maestroRoot $_)
}
if (Test-Path -LiteralPath $frameworkRoot) {
    Remove-Item -Recurse -Force -LiteralPath $frameworkRoot
}
Ensure-Directory $frameworkRoot

if ($Channel -eq 'stable') {
    Ensure-Directory (Join-Path $memoryRoot 'sessions')
    Ensure-Directory (Join-Path $memoryRoot 'archive')
    $items = @('core','agents','skills','pipelines','playbooks','standards','checklists','specs','templates','prompts','adapters','integrations','tests','docs')
    foreach ($item in $items) {
        $destination = Join-Path $frameworkRoot $item
        if (Test-Path -LiteralPath $destination) { Remove-Item -Recurse -Force -LiteralPath $destination }
        Copy-Item -Recurse -LiteralPath (Join-Path $sourceRoot $item) -Destination $destination
    }
    Copy-Item (Join-Path $sourceRoot 'SKILL.md') (Join-Path $frameworkRoot 'SKILL.md') -Force
    Copy-Item (Join-Path $sourceRoot 'LICENSE') (Join-Path $frameworkRoot 'LICENSE') -Force
    Copy-IfMissing (Join-Path $sourceRoot 'specs/project.spec.example.yaml') (Join-Path $maestroRoot 'project.spec.yaml')
    Copy-IfMissing (Join-Path $sourceRoot 'specs/acceptance.md') (Join-Path $maestroRoot 'acceptance.md')
    Copy-IfMissing (Join-Path $sourceRoot 'templates/HANDOFF.md') (Join-Path $maestroRoot 'HANDOFF.md')
    Copy-IfMissing (Join-Path $sourceRoot 'project.manifest.example.yaml') (Join-Path $maestroRoot 'project.manifest.yaml')
    foreach ($file in @('reality-check.md','implementation-plan.md','risk-register.md')) {
        $path = Join-Path $maestroRoot $file
        if (-not (Test-Path $path)) { Write-Utf8 $path "# $($file.Replace('.md',''))`n`nPending first-run onboarding.`n" }
    }
    foreach ($file in @('INDEX.md','PROJECT.md','STATE.md','DECISIONS.md','LEARNINGS.md')) {
        Copy-IfMissing (Join-Path $sourceRoot "templates/memory/$file") (Join-Path $memoryRoot $file)
    }
    Copy-IfMissing (Join-Path $sourceRoot 'templates/memory/SESSION-TEMPLATE.md') (Join-Path $memoryRoot 'SESSION-TEMPLATE.md')
    Write-Utf8 (Join-Path $memoryRoot 'sessions/.gitkeep') ''
    Write-Utf8 (Join-Path $memoryRoot 'archive/.gitkeep') ''
    Copy-Item (Join-Path $sourceRoot 'scripts/memory_checkpoint.py') (Join-Path $toolsRoot 'memory_checkpoint.py') -Force
    Copy-Item (Join-Path $sourceRoot 'scripts/compact_memory.py') (Join-Path $toolsRoot 'compact_memory.py') -Force
    Copy-Item (Join-Path $sourceRoot 'installers/install-agentmemory.sh') (Join-Path $toolsRoot 'install-agentmemory.sh') -Force
    Write-Utf8 (Join-Path $maestroRoot 'START-HERE.md') @'
# Start Here - Vibe Code Maestro Stable

1. Read persistent memory under `.maestro/memory/`.
2. Verify memory against the repository and runtime.
3. Read the constitution, memory protocol, manager agent, and question engine.
4. Complete onboarding, specification, and acceptance criteria before implementation.
5. Maintain risks, validation evidence, memory, and handoff.
'@
} else {
    foreach ($item in @('core','skills','schemas')) {
        $destination = Join-Path $frameworkRoot $item
        if (Test-Path -LiteralPath $destination) { Remove-Item -Recurse -Force -LiteralPath $destination }
        Copy-Item -Recurse -LiteralPath (Join-Path $sourceRoot "v2/$item") -Destination $destination
    }
    Copy-Item (Join-Path $sourceRoot 'v2/SKILL.md') (Join-Path $frameworkRoot 'SKILL.md') -Force
    foreach ($directory in @('workstreams','evidence','handoffs')) {
        $path = Join-Path $controlRoot $directory
        Ensure-Directory $path
        if (-not (Test-Path (Join-Path $path '.gitkeep'))) { Write-Utf8 (Join-Path $path '.gitkeep') '' }
    }
    $statePath = Join-Path $controlRoot 'state.json'
    if (-not (Test-Path $statePath)) {
        Write-Utf8 $statePath @'
{
  "project": "",
  "repository": null,
  "default_branch": "main",
  "default_branch_sha": null,
  "freshness": {"verified_at": null, "requires_live_recheck": true},
  "priority_order": [],
  "active_workstreams": [],
  "next_human_decisions": [],
  "updated_at": ""
}
'@
    }
    $reservationsPath = Join-Path $controlRoot 'reservations.json'
    if (-not (Test-Path $reservationsPath)) {
        Write-Utf8 $reservationsPath "{`n  `"reservations`": [],`n  `"updated_at`": `"`"`n}`n"
    }
    Write-Utf8 (Join-Path $maestroRoot 'START-HERE.md') @'
# Start Here - Maestro Next (experimental)

This installation is for an existing repository. Do not reset project configuration or application code.

1. Establish the workspace boundary using `.maestro/framework/core/workspace-model.md`.
2. Read the smallest relevant state in `.maestro/control-plane/`.
3. Verify live repository and provider facts.
4. Resolve reservations and dependencies.
5. Compile the minimum context packet.
6. Execute within the boundary, retain evidence, and run applicable gates.
7. Write a handoff when ownership changes.

Read `.maestro/framework/SKILL.md` for the complete experimental contract.
'@
}

Write-Utf8 (Join-Path $maestroRoot 'prompts/codex.md') 'Read AGENTS.md, `.maestro/START-HERE.md`, and the installed framework skill before acting.'
Write-Utf8 (Join-Path $maestroRoot 'prompts/claude.md') 'Read CLAUDE.md, `.maestro/START-HERE.md`, and the installed framework skill before acting.'
Write-Utf8 (Join-Path $maestroRoot 'prompts/cursor.md') 'Read `.maestro/START-HERE.md` and the installed framework skill before acting.'
Write-Utf8 (Join-Path $maestroRoot 'prompts/gemini.md') 'Read GEMINI.md, `.maestro/START-HERE.md`, and the installed framework skill before acting.'
Copy-Item (Join-Path $sourceRoot 'docs/lovable-master-prompt.md') (Join-Path $maestroRoot 'prompts/lovable.md') -Force
Copy-Item (Join-Path $sourceRoot 'docs/mimo-master-prompt.md') (Join-Path $maestroRoot 'prompts/mimo.md') -Force

$managedBody = 'Read `.maestro/START-HERE.md` and `.maestro/framework/SKILL.md`; preserve existing project instructions and operate only within the verified workspace boundary.'
function Install-Codex { Replace-ManagedBlock (Join-Path $targetRoot 'AGENTS.md') 'Vibe Code Maestro' $managedBody; Install-PortableSkill (Join-Path $targetRoot '.codex/skills/vibe-code-maestro/SKILL.md') }
function Install-Claude { Replace-ManagedBlock (Join-Path $targetRoot 'CLAUDE.md') 'Vibe Code Maestro' $managedBody; Install-PortableSkill (Join-Path $targetRoot '.claude/skills/vibe-code-maestro/SKILL.md') }
function Install-Lovable { Ensure-Directory (Join-Path $targetRoot 'docs'); Copy-Item (Join-Path $sourceRoot 'docs/lovable-master-prompt.md') (Join-Path $targetRoot 'docs/LOVABLE.md') -Force }
function Install-Mimo { Ensure-Directory (Join-Path $targetRoot 'docs'); Copy-Item (Join-Path $sourceRoot 'docs/mimo-master-prompt.md') (Join-Path $targetRoot 'docs/MIMO.md') -Force }
function Install-Cursor { Write-Utf8 (Join-Path $targetRoot '.cursor/rules/maestro.mdc') "---`ndescription: Vibe Code Maestro operating rules`nalwaysApply: true`n---`nRead `.maestro/START-HERE.md` and `.maestro/framework/SKILL.md`.`n" }
function Install-Gemini { Replace-ManagedBlock (Join-Path $targetRoot 'GEMINI.md') 'Vibe Code Maestro' $managedBody; Install-PortableSkill (Join-Path $targetRoot '.gemini/skills/vibe-code-maestro/SKILL.md') }

switch ($Platform) {
    'codex' { Install-Codex }
    'claude' { Install-Claude }
    'lovable' { Install-Lovable }
    'mimo' { Install-Mimo }
    'cursor' { Install-Cursor }
    'gemini' { Install-Gemini }
    'all' { Install-Codex; Install-Claude; Install-Lovable; Install-Mimo; Install-Cursor; Install-Gemini }
}

if ((Get-Command git -ErrorAction SilentlyContinue) -and -not (Test-Path (Join-Path $targetRoot '.git'))) {
    & git -C $targetRoot init -q
}

$metadata = [ordered]@{
    framework = 'vibe-code-maestro'
    version = if ($Channel -eq 'next') { '0.2.1-lab' } else { '1' }
    channel = $Channel
    platform = $Platform
    installed_at = [DateTime]::UtcNow.ToString('yyyy-MM-ddTHH:mm:ssZ')
    framework_path = '.maestro/framework'
    control_plane_path = '.maestro/control-plane'
    start_file = '.maestro/START-HERE.md'
}
Write-Utf8 (Join-Path $maestroRoot 'install.json') (($metadata | ConvertTo-Json) + "`n")

$python = Get-Command python -ErrorAction SilentlyContinue
if ($python) {
    & $python.Source (Join-Path $sourceRoot 'scripts/validate_installation.py') $targetRoot $Platform $Channel
    if ($LASTEXITCODE -ne 0) { throw 'Installation validation failed.' }
}
Write-Host "Vibe Code Maestro installed successfully."
Write-Host "Target: $targetRoot"
Write-Host "Platform: $Platform"
Write-Host "Channel: $Channel"
