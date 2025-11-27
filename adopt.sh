#!/usr/bin/env zsh

dir=(
git
sdkman
ssh
starship
zsh
)

if !command -v stow &>/dev/null; then
    zsh $DOTFILES_DIR/scripts/install_stow.sh
fi

stow ${dir[@]} --no-folding --adopt