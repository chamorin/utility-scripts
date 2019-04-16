#!/bin/bash

NUMBER_OF_KEYS=$(($(lsblk -do NAME,SIZE | grep -Ec '^([^l][^o][^o][^p]).*')-1))

choose_usb() {
        lsblk -do NAME,SIZE | grep -E '^([^l][^o][^o][^p]).*'
        echo -e

        read -p "Choose a usb key to repair(#): " usb
        if [ $usb -lt 1 ] || [ $usb -gt $NUMBER_OF_KEYS ]; then
                #invalid usb number
        fi

        read -p "Are you sure you want to repair usb key $usb? `echo $'\n>' `It will delete all content on the usb (y/n): " choice
        if [ $choice != "y" ] || [ $choice != "n" ]; then
                #invalid choice
        fi
}

choose_usb
while [ $? -ne 0 ]
do
    echo -e "Error: choose a valid usb!"
    choose_usb
done
