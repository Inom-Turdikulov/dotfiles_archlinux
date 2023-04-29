autoload -U colors && colors	# Load colors

# Set GPG TTY
# If gnupg2 and gpg-agent 2.x are used, be sure to set the environment variable GPG_TTY.
export GPG_TTY=$(tty)

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{profile,profile-keys,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000

setopt autocd beep extendedglob nomatch notify appendhistory interactive_comments

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

# Key bindings
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
bindkey -e # Enable emacs key bindings

if [[ -r "$HOME/.local/share/zsh-toggle-command-prefix/toggle-command-prefix.zsh" ]]; then
  source "$HOME/.local/share/zsh-toggle-command-prefix/toggle-command-prefix.zsh"
fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Enable direnv
eval "$(direnv hook zsh)"

# Disable Software Flow Control to use C-s and C-q in programs
stty start undef
stty stop undef

# NNN cd on exit, and run the n command instead of nnn
# (more precisely the n function).
if [ -f /usr/share/nnn/quitcd/quitcd.bash_zsh ]; then
    source /usr/share/nnn/quitcd/quitcd.bash_zsh
fi

# Enable zsh-autocomplete
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
# bind accept
bindkey '^y' autosuggest-accept
