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
        echo "${GREEN}$message${NOCOLOR}"
    elif [[ $level = 'warning' ]]; then
        echo "${YELLOW}$message${NOCOLOR}"
    else
        echo "${RED}$message${NOCOLOR}"
    fi
}

log info 'Installing: Starship'

curl -sS https://starship.rs/install.sh --output starship-installer.sh
sh starship-installer.sh --bin-dir /usr/local/bin --yes
rm starship-installer.sh