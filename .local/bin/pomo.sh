#!/bin/sh
another_instance()
{
    notify-send "There is another instance running, exiting"
    exit 1
}
if [ "$(pgrep pomo.sh)" != $$ ]; then
     another_instance
fi

if [[ "$1" == "--minutes="* ]]; then
    MINUTES="${1#--minutes=}"; shift
elif [[ "$1" == "-m"* ]]; then
    MINUTES="${1#-m}"; shift
    if [ "$MINUTES" == "" ]; then
        MINUTES="${1}"; shift
    fi
fi

MINUTES=${MINUTES:-25}

trap "timew cancel && exit" INT TERM

notify-send -u critical "Pomodoro Start!"
timew start pomodoro $@ 2>&1 1>/dev/null
sleep $(( $MINUTES * 60 ))


timew stop 2>&1 1>/dev/null
notify-send -u critical "Pomodoro Finished!"
