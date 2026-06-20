#!/bin/zsh

# Links Kiro steering files from the source of truth to the Kiro config directory

SOURCE_DIR="$HOME/Documents/AI/Steering"
TARGET_DIR="$HOME/.kiro/steering"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Source directory does not exist: $SOURCE_DIR"
  exit 1
fi

mkdir -p "$TARGET_DIR"

for file in "$SOURCE_DIR"/*; do
  name=$(basename "$file")
  link="$TARGET_DIR/$name"

  if [[ -L "$link" ]]; then
    echo "Link already exists: $link -> $(readlink "$link")"
  else
    ln -s "$file" "$link"
    echo "Created link: $link -> $file"
  fi
done
