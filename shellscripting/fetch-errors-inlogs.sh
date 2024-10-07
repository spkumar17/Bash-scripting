#!/bin/bash

read -p "enter the file path:" Fetch
if [ -z "$Fetch" ]; then 
    echo "enter the path"
elif [ ! -f "$Fetch" ]; then
    echo "File not found or incorrect path. Please check the path and try again."    
else    
    Search=$(grep -w ERROR $Fetch )
    if [ -z "$Search" ]; then
        echo "No error logs in the given log file"
    else
        grep -w ERROR $Fetch >> /home/kumar/shellscripting/AppErrorLogs$(date +"%Y-%m-%d_%H-%M-%S").log
        echo "Moved error logs to /home/kumar/shellscripting/AppErrorLogs$(date +"%Y-%m-%d_%H-%M-%S").log"
    fi                                                                                                                                    
fi    