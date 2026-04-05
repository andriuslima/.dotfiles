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

log info '|||> Setting Directories'

mkdir $HOME/Codes
mkdir $HOME/Codes/work
mkdir $HOME/Codes/personal

git clone git@github.com:andriuslima/andriuslima.git $HOME/Codes/personal/andriuslima
git clone git@github.com:andriuslima/scripts.git $HOME/Codes/personal/scripts
git clone git@github.com:andriuslima/blog.git $HOME/Codes/personal/blog