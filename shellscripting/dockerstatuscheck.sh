#!/bin/bash
 
# this will check if the docker is active if not it will start the service 
# running this script using while not with cron   
while true; do
    check=$(systemctl status docker | awk 'NR==3 {print}' | cut -d '(' -f 1 | cut -d ':' -f 2 | xargs)

    if [ "$check" == "active" ]; then
        echo "Docker service is active"
    else
        echo "Docker service is inactive"
        sudo usermod -aG docker $USER
        check2=$(systemctl status docker | awk 'NR==3 {print}')
        echo $check2
        echo "starting docker services..."
        sudo systemctl start docker
        sleep 3
        check=$(systemctl status docker | awk 'NR==3 {print}' | cut -d '(' -f 1 | cut -d ':' -f 2 | xargs)
        if [ "$check" == "active" ]; then
            echo "Docker service is active"
        else
            echo " unable to start the docker service"
            echo " take required action......."
            exit 1
        fi    


    fi
    sleep 10         
done
---


check=$(systemctl status docker | awk 'NR==3 {print}' | cut -d '(' -f 1 | cut -d ':' -f 2 | xargs)

    if [ "$check" == "active" ]; then
        echo "Docker service is active"
    else
        echo "Docker service is inactive"
        check2=$(systemctl status docker | awk 'NR==3 {print}')
        echo $check2
        echo "starting docker services..."
        sudo systemctl start docker
        sleep 3
        check=$(systemctl status docker | awk 'NR==3 {print}' | cut -d '(' -f 1 | cut -d ':' -f 2 | xargs)
        if [ "$check" == "active" ]; then
            echo "Docker service is active"
        else
            echo " unable to start the docker service"
            echo " take required action......."
            exit 1
        fi    


    fi
