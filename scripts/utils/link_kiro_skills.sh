#!/bin/zsh

# Links Kiro skills from the source of truth to the Kiro config directory

SOURCE_DIR="$HOME/Documents/AI/Skills"
TARGET_DIR="$HOME/.kiro/skills"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Source directory does not exist: $SOURCE_DIR"
  exit 1
fi

mkdir -p "$TARGET_DIR"

for skill in "$SOURCE_DIR"/*; do
  name=$(basename "$skill")
  link="$TARGET_DIR/$name"

  if [[ -L "$link" ]]; then
    echo "Link already exists: $link -> $(readlink "$link")"
  else
    ln -s "$skill" "$link"
    echo "Created link: $link -> $skill"
  fi
done
