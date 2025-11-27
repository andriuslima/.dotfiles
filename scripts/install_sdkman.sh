#!/usr/bin/env zsh

# If SDKMAN directory exsists it will not be installed.
# First need to delete the directory, installed it and then stow link again.

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

source "$XDG_CONFIG_HOME/sdkman/bin/sdkman-init.sh"
if command -v sdk &>/dev/null; then
    log info 'SDKMAN already installed'
else
    log info 'Installing: SDKMAN'
    curl -s "https://get.sdkman.io?rcupdate=false" | bash
    source "$XDG_CONFIG_HOME/sdkman/bin/sdkman-init.sh"
fi

sdk update
#sdk selfupdate

log info '|||> Setting Gradle'
sdk install gradle 8.7
sdk default gradle 8.7

log info '|||> Setting Java versions'
sdk install java 21.0.2-amzn
sdk default java 21.0.2-amzn