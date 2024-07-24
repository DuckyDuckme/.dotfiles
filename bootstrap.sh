#!/bin/bash
#
# A small script to setup my dotfiles from github based on M. Seri's bootstrapping script

link() {
    echo -n "Linking $2..."
    ln -sf $1 $2
    echo "done"
}

copy() {
    echo -n "Copying $2..."
    cp -fr $1 $2
    echo "done"
}
    
install() {
    $1 "$HOME/.dotfiles/gitconfig" "$HOME/.gitconfig"
    $1 "$HOME/.dotfiles/bashrc" "$HOME/.bashrc"
    $1 "$HOME/.dotfiles/inputrc" "$HOME/.inputrc"
    $1 "$HOME/.dotfiles/vimrc" "$HOME/.vimrc"
    $1 "$HOME/.dotfiles/xinitrc" "$HOME/.xinitrc"
    $1 "$HOME/.dotfiles/zshrc" "$HOME/.zshrc"

    $1 "$HOME/.dotfiles/.config" "$HOME"

}

print_usage() {
    echo -e "USAGE:\n./bootstrap.sh [OPTIONS] are either:\n\n\
    -l, --link\t Link the files from this repository to their destination.\n\
    -c, --copy\t Copy the files to their destination (default)"
}

run() {
    if [[ $1 == "-l" || $1 == "--link" ]]; then
	install link
    elif [[ -z $1 || $1 == "-c" || $1 == "--copy" ]]; then
	# default
	install copy
    else
	print_usage
	exit 1
    fi
}

run $1
