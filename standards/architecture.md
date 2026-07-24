# Padrão de Arquitetura

## Camadas

```text
routes/pages -> features -> domain/services -> data clients -> external systems
                    |             |
                 schemas       policies
```

## Regras

- `routes`: composição, carregamento e limites de navegação.
- `features`: UI e casos de uso de uma capacidade de negócio.
- `domain`: regras puras, tipos, cálculos e políticas.
- `data`: queries, mutations, RPCs e mapeamento de persistência.
- `shared`: componentes e utilitários realmente genéricos.
- evitar diretórios `utils` gigantes e componentes “God”.
- regras comerciais não devem morar apenas na camada visual.
- snapshots são históricos; configuração viva deve ser centralizada.

## Estrutura sugerida

```text
src/
  routes/
  features/
    <feature>/
      components/
      queries/
      mutations/
      schemas/
      services/
      types.ts
  domain/
  components/ui/
  lib/
  styles/
db/migrations/
tests/
```

## ADR obrigatório

Criar ADR quando houver:

- troca de framework ou banco;
- modelo multi-tenant;
- estratégia de autenticação;
- eventos/filas;
- armazenamento de arquivos;
- snapshots e auditoria;
- integração crítica;
- decisão com custo relevante de reversão.
