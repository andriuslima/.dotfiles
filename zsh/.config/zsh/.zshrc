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
alias ll='ls -l'
alias la='ls -la'
alias zshconfig='$EDITOR $ZDOTDIR/'
alias dotconfig='$EDITOR $HOME/.dotfiles/'
alias codes='cd $HOME/Codes/'
alias tsq='cd $HOME/Codes/tsq/'
alias ca='cd $HOME/Codes/ca/'
alias g='git'
alias glog='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --stat'
alias gs='git status'
alias gc='git commit -m'
alias gca='git commit --amend --no-edit'

# Exports
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.dotnet/tools:$PATH
export PATH=$BUN_INSTALL/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export DOTNET_ROOT="/usr/local/share/dotnet"
export HISTFILE=$ZDOTDIR/.zsh_history # History filepath
export HISTSIZE=10000 # Maximum events for internal history
export SAVEHIST=$HISTSIZE # Maximum events in history file
export HISTDUP=erase
export WORDCHARS=${WORDCHARS//[\/]}
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export EDITOR=code
export BUN_INSTALL="$HOME/.bun"

# Options
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

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

# Keymaps
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Conda Settings
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/andriuslima/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/andriuslima/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/andriuslima/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/andriuslima/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Sdkman
export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# FZF
[ -f "${XDG_CONFIG_HOME}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME}"/fzf/fzf.zsh
source <(fzf --zsh)

# bun completions
[ -s "/Users/andriuslima/.bun/_bun" ] && source "/Users/andriuslima/.bun/_bun"

#Starship
eval "$(starship init zsh)"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
