# Browser
export BROWSER="qutebrowser"

# Terminal
export TERMINAL='st'
export TERM=xterm-256color

# Editors
export EDITOR="e"
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

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Add `~/.local/bin`
export PATH="$HOME/.local/bin:$HOME/.local/bin/statusbar:$HOME/.emacs.d/bin:$PATH";

# Configure default fzf (fuzzy-finder) command
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

# Set ssh agent vars
export SSH_AGENT_PID=""
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"

# Archlinux specific environment variables
export QT_QPA_PLATFORMTHEME=qt5ct
export ELM_SCALE=2
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_AUTO_SCREEN_SET_FACTOR=0
export QT_SCALE_FACTOR=2
export QT_FONT_DPI=96

export XCURSOR_PATH=$RUNTIME/usr/share/icons
