#!/bin/bash

option=$1

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
CONFIGS_DIR="$(dirname "$SCRIPT_DIR")"
USER_HOME=$HOME

find "$CONFIGS_DIR/" -print0 | while IFS= read -r -d '' file
do
	if [[ $file == $CONFIGS_DIR/README.md ]] ;
	then
		continue
	fi

	if [[ $file == $CONFIGS_DIR/.git* ]] || [[ $file == $CONFIGS_DIR/bin* ]] || [[ -d "$file" ]] ;
	then
		continue
	fi

	config=${file#"$CONFIGS_DIR/"}
	user_config="$USER_HOME/$config"
	# check if config exists in the system and if its already a link to repo config file
	if [[ ! -L "$user_config" ]] ;
	then
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
			ln -s "$file" "$user_config"
			echo "---"
		fi
		
	fi
done

