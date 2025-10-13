#!/usr/bin/env zsh

dir=(
modules
git
scripts
sdkman
ssh
starship
zsh
)

stow ${dir[@]} --no-folding --adopt