# Comandos de Rede Linux

## ss -tulpn

Mostra:
- portas abertas
- conexões
- serviços escutando

### Opções

- t = TCP
- u = UDP
- l = listening
- p = process
- n = numérico

---

## Pipe |

O pipe envia a saída de um comando para outro.

Exemplo:

```bash
ss -tulpn | grep 53
```

Objetivo:
Filtrar apenas linhas contendo porta 53.

---

## grep

Usado para filtrar texto.

Exemplo:

```bash
ss -tulpn | grep 22
```