#!/bin/bash


aws --version > /dev/null
if [ $? -eq 0 ]; then
    read -p "enter the aws regions:" regions
    for region in ${regions}; do
        echo "fetching the details of $region region"
        aws ec2 describe-vpcs --region $region |jq -r ".Vpcs[].VpcId"
    done
else
    echo "incorrect command"
fi

#-----------------------------------------------------------------

# input as arguments 

aws --version > /dev/null
if [ $? -eq 0 ]; then
    for region in $@; do
        echo "fetching the details of $region region"
        aws ec2 describe-vpcs --region $region |jq -r ".Vpcs[].VpcId"
    done
else
    echo "incorrect command"
fi