#!/usr/bin/env bash

export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help";

export PATH=$HOME/.local/jbin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/sbin:$PATH

export PATH=$HOME/go/bin:$PATH

alias ll='ls -lash'
alias xpl='xdg-open .'
alias myrootfind=myrootfind
alias myfind=myfind
alias locatedir=locate_dir
alias displaylog='tail -fn 100 $1'
alias vi="nvim -u ~/.config/nvim/init.vim"

alias fuzzy='find * -type f | fzy | cat'
# alias cp='rsync --info=progress2'

alias dvorak='/usr/bin/xmodmap ~/dotfiles/files/.xmodmap-dvorak'
alias qwerty='/usr/bin/setxkbmap -layout us && /usr/bin/xmodmap -e "keycode 66 = Escape Escape"'

locate_dir()
{
    in=$(locate $1);
    echo $(dirname $in);
};

myrootfind()
{
    find / -path /timeshift -prune -o -iname $1 2>&1 | grep -iv "permission";
}

myfind()
{
    find $1 -path /timeshift -prune -o -iname $2 2>&1 | grep -iv "permission"
};

export EDITOR=vi

