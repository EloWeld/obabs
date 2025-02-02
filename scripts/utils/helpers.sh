#!/bin/bash

# Функция для красивого вывода
print_status() {
    echo -e "${BLUE}[*] $1${NC}"
}

print_error() {
    echo -e "${RED}[✗] $1${NC}"
}

# Функция для проверки успешности выполнения
check_success() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[✓] $1${NC}"
    else
        echo -e "${RED}[✗] Ошибка: $1${NC}"
        exit 1
    fi
} 