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

export DOTFILES_DIR=$HOME/.dotfiles/
SCRIPTS_DIR="$DOTFILES_DIR/scripts"
LANGUAGES_DIR="$SCRIPTS_DIR/languages"
TOOLS_DIR="$SCRIPTS_DIR/tools"

log info 'Installing tools'
for script in "$TOOLS_DIR"/*.sh; do
    if [[ -f "$script" ]]; then
        log info "Running $(basename "$script")..."
        zsh "$script"
    fi
done

log info 'Installing languages'
for script in "$LANGUAGES_DIR"/*.sh; do
    if [[ -f "$script" ]]; then
        log info "Running $(basename "$script")..."
        zsh "$script"
    fi
done

log info '|> Setting configs'
zsh $SCRIPTS_DIR/setup_ssh.sh
zsh $SCRIPTS_DIR/setup_personal_repositories.sh
zsh $SCRIPTS_DIR/setup_work_repositories.sh
log info '|> Configs set'