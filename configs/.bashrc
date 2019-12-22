
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Use global profile when available
if [ -f /usr/share/defaults/etc/profile ]; then
	. /usr/share/defaults/etc/profile
fi
# allow admin overrides
if [ -f /etc/profile ]; then
	. /etc/profile
fi

PATH=$HOME/.cargo/bin:$PATH

alias ls='ls --color=auto'
alias ll='ls -l'
alias l='ls -lA'
alias la='ls -la'


if [[ -f "$HOME/.bashrc_local" ]] ;
then
	source "$HOME/.bashrc_local"
fi
