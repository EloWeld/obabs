#!/bin/bash

source scripts/utils/colors.sh
source scripts/utils/helpers.sh

print_status "Установка Docker..."

# Установка зависимостей
apt install -y apt-transport-https ca-certificates curl software-properties-common

# Добавление официального GPG-ключа Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
check_success "Добавлен GPG-ключ Docker"

# Добавление репозитория Docker
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update

# Установка Docker
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
check_success "Docker установлен"

# Настройка Docker
print_status "Настройка Docker..."
mkdir -p /etc/docker
cp configs/docker/daemon.json /etc/docker/daemon.json
systemctl restart docker

# Добавление текущего пользователя в группу docker
usermod -aG docker $USER
check_success "Docker настроен"

# Проверка установки
docker --version
docker compose version 