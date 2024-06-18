eval "$(/opt/homebrew/bin/brew shellenv)"

# ruby
PATH="/opt/homebrew/opt/ruby/bin:$PATH"
GEMSDIR=$(gem environment gemdir)/bin
PATH=$GEMSDIR:$PATH

# llvm / clang, etc.
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# less
export LESSHISTFILE="$XDG_STATE_HOME"/less/history

# man
alias man='man -pager="less"'

# rust
export CARGO_HOME=$HOME/.cargo
export RUSTUP_HOME=$HOME/.rustup
export RUSTBIN="$CARGO_HOME/bin"
export PATH="$PATH:$RUSTBIN"

# racket
# export RACKET=/Applications/Racket\ v8.9/bin

# npm / node
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PATH=$PATH:./node_modules/.bin

# hammerspoon
# defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

#clingo
export CLINGO_LIBRARY_PATH=/opt/homebrew/opt/clingo/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CLINGO_LIBRARY_PATH

# python
export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python_cache

# hunspell
export DICPATH="$XDG_CONFIG_HOME/hunspell/dictionaries"
