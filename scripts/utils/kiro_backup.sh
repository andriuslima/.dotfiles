#!/bin/bash

set -e

KIRO_HOME="$HOME/.kiro"
DOTFILES_KIRO="$DOTFILES_DIR/kiro"

echo "Backing up Kiro configuration..."

# Settings
mkdir -p "$DOTFILES_KIRO/settings"
cp "$KIRO_HOME/settings/mcp.json" "$DOTFILES_KIRO/settings/mcp.json"
cp "$KIRO_HOME/settings/permissions.yaml" "$DOTFILES_KIRO/settings/permissions.yaml"

# Skills
if [ -d "$KIRO_HOME/skills" ]; then
  mkdir -p "$DOTFILES_KIRO/skills"
  rsync -a --delete --exclude ".DS_Store" "$KIRO_HOME/skills/" "$DOTFILES_KIRO/skills/"
fi

# Steering
if [ -d "$KIRO_HOME/steering" ]; then
  mkdir -p "$DOTFILES_KIRO/steering"
  rsync -a --delete --exclude ".DS_Store" "$KIRO_HOME/steering/" "$DOTFILES_KIRO/steering/"
fi

# Agents
if [ -d "$KIRO_HOME/agents" ]; then
  mkdir -p "$DOTFILES_KIRO/agents"
  rsync -a --delete --exclude ".DS_Store" "$KIRO_HOME/agents/" "$DOTFILES_KIRO/agents/"
fi

echo "Kiro backup complete."
