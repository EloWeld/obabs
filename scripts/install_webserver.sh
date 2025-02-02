#!/bin/bash

source scripts/utils/colors.sh
source scripts/utils/helpers.sh

install_nginx() {
    print_status "Установка Nginx..."
    apt install -y nginx

    # Копирование конфигурации
    cp -r configs/nginx/* /etc/nginx/
    
    # Проверка конфигурации
    nginx -t
    
    systemctl enable nginx
    systemctl restart nginx
    check_success "Nginx установлен и настроен"
}

install_certbot() {
    print_status "Установка Certbot..."
    apt install -y certbot python3-certbot-nginx
    check_success "Certbot установлен"
}

install_caddy() {
    print_status "Установка Caddy..."
    apt install -y debian-keyring debian-archive-keyring apt-transport-https
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
    apt update
    apt install -y caddy

    # Копирование конфигурации
    cp configs/caddy/Caddyfile /etc/caddy/Caddyfile
    
    systemctl enable caddy
    systemctl restart caddy
    check_success "Caddy установлен и настроен"
}

# Основное меню
echo "Выберите веб-сервер для установки:"
echo "1) Nginx + Certbot"
echo "2) Caddy (со встроенным автоматическим SSL)"
echo "3) Установить оба"
echo "0) Отмена"

read -p "Ваш выбор: " choice

case $choice in
    1)
        install_nginx
        install_certbot
        ;;
    2)
        install_caddy
        ;;
    3)
        install_nginx
        install_certbot
        install_caddy
        ;;
    0)
        exit 0
        ;;
    *)
        echo "Неверный выбор"
        exit 1
        ;;
esac 