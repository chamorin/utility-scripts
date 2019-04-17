#!/bin/bash

NUMBER_OF_KEYS=$(lsblk -dn | grep -Ec '^([^l][^o][^o][^p]).*')
RE='^[0-9]+$'

echo "NAME         SIZE"
lsblk -dno NAME,SIZE | grep -E '^([^l][^o][^o][^p]).*' | grep -En '*'
echo -e

read -n 1 -p "Choose a usb key to repair(#): " usb
while ! [[ $usb =~ $RE ]] || [ $usb -lt 1 ] || [ $usb -gt $NUMBER_OF_KEYS ]
do
    echo -e $'\nError: enter a valid usb number(1-'$NUMBER_OF_KEYS')'
    read -n 1 -p "Choose a usb key to repair(#): " usb
done

echo -e
read -p "Are you sure you want to repair usb key $(lsblk -dno NAME | grep -E '^([^l][^o][^o]).*' | sed -ne "$usb"p)? `echo $'\n>' `It will delete all content on the usb (y/n): " choice
while [ "$choice" != "y" ] && [ "$choice" != "n" ]
do
    echo -e "Error: enter a valid choice(y/n)"
    read -p "Are you sure you want to repair usb key $(lsblk -dno NAME | grep -E '^([^l][^o][^o]).*' | sed -ne "$usb"p)? `echo $'\n>' `It will delete all content on the usb (y/n): " choice
done

if [ "$choice" == "n" ]; then
    exit 0
fi

disk="$(lsblk -dno NAME | grep -E '^([^l][^o][^o]).*' | sed -ne "$usb"p)"

sudo fsck -f /dev/"$disk"
#sudo dd if=/dev/zero of=/dev/"$disk"
#sudo mkfs.msdos -f 32 /dev/"$disk"1
