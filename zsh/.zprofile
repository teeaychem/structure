if [[ $(uname) == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '$XDG_CONFIG_HOME/.opam/opam-init/init.zsh' ]] || source '$XDG_CONFIG_HOME/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

# llvm / clang, etc.
if [[ $(uname) == "Darwin" ]]; then
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
fi

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
if [[ $(uname) == "Darwin" ]]; then
    export CLINGO_LIBRARY_PATH=/opt/homebrew/opt/clingo/lib
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CLINGO_LIBRARY_PATH
fi

# python
export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python_cache

# hunspell
export DICPATH="$STRUCTURE_HOME/hunspell/dictionaries"

#m4
if [[ $(uname) == "Darwin" ]]; then
    export PATH="/opt/homebrew/opt/m4/bin:$PATH"
fi

if [ -f ~/.config/zsh/.profile_local ]; then
    source ~/.config/zsh/.profile_local
fi
