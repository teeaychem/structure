eval "$(/opt/homebrew/bin/brew shellenv)"


# ruby
PATH="/opt/homebrew/opt/ruby/bin:$PATH"
GEMSDIR=$(gem environment gemdir)/bin
PATH=$GEMSDIR:$PATH

# llvm / clang, etc.
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# less
export LESSHISTFILE="$XDG_STATE_HOME"/less/history
alias less='less --lesskey-file=$XDG_CONFIG_HOME/lesskey'

# man
alias man='man --pager="less --lesskey-file=$XDG_CONFIG_HOME/lesskey"'

# rust
# export CARGO_HOME=$XDG_DATA_HOME/cargo
# export RUSTUP_HOME=$XDG_DATA_HOME/rustup
# export RUSTBIN="$CARGO_HOME/bin"
export PATH="$PATH:RUSTBIN"

# racket
# export RACKET=/Applications/Racket\ v8.9/bin

# npm / node
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PATH=$PATH:./node_modules/.bin

# hammerspoon
# defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
