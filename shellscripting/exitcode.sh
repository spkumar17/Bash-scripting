#$? this will store the exit code information of the command

#!/bin/bash
aws --version > /dev/null
if [ $? -eq 0 ]; then
    region=$1
    aws ec2 describe-vpcs --region $region |jq ".Vpcs[].VpcId"
else 
    echo "incorrect command"
if

