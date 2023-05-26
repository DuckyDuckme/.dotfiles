#!/bin/bash
#
# A small script to setup my dotfiles from github

install () {
    if [ ! -d $(dirname $2) ]; then
        echo "Skipping $2: destination directory does not exist"
        return
    fi

    if [ -e $2 -a ! -h $2 ]; then
        echo "Skipping $2: installing would overwrite non-symlink"
        return
    fi

    echo -n "Linking $2..."
    ln -sf $1 $2
    echo "done"
}

if [ "$PWD" != "$HOME/.dotfiles" ]; then
    echo "Please execute bootstap.sh from .dotfiles directory in $HOME"
    exit 1
fi

set -ex

git pull

install "$HOME/.dotfiles/gitconfig" "$HOME/.gitconfig"
install "$HOME/.dotfiles/bashrc" "$HOME/.bashrc"
install "$HOME/.dotfiles/inputrc" "$HOME/.inputrc"
install "$HOME/.dotfiles/vimrc" "$HOME/.vimrc"
install "$HOME/.dotfiles/xinitrc" "$HOME/.xinitrc"
