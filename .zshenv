
# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache


# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

#LESS
export LESSHISTFILE="$XDG_STATE_HOME"/less/history

# RUST
export RUSTBUN="$HOME/.cargo/bin"

# RACKET
# export RACKET=/Applications/Racket\ v8.9/bin

# PATH
export PATH="$RUSTBUN:$PATH"

