#!/bin/bash

set -x  # Enable debugging

echo $(date)

for I in {1..10};
    do
    echo $(date) | awk   '{print $1, $2, $3}'
    sleep 1
done


#Tue Sep 24 23:10:54 IST 2024 this spaces are called Delimiters  which sparate them as fields 

#!/bin/bash

set -x  # Enable debugging

echo $(date)

for I in {1..10};
    do
    echo $(date) | awk  -F " " '{print $1, $2, $3}'  # Print the day, month, and date
    sleep 1
done