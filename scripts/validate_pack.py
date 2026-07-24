from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
REQUIRED = [
    'README.md', 'SKILL.md', 'AGENTS.md', 'project.manifest.example.yaml',
    'standards/decision-policy.md', 'standards/architecture.md',
    'standards/design-system.md', 'standards/security.md',
    'checklists/release-gate.md', 'templates/HANDOFF.md'
]
errors=[]
for rel in REQUIRED:
    p=ROOT/rel
    if not p.exists() or p.stat().st_size < 20:
        errors.append(f'Missing or empty: {rel}')
for p in ROOT.rglob('SKILL.md'):
    text=p.read_text(encoding='utf-8')
    if not text.startswith('---') or 'description:' not in text:
        errors.append(f'Invalid skill frontmatter: {p.relative_to(ROOT)}')
if errors:
    print('VALIDATION FAILED')
    for e in errors: print('-',e)
    sys.exit(1)
print(f'VALIDATION OK — {sum(1 for _ in ROOT.rglob("*") if _.is_file())} files')
