#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# source the env variables which appends to path and sets some TERMCAP stuff
if [ -f .config/.env ]; then
    . ~/.config/.env
fi

export HISTCONTROL=ignoredups:erasedups
export HISTIGNORE="pwd:ls:la:ll:cd:.."
export HISTSIZE=1000000
export HISTFILESIZE=1000000

# Source the aliases
if [ -f ~/.config/.aliases ]; then
    . ~/.config/.aliases
fi

# Set the prompt
PS1='\[\e[1;32m\]$? \u@\h \W \$\[\e[m\] '

# Prepend any path with cd
shopt -s autocd
