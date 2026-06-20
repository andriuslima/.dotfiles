#!/usr/bin/env zsh

# Documentation: https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script

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

if command -v dotnet &>/dev/null && dotnet --list-sdks | grep -q "^8\."; then
    log info '.NET 8 already installed. Performing update'
    curl -fsSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel 8.0
else
    log info 'Installing: .NET 8'
    curl -fsSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel 8.0
fi
