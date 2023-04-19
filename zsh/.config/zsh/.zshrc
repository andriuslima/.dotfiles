[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

plug "zap-zsh/zap-prompt"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "zap-zsh/completions"
#plug "zap-zsh/nvm"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "hlissner/zsh-autopair"
plug "Aloxaf/fzf-tab"
plug "wintermi/zsh-brew"


# Alias
alias la='exa --long --icons --all --sort name --created --modified --group --header'
alias ll='exa --long --icons --all --sort name --header --no-time'
alias v='nvim'
alias vim='nvim'
alias dkmonitor='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}"'
alias dkcompose='docker-compose'
alias zshconfig='$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc'
alias codes='cd $HOME/Codes/'
alias tsq='cd $HOME/Codes/tsq/'
alias python='python3'
alias lg='lazygit'
alias g='git'
alias glog='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --stat'
alias gs='git status'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gca!='git commit --amend --no-edit'

# Exports
export HISTFILE=$ZDOTDIR/.zhistory # History filepath
export HISTSIZE=10000 # Maximum events for internal history
export SAVEHIST=10000 # Maximum events in history file
export WORDCHARS=${WORDCHARS//[\/]}
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/dotnet/:$PATH
export PATH=$HOME/.bin/jetbrains/:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export PATH=$XDG_CONFIG_HOME/yarn/global/node_modules/.bin:$PATH
export PATH=$HOME/.local/share/:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/google-cloud-sdk/bin:$PATH
export PATH=$HOME/.local/bin/:$PATH
export PATH=$HOME/.dotnet/tools:$PATH
export SDKMAN_DIR=$XDG_CONFIG_HOME/sdkman
export NVM_DIR=$XDG_CONFIG_HOME/nvm
export GOPATH=$HOME/Codes/go
export EDITOR=code

# Functions
function get_project() {
    find $HOME/Codes/tsq $HOME/Codes/personal $HOME/Codes/projects -mindepth 1 -maxdepth 1 -type d | fzf
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
