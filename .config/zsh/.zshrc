# # # maybe someday
# https://getantidote.github.io/usage

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# locale
export LC_ALL=en_GB.UTF-8

# # # keys

set -o emacs

bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest

bindkey "\e\e[D" emacs-backward-word  # | option + <-
bindkey "^[[1;5D" emacs-backward-word # | ctl + <-
bindkey "\e\e[C" emacs-forward-word   # | option + ->
bindkey "^[[1;5C" emacs-forward-word  # | ctl + ->

# # # aliases # # #

# homebrew
alias bu='brew upgrade'

# cmake
alias cmakec='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'

# git
alias gdiff='git diff'
alias glog='git log'
alias glogl='git log --pretty="oneline"'
alias grem='git remote'
alias grems='git remote show'
alias gs='git status'
alias groot='git rev-parse --show-toplevel'

# # # aliases end # # #

# # # python
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/python/python.plugin.zsh
alias py='python3'
alias py3='python3'

alias pyfind='find . -name "*.py"'
alias pygrep='grep -nr --include="*.py"'

function pyclean() {
  find "${@:-.}" -type f -name "*.py[co]" -delete
  find "${@:-.}" -type d -name "__pycache__" -delete
  find "${@:-.}" -depth -type d -name ".mypy_cache" -exec rm -r "{}" +
  find "${@:-.}" -depth -type d -name ".pytest_cache" -exec rm -r "{}" +
}

# # # macos
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

function pfd() {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (insertion location as alias)
    end tell
EOF
}

function cdf() {
  cd "$(pfd)"
}

function rmdsstore() {
  find "${@:-.}" -type f -name .DS_Store -delete
}


# # # misc. functions

function find-up() {
  search_path=$(pwd)
  while [[ "$search_path" != "" && ! -e "$search_path/$1" ]]; do
    search_path=${search_path%/*}
  done
  if [[  -e $search_path ]]; then
      echo "$search_path"
  else
      echo "failure: could not find $1 in any parent of $(pwd)"
  fi
}


function venv-up() {
  search_path=$(pwd)
  while [[ "$search_path" != "" && ! -e "$search_path/.venv" ]]; do
    search_path=${search_path%/*}
  done
  if [[  -e $search_path ]]; then
      source "$search_path/.venv/bin/activate"
  else
      echo "failure: could not find a .venv folder in any parent of $(pwd)"
  fi
}


# # # completions

# compinstall
# https://github.com/zsh-users/zsh-completions

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle :compinstall filename '/Users/sparkes/.config/zsh/.zshrc'

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

# Additionally, if you receive "zsh compinit: insecure directories" warnings when attempting to load these completions, you may need to run these commands:
# chmod go-w '/opt/homebrew/share'
# chmod -R go-w '/opt/homebrew/share/zsh'


# # # autosuggestions

# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
