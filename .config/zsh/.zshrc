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

# # # aliases # # #

# homebrew
alias bu='brew upgrade'

# latex
alias bibfix="rm -rf `biber --cache`; biber --version"

# cmake
alias cmakec='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'

# git
alias gd='git diff'
alias gl='git log'
alias glo='git log --pretty="oneline"'
alias gr='git remote'
alias grs='git remote show'
alias gs='git status'

# # # aliases end # # #

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# # # python
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/python/python.plugin.zsh

builtin which py > /dev/null || alias py='python3'

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

# compinstall
# https://github.com/zsh-users/zsh-completions

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'l:|=* r:|=*'
zstyle :compinstall filename '/Users/sparkes/.config/zsh/.zshrc'

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
  fi

# Additionally, if you receive "zsh compinit: insecure directories" warnings when attempting to load these completions, you may need to run these commands:
# chmod go-w '/opt/homebrew/share'
# chmod -R go-w '/opt/homebrew/share/zsh'


# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
