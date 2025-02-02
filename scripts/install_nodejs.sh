#!/bin/bash

source scripts/utils/colors.sh
source scripts/utils/helpers.sh

print_status "Установка Node.js..."

# Установка NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Установка последней LTS версии Node.js
print_status "Установка последней LTS версии Node.js..."
nvm install --lts
nvm use --lts

# Установка глобальных пакетов
print_status "Установка глобальных npm пакетов..."
npm install -g yarn pm2 typescript

# Проверка установки
node --version
npm --version
yarn --version

check_success "Node.js установлен" 