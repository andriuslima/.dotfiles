#!/usr/bin/env zsh

modules=(
git
scripts
sdkman
ssh
starship
zsh
)

stow ${modules[@]} --no-folding --restow
