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
}

log info "Installing GNU Stow"

currentDir=${pwd}

curl -sS https://mirrors.ibiblio.org/gnu/stow/stow-2.4.1.tar.gz --output stow-2.4.1.tar.gz
tar --extract --file stow-2.4.1.tar.gz
cd stow-2.4.1
./configure
sudo make install

cd $currentDir
rm stow-2.4.1.tar.gz
rm -rf stow-2.4.1