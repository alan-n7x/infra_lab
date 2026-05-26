#!/bin/bash

set -e

echo "🔧 Atualizando sistema..."
sudo apt update -y
sudo apt upgrade -y

echo "📦 Instalando PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib

echo "🚀 Habilitando serviço PostgreSQL..."
sudo systemctl enable postgresql
sudo systemctl start postgresql

echo "🧱 Criando cluster (caso não exista)..."
sudo pg_createcluster 18 main --start || true

echo "🔎 Status dos clusters:"
pg_lsclusters

echo "✅ PostgreSQL instalado e ativo!"
echo "👉 Próximo passo: sudo -u postgres psql"