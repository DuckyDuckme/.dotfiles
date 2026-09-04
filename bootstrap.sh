#!/bin/bash
#
# A small script to setup my dotfiles from github based on M. Seri's bootstrapping script

#SOURCE_DIR=$(dirname "$(readlink -f "$0")")
SOURCE_DIR=$(realpath "$0")

link() {
    echo -n "Linking $1... "
    ln -s $1 $2
    echo "done"
}

copy() {
    echo -n "Copying $1... "
    cp -r $1 $2
    echo "done"
}
    
install() {
    for f in /home/ducky/.dotfiles/*; do
	name="${f##*/}"

	# we look for actual files and also those without an extension as these turn out to be the problematic ones
	if [[ -f "$f" && "$name" != *.* ]]; then
	    echo -e "$name" "$HOME/.$name"
	fi
    done
    #$1 "$HOME/.dotfiles/gitconfig" "$HOME/.gitconfig"
    #$1 "$HOME/.dotfiles/bashrc" "$HOME/.bashrc"
    #$1 "$HOME/.dotfiles/inputrc" "$HOME/.inputrc"
    #$1 "$HOME/.dotfiles/vimrc" "$HOME/.vimrc"
    #$1 "$HOME/.dotfiles/xinitrc" "$HOME/.xinitrc"
    #$1 "$HOME/.dotfiles/zshrc" "$HOME/.zshrc"

    $1 "$HOME/.dotfiles/.config" "$HOME"
}

ask_for_interactive() {
    # ask if we want to install things interactively
    # what i mean by this is asking at each file for options
    echo -e "Run interactively?"
}

print_usage() {
    echo -e "USAGE:\n./bootstrap.sh [OPTIONS] are either:\n\n\
-l, --link\t Link the files from this repository to their destination.\n\
-c, --copy\t Copy the files to their destination"
}

run() {
    if [[ $1 == "-l" || $1 == "--link" ]]; then
	install link
    elif [[ $1 == "-c" || $1 == "--copy" ]]; then
	install copy
    else
	# default
	print_usage
	exit 1
    fi
}

run $1
