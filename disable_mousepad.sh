#!/bin/bash

mousepadId=$(xinput | grep Touchpad | cut -b 55-57)
isEnabled=$(xinput --list-props 16 | head -n 2 | tail -n 1 | rev | cut -b -1)

if [ "$isEnabled" -eq 1 ]; then
	xinput disable $mousepadId
else
	xinput enable $mousepadId
fi

