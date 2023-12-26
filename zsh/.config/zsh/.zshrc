[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

plug "zap-zsh/fzf"
plug "zap-zsh/completions"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "hlissner/zsh-autopair"
plug "Aloxaf/fzf-tab"
plug "wintermi/zsh-brew"
plug "wintermi/zsh-starship"


# Alias
alias la='exa --long --icons --all --sort name --created --modified --group --header'
alias ll='exa --long --icons --all --sort name --header --no-time'
alias cat='bat'
alias dkmonitor='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}"'
alias dkcompose='docker-compose'
alias zshconfig='$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc'
alias dotconfig='$EDITOR $HOME/.dotfiles/'
alias codes='cd $HOME/Codes/'
alias tsq='cd $HOME/Codes/tsq/'
alias ca='cd $HOME/Codes/ca/'
alias python='python3.12'
alias lg='lazygit'
alias g='git'
alias glog='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --stat'
alias gs='git status'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gca!='git commit --amend --no-edit'

# Exports
# # PATHS
export PATH=/opt/homebrew/bin/:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/opt/homebrew/opt/dotnet@6/bin:$PATH
export PATH=$HOME/.bin/jetbrains/:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export PATH=$XDG_CONFIG_HOME/yarn/global/node_modules/.bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.dotnet/tools:$PATH
export HISTFILE=$ZDOTDIR/.zhistory # History filepath
export HISTSIZE=10000 # Maximum events for internal history
export SAVEHIST=10000 # Maximum events in history file
export WORDCHARS=${WORDCHARS//[\/]}
export SDKMAN_DIR=$XDG_CONFIG_HOME/sdkman
export NVM_DIR=$XDG_CONFIG_HOME/nvm
export GOPATH=$HOME/Codes/go
export EDITOR=code
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
export STARSHIP_CACHE=$XDG_CACHE_HOME/starship/

# Functions
function get_project() {
    find $HOME/Codes/tsq $HOME/Codes/ca $HOME/Codes/personal $HOME/Codes/projects -mindepth 1 -maxdepth 1 -type d | fzf
}

function go_project() {
    cd $(get_project)
}


function open_project() {
    selected=$(get_project)
    $($EDITOR $selected)
}

gwrapper() {
  gradle wrapper --gradle-version "$1" --distribution-type all
}

grlu() {
   git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done
}

shell_loading_performance() {
    for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done
}

shell_reload() {
    source $XDG_CONFIG_HOME/zsh/.zshrc
}

lt() {
    local level
    if [[ $# -eq 2 ]] then level=$2 else level=1 fi
    exa --long --icons --all --sort name --created --modified --group --header --tree --level="$level" ./$1;
}

profileUpdate() {
    export AWS_PROFILE=$1
}

profileUnset() {
    unset AWS_PROFILE
}

# Keymaps
zle -N open_project
bindkey '^p' 'open_project'

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# Conda Settings
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/andriuslima/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/andriuslima/miniconda/etc/profile.d/conda.sh" ]; then
        . "/Users/andriuslima/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/andriuslima/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# gcloud
if [ -f '/Users/andriuslima/.local/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/andriuslima/.local/google-cloud-sdk/completion.zsh.inc'; fi

# Sdkman
export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# Zoxide config
eval "$(zoxide init zsh)"
