#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
PS1='[\u@\h \W]\$ '
export PATH=$HOME/bin:$PATH
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

if [[ -f "$HOME/.bashrc_local" ]] ;
then
	source "$HOME/.bashrc_local"
fi
