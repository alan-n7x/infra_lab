# Zabbix 7.x + PostgreSQL — Instalação, Troubleshooting e Primeira Coleta

## Objetivo

Documentar o processo de instalação do Zabbix Server utilizando PostgreSQL, incluindo troubleshooting real encontrado durante a configuração inicial do ambiente.

Este documento faz parte do projeto:

```text
infra_lab
```

---

# Arquitetura Inicial do Lab

```text
[ Zabbix Agent ]
        ↓
[ Zabbix Server ]
        ↓
[ PostgreSQL ]
        ↓
[ Frontend Web ]
```

Tudo inicialmente rodando na mesma VM Ubuntu Server.

---

# Componentes Utilizados

| Componente    | Função                           |
| ------------- | -------------------------------- |
| PostgreSQL    | Banco de dados                   |
| Zabbix Server | Motor principal de monitoramento |
| Zabbix Agent  | Coleta métricas do host          |
| Apache/PHP    | Frontend web                     |
| Ubuntu Server | Sistema operacional              |

---

# Portas Importantes

| Porta   | Serviço       |
| ------- | ------------- |
| 10050   | Zabbix Agent  |
| 10051   | Zabbix Server |
| 5432    | PostgreSQL    |
| 80/8080 | Frontend Web  |

---

# Conceitos Importantes

## O frontend NÃO faz coleta

O frontend apenas:

* exibe dashboards
* lê o banco
* conversa com o Zabbix Server

Quem realiza a coleta:

* zabbix-server
* zabbix-agent

---

# Instalação do PostgreSQL

## Acesso ao PostgreSQL

```bash
sudo -u postgres psql
```

---

## Listar bancos

```sql
\l
```

---

## Criar senha do usuário zabbix

```sql
ALTER USER zabbix WITH PASSWORD 'Zabbix123!';
```

---

# Instalação do Zabbix Agent

## Verificar status

```bash
sudo systemctl status zabbix-agent
```

Resultado esperado:

```text
active (running)
```

---

## Verificar porta 10050

```bash
ss -tulnp | grep 10050
```

Resultado esperado:

```text
0.0.0.0:10050
```

---

# Instalação do Zabbix Server

## Verificar status

```bash
sudo systemctl status zabbix-server
```

---

## Verificar porta 10051

```bash
ss -tulnp | grep 10051
```

Resultado esperado:

```text
0.0.0.0:10051
```

---

# Problema Encontrado

## Sintoma

Frontend exibia:

```text
Connection to Zabbix server failed. Incorrect configuration.
```

Além disso:

* ZBX permanecia cinza
* coleta não funcionava
* porta 10051 não abria

---

# Investigação

## 1. Verificação do Agent

O agent estava funcional:

```bash
ss -tulnp | grep 10050
```

Porta aberta corretamente.

---

## 2. Verificação do Server

A porta 10051 NÃO abria:

```bash
ss -tulnp | grep 10051
```

---

## 3. Investigação dos logs

Comando utilizado:

```bash
sudo tail -f /var/log/zabbix/zabbix_server.log
```

Erro encontrado:

```text
password authentication failed for user "zabbix"
```

---

# Causa Raiz

O frontend possuía a senha correta do PostgreSQL, porém o arquivo:

```text
/etc/zabbix/zabbix_server.conf
```

estava com senha incorreta.

---

# Correção Aplicada

## Editar configuração do server

```bash
sudo nano /etc/zabbix/zabbix_server.conf
```

Alterar:

```ini
DBPassword=Zabbix123!
```

---

## Reiniciar serviços

```bash
sudo systemctl restart postgresql
sudo systemctl restart zabbix-server
sudo systemctl restart zabbix-agent
sudo systemctl restart apache2
```

---

# Resultado Final

Após correção:

* porta 10051 abriu
* frontend conectou corretamente
* ZBX ficou verde
* coleta iniciou normalmente

---

# Primeira Coleta Realizada

Host monitorado:

* próprio servidor Zabbix

Métricas coletadas:

* CPU
* memória
* disco
* rede
* uptime
* load average

---

# Aprendizados Importantes

## 1. Serviço ativo != serviço funcional

Mesmo com:

```text
systemctl status zabbix-server
```

em estado:

```text
active
```

o serviço ainda estava quebrado internamente.

---

## 2. Logs são a fonte da verdade

O erro real só apareceu em:

```bash
tail -f /var/log/zabbix/zabbix_server.log
```

---

## 3. Observabilidade é multicamada

Fluxo real:

```text
Frontend
↓
Zabbix Server
↓
PostgreSQL
↓
Agent
```

---

## 4. Monitorar o próprio monitorador é prática real

Em ambientes reais, o primeiro host monitorado normalmente é o próprio servidor Zabbix.

---

## 5. Troubleshooting orientado a fluxo

Metodologia utilizada:

```text
UI → Porta → Serviço → Log → Banco → Autenticação
```

---

# Comandos Importantes

## Status dos serviços

```bash
sudo systemctl status zabbix-server
sudo systemctl status zabbix-agent
sudo systemctl status postgresql
```

---

## Verificar portas

```bash
ss -tulnp | grep 10050
ss -tulnp | grep 10051
```

---

## Logs

```bash
sudo tail -f /var/log/zabbix/zabbix_server.log
```

---

## PostgreSQL

```bash
psql -U zabbix -d zabbix -h localhost
```

---

# Próximos Passos do InfraLab

* monitorar outras VMs
* instalar agents remotos
* Docker monitoring
* Grafana
* triggers
* alertas
* Telegram/Discord
* SNMP
* Proxy
* automação com Ansible

---

# Conclusão

O principal aprendizado deste lab foi entender que:

```text
observabilidade não é apenas instalar ferramentas,
mas compreender o fluxo completo entre serviços,
banco, agentes e coleta.
```

Os problemas encontrados foram extremamente próximos de cenários reais de produção, principalmente relacionados a:

* autenticação
* integração
* troubleshooting
* análise de logs
* dependências entre serviços
