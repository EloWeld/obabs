#!/bin/bash

source scripts/utils/colors.sh
source scripts/utils/helpers.sh

print_status "Настройка MOTD..."

# Установка neofetch
apt install -y neofetch
check_success "Neofetch установлен"

# Отключение стандартных MOTD-скриптов
chmod -x /etc/update-motd.d/*

# Копирование нового заголовка
cp configs/motd/00-header /etc/update-motd.d/00-header
chmod +x /etc/update-motd.d/00-header

# Создание скрипта для запуска neofetch
cat > /etc/update-motd.d/10-neofetch << 'EOF'
#!/bin/bash
neofetch
EOF
chmod +x /etc/update-motd.d/10-neofetch

# Обновление MOTD
run-parts /etc/update-motd.d/

check_success "MOTD настроен" 