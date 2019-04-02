#!/bin/bash

if [ -f /tmp/keyboard_light ]; then
   xset led off && rm /tmp/keyboard_light
else
   xset led on && touch /tmp/keyboard_light
fi
