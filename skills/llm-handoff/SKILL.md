---
name: llm-handoff
description: Produzir contexto operacional preciso para continuidade por outra LLM.
version: 1.0.0
---

# LLM Handoff

## Objetivo

Produzir contexto operacional preciso para continuidade por outra LLM.

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

`artifacts/HANDOFF.md`

## Definition of Done

- saída acionável;
- decisões justificadas;
- inconsistências sinalizadas;
- critérios verificáveis;
- nenhuma afirmação externa sem evidência.
