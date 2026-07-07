#!/usr/bin/env zsh

dir=(
kiro
git
ssh
starship
zsh
)

stow ${dir[@]} --no-folding --restow
