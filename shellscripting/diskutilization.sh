#!/bin/bash

disk_space=$(df -h | grep -w /dev/loop0 | awk -F ' '  '{print$5}' | cut -d "%" -f 1)

if [ $disk_space -gt 80 ]; then
    echo "disk space is $disk_space% which is greater the 80%"
    echo " please delete the unnessary files or move the file"
else
    echo "disk space is $disk_space% which is greater the 80%"
    echo "free to use the disk as the disk is only $disk_space%"
fi                                                                                                                                   :
