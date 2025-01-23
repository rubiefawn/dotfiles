#!/bin/sh
case $- in *i*) ;; *) return ;; esac
. ~/.shrc

# export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

function git-info-color {
	[ -d .git ] && printf " \e[95m$(git name-rev --name-only @)\e[0m@\e[95m$(git rev-parse --short=7 @)\e[0m"
}

function git-info {
	[ -d .git ] && printf " $(git name-rev --name-only @)@$(git rev-parse --short=7 @)"
}

function exit-status-color { [ $? -ne 0 ] && printf " \e[91m${1}\e[0m"; }
function exit-status { [ $? -ne 0 ] && printf "!${1}"; }

if [ $(tput colors) -ge 16 ]; then
	PS1='\e[93m\u\e[0m@\e[93m\H \e[96m\w$(git-info-color)$(exit-status-color $?)\e[0m\n🐚 '
else
	PS1='\u@\H \w$(git-info)$(exit-status $?)\n$ '
fi

unset git-info-color git-info exit-status-color exit-status
