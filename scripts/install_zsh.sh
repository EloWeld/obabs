#!/bin/bash

source scripts/utils/colors.sh
source scripts/utils/helpers.sh

print_status "Установка Zsh и Oh My Zsh..."
apt install -y zsh curl git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Получаем реального пользователя
REAL_USER=$(who am i | awk '{print $1}')
REAL_HOME=$(getent passwd $REAL_USER | cut -d: -f6)

# Установка плагинов
print_status "Установка плагинов Zsh..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$REAL_HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Установка темы Powerlevel10k
print_status "Установка Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$REAL_HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Копирование конфигурационных файлов
cp configs/zsh/.zshrc $REAL_HOME/.zshrc
cp configs/zsh/.p10k.zsh $REAL_HOME/.p10k.zsh

# Установка правильных прав
chown -R $REAL_USER:$REAL_USER $REAL_HOME/.oh-my-zsh
chown $REAL_USER:$REAL_USER $REAL_HOME/.zshrc
chown $REAL_USER:$REAL_USER $REAL_HOME/.p10k.zsh

# Установка Zsh как оболочки по умолчанию
chsh -s $(which zsh) $REAL_USER

check_success "Oh My Zsh установлен"

# Добавляем информационное сообщение
echo -e "${GREEN}[i] Для активации Zsh выполните команду:${NC}"
echo -e "${BLUE}    exec zsh${NC}"
echo -e "${GREEN}[i] Или перезапустите терминал${NC}" 