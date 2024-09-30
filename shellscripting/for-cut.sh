#!/bin/bash

echo $(date)
for I in {1..5};do

echo $(date) | cut -d" " -f 1,4
sleep 1
done


# cut can not rearrage the order or it can not print same fields multiple times but awk can do that 

#!/bin/bash

set -x  # Enable debugging

echo $(date)

for I in {1..10};
    do
    echo $(date) | awk  -F " " '{print $1, $2, $3}'  # Print the day, month, and date
    sleep 1
done