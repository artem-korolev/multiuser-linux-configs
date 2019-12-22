
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

function detect_repo() {
		BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
 		if [ ! "${BRANCH}" == "" ]
 		then
			ORANGE='\033[0;32m'
			NC='\033[0m' # No Color
			echo ", Branch: [${ORANGE}${BRANCH}${NC}]"
		else
			echo ""
		fi
}

alias ls='ls --color=auto'
alias ll='ls -l'
alias l='ls -lA'
alias la='ls -la'
PS1='[\u@\h \W]\$ '
#export PS1="\n\d \t\`detect_repo\`\n[\[\e[32m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]: \[\e[33m\]\w\[\e[m\]]\n\\$ "
#export PATH=$HOME/bin:$PATH
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

# Android emulator
#export PATH=/opt/android-sdk/emulator:$PATH

# NPM
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
export npm_config_prefix=~/.npm-packages
# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
#unset MANPATH # delete if you already modified MANPATH elsewhere in your config
#export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
export QT_QPA_PLATFORMTHEME=qt5ct


if [[ -f "$HOME/.bashrc_local" ]] ;
then
	source "$HOME/.bashrc_local"
fi
