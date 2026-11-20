#!/usr/bin/env zsh
# Installs agent skills from https://skills.sh globally for Kiro (~/.kiro/skills).
RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'
YELLOW='\033[1;33m'
function log() {
    level=$1
    message=$2
    if [[ $level = 'info' ]]; then
        echo "${GREEN}$message${NOCOLOR}"
    elif [[ $level = 'warning' ]]; then
        echo "${YELLOW}$message${NOCOLOR}"
    else
        echo "${RED}$message${NOCOLOR}"
    fi
}

AGENT="kiro-cli"

# Skills to install, one "<owner/repo> <skill>" per line.
# Add new skills here (see https://www.skills.sh).
SKILLS=(
    "avivsinai/bitbucket-cli bkt"
)

if ! command -v npx &>/dev/null; then
    log error "npx not found. Install Node first (scripts/languages/install_node.sh)"
    exit 1
fi

failed=0
for entry in "${SKILLS[@]}"; do
    repo="${entry%% *}"
    skill="${entry##* }"
    log info "Installing skill: $skill ($repo)"
    if npx -y skills@latest add "$repo" --skill "$skill" --agent "$AGENT" --global --copy --yes; then
        log info "Skill $skill installed"
    else
        log error "Failed to install skill $skill from $repo"
        failed=1
    fi
done

exit $failed
