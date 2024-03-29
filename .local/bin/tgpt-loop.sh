#!/bin/bash
# Purpose: Display various options to operator using menus
# Author: Vivek Gite < vivek @ nixcraft . com > under GPL v2.0+
# ---------------------------------------------------------------------------
# capture CTRL+C, CTRL+Z and quit singles using the trap
trap '' SIGINT
trap ''  SIGQUIT
trap '' SIGTSTP

export HOWDOI_COLORIZE=1
export HOWDOI_SEARCH_ENGINE=google
program="tgpt"

# display message and pause
pause(){
	local m="$@"
	echo "$m"
	read -p "Press [Enter] key to continue..." key
}

# set an
while :
do
	# show menu
	read -r -p "[q - exit]: " c
	# take action
	case $c in
		q) break;;
		*) $program "$c";;
	esac
done
