#!/bin/bash

source scripts/utils/colors.sh
source scripts/utils/helpers.sh

print_status "Обновление системы..."
apt update && apt upgrade -y
check_success "Система обновлена" 