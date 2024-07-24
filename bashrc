
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Export some env variables for me
export EDITOR=/bin/vim
export PATH=$HOME:/opt:$PATH
export VISUAL=/bin/nvim
export HISTCONTROL=ignoredups:erasedups
export BROWSER=/usr/bin/firefox
export HISTIGNORE="pwd:ls:la:ll:cd:.."
export HISTSIZE=1000000
export HISTFILESIZE=1000000
# export VK_ICK_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json

# Set coloured ls with dircolors
# eval `dircolors -b ~/.dir_colors`

# Source the aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# Set the prompt
PS1='\e[1;32m$? \u@\h \W \$\e[m '

# Prepend any path with cd
shopt -s autocd

# Search the official repositories, when entering an unrecognized command
# It takes a lot of time when there is no command
#source /usr/share/doc/pkgfile/command-not-found.bash

# Color for manpages in less makes manpages a little easier to read
# doesn't work with alacritty
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
