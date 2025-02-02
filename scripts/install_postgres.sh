#!/bin/bash

source scripts/utils/colors.sh
source scripts/utils/helpers.sh

print_status "Установка PostgreSQL..."
apt install -y postgresql postgresql-contrib

# Копирование конфигурации
print_status "Настройка PostgreSQL..."
cp configs/postgres/postgresql.conf /etc/postgresql/*/main/postgresql.conf
systemctl restart postgresql

# Создание пользователя и базы данных по умолчанию
sudo -u postgres psql -c "CREATE USER admin WITH PASSWORD 'admin';"
sudo -u postgres psql -c "CREATE DATABASE admin OWNER admin;"

systemctl enable postgresql
systemctl start postgresql
check_success "PostgreSQL установлен и настроен" 