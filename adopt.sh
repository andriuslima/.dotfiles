#!/usr/bin/env zsh

dir=(
    git
    scripts
    sdkman
    ssh
    starship
    zsh
)

stow ${dir[@]} --no-folding --adopt

