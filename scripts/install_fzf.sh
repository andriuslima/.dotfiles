#!/usr/bin/env zsh

# Documentation: https://github.com/junegunn/fzf

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

fzf_dir=${XDG_CONFIG_HOME}/fzf

if command -v fzf &>/dev/null; then
    log info 'FZF already installed. Performing Update'
    cd $fzf_dir && git pull && ./install --xdg --key-bindings --completion --no-update-rc --no-bash --no-fish --all
else
    log info "Installing: FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git $fzf_dir
    $fzf_dir/install --xdg --key-bindings --completion --no-update-rc --no-bash --no-fish --all
fi
