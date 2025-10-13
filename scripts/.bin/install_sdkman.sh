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
        echo -e "${GREEN}$message${NOCOLOR}"
    elif [[ $level = 'warning' ]]; then
        echo -e "${YELLOW}$message${NOCOLOR}"
    else
        echo -e "${RED}$message${NOCOLOR}"
    fi
}

log info '|||> Installing SDKMAN'

export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"

if [ ! -f "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
    curl -s "https://get.sdkman.io?rcupdate=false" | bash
else
    log info 'SDKMAN already installed'
fi

source "$SDKMAN_DIR/bin/sdkman-init.sh"
sdk update
sdk selfupdate

log info '|||> Setting Gradle'
sdk install gradle 8.7
sdk default gradle 8.7

log info '|||> Setting Java versions'
sdk install java 21.0.2-amzn
sdk default java 21.0.2-amzn