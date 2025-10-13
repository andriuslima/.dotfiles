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

log info '|||> Installing NVM'

export NVM_DIR="${XDG_CONFIG_HOME}/nvm"

if [ ! -f "$NVM_DIR/nvm.sh" ] ; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
else
    log info 'NVM already installed. Performing update'
    cd $NVM_DIR && ./install.sh
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

log info 'Installing node'
nvm cache clear
nvm install 20.12.2
nvm install 22.15.0
nvm alias default 22.15.0

nvm use default 22.15.0

log info 'Installing NPM packages'
npm install -g @nestjs/cli
npm install -g pnpm@latest-10
npm i -g npm@11.6.2
