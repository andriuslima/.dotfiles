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

log info '|> Installing Apps...'
zsh $HOME/.bin/install_aws.sh
zsh $HOME/.bin/install_bun.sh
zsh $HOME/.bin/install_fzf.sh
zsh $HOME/.bin/install_node.sh
zsh $HOME/.bin/install_python.sh
zsh $HOME/.bin/install_sdkman.sh
zsh $HOME/.bin/install_starship.sh
zsh $HOME/.bin/install_stow.sh
zsh $HOME/.bin/install_zshzap.sh
log info '|> Packages set'

log info '|> Setting configs'
zsh $HOME/.bin/setup_ssh.sh
log info '|> Configs set'