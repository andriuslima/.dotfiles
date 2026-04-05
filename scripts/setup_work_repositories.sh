#!/usr/bin/env zsh

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

DOMAIN="bitbucket.org"
WORKSPACE="associa_it"
CODES_DIR="$HOME/Codes/work"

REPOS=(
    "associa_service_corporate_accounting"
    "ca_ais_integrations"
    "ca_api_test"
    "ca_common_pkg"
    "ca_datawarehouse"
    "ca_docker_builder"
    "ca_frontend"
    "ca_graphql"
    "ca_infrastructure"
    "ca_integrations"
    "ca_intelligence"
    "ca_misc"
    "ca_reports"
    "ca_service_associa-proxy"
    "ca_service_billing"
    "ca_service_closing"
    "ca_service_community"
    "ca_service_notification"
    "ca_service_order"
    "ca_service_product"
    "ca_service_question"
    "ca_service_reporting"
    "ca_service_user"
    "ca_webhook_provider"
    "ca_workers"
)

log info '|||> Setting Directories'

mkdir -p $CODES_DIR
cd $CODES_DIR

for REPO in "${REPOS[@]}"; do
    if [ -d "$REPO" ]; then
        log warn "Directory '$REPO' already exists. Updating..."
        pushd "$REPO" > /dev/null
        
        # Check for unstaged changes
        if [[ -n $(git status --porcelain) ]]; then
            log warn "Unstaged changes detected in $REPO. Stashing..."
            git stash > /dev/null 2>&1
        fi

        log info "Pulling latest changes in $REPO..."
        git pull > /dev/null 2>&1
        
        log info "Pruning remote branches and cleaning up local branches in $REPO..."
        git fetch -p > /dev/null 2>&1
        for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do
            git branch -D $branch > /dev/null 2>&1
        done
        
        popd > /dev/null
    else
        log info "Cloning $REPO..."
        git clone "git@$DOMAIN:$WORKSPACE/$REPO.git" $CODES_DIR/$REPO > /dev/null 2>&1
    fi
done