#!/bin/bash

echo "Atualizando sistema..."
sudo apt update && sudo apt upgrade -y

echo "Instalando pacotes básicos..."
sudo apt install -y \
    git curl wget unzip \
    nmap net-tools

echo "Instalando Docker..."
sudo apt install -y docker.io

echo "Instalando Docker Compose..."
sudo apt install -y docker-compose-plugin

echo "Habilitando Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Adicionando usuário ao Docker group..."
sudo usermod -aG docker $USER

echo "Limpando sistema..."
sudo apt autoremove -y

echo "Setup concluído!"
echo "IMPORTANTE: reinicie a sessão para usar Docker sem sudo"