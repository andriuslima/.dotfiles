#!/usr/bin/env zsh

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
    sleep 1
}

if !command -v stow &>/dev/null; then
    zsh scripts/.bin/install_stow.sh
fi

log info '|> Installing Apps...'
zsh $DOTFILES_DIR/scripts/install_aws.sh
zsh $DOTFILES_DIR/scripts/install_bun.sh
zsh $DOTFILES_DIR/scripts/install_fzf.sh
zsh $DOTFILES_DIR/scripts/install_node.sh
zsh $DOTFILES_DIR/scripts/install_python.sh
zsh $DOTFILES_DIR/scripts/install_sdkman.sh
zsh $DOTFILES_DIR/scripts/install_starship.sh
zsh $DOTFILES_DIR/scripts/install_zshzap.sh
log info '|> Packages set'

log info '|> Setting configs'
zsh $DOTFILES_DIR/scripts/setup_ssh.sh
log info '|> Configs set'