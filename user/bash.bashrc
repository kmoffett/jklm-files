###
## /etc/bash.bashrc  -  System-wide rc file for interactive bash(1) shells
## Copyright (C) 2006       Kyle Moffett <kyle@moffetthome.net>
## Copyright (C) 2007-2011  eXMeritus, A Boeing Company
##
## This program is free software; you can redistribute it and/or modify it
## under the terms of version 2 of the GNU General Public License, as
## published by the Free Software Foundation.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
## for more details.
##
## You should have received a copy of the GNU General Public License along
## with this program; otherwise you can obtain it here:
##   http://www.gnu.org/licenses/gpl-2.0.txt
###

## If we aren't running bash intractively then this file won't work
case "${BASH:+"is-bash"}:$-" in
	(is-bash:*i*) ;;
	(*) return 0  ;;
esac

## Don't put duplicate lines in the history
export HISTCONTROL=ignoredups

## Recheck the window size after every command
shopt -s checkwinsize

## Enable bash completion in interactive shells
[ -f /etc/bash_completion ] && . /etc/bash_completion

## Try to stuff some GIT info into the prompt if we can
extraps1=""
extratitle=""
if declare -f __git_ps1 >/dev/null 2>&1; then
	extraps1='$(__git_ps1 "[\[\033[01;31m\]%s\[\033[00m\]]")'
	extratitle='$(__git_ps1 " [%s]")'
fi

## Set a fancy prompt.  If we happen to be running xterm or rxvt or something
## that supports custom titlebars then put some useful info in the title bar.
PROMPT_COMMAND=''
case "${TERM}" in (xterm*|rxvt*|screen*)
	#titlebar='\033]0;${USER}@${HOSTNAME}: ${PWD/#"${HOME}"/~}\007'
	titlebar='${USER}@${HOSTNAME}: ${PWD/#"${HOME}"/~}'
	#PROMPT_COMMAND="echo -ne \"\033]0;\007${titlebar}\""
	PROMPT_COMMAND="echo -ne \"\\033]0;${titlebar}${extratitle}\\007\""
esac
export PROMPT_COMMAND
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'
PS1="${PS1}${extraps1}"'\$ '
export PS1

## Turn on ls color support
eval "$(dircolors -b)"
function ls() { "$(which ls)" --color=auto "$@"; }
export ls

## Allow the user to stick aliases in ~/.bash_aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

## Enable the command-not-found package, if installed
if [ -x /usr/lib/command-not-found ]; then
	function command_not_found_handle {
		## Double-check (may have been removed since)
		[ -x /usr/lib/command-not-found ] || return 127
		/usr/bin/python /usr/lib/command-not-found -- "$1"
		return $?
	}
fi

# vim:set ft=sh:
