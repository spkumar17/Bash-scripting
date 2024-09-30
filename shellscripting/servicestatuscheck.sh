#!/bin/bash

set -x  # Enable debugging

server_url="www.google.com"
echo "Service availability check started at $(date)"

for I in {1..10}; do
        if curl -s --head  --request GET "$server_url" | grep "200 OK" > /dev/null; then
        echo "$(date): Service is UP"
    else
        echo "$(date): Service is DOWN"
    fi
    sleep 5  # Check every 5 sec
done


# Yes, curl can be used to browse and interact with web resources from the command line.It’s a versatile tool primarily designed for transferring data using various protocols, including HTTP, HTTPS, FTP, and more.

# curl --head www.google.com | grep "200 OK" > /dev/null
# curl --head www.google.com: This command retrieves only the HTTP headers from the response when accessing the Google homepage. It will not download the full HTML body, just the headers, which include information such as the status code.
# | grep 200: Again, this pipes the output to grep to search for the string 200 
# /dev/null finally saves the data in this file 

