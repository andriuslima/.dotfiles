#!/usr/bin/env zsh

# refresh_work_repositories.sh
#
# Goal: bring every repository under "$HOME/Codes/work" onto the develop branch
# (falling back to master/main when develop does not exist), pulling the latest
# changes and cleaning up stale local branches via `pruner`.
#
# Rules:
#   - Uncommitted changes                -> skip, report at the end
#   - On a feature branch                -> push commits, switch to the main
#                                           branch, pull, fetch --prune, pruner
#   - On a main branch (develop/master/  -> if there are unpushed commits, skip
#     main)                                 and report; otherwise pull, switch
#                                           to develop, pull, fetch --prune, pruner
#   - Report repositories with pending changes and unpushed commits at the end.

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

CODES_DIR="$HOME/Codes/work"

# Repositories reported at the end.
SKIPPED_DIRTY=()      # uncommitted changes
SKIPPED_UNPUSHED=()   # on a main branch with commits not pushed

# Shared functions (pruner, ...). Located alongside .zshrc.
FUNCTIONS_FILE="$ZDOTDIR/functions.zsh"
if [[ -f "$FUNCTIONS_FILE" ]]; then
    source "$FUNCTIONS_FILE"
else
    log error "Shared functions file not found at $FUNCTIONS_FILE."
    exit 1
fi

# Return the preferred main branch that exists locally: develop > master > main.
function main_branch() {
    for candidate in develop master main; do
        if git show-ref --verify --quiet "refs/heads/$candidate"; then
            echo "$candidate"
            return 0
        fi
    done
    return 1
}

# Whether the current branch has commits not pushed to its upstream.
# Returns 0 (true) when there are unpushed commits or no upstream is set.
function has_unpushed_commits() {
    local upstream
    upstream=$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null)
    if [[ -z "$upstream" ]]; then
        # No upstream configured: treat any local commits as unpushed.
        return 0
    fi
    [[ -n $(git rev-list "$upstream"..HEAD 2>/dev/null) ]]
}

if [[ ! -d "$CODES_DIR" ]]; then
    log error "Directory $CODES_DIR does not exist. Nothing to refresh."
    exit 1
fi

cd "$CODES_DIR"

for REPO in */; do
    REPO="${REPO%/}"

    # Only process git repositories.
    if [[ ! -d "$REPO/.git" ]]; then
        continue
    fi

    pushd "$REPO" > /dev/null

    # 1. Uncommitted changes -> skip and report.
    if [[ -n $(git status --porcelain) ]]; then
        log warning "[$REPO] Uncommitted changes detected. Skipping."
        SKIPPED_DIRTY+=("$REPO")
        popd > /dev/null
        continue
    fi

    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    TARGET_BRANCH=$(main_branch)

    if [[ -z "$TARGET_BRANCH" ]]; then
        log error "[$REPO] No develop/master/main branch found. Skipping."
        popd > /dev/null
        continue
    fi

    if [[ "$CURRENT_BRANCH" == "develop" || "$CURRENT_BRANCH" == "master" || "$CURRENT_BRANCH" == "main" ]]; then
        # 2. On a main branch.
        if has_unpushed_commits; then
            log warning "[$REPO] On '$CURRENT_BRANCH' with unpushed commits. Skipping."
            SKIPPED_UNPUSHED+=("$REPO")
            popd > /dev/null
            continue
        fi

        log info "[$REPO] On '$CURRENT_BRANCH'. Pulling latest changes..."
        git pull > /dev/null 2>&1

        if [[ "$CURRENT_BRANCH" != "$TARGET_BRANCH" ]]; then
            log info "[$REPO] Switching to '$TARGET_BRANCH'..."
            git checkout "$TARGET_BRANCH" > /dev/null 2>&1
            log info "[$REPO] Pulling latest changes on '$TARGET_BRANCH'..."
            git pull > /dev/null 2>&1
        fi

        log info "[$REPO] Pruning remote branches and cleaning up local branches..."
        pruner > /dev/null 2>&1
    else
        # 3. On a feature branch.
        log info "[$REPO] On feature branch '$CURRENT_BRANCH'. Pushing committed changes..."
        if git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' > /dev/null 2>&1; then
            git push > /dev/null 2>&1
        else
            log info "[$REPO] No upstream set for '$CURRENT_BRANCH'. Setting upstream while pushing..."
            git push --set-upstream origin "$CURRENT_BRANCH" > /dev/null 2>&1
        fi

        log info "[$REPO] Switching to '$TARGET_BRANCH'..."
        git checkout "$TARGET_BRANCH" > /dev/null 2>&1

        log info "[$REPO] Pulling latest changes on '$TARGET_BRANCH'..."
        git pull > /dev/null 2>&1

        log info "[$REPO] Pruning remote branches and cleaning up local branches..."
        pruner > /dev/null 2>&1
    fi

    popd > /dev/null
done

# Final report.
echo ""
log info "|||> Refresh complete"

if [[ ${#SKIPPED_DIRTY[@]} -gt 0 ]]; then
    log warning "Repositories with uncommitted changes (skipped):"
    for repo in "${SKIPPED_DIRTY[@]}"; do
        log warning "  - $repo"
    done
fi

if [[ ${#SKIPPED_UNPUSHED[@]} -gt 0 ]]; then
    log warning "Repositories on a main branch with unpushed commits (skipped):"
    for repo in "${SKIPPED_UNPUSHED[@]}"; do
        log warning "  - $repo"
    done
fi

if [[ ${#SKIPPED_DIRTY[@]} -eq 0 && ${#SKIPPED_UNPUSHED[@]} -eq 0 ]]; then
    log info "All repositories refreshed with no pending changes."
fi
