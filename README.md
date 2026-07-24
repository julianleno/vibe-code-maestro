[Português (Brasil)](README.md) | [English](README.en-EN.md)

# Vibe Code Maestro

**Um sistema operacional de desenvolvimento para IAs.** Instale em um projeto, descreva a ideia e a IA passa a trabalhar como gerente de produto, arquitetura, UI/UX, engenharia, QA, segurança e release — com especificação, memória persistente, testes e CI/CD.

> Você não precisa entender a estrutura inteira. Escolha sua ferramenta, copie o comando e depois cole o prompt indicado.

## O que o Maestro resolve

Sem processo, uma IA tende a começar a programar cedo demais, esquecer decisões quando a conversa cresce e declarar trabalho concluído sem evidência. O Maestro força este fluxo:

```text
memória → inspeção → perguntas simples → especificação → arquitetura → UX
→ scaffold → implementação em partes completas → testes → segurança
→ checkpoint de memória → CI/CD → release → handoff
```

## O que o instalador faz

Ao executar o bootstrap, ele:

1. instala o cérebro completo em `.maestro/framework/`;
2. cria especificação, aceite, plano, riscos e handoff;
3. cria memória persistente em `.maestro/memory/`;
4. configura Codex, Claude, Lovable, Mimo, Cursor ou Gemini;
5. preserva `AGENTS.md`, `CLAUDE.md` e outras instruções existentes;
6. cria prompts prontos para copiar e colar;
7. valida automaticamente se a instalação ficou completa.

---

# O caminho mais fácil

## Opção A — mande a própria IA instalar

No Codex ou Claude Code, abra o projeto onde quer trabalhar e cole:

```text
Retrieve and follow the instructions at:
https://raw.githubusercontent.com/julianleno/vibe-code-maestro/main/INSTALL_FOR_AGENTS.md

Install Vibe Code Maestro in this repository for my current coding agent.
Do not edit application code during installation.
```

A IA deve instalar, validar e mostrar o próximo prompt.

## Opção B — instale manualmente para todas as ferramentas

### macOS, Linux ou Git Bash

```bash
git clone https://github.com/julianleno/vibe-code-maestro.git
cd vibe-code-maestro
./installers/bootstrap.sh all ../meu-projeto
```

### Windows PowerShell

```powershell
git clone https://github.com/julianleno/vibe-code-maestro.git
cd vibe-code-maestro
powershell -ExecutionPolicy Bypass -File .\installers\bootstrap.ps1 all ..\meu-projeto
```

**Depois abra `meu-projeto` na IA. Não abra a pasta `vibe-code-maestro`.**

---

# Codex — passo a passo

## 1. Instale

### macOS, Linux ou Git Bash

```bash
git clone https://github.com/julianleno/vibe-code-maestro.git
cd vibe-code-maestro
./installers/bootstrap.sh codex ../meu-projeto
```

### Windows PowerShell

```powershell
git clone https://github.com/julianleno/vibe-code-maestro.git
cd vibe-code-maestro
powershell -ExecutionPolicy Bypass -File .\installers\bootstrap.ps1 codex ..\meu-projeto
```

## 2. Abra a pasta certa

No Codex, abra:

```text
meu-projeto
```

Não abra:

```text
vibe-code-maestro
```

## 3. Cole este prompt

```text
Inicialize o Vibe Code Maestro neste repositório.
Leia AGENTS.md e .maestro/START-HERE.md.
Carregue a memória persistente antes de agir.
Inspecione o projeto antes de escrever código.
Faça somente as perguntas ainda necessárias, em linguagem simples.
Quando eu não souber uma decisão técnica, recomende o padrão mais seguro e simples.
Crie a especificação e os critérios de aceite antes do scaffold.
Antes de encerrar, atualize a memória e deixe a próxima ação exata.

Minha ideia: descreva aqui o que você quer criar.
```

## 4. Responda às perguntas

Você pode responder normalmente ou dizer:

```text
Não sei. Decida por mim usando o padrão recomendado.
```

## 5. Aprove a especificação

Quando o Codex apresentar o resumo:

```text
Especificação aprovada. Faça o scaffold e implemente a primeira vertical slice completa. Execute os testes aplicáveis, atualize a memória persistente e mostre as evidências antes de marcar como concluído.
```

---

# Claude Code — passo a passo

## 1. Instale

```bash
git clone https://github.com/julianleno/vibe-code-maestro.git
cd vibe-code-maestro
./installers/bootstrap.sh claude ../meu-projeto
```

No Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\installers\bootstrap.ps1 claude ..\meu-projeto
```

## 2. Abra `meu-projeto` no Claude Code

## 3. Cole

```text
Inicialize o Vibe Code Maestro.
Leia CLAUDE.md e .maestro/START-HERE.md.
Carregue a memória persistente e verifique se ela combina com o repositório atual.
Atue como gerente dos agentes especialistas.
Faça somente as perguntas ainda necessárias e use linguagem simples.
Não implemente antes de criar especificação, critérios de aceite e plano da primeira entrega completa.
Antes de encerrar, atualize memória, handoff e próxima ação.

Minha ideia: descreva aqui o que você quer criar.
```

O instalador cria:

```text
CLAUDE.md
.claude/skills/vibe-code-maestro/SKILL.md
.maestro/
```

---

# Lovable — passo a passo

Lovable usa um fluxo de conversa diferente de Codex e Claude. O Maestro gera um prompt mestre pronto.

## 1. Instale

```bash
./installers/bootstrap.sh lovable ../meu-projeto
```

No Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\installers\bootstrap.ps1 lovable ..\meu-projeto
```

## 2. Abra

```text
meu-projeto/docs/LOVABLE.md
```

## 3. Copie todo o conteúdo

Cole como primeira mensagem no Lovable e substitua:

```text
Project idea: REPLACE THIS TEXT.
```

pela ideia real.

## 4. Memória no Lovable

Quando o projeto estiver conectado ao GitHub, mantenha `.maestro/memory/` versionada. O prompt instrui o Lovable a ler e atualizar esses arquivos. Se ele não conseguir editá-los, deverá entregar o conteúdo atualizado para você salvar.

---

# Mimo Build — passo a passo

Mimo também usa um fluxo orientado por conversa. O Maestro gera um prompt específico.

## 1. Instale

```bash
./installers/bootstrap.sh mimo ../meu-projeto
```

No Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\installers\bootstrap.ps1 mimo ..\meu-projeto
```

## 2. Abra

```text
meu-projeto/docs/MIMO.md
```

## 3. Copie tudo e cole como primeira mensagem no Mimo

Substitua a ideia no final do prompt.

## 4. Memória no Mimo

Quando o Mimo não puder ler os arquivos do repositório diretamente, cole no início de uma nova conversa:

```text
.maestro/memory/PROJECT.md
.maestro/memory/STATE.md
```

Ao terminar, peça para ele devolver `STATE.md`, novas decisões e o checkpoint da sessão atualizados.

---

# Memória persistente

A memória local é instalada automaticamente e não depende da janela de contexto da LLM.

```text
.maestro/memory/
├── INDEX.md       # ordem de leitura e último checkpoint
├── PROJECT.md     # produto, usuários, domínio e baseline técnico
├── STATE.md       # onde o trabalho parou e próxima ação exata
├── DECISIONS.md   # decisões e justificativas
├── LEARNINGS.md   # aprendizados verificados
├── sessions/      # resumos curtos de cada sessão
└── archive/       # sessões antigas compactadas
```

## Começar uma conversa nova sem perder o fio

Cole:

```text
Retome este projeto usando Vibe Code Maestro.
Leia .maestro/START-HERE.md e todos os arquivos canônicos de memória.
Verifique o estado atual do repositório, explique onde o agente anterior parou e execute a próxima ação exata, salvo se existir bloqueio ou contradição que dependa de mim.
```

## Criar checkpoint manualmente

```bash
python .maestro/tools/memory_checkpoint.py \
  --objective "Implementar cadastro de clientes" \
  --summary "Cadastro e listagem concluídos" \
  --changed "src/features/clients" \
  --validation "Testes e build passaram" \
  --next "Implementar edição de cliente"
```

## Compactar sessões antigas

```bash
python .maestro/tools/compact_memory.py --keep 20
```

O Maestro não deve colocar segredos, tokens, dados privados ou transcrições completas nessa memória.

---

# Agentmemory opcional

A memória nativa acima já funciona sozinha. Para busca semântica entre sessões e agentes, você pode instalar opcionalmente o projeto `rohitg00/agentmemory`.

Funciona melhor com Codex, Claude Code, Cursor e Gemini CLI. Lovable e Mimo continuam usando a memória do repositório.

## Instalar no Codex

```bash
./installers/install-agentmemory.sh codex
```

## Instalar no Claude Code

```bash
./installers/install-agentmemory.sh claude
```

Outras opções:

```text
cursor | gemini
```

Depois inicie o serviço:

```bash
agentmemory
```

No Windows, use WSL2 para esse instalador opcional.

**Regra:** resultados encontrados no agentmemory são pistas. O código, a especificação, os ADRs e `.maestro/memory/` continuam sendo a fonte canônica.

---

# O que a IA deve perguntar

Ela não deve começar perguntando qual biblioteca ou estrutura de pastas você prefere. Primeiro precisa entender:

1. o que será criado e quem usará;
2. qual tarefa principal precisa funcionar;
3. o que entra e não entra na versão 1;
4. se haverá login, pagamento, dados pessoais ou integrações;
5. referências visuais e destino de publicação.

O onboarding pergunta no máximo quatro coisas na primeira rodada e pula informações já encontradas na memória ou no repositório.

---

# O que é uma vertical slice

É uma parte pequena, porém completa:

```text
login → cadastro de cliente → salvar no banco → listar clientes → testes
```

Não é apenas uma tela sem dados ou uma API sem interface.

---

# Projeto novo ou existente

O mesmo comando funciona nos dois casos.

- **Projeto novo:** o agente cria a especificação e recomenda o scaffold.
- **Projeto existente:** o agente lê código, dependências, banco, CI, deploy e memória antes de sugerir mudanças.

O instalador não apaga seus arquivos. Se já existir `AGENTS.md`, `CLAUDE.md` ou `GEMINI.md`, ele atualiza somente um bloco delimitado do Maestro e preserva o restante.

---

# Atualizar o Maestro no projeto

```bash
cd vibe-code-maestro
git pull
./installers/bootstrap.sh codex ../meu-projeto
```

A atualização:

- atualiza `.maestro/framework/`;
- preserva especificação, memória, decisões e relatórios;
- não duplica os blocos de instruções;
- executa novamente a validação.

---

# Conferir a instalação

```bash
python scripts/validate_installation.py ../meu-projeto codex
```

Troque `codex` por:

```text
claude | lovable | mimo | cursor | gemini | all
```

O bootstrap executa essa validação automaticamente quando Python está disponível.

---

# Estrutura criada

```text
meu-projeto/
├── .maestro/
│   ├── START-HERE.md
│   ├── project.spec.yaml
│   ├── acceptance.md
│   ├── implementation-plan.md
│   ├── risk-register.md
│   ├── HANDOFF.md
│   ├── memory/
│   ├── prompts/
│   ├── tools/
│   └── framework/
├── AGENTS.md                 # Codex
├── CLAUDE.md                 # Claude
├── .codex/skills/
├── .claude/skills/
├── docs/LOVABLE.md
└── docs/MIMO.md
```

---

# Qualidade e CI/CD

Uma entrega não pode ser marcada como pronta quando:

- a especificação está desatualizada;
- autorização ou RLS falham;
- existem falhas críticas de segurança ou acessibilidade;
- o build de produção não foi validado;
- migrations não possuem recuperação;
- smoke tests falham;
- a memória não mostra claramente o estado e a próxima ação;
- CI/CD está vermelho.

O próprio repositório executa:

```bash
python scripts/validate_maestro.py
python scripts/test_bootstrap.py
python scripts/validate_pack.py
```

O teste de bootstrap instala duas vezes em projetos temporários para garantir idempotência e preservação de memória e instruções existentes.

---

# Problemas comuns

## “A IA não encontrou o Maestro”

Provavelmente você abriu a pasta errada. Abra `meu-projeto`, onde existe `.maestro/START-HERE.md`.

## “Ela começou a programar sem perguntar”

Cole o prompt de `.maestro/prompts/<plataforma>.md` e diga:

```text
Pare a implementação. Execute o onboarding e crie a especificação primeiro.
```

## “Uma conversa nova esqueceu tudo”

Peça para ler `.maestro/memory/` antes de agir. Confira se `STATE.md` contém a próxima ação e se os arquivos foram commitados.

## “Já tenho AGENTS.md ou CLAUDE.md”

O instalador preserva o conteúdo existente e gerencia apenas o bloco entre:

```text
<!-- VIBE-CODE-MAESTRO:START -->
<!-- VIBE-CODE-MAESTRO:END -->
```

---

# Referências externas

Este framework é original e integra, sem reivindicar autoria:

- UI/UX Pro Max, da NextLevelBuilder;
- Taste Skill, de Leonxlnx;
- Agentmemory, de Rohit Ghumare.

Consulte `integrations/` para política, atribuição e instalação opcional.
