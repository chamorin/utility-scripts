#!/bin/bash

NUMBER_OF_KEYS=$(($(lsblk -do NAME,SIZE | grep -Ec '^([^l][^o][^o][^p]).*')-1))
RE='^[0-9]+$'

lsblk -do NAME,SIZE | grep -E '^([^l][^o][^o][^p]).*'
echo -e

read -p "Choose a usb key to repair(#): " usb
while ! [[ $usb =~ $RE ]] || [ $usb -lt 1 ] || [ $usb -gt $NUMBER_OF_KEYS ]
do
    echo "Error: enter a valid usb number(1-$NUMBER_OF_KEYS)"
    read -p "Choose a usb key to repair(#): " usb
done

read -p "Are you sure you want to repair usb key $usb? `echo $'\n>' `It will delete all content on the usb (y/n): " choice
while [ "$choice" != "y" ] && [ "$choice" != "n" ]
do
    echo "Error: enter a valid choice(y/n)"
    read -p "Are you sure you want to repair usb key $usb? `echo $'\n>' `It will delete all content on the usb (y/n): " choice
done
