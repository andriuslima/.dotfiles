#!/bin/zsh

usage() {
  echo "Usage: remove_app_files.sh <--dry-run|--remove> <app_name>"
  exit 1
}

if [[ $# -ne 2 ]]; then
  usage
fi

mode="$1"
app_name="$2"

if [[ "$mode" != "--dry-run" && "$mode" != "--remove" ]]; then
  usage
fi

directories=(
  "$HOME/Library/Application Support"
  "$HOME/Library/Caches"
  "$HOME/Library/Preferences"
  "$HOME/Library/Saved Application State"
  "$HOME/Library/Containers"
  "$HOME/Library/Group Containers"
  "$HOME/Library/LaunchAgents"
  "/Library/Application Support"
  "/Library/Caches"
  "/Library/Preferences"
  "/Library/LaunchAgents"
  "/Library/LaunchDaemons"
  "/Library/StartupItems"
)

echo "Searching for files/folders named '$app_name'...\n"

all_matches=""

for dir in "${directories[@]}"; do
  if [[ ! -d "$dir" ]]; then
    continue
  fi

  matches=$(find "$dir" -maxdepth 3 -iname "*${app_name}*" 2>/dev/null)
  if [[ -n "$matches" ]]; then
    all_matches+="${matches}\n"
  fi
done

all_matches=$(echo "$all_matches" | sed '/^$/d')

if [[ -z "$all_matches" ]]; then
  echo "(no matches)"
  exit 0
fi

if [[ "$mode" == "--dry-run" ]]; then
  echo "Files/folders that would be removed:"
  echo "$all_matches"
elif [[ "$mode" == "--remove" ]]; then
  echo "$all_matches" | while IFS= read -r item; do
    if [[ -n "$item" && -e "$item" ]]; then
      rm -rf "$item" 2>/dev/null
      if [[ $? -eq 0 ]]; then
        echo "Removed: $item"
      else
        echo "Failed (permission denied): $item"
      fi
    fi
  done
fi
