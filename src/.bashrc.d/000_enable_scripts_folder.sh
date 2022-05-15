
add_path(){
	NEW_PATH=$1
	if ! [[ "$PATH" =~ "$NEW_PATH" ]]
	then
		export PATH="$NEW_PATH:$PATH"
	fi
}

add_path "$HOME/.scripts"
