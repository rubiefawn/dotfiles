function echo-git-info {
	[ -d .git ] && echo " \e[95m$(git name-rev --name-only @)\e[0m@\e[95m$(git rev-parse --short=7 @)\e[0m"
}

function echo-exit-status {
	[ $? -ne 0 ] && echo " \e[91m$1\e[0m"
}

alias ls='ls --color=auto --time-style=long-iso -Fh'
alias ll='ls --color=auto --time-style=long-iso -Fhla'
HELIX=$(command -v hx || command -v helix || $EDITOR)
alias hx=$HELIX
export EDITOR=$HELIX
export VISUAL=$EDITOR
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

case "$-" in *i*)
	set -o vi
	PS1='\e[93m\u\e[0m@\e[93m\H \e[96m\w$(echo-git-info)$(echo-exit-status $?)\n🐚 '
;; *) ;; esac
