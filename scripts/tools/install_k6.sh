#!/usr/bin/env zsh

# Documentation: https://grafana.com/docs/k6/latest/set-up/install-k6/
# Releases: https://github.com/grafana/k6/releases

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

function get_latest_version() {
    curl -sI https://github.com/grafana/k6/releases/latest | grep -i '^location:' | sed 's|.*/tag/||' | tr -d '\r\n'
}

function get_arch() {
    local arch=$(uname -m)
    if [[ $arch = 'arm64' || $arch = 'aarch64' ]]; then
        echo "arm64"
    else
        echo "amd64"
    fi
}

function install_k6() {
    local version=$1
    local arch=$(get_arch)
    local filename="k6-${version}-macos-${arch}.zip"
    local url="https://github.com/grafana/k6/releases/download/${version}/${filename}"

    log info "Downloading k6 ${version} for macos-${arch}..."
    curl -sL "${url}" --output "${filename}"

    log info "Extracting ${filename}..."
    unzip -qo "${filename}"

    log info "Installing k6 to /usr/local/bin..."
    sudo mv "k6-${version}-macos-${arch}/k6" /usr/local/bin/k6
    sudo chmod +x /usr/local/bin/k6

    rm -rf "${filename}" "k6-${version}-macos-${arch}"
    log info "k6 ${version} installed successfully"
}

latest_version=$(get_latest_version)

if command -v k6 &>/dev/null; then
    installed_version=$(k6 version | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+')
    if [[ $installed_version = $latest_version ]]; then
        log info "k6 ${latest_version} is already installed"
    else
        log warning "k6 ${installed_version} installed, updating to ${latest_version}..."
        install_k6 $latest_version
    fi
else
    log info "Installing: k6"
    install_k6 $latest_version
fi
