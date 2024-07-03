[ -f "$XDG_DATA_HOME/zap/zap.zsh" ] && source "$XDG_DATA_HOME/zap/zap.zsh"

# Plugins
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/completions"
plug "zap-zsh/fzf"
plug "hlissner/zsh-autopair"
plug "Aloxaf/fzf-tab"
plug "wintermi/zsh-brew"

# Alias
alias la='eza --long --icons --all --sort name --created --modified --group --header'
alias ll='eza --long --icons --all --sort name --header --no-time'
alias cat='bat'
alias dkmonitor='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}"'
alias compose='docker-compose'
alias zshconfig='$EDITOR $ZDOTDIR/'
alias dotconfig='$EDITOR $HOME/.dotfiles/'
alias codes='cd $HOME/Codes/'
alias tsq='cd $HOME/Codes/tsq/'
alias ca='cd $HOME/Codes/ca/'
alias python='python3.12'
alias g='git'
alias glog='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --stat'
alias gs='git status'
alias gc='git commit -m'
alias gca='git commit --amend --no-edit'

# Exports
export PATH=/opt/homebrew/bin/:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/opt/homebrew/opt/dotnet@6/bin:$PATH
export PATH=$HOME/.dotnet/tools:$PATH
export PATH=$HOME/.bin/jetbrains/:$PATH
export PATH="$(yarn global bin):$PATH"
export HISTFILE=$ZDOTDIR/.zsh_history # History filepath
export HISTSIZE=10000 # Maximum events for internal history
export SAVEHIST=$HISTSIZE # Maximum events in history file
export HISTDUP=erase
export WORDCHARS=${WORDCHARS//[\/]}
export SDKMAN_DIR=$XDG_CONFIG_HOME/sdkman
export NVM_DIR=$XDG_CONFIG_HOME/nvm
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
export STARSHIP_CACHE=$XDG_CACHE_HOME/starship/
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export CODE_DIR=$HOME/Codes
export CODES_SRC=($CODE_DIR/tsq $CODE_DIR/ca $CODE_DIR/personal $CODE_DIR/projects)
export EDITORS=("code\n\nidea\nwebstorm\nrider\npycharm\n")
export EDITOR=code

# Options
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Functions
function get_project() {
    find $CODES_SRC -mindepth 1 -maxdepth 1 -type d | fzf
}

function get_editors() {
    echo $EDITORS | fzf
}

function go_project() {
    cd $(get_project)
}

function open_project() {
    project=$(get_project)
    editor=$(get_editors)

    $($editor $project)
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
    source $ZDOTDIR/.zshrc
}

lt() {
    local level
    if [[ $# -eq 2 ]] then level=$2 else level=2 fi
    eza --long --icons --all --sort name --created --modified --group --header --tree --level="$level" ./$1;
}

# Keymaps
bindkey -e
bindkey '^x' 'open_project'
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

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

# Sdkman
export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

#Starship
eval "$(starship init zsh)"