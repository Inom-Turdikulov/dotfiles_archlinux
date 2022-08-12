# Terminal
export TERMINAL='st'
export TERM=xterm-256color

# Editors
export EDITOR="env TERM=xterm-24bit emacsclient -t -a emacs"
export VISUAL="$EDITOR"
export PAGER='less'

# https://wiki.gentoo.org/wiki/Man_page#Color_for_man_pages
export MANPAGER="less -R --use-color -Dd+r -Du+b"

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
export HISTCONTROL='ignoreboth';

# Language
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8';

# Set GPG TTY
# If gnupg2 and gpg-agent 2.x are used, be sure to set the environment variable GPG_TTY.
export GPG_TTY=$(tty)

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Add `~/.local/bin`
export PATH="$HOME/.local/bin:$HOME/.local/bin/statusbar:$PATH";

# Configure default fzf (fuzzy-finder) command
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

# Set ssh agent vars
export SSH_AGENT_PID=""
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
