#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

TTY=`tty`
TTY_NUMBER=${TTY//[^0-9]/}
if [[ ! $DISPLAY && $TTY_NUMBER -le 4 ]]; then
	exec startx
	#exec weston
fi
