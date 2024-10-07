#!/bin/bash

path= $1

echo "top 5 largest files in $path are"
du -ah $path | sort -rh | awk -F" " '{ print $2 }' | head -n 5 | tr '\n' ' ' >> /home/kumar/shellscripting.largefileindir.txt
echo "Use the below Command to find  the largest files in the $path "
echo "cat /home/kumar/shellscripting.largefileindir.txt"
