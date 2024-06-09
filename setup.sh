#!/bin/zsh

# https://github.com/jorinvo/dotfiles/blob/mac/setup-mac
link_to() {
  if [ ! -e $2 ]; then
    if [ ! -e $1 ]; then
      printf "%s\n" 'WARNING: cannot link $1 because it does not exist'
    else
      mkdir -p "$(dirname "$2")"
      ln -s $1 $2
      printf '%s\n' "Linked $2"
    fi
  fi
}

overlink_to() {
    if [ -e $2 ]; then
        rm $2
    fi
    if [ -L $2 ]; then
        rm $2
    fi
    if [ ! -e $1 ]; then
        printf "%s\n" 'WARNING: cannot link $1 because it does not exist'
    else
        mkdir -p $(dirname $2)
        ln -s $1 $2
        printf '%s\n' "Linked $2"
    fi
}

# takes a single arguments and overlinks anything stored in the repo matching the argument
link_git() {
    if [[ -d $XDG_CONFIG_HOME/$1 || $(mkdir -p $XDG_CONFIG_HOME/$1) ]]
then
    printf '\n%s\n' "Linking $1"
    for tracked_file in $(git ls-tree --full-tree -r --name-only HEAD)
    do
        if [[ ${tracked_file:0:${#1}} == "$1" ]]
        then
            overlink_to "$PWD/$tracked_file" "$XDG_CONFIG_HOME/$tracked_file"
        fi
    done
fi

}

printf '%s\n' "Setting up structure…"

overlink_to $PWD/.zshenv $HOME/.zshenv

source $HOME/.zshenv

mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_DATA_HOME

if [[ $ZDOTDIR != $XDG_CONFIG_HOME/zsh  ]]; then
    echo "Something went wrong setting up .zshenv"
    exit

fi

# https://unix.stackexchange.com/questions/696353/check-if-a-command-exists-revisited
# used for homebrew
if ! command -v -- "brew" > /dev/null 2>&1; then

    printf '%s\n' "I think brew is missing, so trying to install…"

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    eval "$(/opt/homebrew/bin/brew shellenv)"

    brew install powerlevel10k
    brew install zsh-autosuggestions
    brew install zsh-completions
fi

# if brew isn't available, give up
if ! command -v -- "brew" > /dev/null 2>&1; then

    printf '%s\n' "Something went wrong when installing brew, so the rest is up to you…"
    exit

fi

printf '%s\n%s\n' "Brew seems okay so…" "Setting up .config!"

link_git "emacs"
link_git "zsh"
link_git "hunspell"
link_git "latexmk"
link_git "homebrew"
link_git "hammerspoon"
