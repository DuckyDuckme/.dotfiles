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
setopt autocd extendedglob notify
unsetopt beep

# For vi insert mode
bindkey -v
bindkey '^R' history-incremental-search-backward

bindkey kj vi-cmd-mode
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ducky/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Add aliases
source $HOME/.config/.aliases

#zstyle ':completion:*' menu select
# Only complete .tex files for the `nvim` command
zstyle ':completion:*:*:nvim:*' file-patterns '*.tex:tex-files' '%p:all-files'

# https://aur.archlinux.org/zsh-theme-powerlevel10k-git.git
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# https://github.com/zdharma-continuum/fast-syntax-highlighting
#source ~/AUR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# oh-my-zsh plugins
plugins=(
colored-man-pages
)

# zoxide
eval "$(zoxide init zsh)"
export _ZO_ECHO=1
