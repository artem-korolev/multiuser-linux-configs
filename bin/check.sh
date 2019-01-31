#!/bin/bash

option=$1

if [[ -L "${BASH_SOURCE[0]}" ]] ;
then
	SCRIPT_SOURCE="$(readlink -f "${BASH_SOURCE[0]}")"
else
	SCRIPT_SOURCE="${BASH_SOURCE[0]}"
fi

SCRIPT_DIR="$( cd "$( dirname "$SCRIPT_SOURCE" )" >/dev/null 2>&1 && pwd )"
CONFIGS_DIR="$(dirname "$SCRIPT_DIR")"
USER_HOME=$HOME
MISSING_CONFIGS="false"

while IFS= read -r -d '' file
do
	if [[ $file == $CONFIGS_DIR/README.md ]] || [[ $file == $CONFIGS_DIR/images* ]] || [[ $file == $CONFIGS_DIR/LICENSE ]] ;
	then
		continue
	fi

	if [[ $file == $CONFIGS_DIR/.git* ]] || [[ -d "$file" ]] ;
	then
		continue
	fi

	if [[ $file == $CONFIGS_DIR/bin/check.sh ]] ;
	then
		config="bin/multiuser-linux-configs-check.sh"
	else
		config=${file#"$CONFIGS_DIR/"}
	fi

	user_config="$USER_HOME/$config"
	# check if config exists in the system and if its already a link to repo config file
	if [[ ! -L "$user_config" ]] ;
	then
		MISSING_CONFIGS="true"
		echo "WARNING: found config not linked to configuration repo: $config"
		if [[ $option == "--fix" ]] ;
		then

			echo "BACKUP: creating directory for backup file: $(dirname "$USER_HOME/.configs.bak/$config")"
			mkdir -p "$(dirname "$USER_HOME/.configs.bak/$config")"
			echo "BACKUP: $user_config -> $USER_HOME/.configs.bak/$config"
			cp "$user_config" "$USER_HOME/.configs.bak/$config"
			echo "REMOVE: $user_config"
			rm "$user_config"
			echo "LINK: $file -> $user_config"
			mkdir -p "$(dirname "$user_config")"
			ln -s "$file" "$user_config"
			echo "---"
		fi
		
	fi
done < <(find "$CONFIGS_DIR/" -print0)

if [[ "$MISSING_CONFIGS" == "true" ]] ;
then
	echo ""
	echo "TIP: run 'check.sh --fix' to automatically link user configs to repo configs; backup existing ones"
	echo "It links check.sh to ~/bin/multiuser-linux-configs-check.sh, so you can run 'multiuser-linux-configs-check.sh' or 'multiuser-linux-configs-check.sh --fix', when its already linked"
fi
