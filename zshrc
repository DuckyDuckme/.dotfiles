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

# Add aliases
[[ -f ~/.config/.aliases ]] && source ~/.config/.aliases

#zstyle ':completion:*' menu select
# Only complete .tex files for the `nvim` command
zstyle ':completion:*:*:nvim:*' file-patterns '*.tex:tex-files' '%p:all-files'

# https://aur.archlinux.org/zsh-theme-powerlevel10k-git.git
source /home/ducky/.config/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source the .env file
[[ -f ~/.config/.env ]] && source ~/.config/.env

# zoxide
eval "$(zoxide init zsh)"
export _ZO_ECHO=1

export LESS='--wordwrap -i -F --use-color --mouse --wheel-lines=5 -R'

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
