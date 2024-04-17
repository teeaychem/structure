
# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

#LESS
export LESSHISTFILE="$XDG_STATE_HOME"/less/history
alias less='less --lesskey-file=$XDG_CONFIG_HOME/lesskey'

# MAN
alias man='man --pager="less --lesskey-file=$XDG_CONFIG_HOME/lesskey"'

# RUST
# export RUSTBUN="$CARGO_HOME/bin"
# export CARGO_HOME=$XDG_DATA_HOME/cargo
# export RUSTUP_HOME=$XDG_DATA_HOME/rustup

# RACKET
# export RACKET=/Applications/Racket\ v8.9/bin

# NPM
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# HAMMERSPOON
# defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

# PATH
path=(
  "$XDG_DATA_HOME"/cargo/bin
  $path
)

