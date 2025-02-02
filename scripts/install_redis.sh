#!/bin/bash

source scripts/utils/colors.sh
source scripts/utils/helpers.sh

print_status "Установка Redis..."
apt install -y redis-server

# Копирование конфигурации
print_status "Настройка Redis..."
cp configs/redis/redis.conf /etc/redis/redis.conf
systemctl restart redis-server

systemctl enable redis-server
systemctl start redis-server
check_success "Redis установлен и настроен" 