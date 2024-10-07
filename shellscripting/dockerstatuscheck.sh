#!/bin/bash


while true; do
    check=$(systemctl status docker | awk 'NR==3 {print}' | cut -d '(' -f 1 | cut -d ':' -f 2 | xargs)

    if [ "$check" == "active" ]; then
        echo "Docker service is active"
    else
        echo "Docker service is inactive"
        systemctl status docker
    fi
    sleep 10         
done
