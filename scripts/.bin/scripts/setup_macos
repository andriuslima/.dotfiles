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
}

log info '|||> Setting macOS Settings'

log info '|||> Setting Dock'
defaults write com.apple.dock "show-recents" -int 0
defaults write com.apple.dock "tilesize" -int 65
defaults write com.apple.dock "autohide" -int 0
defaults write com.apple.dock "magnification" -int 0
defaults write com.apple.mouse.scaling -int 5
killall Dock

log info '|||> Setting Directories'

if [ ! -d "$HOME/Codes/tsq/" ]; then
  mkdir -p $HOME/Codes/tsq/
fi

if [ ! -d "$HOME/Codes/ca/" ]; then
  mkdir -p $HOME/Codes/ca/
fi

if [ ! -d "$HOME/Codes/personal/" ]; then
  mkdir -p $HOME/Codes/personal/
fi

if [ ! -d "$HOME/Codes/projects/" ]; then
  mkdir -p $HOME/Codes/projects/
fi
