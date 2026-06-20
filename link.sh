#!/usr/bin/env zsh

dir=(
git
ssh
starship
zsh
)

stow ${dir[@]} --no-folding --restow
