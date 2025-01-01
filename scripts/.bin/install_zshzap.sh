#!/usr/bin/env zsh

if [[ -d "$ZAP_DIR" ]] then
    echo "Zap is already installed in '$ZAP_DIR'"
else
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
fi