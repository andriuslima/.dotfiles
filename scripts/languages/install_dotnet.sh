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

# On Apple Silicon, dotnet-install.sh overwrites ~/.dotnet/dotnet in place.
# macOS keeps the previous binary's code-signature (CDHash) cached for that
# path, so after an update the kernel's AMFI kills the new (validly signed)
# host with "Taskgated Invalid Signature" / SIGKILL. Swapping the file to a
# fresh inode invalidates the stale cache entry.
function bust_signature_cache() {
    dotnet_bin="${DOTNET_ROOT:-$HOME/.dotnet}/dotnet"
    if [[ "$(uname)" = 'Darwin' && -f "$dotnet_bin" ]]; then
        log info "Refreshing dotnet host inode to clear stale signature cache: $dotnet_bin"
        cp -p "$dotnet_bin" "${dotnet_bin}.new" && mv -f "${dotnet_bin}.new" "$dotnet_bin"
    fi
}

function install_dotnet() {
    version=$1
    channel=$2
    log info "Installing/updating: .NET ${version}"
    curl -fsSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel "$channel"
    bust_signature_cache
}

install_dotnet 8 8.0
install_dotnet 10 10.0
