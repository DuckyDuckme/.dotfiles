#!/bin/bash
#
# A small script to set up my dotfiles from github
# It only copies into $HOME; the files in .config/system are installed by hand.

# Directory this script lives in (the dotfiles repo)
SOURCE_DIR=$(dirname "$(realpath "$0")")

# Top-level files that are never installed (glob patterns)
SKIP=("$(basename "$0")" 'README*' 'LICENSE*')

# Directories under .config that are never installed
CONFIG_SKIP=(system)

# Every backup made in one run gets the same suffix, so they're easy to find and restore
BACKUP_SUFFIX=".bak.$(date +%Y%m%d-%H%M%S)"

shopt -s nullglob

print_usage() {
    echo -e "USAGE:\n./bootstrap.sh [-h]\n\n\
Copies the dotfiles in this repository into \$HOME. Files that are already\n\
identical are skipped, new files are copied, and existing files are only\n\
replaced after asking. Replaced files are kept as FILE.bak.<date>-<time>.\n\n\
-h, --help\t Show this help."
}

is_skipped() {
    local name="$1" pattern

    for pattern in "${SKIP[@]}"; do
        [[ "$name" == $pattern ]] && return 0
    done
    return 1
}

# Copy $1 to $2. An identical $2 is left alone; a different one is only
# replaced after asking, and the old version is kept as a backup.
install_file() {
    local src="$1" dst="$2" answer

    if [[ -f "$dst" ]] && cmp -s "$src" "$dst"; then
        echo "$dst is up to date"
        return
    fi

    if [[ -e "$dst" || -L "$dst" ]]; then
        while true; do
            read -rp "$dst differs from the repo. Replace it? [y]es/[N]o/[d]iff/[q]uit " answer
            case "$answer" in
                [yY]*)
                    break ;;
                [nN]*|'')
                    echo "Skipped $dst"
                    return ;;
                [dD]*)
                    # - lines are what you have now, + lines come from the repo
                    diff -u --color=auto "$dst" "$src" ;;
                [qQ]*)
                    echo 'Quitting'
                    exit 0 ;;
                *)
                    echo 'Please answer y, n, d or q.' ;;
            esac
        done
        mv "$dst" "$dst$BACKUP_SUFFIX" || return
        echo "Old version kept as $dst$BACKUP_SUFFIX"
    fi

    mkdir -p "$(dirname "$dst")" || return
    echo -n "Copying $src -> $dst... "
    cp "$src" "$dst" && echo "done"
}

# Top-level files go in as ~/.<name>
install_home_files() {
    local f name

    for f in "$SOURCE_DIR"/*; do
        [[ -f "$f" ]] || continue
        name="${f##*/}"
        is_skipped "$name" && continue
        install_file "$f" "$HOME/.$name"
    done
}

# Files under .config go in one at a time at the same path under ~/.config,
# so files the repo doesn't have (like nvim/coc-settings.json) are left alone
install_config() {
    local dir src prune=() files=()

    [[ -d "$SOURCE_DIR/.config" ]] || return 0

    for dir in "${CONFIG_SKIP[@]}"; do
        prune+=(-path "$SOURCE_DIR/.config/$dir" -prune -o)
    done

    # collect the list first so the prompts in install_file can still read from the terminal
    mapfile -d '' files < <(find "$SOURCE_DIR/.config" "${prune[@]}" -type f -print0 | sort -z)

    for src in "${files[@]}"; do
        install_file "$src" "$HOME/.config/${src#"$SOURCE_DIR/.config/"}"
    done
}

parse_args() {
    [[ $# -eq 0 ]] && return

    case "$1" in
        -h|--help)
            print_usage
            exit 0 ;;
        *)
            print_usage
            exit 1 ;;
    esac
}

run() {
    parse_args "$@"
    install_home_files
    install_config
}

run "$@"
