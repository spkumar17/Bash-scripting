#!/bin/bash

# Function to validate time format
validate_time() {
    date -d "$1" +"%Y-%m-%d %H:%M:%S" > /dev/null 2>&1
    return $?
}

read -p "Enter the file path: " Fetch
if [ -z "$Fetch" ]; then
    echo "Please enter the path."
elif [ ! -f "$Fetch" ]; then
    echo "File not found or incorrect path. Please check the path and try again."
else
    # Prompt for time range
    read -p "Enter start time (YYYY-MM-DD HH:MM:SS) or (MMM-DD-YYY HH:MM:SS ) " start_time
    read -p "Enter end time (YYYY-MM-DD HH:MM:SS): or (MMM-DD-YYY HH:MM:SS) " end_time

    # Validate time format
    if ! validate_time "$start_time" || ! validate_time "$end_time"; then
        echo "Invalid time format. Please use 'YYYY-MM-DD HH:MM:SS' or (MMM-DD-YYY HH:MM:SS)."
        exit 1
    fi

    # Format start and end time to the format found in logs (assuming `YYYY-MM-DD HH:MM:SS`)
    start_time_fmt=$(date -d "$start_time" +"%Y-%m-%d %H:%M:%S")
    end_time_fmt=$(date -d "$end_time" +"%Y-%m-%d %H:%M:%S")

    # Use sed to extract lines within the time range and grep for ERROR
    Search=$(sed -n "/$start_time_fmt/,/$end_time_fmt/p" "$Fetch" | grep -w ERROR)

    if [ -z "$Search" ]; then
        echo "No error logs found in the specified time frame."
    else
        log_file="/home/kumar/shellscripting/AppErrorLogstimeframe$(date +"%Y-%m-%d_%H-%M-%S").log"
        echo "$Search" >> "$log_file"
        echo "Moved error logs to $log_file file in /home/kumar/shellscripting directory."
    fi
fi
