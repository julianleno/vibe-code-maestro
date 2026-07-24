# Segurança e Privacidade

## Baseline

- RLS habilitada em todas as tabelas expostas pelo cliente.
- Princípio do menor privilégio.
- Service role apenas no servidor.
- Storage privado por padrão; signed URLs com expiração.
- Validação server-side de operações sensíveis.
- Funções SQL com `search_path` explícito.
- Auditoria para ações financeiras, administrativas, importações e rollback.
- Segredos fora do repositório e do bundle do cliente.
- Dados pessoais minimizados, normalizados e com retenção definida.

## Checklist de ameaça

Avaliar:

- acesso horizontal indevido;
- elevação de privilégio;
- enumeração de IDs/tokens;
- upload malicioso;
- SQL/RPC insegura;
- XSS e conteúdo rico;
- CSRF em endpoints próprios;
- vazamento em logs;
- replay e idempotência;
- dependências vulneráveis;
- exclusão acidental ou irreversível.
