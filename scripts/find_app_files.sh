#!/bin/zsh

if [[ -z "$1" ]]; then
  echo "Usage: find_app_files.sh <app_name>"
  exit 1
fi

app_name="$1"

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

echo "Searching for files related to '$app_name'...\n"

all_name_matches=""
all_content_matches=""

for dir in "${directories[@]}"; do
  if [[ ! -d "$dir" ]]; then
    continue
  fi

  # Files with the app name in their name
  name_matches=$(find "$dir" -maxdepth 3 -iname "*${app_name}*" 2>/dev/null)
  if [[ -n "$name_matches" ]]; then
    all_name_matches+="${name_matches}\n"
  fi

  # Files containing the app name in their contents (text files only)
  content_matches=$(grep -rl --include="*.plist" --include="*.xml" --include="*.json" --include="*.txt" --include="*.cfg" --include="*.conf" -i "$app_name" "$dir" 2>/dev/null)
  if [[ -n "$content_matches" ]]; then
    all_content_matches+="${content_matches}\n"
  fi
done

echo "=== File name matches ==="
all_name_matches=$(echo "$all_name_matches" | sed '/^$/d')
if [[ -n "$all_name_matches" ]]; then
  echo "$all_name_matches"
else
  echo "(no matches)"
fi

echo "\n=== File content matches ==="
all_content_matches=$(echo "$all_content_matches" | sed '/^$/d')
if [[ -n "$all_content_matches" ]]; then
  echo "$all_content_matches"
else
  echo "(no matches)"
fi
