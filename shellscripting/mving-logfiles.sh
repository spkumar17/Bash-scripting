#!/bin/bash

# This script moves log files which are created before 30 days 

# Example if all the logs files are stored in /home/kumar/shellscripting

path=$1

if [ -z "$path" ]; then 
    echo "Please provide the path."
    exit 1
else
    Backup_path="/home/kumar/shellscriptingbackup"

    mkdir -p "$Backup_path"  # this will create a backup directory if not present 

    # Find files older than 30 days and store them in an array
    Tempfiles=($(find "$path" -type f -mtime +30))

    if [ ${#Tempfiles[@]} -eq 0 ]; then 
        echo "No log files created in the past 30 days."
    else 
        echo "Moving all the log files created 30 days ago to Backup_path: $Backup_path"
        for Tempfile in "${Tempfiles[@]}"; do 
            #cp "$Tempfile" "$Backup_path"  
            mv "$Tempfile" "$Backup_path"
            echo "$Tempfile moved to Backup_path: $Backup_path"
        done
    fi
fi

backup_Tempfiles=($(find "$Backup_path" -type f -mtime +30))

if [ -z "$backup_Tempfiles" ]; then 
    echo "No backup files to move to S3 Glacier"
else
    aws s3 mv $Backup_path s3://log-backup-cppe/backuplogs/ --storage-class GLACIER --recursive
fi     



