# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

PATH=$PATH:"/sbin/"

alias ll="ls -la"
alias vi="/sbin/nvim"
alias xpl="xdg-open ."

# run gparted
xauth generate :1 . trusted

. "$HOME/.local/share/../bin/env"

