#!/usr/bin/env zsh

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
    sleep 1
}

log info '|> Setting configs'
zsh $HOME/.bin/scripts/setup_ssh.sh
zsh $HOME/.bin/scripts/setup_macos.sh

log warning 'Reloading shell'
source $XDG_CONFIG_HOME/zsh/.zshrc