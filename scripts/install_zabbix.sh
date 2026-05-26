#!/bin/bash

set -e

echo "🔧 Atualizando sistema..."
sudo apt update -y
sudo apt upgrade -y

echo "📦 Instalando dependências..."
sudo apt install -y wget curl gnupg2 ca-certificates lsb-release

echo "📥 Instalando repositório Zabbix..."
wget https://repo.zabbix.com/zabbix/7.4/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.4+ubuntu26.04_all.deb
sudo dpkg -i zabbix-release_latest_7.4+ubuntu26.04_all.deb
sudo apt update -y

echo "⚙️ Instalando Zabbix Server + Frontend + Agent..."
sudo apt install -y \
zabbix-server-pgsql \
zabbix-frontend-php \
php8.5-pgsql \
zabbix-nginx-conf \
zabbix-sql-scripts \
zabbix-agent \
zabbix-get

echo "🧠 Finalizado instalação base do Zabbix"
echo "👉 Próximo passo: configurar PostgreSQL e importar schema"