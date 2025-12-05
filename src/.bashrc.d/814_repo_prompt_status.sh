
###############################################################################
##                        Repository For PS
###############################################################################
# Color for use in PS1
BOLD="\[\033[1m\]"
UNDERSCORE="\[\033[4m\]"
BLINK="\[\033[5m\]"
REVERSE="\[\033[7m\]"
CONCEALED="\[\033[8m\]"

ENDCLR="\[\033[00m\]"

BLACK="\[\033[1;30m\]"
RED="\[\033[31m\]"
GREEN="\[\033[32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[34m\]"
PURPLE="\[\033[35m\]"
CYAN="\[\033[36m\]"

BBLACK="\[\033[40m\]"
BRED="\[\033[41m\]"
BGREEN="\[\033[42m\]"
BYELLOW="\[\033[43m\]"
BBLUE="\[\033[44m\]"
BPURPLE="\[\033[45m\]"
BCYAN="\[\033[46m\]"

FILLER="$BLACK"
HASH="$YELLOW"

if_repo(){
    SIGN="$1"
    [ -n "$(find_repo)" ] && echo "${SIGN}"
}


find_repo(){
    DEPTH="$1"
    COUNT="0"
    cur_dir="${PWD}"

	if [ -n "$(git rev-parse --show-toplevel 2> /dev/null)" ]
	then
		git rev-parse --show-toplevel 2> /dev/null
		return 0
	fi

    while [ "$cur_dir" != "/" ]
    do
        if [ -f "${cur_dir}/.hg/dirstate" ]
        then
			# hg root
            echo "${cur_dir}" && break
        fi
        if [ -e "${cur_dir}/.git" ]
        then
			# git rev-parse --show-toplevel
            echo "${cur_dir}" && break
        fi
        cur_dir="$(dirname "$cur_dir")"
    done
}


get_repo_type(){
	if [ -n "$(git rev-parse --show-toplevel 2> /dev/null)" ]
    then
        echo "git"
		return 0
    fi

    LOC="$(find_repo)"
    if [ -f "${LOC}/.hg/dirstate" ]
    then
        echo "hg"
    fi
}

get_repo_branch(){
	if [ -n "$(git rev-parse --show-toplevel 2> /dev/null)" ]
    then
        git rev-parse --abbrev-ref HEAD 2> /dev/null
		return 0
    fi

    LOC="$(find_repo)"
    if [ -f "${LOC}/.hg/dirstate" ]
    then
        cat "${LOC}/.hg/branch"
    fi
}

get_repo_hash(){
	if [ -n "$(git rev-parse --show-toplevel 2> /dev/null)" ]
    then
        git rev-parse HEAD 2> /dev/null | cut -c-12
		return 0
    fi

    LOC="$(find_repo)"
    if [ -f "${LOC}/.hg/dirstate" ]
    then
        echo "$(xxd -ps -l 6 ${LOC}/.hg/dirstate)"
    fi
}

get_repo_dirty(){
    local DIRTY="\033[0;31m"  # Red
    local COMMITED="\033[0;32m"  # Green
    local PUSHED="\033[0;34m"  # Blue
	if [ -n "$(git rev-parse --show-toplevel 2> /dev/null)" ]
    then
        # [ -n "$(cd "$cur_dir"; git status -s)" ] && echo -e "$DIRTY" || echo -e "$GREEN"
        [ -n "$(git status -s 2>&1)" ] && echo -e "$DIRTY" ||  ([ -n "$(git cherry -v 2>&1)" ] && echo -e "$COMMITED" || echo -e "$PUSHED")
		return 0
    fi

    LOC="$(find_repo)"
    if [ -f "${LOC}/.hg/dirstate" ]
    then
        [ -n "$(cd "$LOC"; hg st)" ] && echo -e "$DIRTY" || echo -e "$COMMITED"
    fi
}

REPOSTRING="$FILLER\$(if_repo '[')\$(get_repo_type)\$(if_repo ':')\[\$(get_repo_dirty)\]\$(get_repo_branch)$FILLER\$(if_repo '@')$HASH\$(get_repo_hash)$FILLER\$(if_repo ']')$ENDCLR"

get_date(){
    # date +%Y/%m/%d-%H:%M:%s
	date +%H:%M:%S
}

DATESTRING="$BLUE[\$(get_date)]$ENDCLR"