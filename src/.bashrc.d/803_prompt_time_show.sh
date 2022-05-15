export PROMPT_TIME=

show_time(){
	if [ "$PROMPT_TIME" = yes ]
	then
		echo "[$(date  +'%d-%b-%y %T')]"
	fi
}
