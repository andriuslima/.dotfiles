#!/bin/bash

set -e

KIRO_HOME="$HOME/.kiro"
DOTFILES_KIRO="$HOME/.dotfiles/kiro"

echo "Backing up Kiro configuration..."

# Settings
mkdir -p "$DOTFILES_KIRO/settings"
cp "$KIRO_HOME/settings/mcp.json" "$DOTFILES_KIRO/settings/mcp.json"
cp "$KIRO_HOME/settings/permissions.yaml" "$DOTFILES_KIRO/settings/permissions.yaml"

# Skills
rm -rf "$DOTFILES_KIRO/skills"
cp -r "$KIRO_HOME/skills" "$DOTFILES_KIRO/skills"

# Steering
rm -rf "$DOTFILES_KIRO/steering"
cp -r "$KIRO_HOME/steering" "$DOTFILES_KIRO/steering"

echo "Kiro backup complete."
