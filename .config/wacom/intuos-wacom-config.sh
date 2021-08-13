#!/bin/bash

export XAUTHORITY=/home/alisson/.Xauthority
export DISPLAY=:0

for i in $(seq 10); do
	if xsetwacom list devices | grep -q Wacom; then
		break
	fi
	sleep 1
done

list=$(xsetwacom list devices)
pad=$(echo "${list}" | awk '/pad/{print $7}')
stylus=$(echo "${list}" | xsetwacom list devices | awk '/stylus/{print $7}')

if [ -z "${pad}" ]; then
	exit 0
fi

# Configure the buttons on ${pad}
xsetwacom set "${pad}" Button 1 "key ctrl z"
xsetwacom set "${pad}" Button 2 "key ctrl +"
xsetwacom set "${pad}" Button 3 "key ctrl -"
xsetwacom set "${pad}" Button 8 "key ctrl y"
