
---  

```markdown

# 🔐 Configuração de HTTPS no Zabbix com Certbot (Let's Encrypt)
 

Este documento descreve como configurar HTTPS no Zabbix usando Certbot e Nginx, garantindo comunicação segura via SSL/TLS.

---  
## 🌐 1. Pré-requisitos


Antes de iniciar, garanta:
 

- Domínio configurado no DNS apontando para o servidor Zabbix

- Porta 80 e 443 liberadas no firewall / roteador

- Nginx configurado com `server_name` correto no Zabbix

  

Arquivo:

  

```  

/etc/zabbix/nginx.conf  

````

  

Exemplo:

  

```nginx

server_name seu_dominio_ou_ip;

````

  
---
  

## 📦 2. Instalar Certbot

  
Execute os comandos abaixo para instalar o Certbot via ambiente virtual:

  
```bash

sudo  apt  update  -y

sudo  apt  install  -y  python3  python3-venv  libaugeas0

  
sudo  python3  -m  venv  /opt/certbot

sudo  /opt/certbot/bin/pip  install  --upgrade  pip

sudo  /opt/certbot/bin/pip  install  certbot  certbot-nginx

  
sudo  ln  -s  /opt/certbot/bin/certbot  /usr/bin/certbot

```
 

---

  

## 🚀 3. Emitir certificado SSL

  

Após configurar o DNS e o Nginx corretamente, execute:

  ```bash

sudo  certbot  --nginx

```
  

---

  
## 📧 4. Processo de emissão

  Durante a execução:

  
### 4.1 E-mail

  
Informe seu e-mail para notificações de renovação (recomendado).
  

### 4.2 Termos de uso

  
Aceite os termos digitando:
  

```

y

```

  

### 4.3 Newsletter
 

Você pode aceitar ou recusar notificações promocionais.

  
---

  
## 🔎 5. Seleção do domínio

  
O Certbot irá detectar automaticamente o domínio configurado no Nginx.

  
Selecione o ID correspondente para emitir o certificado.

  
---

  
## 🔐 6. Resultado esperado
  

Se tudo estiver correto:
  

* Certificado SSL será emitido

* Nginx será automaticamente configurado

* Acesso HTTPS será ativado
  

Exemplo de acesso:

 

```

https://seu_dominio_ou_ip

```
  

---
  

## 🔁 7. Renovação automática do certificado
  

Adicionar tarefa no cron:
  

```bash

echo  "0 0,12 * * * root /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && sudo certbot renew -q" | sudo  tee  -a  /etc/crontab > /dev/null

```
  

---
  

## 🧠 8. Observações importantes

  
* Portas **80 e 443 devem estar abertas**

* DNS deve estar propagado corretamente

* Sem DNS válido, o Certbot pode falhar

* HTTPS protege credenciais e tráfego do Zabbix

  
---
  

## 📊 9. Resultado final
  
Após configuração:
 

* Zabbix acessível via HTTPS

* Comunicação criptografada

* Segurança aumentada contra interceptação de tráfego
 

---  

---

  
```markdown

# 🔐 Configuração de HTTPS no Zabbix com Certbot (Let's Encrypt)

 

Este documento descreve como configurar HTTPS no Zabbix usando Certbot e Nginx, garantindo comunicação segura via SSL/TLS.

 

---
  
## 🌐 1. Pré-requisitos
  
Antes de iniciar, garanta:
 
- Domínio configurado no DNS apontando para o servidor Zabbix

- Porta 80 e 443 liberadas no firewall / roteador

- Nginx configurado com `server_name` correto no Zabbix

  
Arquivo:
 

```
  

/etc/zabbix/nginx.conf
  

````

  

Exemplo:

  

```nginx

server_name seu_dominio_ou_ip;

````
  

---
  

## 📦 2. Instalar Certbot
 

Execute os comandos abaixo para instalar o Certbot via ambiente virtual:
  

```bash

sudo  apt  update  -y

sudo  apt  install  -y  python3  python3-venv  libaugeas0
  

sudo  python3  -m  venv  /opt/certbot

sudo  /opt/certbot/bin/pip  install  --upgrade  pip

sudo  /opt/certbot/bin/pip  install  certbot  certbot-nginx
 

sudo  ln  -s  /opt/certbot/bin/certbot  /usr/bin/certbot

```
  

---

  
## 🚀 3. Emitir certificado SSL
 

Após configurar o DNS e o Nginx corretamente, execute:


```bash

sudo  certbot  --nginx

```
 

---

  
## 📧 4. Processo de emissão

  Durante a execução:

  
### 4.1 E-mail

  
Informe seu e-mail para notificações de renovação (recomendado).

  
### 4.2 Termos de uso
  

Aceite os termos digitando:

  
```

y

```

  

### 4.3 Newsletter

  
Você pode aceitar ou recusar notificações promocionais.

  
---
  

## 🔎 5. Seleção do domínio

  
O Certbot irá detectar automaticamente o domínio configurado no Nginx.
 

Selecione o ID correspondente para emitir o certificado.

  
---

  
## 🔐 6. Resultado esperado
  

Se tudo estiver correto:
 

* Certificado SSL será emitido

* Nginx será automaticamente configurado

* Acesso HTTPS será ativado

  
Exemplo de acesso:


```

https://seu_dominio_ou_ip

```
  

---

  
## 🔁 7. Renovação automática do certificado

  
Adicionar tarefa no cron:

  
```bash

echo  "0 0,12 * * * root /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && sudo certbot renew -q" | sudo  tee  -a  /etc/crontab > /dev/null

```
  

---
  

## 🧠 8. Observações importantes

  
* Portas **80 e 443 devem estar abertas**

* DNS deve estar propagado corretamente

* Sem DNS válido, o Certbot pode falhar

* HTTPS protege credenciais e tráfego do Zabbix

  
---
  

## 📊 9. Resultado final

  
Após configuração:

  
* Zabbix acessível via HTTPS

* Comunicação criptografada

* Segurança aumentada contra interceptação de tráfego

  
---