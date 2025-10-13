#!/usr/bin/env zsh

modules=(
codes
git
scripts
sdkman
ssh
starship
zsh
)

stow ${modules[@]} --no-folding --restow
