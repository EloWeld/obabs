#!/bin/bash

# Цвета для вывода
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Загрузка общих функций
source scripts/utils/colors.sh
source scripts/utils/helpers.sh

# Проверка наличия sudo прав
check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        print_error "Пожалуйста, запустите скрипт с правами sudo"
        exit 1
    fi
}

# Создание структуры каталогов
setup_directories() {
    print_status "Создание структуры каталогов..."
    mkdir -p configs/{zsh,motd,docker,postgres,redis}
    check_success "Структура каталогов создана"
}

# Основное меню
main_menu() {
    echo "Выберите компоненты для установки:"
    echo "1) Oh My Zsh"
    echo "2) MOTD (neofetch)"
    echo "3) Python"
    echo "4) Docker"
    echo "5) PostgreSQL"
    echo "6) Redis"
    echo "7) Node.js"
    echo "8) Системные утилиты (tmux, micro, htop, etc.)"
    echo "9) Веб-сервер (Nginx/Caddy + Certbot)"
    echo "10) Установить всё"
    echo "0) Выход"
    
    read -p "Введите номера компонентов через пробел: " choices
    
    for choice in $choices; do
        case $choice in
            1) bash scripts/install_zsh.sh ;;
            2) bash scripts/install_motd.sh ;;
            3) bash scripts/install_python.sh ;;
            4) bash scripts/install_docker.sh ;;
            5) bash scripts/install_postgres.sh ;;
            6) bash scripts/install_redis.sh ;;
            7) bash scripts/install_nodejs.sh ;;
            8) bash scripts/install_utils.sh ;;
            9) bash scripts/install_webserver.sh ;;
            10) 
                for script in scripts/install_*.sh; do
                    bash "$script"
                done
                ;;
            0) exit 0 ;;
            *) echo "Неверный выбор" ;;
        esac
    done
}

# Запуск скрипта
check_sudo
setup_directories
bash scripts/update_system.sh
main_menu
