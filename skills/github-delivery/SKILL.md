---
name: github-delivery
description: Conduzir branch, commits, PR, CI, preview, release e rollback.
version: 1.0.0
---

# GitHub Delivery

## Objetivo

Conduzir branch, commits, PR, CI, preview, release e rollback.

## Entradas mínimas

- `project.manifest.yaml`;
- estado real do repositório;
- artefatos já produzidos;
- restrições verificadas.

## Processo

1. Ler contexto e identificar fatos versus lacunas.
2. Aplicar defaults do Singular Development OS.
3. Priorizar decisões de alto impacto.
4. Produzir solução específica, não genérica.
5. Validar contra os padrões e checklists relevantes.
6. Registrar riscos, decisões e pendências.

## Saída obrigatória

`artifacts/release-report.md`

## Definition of Done

- saída acionável;
- decisões justificadas;
- inconsistências sinalizadas;
- critérios verificáveis;
- nenhuma afirmação externa sem evidência.
