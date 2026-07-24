# Estratégia de Testes

## Pirâmide orientada a risco

- funções puras e regras comerciais: testes unitários;
- queries, mutations, RPCs e policies: integração;
- fluxos que geram receita, alteram dados ou concedem acesso: E2E;
- componentes visuais críticos: teste de estados + revisão em preview.

## Casos-limite obrigatórios

- fronteiras de faixas de preço e quantidade;
- datas, timezone e vencimento;
- ausência de dados opcionais;
- duplicidade e reprocessamento;
- papel autorizado e não autorizado;
- mobile estreito;
- rede lenta/erro;
- reenvio de ação;
- arquivos grandes ou inválidos;
- migração com dados históricos.
