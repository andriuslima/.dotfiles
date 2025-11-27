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










if command -v conda &>/dev/null; then
    log info 'miniconda3 already installed. Performing update'
    source $HOME/miniconda3/bin/activate
    conda update conda --yes
else
    log info 'Installing: miniconda3'
    mkdir -p $HOME/miniconda3
    curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o $HOME/miniconda3/miniconda.sh
    bash $HOME/miniconda3/miniconda.sh -b -u -p $HOME/miniconda3
    rm $HOME/miniconda3/miniconda.sh
fi

log info "Setting Python"

conda config --quiet --add channels conda-forge --quiet
conda config --quiet --add channels defaults
conda config --quiet --set changeps1 false
conda config --quiet --set auto_activate_base false
conda config --quiet --set ssl_verify false