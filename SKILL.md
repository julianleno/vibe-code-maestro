---
name: singular-development-os
description: Mega skill para iniciar e conduzir projetos web completos com defaults fortes, arquitetura verificável, design system, Supabase seguro, GitHub flow, QA, deploy e handoff. Use em sites, landing pages, SaaS, dashboards e sistemas internos.
version: 1.0.0
license: MIT
---

# Singular Development OS — Mega Skill

## 1. Missão

Transformar uma ideia, briefing ou código existente em um produto digital implementado com clareza de negócio, arquitetura sustentável, identidade visual consistente, segurança, qualidade e rastreabilidade.

Esta skill deve reduzir perguntas, não reduzir rigor.

## 2. Ordem obrigatória de leitura

1. `AGENTS.md`
2. `project.manifest.yaml` ou `project.manifest.example.yaml`
3. `standards/decision-policy.md`
4. playbook correspondente ao tipo de projeto
5. skills especializadas necessárias
6. checklists do estágio atual

## 3. Contrato de execução

O agente deve:

- verificar repositório, branches, PRs, banco, migrations, CI e deploy antes de afirmar estado;
- distinguir fato verificado, inferência, decisão e pendência;
- evitar perguntas quando defaults seguros resolvem a questão;
- pedir autorização explícita para ações destrutivas, merge em branch protegida, publicação irreversível e mudanças de dados;
- preservar dados e compatibilidade por padrão;
- trabalhar em mudanças pequenas, coesas e rastreáveis;
- validar typecheck, lint, testes e build antes de recomendar merge;
- documentar decisões arquiteturais relevantes em ADR;
- produzir handoff operacional ao encerrar um ciclo importante.

## 4. Protocolo universal de bootstrap

### Fase 0 — Reality Check

Inspecione o estado real:

- árvore do repositório;
- `package.json` e lockfile;
- framework e versões;
- scripts disponíveis;
- variáveis de ambiente esperadas;
- branch atual, alterações locais e remotes;
- PRs e CI, quando conectores estiverem disponíveis;
- migrations e schema atual;
- serviços externos;
- deploy e previews;
- documentos existentes.

Saída obrigatória: `artifacts/reality-check.md`.

### Fase 1 — Product Frame

Defina:

- problema;
- público;
- resultado esperado;
- proposta de valor;
- ação principal;
- escopo do MVP;
- não-objetivos;
- riscos;
- métricas.

Saída obrigatória: `artifacts/project-brief.md`.

### Fase 2 — System Design

Defina:

- arquitetura;
- módulos;
- modelo de dados;
- autenticação e autorização;
- integrações;
- fluxos críticos;
- fronteiras cliente/servidor;
- estratégia de erros e observabilidade;
- riscos e ADRs.

Saída obrigatória: `artifacts/architecture.md`.

### Fase 3 — Experience Design

Defina:

- mapa de páginas;
- jornada principal;
- hierarquia de conteúdo;
- design tokens;
- componentes;
- responsividade;
- acessibilidade;
- estados vazios, carregamento, erro e sucesso.

Saídas obrigatórias:

- `artifacts/ux-flow.md`
- `artifacts/design-contract.md`

### Fase 4 — Delivery Plan

Quebre o trabalho em slices verticais entregáveis. Cada slice deve conter interface, lógica, dados, validação e critério de aceite.

Saída obrigatória: `artifacts/implementation-plan.md`.

### Fase 5 — Implementation Loop

Para cada slice:

1. confirmar pré-condições;
2. implementar a menor solução completa;
3. testar localmente;
4. revisar segurança e acessibilidade;
5. atualizar documentação;
6. registrar limitações reais;
7. criar commit coeso;
8. abrir ou atualizar PR draft;
9. verificar CI e preview.

### Fase 6 — Release Gate

Aplicar `checklists/release-gate.md`. Nenhuma aprovação baseada apenas em “parece funcionar”.

### Fase 7 — Handoff

Gerar `artifacts/HANDOFF.md` com:

- contexto do produto;
- estado verificado;
- arquitetura;
- decisões;
- alterações;
- migrations;
- riscos;
- pendências;
- URLs e identificadores úteis;
- próxima ação recomendada;
- checklist antes do próximo merge.

## 5. Roteamento por tipo de projeto

| Projeto | Playbook principal |
|---|---|
| Landing page | `playbooks/landing-page.md` |
| Site institucional | `playbooks/marketing-site.md` |
| SaaS / dashboard | `playbooks/saas-app.md` |
| Sistema interno | `playbooks/internal-system.md` |
| Migração / legado | `playbooks/legacy-modernization.md` |

## 6. Skills especializadas

Carregue somente quando necessário, mas os padrões continuam válidos mesmo sem chamada explícita:

- `skills/product-discovery/SKILL.md`
- `skills/technical-architecture/SKILL.md`
- `skills/design-direction/SKILL.md`
- `skills/frontend-engineering/SKILL.md`
- `skills/supabase-backend/SKILL.md`
- `skills/security-privacy/SKILL.md`
- `skills/qa-validation/SKILL.md`
- `skills/github-delivery/SKILL.md`
- `skills/performance-seo/SKILL.md`
- `skills/llm-handoff/SKILL.md`

## 7. Política de decisões automáticas

O agente pode decidir sem perguntar:

- organização de pastas;
- nomes técnicos internos;
- componentes reutilizáveis;
- estados de loading/error/empty;
- responsividade e acessibilidade padrão;
- abordagem de testes proporcional ao risco;
- melhorias de tipagem sem quebra;
- pequenas correções de UI coerentes com o design system.

O agente deve solicitar decisão ou autorização quando houver:

- mudança de escopo comercial;
- preço, pagamento, contrato ou política pública;
- remoção ou transformação destrutiva de dados;
- troca de stack principal;
- dependência paga relevante;
- alteração de autenticação, papéis ou permissões;
- merge em branch protegida;
- publicação em produção;
- uso de ativo, marca ou dado sem licença clara.

## 8. Definition of Done global

Uma entrega só está concluída quando:

- critérios de aceite estão atendidos;
- TypeScript/typecheck passa;
- lint não possui falhas bloqueadoras;
- testes relevantes passam;
- build de produção passa;
- fluxo principal foi validado em desktop e mobile;
- estados vazios, loading e erro existem;
- acessibilidade básica foi verificada;
- RLS/autorização foi validada quando há dados;
- migrations são reversíveis ou possuem plano de recuperação;
- documentação e handoff refletem o estado real;
- nenhum segredo ou arquivo temporário foi versionado;
- CI e preview foram verificados quando disponíveis.

## 9. Regra de comunicação

Relatórios devem priorizar:

1. veredito;
2. evidências;
3. risco;
4. ação recomendada;
5. estado de validação.

Não usar linguagem de certeza quando não houve verificação.
