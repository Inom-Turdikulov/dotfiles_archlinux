exists()
{
  command -v "$1" >/dev/null 2>&1
}

autoload -U colors && colors	# Load colors
autoload -Uz compinit && compinit # Load autocomplete

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

# Set basic configs
setopt autocd beep extendedglob nomatch notify appendhistory interactive_comments

HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000

# bind keys
bindkey -e # Enable emacs key bindings
bindkey '^y' autosuggest-accept

# No validation (path checking), to ensure zsh files exist
# manual install (not recommended) git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /usr/share/zsh-theme-powerlevel10k
POWER_LEVEL_THEME=/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
if [[ -f $POWER_LEVEL_THEME ]]; then
    source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Key bindings
FZF_KEYBINDIGS=/usr/share/fzf/key-bindings.zsh
FZF_COMPLETION=/usr/share/fzf/completion.zsh
[[ ! -f $FZF_KEYBINDIGS ]] || source $FZF_KEYBINDIGS
[[ ! -f $FZF_COMPLETION ]] || source $FZF_COMPLETION

if [[ -r "$HOME/.local/share/zsh-toggle-command-prefix/toggle-command-prefix.zsh" ]]; then
  source "$HOME/.local/share/zsh-toggle-command-prefix/toggle-command-prefix.zsh"
fi

export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT ]]; then
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Enable direnv
if exists direnv; then
    eval "$(direnv hook zsh)"
fi

# Disable Software Flow Control to use C-s and C-q in programs
stty start undef
stty stop undef

# NNN cd on exit, and run the n command instead of nnn
# (more precisely the n function).
if [ -f /usr/share/nnn/quitcd/quitcd.bash_zsh ]; then
    source /usr/share/nnn/quitcd/quitcd.bash_zsh
fi

# Enable zsh-autocomplete
# manual install (not recommended)
# git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/zsh/plugins/zsh-autosuggestions
ZSH_AUTOCOMPLETE_PATH=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
if [[ -f $ZSH_AUTOCOMPLETE_PATH ]]; then
    source $ZSH_AUTOCOMPLETE_PATH
    ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
else
    echo "zsh-autocomplete not found"
fi

START_DIR="$HOME/Projects/main/wiki/"
if [[ -d $START_DIR ]]; then
    cd $START_DIR
fi
