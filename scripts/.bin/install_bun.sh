#!/usr/bin/env zsh

# Documentation: https://bun.sh/docs/installation

RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'
YELLOW='\033[1;33m'

function log() {
    level=$1
    message=$2
    if [[ $level = 'info' ]]; then
        echo -e "${GREEN}$message${NOCOLOR}"
    elif [[ $level = 'warning' ]]; then
        echo -e "${YELLOW}$message${NOCOLOR}"
    else
        echo -e "${RED}$message${NOCOLOR}"
    fi
}

log info 'Installing Bun'

exists=$+commands[bun]

if [ $exists -eq 0 ]; then
    export BUN_INSTALL="$HOME/.bun"
    curl -fsSL https://bun.sh/install | bash
else
    log info 'Bun already installed'
fi
