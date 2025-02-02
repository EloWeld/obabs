#!/bin/bash

source scripts/utils/colors.sh
source scripts/utils/helpers.sh

print_status "Установка Python..."

# Установка Python и pip
apt install -y python3 python3-pip python3-venv

# Установка дополнительных инструментов
apt install -y python3-dev python3-setuptools build-essential

# Обновление pip
python3 -m pip install --upgrade pip

# Установка популярных пакетов
print_status "Установка популярных Python пакетов..."
python3 -m pip install \
    virtualenv \
    poetry \
    black \
    flake8 \
    mypy \
    pytest \
    ipython

# Создание симлинков
update-alternatives --install /usr/bin/python python /usr/bin/python3 1
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# Проверка установки
python --version
pip --version

check_success "Python установлен" 