#!/bin/sh
case $- in *i*) ;; *) return ;; esac
. ~/.shrc

# export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

function git-info-color {
	git rev-parse --is-inside-work-tree >/dev/null 2>&1 && printf " \e[95m%s\e[0m@\e[95m%s\e[0m" "$(git name-rev --name-only @)" "$(git rev-parse --short=7 @)"
}

function git-info {
	git rev-parse --is-inside-work-tree >/dev/null 2>&1 && printf " %s@%s" "$(git name-rev --name-only @)" "$(git rev-parse --short=7 @)"
}

function exit-status-color { [ $? -ne 0 ] && printf " \e[91m${1}\e[0m"; }
function exit-status { [ $? -ne 0 ] && printf "!${1}"; }

if [ $(tput colors) -ge 16 ]; then
	PS1='\e[1;93m\u\e[0m@\e[1;93m\H \e[1;96m\w\e[0m$(git-info-color)$(exit-status-color $?)\e[0m\n🐚 '
else
	PS1='\u@\H \w$(git-info)$(exit-status $?)\n$ '
fi

unset git-info-color git-info exit-status-color exit-status
