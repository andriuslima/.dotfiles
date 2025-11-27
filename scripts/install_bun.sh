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
        echo  "${GREEN}$message${NOCOLOR}"
    elif [[ $level = 'warning' ]]; then
        echo  "${YELLOW}$message${NOCOLOR}"
    else
        echo  "${RED}$message${NOCOLOR}"
    fi
}

if command -v bun &>/dev/null; then
    log info 'Bun already installed. Performing update'
    bun upgrade
else
    log info 'Installing: Bun'
    export BUN_INSTALL="$HOME/.bun"
    curl -fsSL https://bun.sh/install | bash
fi
