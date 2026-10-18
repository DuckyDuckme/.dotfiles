HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# taken from ~~stack~~ Claude
setopt SHARE_HISTORY EXTENDED_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

unsetopt beep

bindkey -v # to set vim keybindings

# puts a huge fzf script into zsh
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
# to pick files fuzzily and paste them into the command line
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# sets Ctrl-R to fuzzy search through history
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# source two plugins
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh   # must be the last line

# The following lines were added by compinstall
zstyle :compinstall filename '/home/ducky/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Add aliases
[[ -f ~/.config/shell/aliases ]] && source ~/.config/shell/aliases

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'      # case-insensitive: cd dow<TAB> → Downloads
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # colored file completion
# Only complete .tex files for the `nvim` command
zstyle ':completion:*:*:nvim:*' file-patterns '*.tex:tex-files' '%p:all-files'

# source the .env file
[[ -f ~/.config/shell/env ]] && source ~/.config/shell/env

# zoxide
eval "$(zoxide init zsh)"
export _ZO_ECHO=1

export LESS='--wordwrap -i -F --use-color --mouse --wheel-lines=5 -R'

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/usr/bin/mamba';
export MAMBA_ROOT_PREFIX="$HOME/.local/share/mamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
