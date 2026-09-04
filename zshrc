# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt autocd extendedglob notify hist_ignore_all_dups
unsetopt beep

bindkey '^R' history-incremental-search-backward

# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/ducky/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# my environment variables
export EDITOR=vim


# For vi insert mode
#bindkey -v
#bindkey '^R' history-incremental-search-backward

#bindkey kj vi-cmd-mode

# Add aliases
source $HOME/.config/.aliases

#zstyle ':completion:*' menu select
# Only complete .tex files for the `nvim` command
zstyle ':completion:*:*:nvim:*' file-patterns '*.tex:tex-files' '%p:all-files'

# https://aur.archlinux.org/zsh-theme-powerlevel10k-git.git
source /home/ducky/.config/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# https://github.com/zdharma-continuum/fast-syntax-highlighting
#source ~/AUR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# zoxide
eval "$(zoxide init zsh)"
export _ZO_ECHO=1

# add ~/scripts to path
path+=('$HOME/scripts/')
# add the .local/bin directory to path
path+=('$HOME/.local/bin/')
# add .cargo/ into the path
path+=('$HOME/.cargo/bin/')
export PATH

#export LESS='-R -F -N -X -S -i'
#export LESS='-F'
export LESS='--wordwrap -i -F --use-color --mouse --wheel-lines=5 -R'

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
