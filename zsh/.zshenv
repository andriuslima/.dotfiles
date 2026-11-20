export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export DOTFILES_DIR=$HOME/.dotfiles/
export ZAP_DIR=$XDG_DATA_HOME/zap
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
export STARSHIP_CACHE=$XDG_CACHE_HOME/starship/
export NVM_DIR=$XDG_CONFIG_HOME/nvm
export DOTNET_ROOT=$HOME/.dotnet

export EDITOR=vim

# Path (typeset -U keeps entries unique across shell invocations)
typeset -U path
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.dotnet/tools:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export PATH=$DOTNET_ROOT:$PATH

## Work environment variables
export AWS_PROFILE=ca-devqa