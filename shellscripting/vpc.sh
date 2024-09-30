
#1/bin/bash
aws --version > /dev/null
if [ $? -eq 0 ]; then
    read -p "enter the aws regions:" regions
    if [ -n "$regions" ]; then
        for region in $regions; do
            echo " fetching details in $region"
            aws ec2 describe-vpcs --region $region |jq ".Vpcs[].VpcId"
        done
    else
        echo "enter atleast one argument"
        read -p "enter the aws regions:" regions
        if [ -n "$regions" ]; then
            for region in $regions; do
                echo " fetching details in $region"
                aws ec2 describe-vpcs --region $region |jq -r ".Vpcs[].VpcId"
            done
        else
            echo "No region entered. Exiting..."    
        fi
    fi

else
    echo "please install aws cli and run the script"
fi
echo $# #will display the number of arguments you passed


