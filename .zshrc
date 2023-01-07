autoload -U colors && colors	# Load colors

# Set GPG TTY
# If gnupg2 and gpg-agent 2.x are used, be sure to set the environment variable GPG_TTY.
export GPG_TTY=$(tty)

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{profile,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt autocd beep extendedglob nomatch notify appendhistory interactive_comments
bindkey -e


# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)  # Include hidden files.


# Enable conda
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# Enable direnv
eval "$(direnv hook zsh)"

# No validation (path checking), to ensure zsh files exist
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -r "/usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]]; then
  source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
  function zvm_after_init() {
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
  }
fi


export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
