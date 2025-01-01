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

log info '|||> Setting SSH'

log info "Generating SSH key"

SSH_PATH=$(cd ~/.ssh; pwd -P)
PRIVATE_KEY="$SSH_PATH/andriuslima"
PUBLIC_KEY="$PRIVATE_KEY.pub"

if [ -f "$PRIVATE_KEY" ]; then
    log warning "$PRIVATE_KEY key already setup"
else
    ssh-keygen -b 2048 -t rsa -f $PRIVATE_KEY -q -N ""
fi

ssh-add $PRIVATE_KEY --apple-use-keychain
