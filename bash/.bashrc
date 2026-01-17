# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

PATH=$PATH:"/sbin/"

alias ll="ls -la"
alias vi="~/.local/bin/nvim"
alias xpl="xdg-open ."

# run gparted
# xauth generate :1 . trusted

# . "$HOME/.local/share/../bin/env"

export LESS="-R"

source ~/.bashrc.old

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Initialize DBus and unlock gnome-keyring for Antigravity
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval $(dbus-launch --sh-syntax --exit-with-session)
fi
gnome-keyring-daemon --start --components=secrets >/dev/null 2>&1

# Load Angular CLI autocompletion.
source <(ng completion script)

# Added by Antigravity CLI installer
export PATH="/home/zzz1/.local/bin:$PATH"

if command -v tmux &>/dev/null && [ -z "$TMUX" ] && [[ $- == *i* ]]; then
  exec tmux new-session -A -s main
fi

export PATH="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:$PATH"
