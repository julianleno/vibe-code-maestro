# RESUMO OPERACIONAL — SINGULAR HUB

> **Atualizado em:** 11 de julho de 2026  
> **Objetivo:** permitir que um novo chat continue o desenvolvimento do Singular Hub sem depender do histórico extenso da conversa anterior.  
> **Regra principal:** antes de qualquer alteração, verificar o estado real do GitHub, do Supabase e dos PRs citados. Este documento é um handoff operacional, não substitui a inspeção do código atual.

---

## 1. Prompt recomendado para iniciar o novo chat

Copiar e enviar:

```text
Use o arquivo RESUMO_SINGULAR_HUB.md como contexto operacional do projeto.

Antes de alterar qualquer coisa:
1. verifique a head atual da main;
2. verifique o status e a head do PR #16;
3. leia os arquivos alterados no PR #16;
4. confirme o CI mais recente e o preview da Vercel;
5. não faça merge sem minha autorização explícita.

Atue como líder técnico e diretor de produto do Singular Hub: direto, crítico, orientado à execução, sem inventar fatos e sem alterar regras já aprovadas sem avisar.
```

---

# 2. Contexto do negócio

## Empresa

**Singular Studio Criativo**

Operação B2B de:

- brindes personalizados;
- kits corporativos;
- camisas;
- bonés;
- agendas;
- canecas;
- papelaria personalizada;
- materiais para eventos, equipes, clientes e ações de marca.

A empresa trabalha com pedidos mínimos, geralmente entre 10 e 50 unidades, e atende Fortaleza e outras regiões do Brasil.

## Objetivo do Singular Hub

O Singular Hub deve funcionar como o sistema operacional da empresa, centralizando:

- clientes;
- propostas e orçamentos;
- pedidos;
- produção;
- oportunidades e canais;
- indicadores comerciais;
- finanças;
- importação de orçamentos antigos;
- governança de dados;
- equipe e permissões.

O sistema deve parecer um produto SaaS profissional, não um painel administrativo genérico.

## Direção estratégica

Prioridades:

1. aumentar previsibilidade comercial;
2. reduzir retrabalho;
3. acompanhar receita, margem e produção;
4. tornar propostas mais profissionais e fáceis de aprovar;
5. preservar integridade dos dados;
6. automatizar processos sem perder controle humano;
7. manter identidade visual forte da Singular.

---

# 3. Perfil de trabalho do usuário

O usuário é **Julian**.

Preferências:

- comunicação direta;
- análise crítica;
- visão de negócio;
- foco em execução;
- sem elogios vazios;
- não apresentar inferências como fatos;
- informar claramente quando algo não foi verificado;
- evitar explicações excessivas e textos genéricos;
- preferência por alterações completas, validadas e publicadas com rastreabilidade.

O assistente pode ser chamado de **Sol**.

## Regra de autorização

- Quando Julian diz explicitamente **“faça”**, **“execute”**, **“aplique”** ou equivalente, isso autoriza implementar.
- Merge em `main` deve ser tratado como uma ação separada, salvo quando Julian autorizar explicitamente publicação direta ou merge.
- O PR #16 **não deve ser mesclado sem autorização explícita**.
- Sempre validar TypeScript, lint e build antes do merge.

---

# 4. Repositório, stack e infraestrutura

## GitHub

```text
Repositório: julianleno/singular-hub
Visibilidade: privado
Branch principal: main
```

## Stack

- React
- TanStack Router / TanStack Start
- TypeScript
- TanStack Query
- Tailwind CSS
- componentes no padrão shadcn/ui
- Lucide Icons
- Supabase JS
- Vercel
- GitHub Actions
- Bun no CI

## Supabase

```text
Project ref: hpyvegdkhjojrfqkzrpa
```

Este é o projeto oficial. Não usar banco criado por Lovable.

## Lovable

Lovable pode ser usado apenas como gerador de UI/código.

Não usar:

- Lovable Cloud Database;
- banco paralelo;
- autenticação paralela;
- storage paralelo.

## Vercel

A Vercel está conectada ao repositório.

- PRs geram preview;
- `main` deve gerar produção automaticamente;
- sempre confirmar o status do deploy quando possível;
- não afirmar que produção foi publicada sem verificar.

---

# 5. Estado atual do GitHub

## `main`

Última head verificada:

```text
4590512334303fa0b79a5fa154a73a2a92b15e13
Adiciona governança às importações PDF
```

Esse commit corresponde ao merge do PR #15.

## PR #16 — prioridade atual

```text
Título: Redesenhar proposta pública com identidade Singular
URL: https://github.com/julianleno/singular-hub/pull/16
Branch: design/singular-brand-proposal
Base: main
Status: aberto
Draft: sim
Mergeable: sim
Head: 153ddd6a0cced7f0b6912435bf44a57b35a3616b
Commit: Refina proposta e aplica regras comerciais
```

Arquivos alterados no PR:

```text
src/routes/o.$token.tsx
src/styles.css
src/lib/quote-business-rules.ts
```

Validação mais recente:

- Typecheck: aprovado
- Lint: aprovado
- Build: aprovado
- CI run: 98
- Job: verify
- conclusão: success

Preview da Vercel:

```text
https://singular-hub-git-design-singular-b-1d3d95-julian-lenos-projects.vercel.app
```

Proposta usada durante a revisão:

```text
https://singular-hub-git-design-singular-b-1d3d95-julian-lenos-projects.vercel.app/o/c697fc2d46eb76988a11c2f19be3ccea9a23286daa1caaf9
```

## PR #14

```text
Título: Adicionar governança às importações de PDF
Status: aberto e draft
```

Esse PR é antigo e foi substituído pelo PR #15, que já foi mesclado.

Ação recomendada:

- verificar o diff;
- fechar como superseded, se não houver conteúdo exclusivo.

## PR #15

```text
Status: mesclado
Merge commit: 4590512334303fa0b79a5fa154a73a2a92b15e13
```

Implementou governança das importações PDF.

## PR #3

```text
Título: Permitir avatares na equipe
Status: mesclado
Merge commit: 10579c4bbade9a2ed0b5f53cea5d745fba5e83c6
```

A funcionalidade de avatares de usuários já está na `main`.

---

# 6. Processo de desenvolvimento e CI

## Fluxo preferido

1. criar branch a partir da `main`;
2. alterar arquivos;
3. criar PR draft;
4. aguardar CI;
5. corrigir TypeScript, lint e build;
6. revisar preview;
7. remover arquivos temporários;
8. pedir autorização para merge;
9. merge com squash;
10. verificar `main` e deploy.

## GitHub Actions

Workflow oficial executa:

- instalação de dependências;
- Typecheck;
- lint advisory;
- build de produção.

## Atenção

Pushes feitos por alguns conectores podem não disparar workflow `push`.

O padrão usado anteriormente foi abrir PR para disparar CI.

Não deixar no repositório:

- scripts temporários;
- workflows temporários;
- marcadores de validação;
- arquivos `noop`;
- patch runners.

---

# 7. Design System da Singular

O usuário forneceu um documento chamado:

```text
Singular Studio Criativo — Design System
```

No novo chat, procurar esse arquivo na File Library, caso seja necessário consultar o conteúdo integral.

## Fundação da marca

### Cores oficiais

```text
Brand Blue:     #0060E6
Brand Pink:     #FF4DB7
Brand Yellow:   #FFD900
Brand Obsidian: #050505
Brand White:    #FFFFFF
Navy utilizado: #0B1437
```

Observação: no início do PR #16 também foram usados `#0A4CFF` e `#FF4DB2`. A revisão mais recente aproximou o código do design system oficial com `#0060E6` e `#FF4DB7`.

## Regra de uso

- azul = confiança, tecnologia e ação principal;
- rosa = energia criativa e destaques;
- amarelo = assinatura e destaque controlado;
- navy/obsidian = contraste premium;
- não dar o mesmo peso para azul, rosa e amarelo;
- evitar visual infantil;
- evitar excesso de glassmorphism;
- evitar microcopy artificial;
- “menos brinde, mais marca”.

## Tipografia recomendada no design system

- Display: Fraunces
- UI e corpo: Inter

O projeto atualmente usa a tipografia configurada no app. Antes de adicionar Fraunces, verificar:

- bundle;
- fonte local ou Google Fonts;
- impressão;
- impacto no Hub inteiro.

## Tokens já adicionados no PR #16

Em `src/styles.css`:

- `--brand-blue`
- `--brand-pink`
- `--brand-navy`
- `--brand-canvas`
- azul como cor primária;
- rosa como accent;
- paleta de gráficos atualizada;
- sidebar atualizada;
- fundo atmosférico;
- `bg-singular-gradient`;
- `text-singular-gradient`;
- raio base alterado para `0.875rem`.

Essas mudanças afetam o sistema inteiro. Revisar rotas principais no claro e no escuro antes do merge.

---

# 8. Módulo `/clientes`

## Melhorias implementadas

- cards responsivos abaixo de `xl`;
- tabela compacta em telas grandes;
- visão comercial;
- estágios;
- métricas;
- KPIs;
- filtros;
- nome comercial e razão social;
- edição próxima ao nome;
- remoção em coluna final;
- remoção da exibição redundante de LTV;
- “Valor” renomeado para “Faturamento”.

## Logos dos clientes

Suporta:

- upload de imagem;
- URL externa;
- preview;
- substituição;
- remoção;
- normalização da imagem antes do upload.

### Compressão

Raster:

- arquivo original até 10 MB;
- maior dimensão: 512 px;
- conversão para WebP;
- qualidade progressiva;
- arquivo final até 500 KB.

SVG:

- preservado;
- limite de 250 KB.

### Exibição

Avatar/logo visual:

- contêiner de 48 px;
- sem padding interno;
- ampliação visual para compensar margens transparentes;
- fallback por iniciais.

Commits relevantes:

```text
43b3d12f137c9956f18dc8034c7b00d23d80a0d3
343234fe8ba4ac900d56469ee461db7f2bdeac25
f7f252ba299b7d9e2ea6c69eeb55a18a1838e176
```

---

# 9. Avatares de usuários

Já mesclado pelo PR #3.

## Supabase Storage

```text
Bucket: user-avatars
Privado: sim
Tipos: PNG, JPG, WEBP
Limite: 2 MB
```

Regras:

- equipe pode ler;
- administradores podem criar, alterar e excluir;
- signed URLs;
- fallback por iniciais;
- exibição no menu lateral e menu do usuário.

Migration:

```text
db/migrations/0011_user_avatars_storage.sql
```

---

# 10. Dashboard `/dashboard`

O dashboard foi transformado em um centro de comando comercial e operacional.

Commit principal:

```text
e8dec31c49b34304135721f4ef710d18d10e11c9
```

## Conteúdo

- faturamento versus meta;
- percentual atingido;
- valor restante;
- projeção mensal;
- ritmo diário necessário;
- pipeline bruto;
- pipeline ponderado;
- conversão;
- ticket médio;
- pedidos;
- produção em risco;
- propostas abertas;
- alertas;
- funil;
- performance por canal;
- saúde da produção;
- top clientes;
- receita versus meta.

## Metas

Tabela:

```text
business_goals
```

Meta inicial:

```text
Receita: R$ 30.000
Pedidos: 20
Conversão: 25%
```

Migration:

```text
db/migrations/0012_business_goals.sql
```

## Gráfico no dark mode

Contraste corrigido.

Commit:

```text
930b678e934e9b5d85ec595fbd3c6bdb3ab62235
```

---

# 11. Rota `/lancamentos`

Foi reformulada como central comercial mensal.

Commit principal:

```text
e894e28ce189d0af1e702645c020fe0a13f1a0a4
```

## Indicadores

- mensagens;
- leads;
- qualificados;
- pipeline;
- receita atribuída;
- propostas;
- pedidos;
- conversão.

## Oportunidades

- busca;
- filtro por canal;
- filtro por etapa;
- edição;
- exclusão;
- atualização de etapa;
- valor potencial;
- campanha;
- produto;
- layout responsivo.

## Métricas agregadas

Separadas das oportunidades individuais para evitar duplicidade conceitual.

---

# 12. Módulo `/financas`

Criado e restrito a administradores.

Commit principal:

```text
e894e28ce189d0af1e702645c020fe0a13f1a0a4
```

Migration:

```text
db/migrations/0013_finance_module.sql
```

## Conceitos

O módulo usa:

- competência;
- vencimento;
- data de realização;
- entradas;
- saídas;
- pendente;
- realizado;
- cancelado;
- categorias;
- recorrência;
- vínculo com pedidos.

## Indicadores

- entradas;
- saídas;
- lucro bruto;
- lucro líquido;
- margem líquida;
- custos diretos;
- despesas fixas;
- contas a receber;
- contas a pagar;
- fluxo de caixa;
- composição das despesas.

## Categorias iniciais

- Vendas
- Outras receitas
- Matéria-prima e produção
- Fretes e entregas
- Taxas e impostos
- Marketing e anúncios
- Softwares e assinaturas
- Aluguel e estrutura
- Folha e prestadores
- Manutenção e equipamentos
- Outras despesas

## Integração com pedidos

- pedidos geram entradas;
- alteração do pedido atualiza a movimentação;
- proteção contra duplicidade;
- vendas sincronizadas não podem ser excluídas manualmente;
- botão de sincronização.

Na implantação inicial, 23 pedidos históricos foram importados.

---

# 13. Parcelamentos de máquinas

Commit principal:

```text
7e2e3be3c0524f4750698789458f198e8b510991
```

Migration:

```text
db/migrations/0014_machinery_installments.sql
```

## Estrutura

Tabela:

```text
finance_installment_plans
```

Campos vinculados em transações:

```text
installment_plan_id
installment_number
installment_total
```

## Funcionalidades

- cadastro da máquina;
- fornecedor;
- total de parcelas;
- parcela atual;
- valor por parcela;
- vencimento;
- pago/pendente;
- saldo;
- progresso;
- geração de parcelas;
- registrar pagamento;
- desfazer pagamento;
- cancelar parcelas futuras;
- concluir contrato.

Exemplo:

```text
Parcela atual: 10 de 15
```

---

# 14. Importação de orçamentos PDF

Rota:

```text
/importacoes/orcamentos-pdf
```

O módulo evoluiu em quatro fases.

## Fase 1 — hardening operacional

Commit:

```text
11f37d5fdbc06a9d40e00c69d978fffb6ad55a8d
```

Migration:

```text
db/migrations/0015_pdf_import_phase1_hardening.sql
```

Implementou:

- contadores corretos;
- pendências de produtos, preços, termos e clientes;
- bloqueio de aplicação incompleta;
- merge transacional;
- idempotência;
- status real do lote;
- CPF/CNPJ com dígitos verificadores;
- WhatsApp normalizado;
- paginação server-side;
- tratamento de erros.

## Fase 2 — redesign operacional

Commit:

```text
48299907c0f92857fdadffd12eff761eddcb6f5f
```

Implementou:

- workflow guiado;
- progresso;
- filas de bloqueio;
- filtros de risco;
- confiança em porcentagem;
- combobox pesquisável;
- visualização do JSON;
- responsividade.

## Fase 3 — importação real de PDF

Commit:

```text
63a0495b74eb7ab79200feb9d07fa66f5f6f648b
```

Migrations:

```text
0016_pdf_import_phase3_storage.sql
0017_pdf_import_phase3_processing_rpcs.sql
0018_pdf_import_phase3_finalize_rpc.sql
```

Bucket:

```text
pdf-imports
```

Configuração:

- privado;
- admin;
- 25 MB;
- PDF;
- checksum SHA-256;
- signed URL;
- prevenção de duplicidade.

Tabela:

```text
pdf_import_pages
```

Pipeline:

- upload;
- leitura com PDF.js;
- extração página por página;
- armazenamento do texto;
- candidatos de produtos;
- candidatos de preços;
- clientes;
- termos;
- itens;
- reprocessamento;
- progresso.

Limitação:

- depende da camada textual;
- PDF escaneado precisa de OCR;
- processamento ocorre no navegador.

## Fase 4 — governança

Commit em `main`:

```text
4590512334303fa0b79a5fa154a73a2a92b15e13
```

PR mesclado:

```text
#15
```

Implementou:

- `pdf_import_audit_log`;
- `pdf_import_applied_changes`;
- auditoria por lote;
- snapshots;
- relatórios;
- duplicidade entre lotes;
- rollback controlado;
- bloqueios de dependência;
- exportação JSON;
- usuário responsável;
- restauração ou desativação segura.

RPCs relevantes:

```text
execute_pdf_import_batch_v3
get_pdf_import_cross_batch_duplicates
preview_pdf_import_rollback
rollback_pdf_import_batch
```

Atenção:

- verificar no diretório `db/migrations` os nomes exatos das migrations de governança antes de criar a próxima migration;
- o PR #14 antigo ainda está aberto e deve ser revisado/fechado.

---

# 15. Proposta comercial pública — estado do PR #16

Rota:

```text
/o/$token
```

Exemplo de token usado:

```text
c697fc2d46eb76988a11c2f19be3ccea9a23286daa1caaf9
```

## Direção aprovada

- identidade azul → rosa;
- proposta premium;
- pouco texto;
- informação comercial objetiva;
- não usar “IA slop”;
- não usar headlines genéricos;
- manter visual profissional e bonito;
- foco em aprovação.

## Header atual no PR

Mantém:

- gradiente azul → rosa;
- padrão de pontos;
- logo;
- e-mail;
- WhatsApp;
- selo “Proposta comercial”;
- validade;
- bloco com número da proposta;
- saudação em `h3`;
- cartão de cliente sobreposto.

Saudação:

```text
Olá, {nome do contato}.
Muito obrigado pelo contato!
Segue o orçamento solicitado:
```

Regras:

- usa `contact_name`;
- se não houver, usa nome do cliente;
- se nenhum existir, omite “Olá...”;
- evita headline publicitário genérico.

## Cliente

- mostra nome;
- mostra apenas CNPJ;
- sem CNPJ, o campo fica vazio;
- não mostrar “CPF/CNPJ não informado”;
- contato pode aparecer como `—` se vazio;
- validade vem da proposta.

## Produção

No cartão superior:

```text
7 a 10 dias úteis após confirmação do pedido.
```

O componente permite quebra de linha.

Atenção:

- o cartão superior força esse texto;
- o card de termos usa `q.production_deadline_text` quando existe;
- decidir se a regra deve ser totalmente fixa ou se o prazo variável deve prevalecer.

## Escopo

Restaurado:

```text
Escopo comercial
O que está incluído
```

## Imagens de produto

Desktop:

```text
144 × 144 px
object-contain
```

Mobile:

```text
altura de 160 px
largura total
object-contain
```

## Total

Atual:

```text
Fundo: #FFF0A8
Borda: #E9CF62
Texto escuro
```

O usuário pediu um amarelo mais forte que:

```text
border-[#e6dfce] bg-[#faf6ec]
```

## Formas de pagamento

O estilo anterior foi restaurado:

- card recomendado com borda gradiente;
- badge;
- ícone;
- descrição;
- valor;
- “Sem juros”;
- economia;
- total;
- duas colunas.

Foi removido somente o texto:

```text
Opções pensadas para equilibrar fluxo de caixa, prazo e melhor condição comercial.
```

## Dados bancários

Ficam imediatamente após as formas de pagamento.

## Pix

Exibição:

```text
41.309.292.0001-26
```

Ao copiar:

```text
41309292000126
```

A função remove caracteres não numéricos.

## CTA

Botão:

```text
Aprovar via WhatsApp
```

Cor:

```text
#25D366
Hover: #1EBE5D
```

## Logo

O usuário enviou no chat:

```text
logo-singular-white.svg
```

Esse arquivo foi anexado à conversa, mas não foi versionado no GitHub.

O código atual continua usando:

```text
https://www.sejasingular.com/assets/logo-singular-brand.svg
```

com `brightness-0 invert` sobre fundo escuro.

Próxima ação recomendada:

1. localizar `logo-singular-white.svg` na File Library ou pedir novo upload;
2. salvar em algo como:

```text
public/brand/logo-singular-white.svg
```

3. atualizar o header para usar o arquivo local;
4. manter a logo colorida no rodapé, se necessário;
5. remover dependência externa para a marca principal.

---

# 16. Regras comerciais definidas pelo usuário

Arquivo criado no PR #16:

```text
src/lib/quote-business-rules.ts
```

## Constantes

```text
validityBusinessDays: 7
productionDepositPercent: 60
productionBalancePercent: 40
freeFortalezaDeliveryMinimum: 5000
maxInterestFreeInstallments: 10
```

## Parcelamento sem juros

Função:

```text
getInterestFreeInstallments(total)
```

Regra atual:

| Total | Sem juros |
|---:|---:|
| abaixo de R$ 2.000 | 1x |
| R$ 2.000 a R$ 2.999 | 2x |
| R$ 3.000 a R$ 3.999 | 3x |
| R$ 4.000 a R$ 4.999 | 4x |
| ... | ... |
| R$ 10.000 ou mais | 10x |

Parcelas acima do limite:

- juros da operadora.

## Pagamento

Texto público revisado:

- Pix à vista com desconto;
- depósito;
- transferência;
- boleto;
- cartão;
- não trabalhamos com pagamento faturado;
- 60% para iniciar;
- 40% até a entrega.

A regra interna de aceitar faturado para algumas empresas **não deve aparecer ao cliente**.

## Entrega

Regra:

```text
pedidos a partir de R$ 5.000 → entrega gratuita em Fortaleza
abaixo → taxa de deslocamento por distância
outros estados → cálculo por peso e dimensões
```

## Urgência

Função atual:

```text
getUrgencyPriceMultiplier(productionBusinessDays)
```

Multiplicadores:

| Prazo | Multiplicador |
|---:|---:|
| 7 dias ou mais | 1.00 |
| 5–6 dias | 1.08 |
| 3–4 dias | 1.15 |
| até 2 dias | 1.25 |

A taxa é interna e deve ser diluída no preço dos produtos.

Nunca mostrar explicitamente ao cliente:

- “taxa de urgência”;
- percentual;
- multiplicador;
- linha separada.

## Texto gramatical revisado

### Pagamento

```text
O pagamento poderá ser realizado via Pix à vista com desconto, depósito bancário, transferência, boleto ou cartão de crédito.

Para pedidos abaixo de R$ 2.000, o pagamento no cartão poderá ser realizado em 1 vez sem juros ou parcelado com os juros da operadora.

Para valores maiores, o limite de parcelas sem juros acompanha a faixa do pedido, até o máximo de 10 vezes. Parcelamentos acima desse limite estarão sujeitos aos juros da operadora.

Não trabalhamos com pagamento faturado.

A produção será iniciada após a confirmação do pagamento de 60% do valor total do pedido. Os 40% restantes deverão ser quitados até a entrega do material.
```

### Termos gerais

```text
Quaisquer dúvidas poderão ser esclarecidas por e-mail ou telefone. Os dados de contato estão disponíveis no início desta proposta.

Prazo de entrega: {dado variável} dias úteis.

O prazo de produção será contado a partir da confirmação do pagamento.

A viabilidade de pedidos com prazo reduzido será analisada pela equipe.

Caso seja necessária a entrega dos produtos, será cobrada uma taxa de deslocamento calculada conforme a distância, em quilômetros.

Para pedidos a partir de R$ 5.000, a entrega em Fortaleza é gratuita.

O frete para outros estados será calculado conforme o peso e as dimensões dos produtos e deverá ser pago junto com os 40% restantes, antes do envio.

Esta proposta é válida por 7 dias úteis. Após esse prazo, será necessário solicitar uma nova proposta.
```

---

# 17. Ponto técnico crítico das regras comerciais

No estado atual do PR #16, as regras são usadas como fallback:

```text
q.payment_terms_snapshot || paymentTerms
q.general_terms_snapshot || generalTerms
```

Consequência:

- propostas que já possuem snapshot antigo continuarão mostrando o snapshot antigo;
- as novas regras não substituem automaticamente dados armazenados;
- o módulo de criação/edição de propostas ainda precisa usar essas regras ao gerar os snapshots;
- o banco ainda pode conter validade e prazo diferentes;
- o cálculo interno de urgência ainda não foi conectado ao preço dos itens;
- a entrega gratuita ainda não está conectada ao cálculo real do frete;
- o limite de parcelas sem juros está ajustando a apresentação do card público, mas deve ser integrado à geração das opções de pagamento.

## Próxima implementação correta

1. localizar onde propostas são criadas e editadas;
2. localizar onde `payment_terms_snapshot` e `general_terms_snapshot` são gerados;
3. centralizar as regras;
4. aplicar regras no momento da criação;
5. preservar snapshots antigos para auditoria;
6. adicionar opção explícita para regenerar termos;
7. implementar urgência no cálculo interno dos itens;
8. implementar entrega Fortaleza no cálculo de frete;
9. validar o endereço da entrega;
10. testar faixas de R$ 1.999, R$ 2.000, R$ 2.999, R$ 3.000, R$ 9.999 e R$ 10.000.

---

# 18. Supabase — pontos importantes

## Segurança

- RLS deve permanecer habilitada;
- funções devem ter `search_path` definido;
- grants devem ser mínimos;
- RPCs administrativas devem validar perfil;
- arquivos privados devem usar signed URL;
- não expor dados financeiros a usuários não administradores.

## Leaked Password Protection

Ainda pode depender de configuração manual no dashboard do Supabase.

Verificar no novo chat antes de afirmar que está habilitado.

## Tipagem

O projeto ainda possui alguns usos de:

```ts
supabase as any
supabase.rpc as any
```

Não bloquear entregas por isso, mas priorizar tipagem gradual em módulos novos.

---

# 19. Dados de clientes e normalização

Regras usadas anteriormente:

- `clients.company` pode ser derivado de `bling_code` textual;
- `bling_code` somente numérico, como `001`, deve ser ignorado;
- `name` e `company` em Title Case;
- sufixos empresariais em caixa alta;
- `de` e `e` em minúsculas quando isolados;
- `E` no início permanece maiúsculo.

Sufixos:

```text
LTDA
LTD
EPP
ME
MEI
EIRELI
SPE
SLU
SCP
SA
S/A
S.A.
```

---

# 20. Commits principais já publicados

```text
88debe82656a2a3730c893feb9494c9a78d62106 — hardening inicial
10579c4bbade9a2ed0b5f53cea5d745fba5e83c6 — avatares de usuários
43b3d12f137c9956f18dc8034c7b00d23d80a0d3 — logo externa e otimização
343234fe8ba4ac900d56469ee461db7f2bdeac25 — ampliar logos de clientes
f7f252ba299b7d9e2ea6c69eeb55a18a1838e176 — escala visual das logos
e8dec31c49b34304135721f4ef710d18d10e11c9 — dashboard executivo
e894e28ce189d0af1e702645c020fe0a13f1a0a4 — lançamentos e finanças
7e2e3be3c0524f4750698789458f198e8b510991 — parcelas de máquinas
930b678e934e9b5d85ec595fbd3c6bdb3ab62235 — contraste do dashboard
11f37d5fdbc06a9d40e00c69d978fffb6ad55a8d — importação PDF fase 1
48299907c0f92857fdadffd12eff761eddcb6f5f — importação PDF fase 2
63a0495b74eb7ab79200feb9d07fa66f5f6f648b — importação PDF fase 3
4590512334303fa0b79a5fa154a73a2a92b15e13 — importação PDF fase 4
```

PR #16, ainda não publicado:

```text
153ddd6a0cced7f0b6912435bf44a57b35a3616b
```

---

# 21. Próximas ações recomendadas

## Prioridade 1 — finalizar PR #16

1. abrir preview;
2. revisar desktop;
3. revisar mobile;
4. revisar impressão;
5. conferir logo;
6. conferir CNPJ vazio;
7. conferir nome de contato;
8. conferir prazo;
9. conferir Pix copiado;
10. conferir cards de pagamento;
11. conferir amarelo;
12. conferir CTA WhatsApp;
13. corrigir detalhes;
14. pedir autorização para merge.

## Prioridade 2 — versionar logo branca

- localizar o SVG enviado;
- adicionar ao repositório;
- remover dependência do logo externo no header.

## Prioridade 3 — integrar regras no criador de propostas

- snapshots;
- validade;
- parcelamento;
- urgência;
- frete;
- entrega grátis;
- testes por faixa.

## Prioridade 4 — auditoria visual do Hub

Como `src/styles.css` do PR #16 altera tokens globais, revisar:

- login;
- sidebar;
- dashboard;
- clientes;
- propostas;
- pedidos;
- produção;
- lançamentos;
- finanças;
- equipe;
- importações;
- claro;
- escuro.

## Prioridade 5 — fechar PR obsoleto

- revisar e fechar PR #14 como superseded pelo #15.

---

# 22. Checklist antes de qualquer merge do PR #16

- [ ] `main` não avançou de forma conflitante
- [ ] PR está mergeable
- [ ] Typecheck passou
- [ ] lint passou
- [ ] build passou
- [ ] preview Vercel está Ready
- [ ] desktop revisado
- [ ] mobile revisado
- [ ] impressão revisada
- [ ] logo correta
- [ ] CNPJ condicional
- [ ] nome do contato correto
- [ ] Pix copia somente números
- [ ] WhatsApp verde
- [ ] termos sem duplicidade
- [ ] regras internas não expostas
- [ ] nenhum arquivo temporário
- [ ] autorização explícita de Julian para merge

---

# 23. Arquivos anexados relevantes

Procurar na File Library:

```text
logo-singular-white.svg
Singular Studio Criativo — Design System
capturas da proposta com marcações em vermelho
capturas da proposta com marcações em verde
```

Esses arquivos não devem ser presumidos como presentes no filesystem do novo chat. Usar File Library ou solicitar reupload.

---

# 24. Conduta esperada no novo chat

- Não repetir toda a história.
- Não alterar funcionalidades já aprovadas sem necessidade.
- Não chamar texto genérico de “premium”.
- Mostrar alterações concretas.
- Priorizar UX, conversão, consistência e integridade.
- Verificar o código antes de afirmar.
- Verificar estado atual de GitHub e Supabase.
- Fazer uma alteração por objetivo.
- Não misturar mudanças estruturais com cosméticas sem explicar.
- Preservar os dados existentes.
- Não mesclar PR sem autorização.
- Sempre informar commit, PR, CI e deploy quando aplicável.

---

## Fim do handoff

Primeira tarefa recomendada no novo chat:

```text
Verifique o PR #16, abra os três arquivos alterados e confirme se o preview mais recente corresponde ao commit 153ddd6a0cced7f0b6912435bf44a57b35a3616b. Depois, faça uma revisão visual e técnica da proposta antes de sugerir o merge.
```
