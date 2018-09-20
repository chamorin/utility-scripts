#!/bin/bash

index=0

print_state () {
 if [ $? -eq 0 ]
 then
  echo -ne "\e[92mDONE\n"
 else
  echo -ne "\e[31mFAILED\n"
 fi
}

for image in *.bin ; do
 newFilename=$(basename -- "$image")
 newFilename="${newFilename%.*}"
 echo -ne "\e[90mConverting images... "
 cat "${image}" | base64 -d > "${newFilename}"."${1}" 2>&1 >/dev/null
  	
 print_state
	
 index=$((index+1))
done

echo -e "\e[0m"

echo -e Number of converted images : "${index}"

echo -e "\e[0m"
