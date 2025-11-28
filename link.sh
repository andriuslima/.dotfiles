#!/usr/bin/env zsh

modules=(
git
sdkman
ssh
starship
zsh
)

export DOTFILES_DIR=$HOME/.dotfiles/

if !command -v stow &>/dev/null; then
    zsh $DOTFILES_DIR/scripts/install_stow.sh
fi

stow ${modules[@]} --no-folding --restow
