INSTALAÇÃO E CONFIGURAÇÃO DO ZABBIX 7.4 (UBUNTU 26.04 + POSTGRESQL)

TORNAR-SE USUÁRIO ROOT

sudo -s

INSTALAR REPOSITÓRIO OFICIAL DO ZABBIX

wget https://repo.zabbix.com/zabbix/7.4/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.4+ubuntu26.04_all.deb
dpkg -i zabbix-release_latest_7.4+ubuntu26.04_all.deb
apt update

INSTALAR ZABBIX SERVER, FRONTEND E AGENT

apt install zabbix-server-pgsql zabbix-frontend-php php8.5-pgsql zabbix-nginx-conf zabbix-sql-scripts zabbix-agent

CRIAR BANCO DE DADOS POSTGRESQL

Certifique-se que o PostgreSQL está ativo.

sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix

IMPORTAR SCHEMA INICIAL DO ZABBIX

zcat /usr/share/zabbix/sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

CONFIGURAR ZABBIX SERVER

Editar arquivo:
nano /etc/zabbix/zabbix_server.conf

Configurar:

DBHost=localhost
DBName=zabbix
DBUser=zabbix
DBPassword=sua_senha

CONFIGURAR FRONTEND (NGINX)

Editar arquivo:
nano /etc/zabbix/nginx.conf

Ajustar:

listen 8080
server_name IP_OU_DOMINIO

INICIAR SERVIÇOS

systemctl restart zabbix-server zabbix-agent nginx php8.5-fpm
systemctl enable zabbix-server zabbix-agent nginx php8.5-fpm

ACESSO WEB

http://IP_DO_SERVIDOR:8080

Usuário padrão:
Admin
Senha:
zabbix

OBSERVAÇÕES IMPORTANTES

PostgreSQL deve ter cluster ativo (pg_lsclusters)
Banco zabbix deve existir antes da importação do schema
Zabbix só inicia corretamente após conexão com o banco configurada