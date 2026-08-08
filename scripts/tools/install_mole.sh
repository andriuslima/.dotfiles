#!/usr/bin/env zsh

# Documentation: https://github.com/tw93/mole

RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'
YELLOW='\033[1;33m'

function log() {
    level=$1
    message=$2
    if [[ $level = 'info' ]]; then
        echo "${GREEN}$message${NOCOLOR}"
    elif [[ $level = 'warning' ]]; then
        echo "${YELLOW}$message${NOCOLOR}"
    else
        echo "${RED}$message${NOCOLOR}"
    fi
}

if command -v mo &>/dev/null; then
    log warning "Mole already installed, updating..."
    mo update
    log info "Mole updated successfully"
else
    log info "Installing: Mole"
    curl -fsSL https://raw.githubusercontent.com/tw93/mole/main/install.sh | bash
fi
