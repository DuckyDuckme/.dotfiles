#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Export some env variables for me
export EDITOR=/bin/vim
export PATH=$HOME:/opt:$PATH
export VISUAL=/bin/vim
export HISTCONTROL=ignoredups:erasedups
export BROWSER=/usr/bin/firefox
export HISTIGNORE="pwd:ls:la:ll:cd:.."
export HISTSIZE=1000000
export HISTFILESIZE=1000000

# Set coloured ls with dircolors
# eval `dircolors -b ~/.dir_colors`

# Set some aliases
alias reboot='doas reboot'
alias pac='doas pacman -Syu'
alias ll='ls -l'
alias la='ls -lAh'
alias ls='ls --color=auto'
alias ..='cd ..'
alias diskspace="du -S | sort -n -r | more"
alias grep="grep --color=auto"
alias samba="ssh k.pudowski@samba.fmf.nl"
alias rm="rm -I" # this shit is dangerous
alias shut="shutdown now"

# Set the prompt
PS1='\e[1;32m$? \u@\h \W \$\e[m '

# Prepend any path with cd
shopt -s autocd

# Search the official repositories, when entering an unrecognized command
# It takes a lot of time when there is no command
#source /usr/share/doc/pkgfile/command-not-found.bash

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Extract a compressed file function
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
