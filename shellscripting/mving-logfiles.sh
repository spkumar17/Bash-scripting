#!/bin/bash

# This script moves log files which are created before 30 days 

# Example if all the logs files are stored in /home/kumar/shellscripting

path=$1

if [ -z "$path" ]; then 
    echo "Please provide the path."
    exit 1
else
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S") 
    Backup_path="/home/kumar/shellscripting_$TIMESTAMP.txt"

    mkdir -p "$Backup_path"  # this will create a backup directory if not present 

    # Find files older than 30 days and store them in an array
    Tempfiles=($(find "$path" -type f -mtime +30))

    if [ ${#Tempfiles[@]} -eq 0 ]; then 
        echo "No log files created in the past 30 days."
    else 
        echo "Moving all the log files created 30 days ago to Backup_path: $Backup_path"
        for Tempfile in "${Tempfiles[@]}"; do 
            cp "$Tempfile" "$Backup_path"  # as a demo i used cp but we need to use mv command
            #mv "$Tempfile" "$Backup_path"
            echo "$Tempfile moved to Backup_path: $Backup_path"
        done
    fi
fi

