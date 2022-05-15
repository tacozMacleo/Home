errec(){
    RET=$?
    if [ "$RET" != "0" ]
    then
	    echo "($RET)"
    fi
}
