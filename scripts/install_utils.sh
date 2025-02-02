#!/bin/bash

source scripts/utils/colors.sh
source scripts/utils/helpers.sh

print_status "Установка системных утилит..."

# Установка базовых утилит
apt install -y \
    tmux \
    micro \
    htop \
    ncdu \
    net-tools \
    ufw \
    curl \
    wget \
    git \
    zip \
    unzip \
    tree
check_success "Базовые утилиты установлены"

# Настройка tmux
print_status "Настройка tmux..."

# Get the actual user's home directory
REAL_USER=$(who am i | awk '{print $1}')
REAL_HOME=$(getent passwd $REAL_USER | cut -d: -f6)

# Create .tmux.conf in the correct location
mkdir -p $REAL_HOME
cp configs/tmux/.tmux.conf $REAL_HOME/.tmux.conf
chown $REAL_USER:$REAL_USER $REAL_HOME/.tmux.conf

check_success "Tmux настроен"

# Настройка micro
print_status "Настройка micro..."
mkdir -p /root/.config/micro
cp configs/micro/settings.json /root/.config/micro/
if [ ! -z "$SUDO_USER" ]; then
    mkdir -p /home/$SUDO_USER/.config/micro
    cp configs/micro/settings.json /home/$SUDO_USER/.config/micro/
    chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/micro
fi
check_success "Micro настроен"

# Настройка UFW
print_status "Настройка UFW..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow http
ufw allow https
echo "y" | ufw enable
check_success "UFW настроен" 