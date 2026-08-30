#!/usr/bin/env zsh

# Shared shell functions.
#
# Sourced from both .zshrc (for interactive use) and standalone scripts, so it
# must stay free of interactive-only assumptions (no prompt/plugin dependencies).

# grlu: fetch --prune and delete local branches whose upstream is gone.
pruner() {
    git fetch -p
    for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}');
        do git branch -D $branch;
    done
}
