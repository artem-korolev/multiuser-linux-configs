#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

TTY_NUMBER=$(tty | grep -o -E '[0-9]+$')
if [[ ! $DISPLAY && $TTY_NUMBER -le 4 ]]; then
	exec startx
	#exec weston
fi
