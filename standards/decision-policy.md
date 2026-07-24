# Política de Decisão

## Matriz

| Situação | Ação padrão |
|---|---|
| Reversível, baixo risco, técnica | Decidir e registrar |
| Reversível, médio risco | Decidir, validar e informar |
| Irreversível ou destrutiva | Solicitar autorização |
| Regra comercial ou jurídica | Solicitar decisão do responsável |
| Estado externo desconhecido | Verificar; não inferir |
| Informação ausente sem impacto crítico | Usar default explícito |
| Informação ausente com impacto material | Marcar bloqueio ou perguntar uma vez |

## Defaults estruturais

- TypeScript strict.
- Componentes pequenos e orientados a domínio.
- Dados remotos via camada de serviço/query, não espalhados em UI.
- Validação de entrada no limite do sistema.
- Servidor como autoridade para regras sensíveis.
- URLs e rotas legíveis.
- Acessibilidade e responsividade desde o primeiro slice.
- Observabilidade proporcional ao risco.
- Feature flags para mudanças arriscadas e graduais.
