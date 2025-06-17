#!/bin/bash
set -e

echo "[+] Atualizando Pacotes"
sudo apt-get update -y
sudo apt-get upgrade -y

echo "[+] Instalando depedências básicas"
sudo apt-get install -y curl git docker.io docker-compose

echo "[+] Adicionando usuário vagrant ao grupo docker"
sudo usermod -aG docker vagrant

echo "[+] Instalando Kind"
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv kind /usr/local/bin

echo "[+] Instalando Kubectl"
curl -LO "https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin

echo "[+] Criando cluster com Kind"
kind create cluster --name devsecops --image kindest/node:v1.27.3

echo "[+] Instalando Helm"
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash