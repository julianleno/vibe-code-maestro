# GitHub e Entrega

## Fluxo

1. atualizar `main` local;
2. criar branch por objetivo;
3. implementar slice;
4. validar localmente;
5. commit coeso;
6. abrir PR draft;
7. verificar CI;
8. revisar preview;
9. resolver comentários;
10. solicitar autorização de merge;
11. squash merge;
12. verificar produção.

## Naming

```text
feature/<capacidade>
fix/<problema>
design/<superficie>
refactor/<escopo>
chore/<manutencao>
```

## Proibições

- commits “final”, “teste”, “ajustes” sem contexto;
- merge com CI vermelho;
- afirmar deploy sem abrir o status real;
- incluir `.env`, dumps ou credenciais;
- deixar PR obsoleto sem fechamento ou explicação.
