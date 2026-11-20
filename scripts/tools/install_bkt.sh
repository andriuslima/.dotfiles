#!/usr/bin/env zsh
# Installs bkt (https://github.com/avivsinai/bitbucket-cli) from the GitHub release archive, without Homebrew.
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

REPO="avivsinai/bitbucket-cli"
INSTALL_DIR="${BKT_INSTALL_DIR:-$HOME/.local/bin}"

# macOS on Apple Silicon only
OS="darwin"
ARCH="arm64"

# Latest release version (without the leading "v")
VERSION="${BKT_VERSION:-$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" | sed -n 's/.*"tag_name": *"v\{0,1\}\([^"]*\)".*/\1/p' | head -n1)}"
if [[ -z "$VERSION" ]]; then
    log error "Could not determine the latest bkt version"
    exit 1
fi

if command -v bkt &>/dev/null && bkt --version 2>/dev/null | grep -q "$VERSION"; then
    log info "bkt $VERSION already installed"
    exit 0
fi

ARCHIVE="bkt_${VERSION}_${OS}_${ARCH}.tar.gz"
BASE_URL="https://github.com/$REPO/releases/download/v${VERSION}"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

log info "Installing: bkt $VERSION ($OS/$ARCH)"
curl -fsSL "$BASE_URL/$ARCHIVE" -o "$TMP_DIR/$ARCHIVE" || { log error "Download failed: $BASE_URL/$ARCHIVE"; exit 1; }
curl -fsSL "$BASE_URL/checksums.txt" -o "$TMP_DIR/checksums.txt" || { log error "Checksum download failed"; exit 1; }

# Verify checksum
EXPECTED="$(grep " $ARCHIVE\$" "$TMP_DIR/checksums.txt" | awk '{print $1}')"
ACTUAL="$(shasum -a 256 "$TMP_DIR/$ARCHIVE" | awk '{print $1}')"
if [[ -z "$EXPECTED" || "$EXPECTED" != "$ACTUAL" ]]; then
    log error "Checksum verification failed for $ARCHIVE"
    exit 1
fi

tar -xzf "$TMP_DIR/$ARCHIVE" -C "$TMP_DIR" || { log error "Extraction failed"; exit 1; }
BINARY="$(find "$TMP_DIR" -type f -name bkt | head -n1)"
if [[ -z "$BINARY" ]]; then
    log error "bkt binary not found in archive"
    exit 1
fi

mkdir -p "$INSTALL_DIR"
install -m 755 "$BINARY" "$INSTALL_DIR/bkt"
log info "bkt installed to $INSTALL_DIR/bkt"

case ":$PATH:" in
    *":$INSTALL_DIR:"*) ;;
    *) log warning "$INSTALL_DIR is not in PATH; add it to your shell config" ;;
esac
