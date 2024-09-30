
#!/bin/bash

function deletevolume {
    # to know list of regions us "aws ec2 describe-regions | jq -r .Regions[].RegionName | tr '\n' ' ' "
    aws_regions=(ap-south-1 eu-north-1 eu-west-3 eu-west-2 eu-west-1 ap-northeast-3 ap-northeast-2 ap-northeast-1 ca-central-1 sa-east-1 ap-southeast-1 ap-southeast-2 eu-central-1 us-east-1 us-east-2 us-west-1 us-west-2)
    
    for region in "${ aws_regions[@] }"; do
        
        vols=($(aws ec2 describe-volumes --region $region | jq -r .Volumes[].VolumeId ))
    
        for vol in "${ vols[@] }"; do

            volume_info=$(aws ec2 describe-volumes --volume-ids $vol)
            size=$(echo "$volume_info" | jq  ".Volumes[].Size")
            state=$(echo "$volume_info" | jq -r ".Volumes[].State")

            if [ "$state" == "in-use" ]; then

                echo "$vol is attached to an instance. Skipping deletion."
            
            elif [ "$size" -lt 5 ]; then
            
                echo "$vol is less than 5GB. Skipping deletion."
            
            else
            
                echo "Deleting Volume $vol"
                aws ec2 delete-volume --volume-id $vol
            
            fi
        
        done 

        echo "---------------------------------"
    
    done         
}
deletevolume
#------------------------------------------------------------------------------------------------------

#---------------final version ---------------#


#!/bin/bash

function deletevolume {
    # to know list of regions us "aws ec2 describe-regions | jq -r .Regions[].RegionName | tr '\n' ' ' "
    aws_regions=($(aws ec2 describe-regions | jq -r .Regions[].RegionName | tr '\n' ' '))

    for region in "${aws_regions[@]}"; do
        echo "Checking volumes in region: $region"

        vols=($(aws ec2 describe-volumes --region $region | jq -r .Volumes[].VolumeId ))

         # Check if any volumes were found

        if [ -z "$vols" ]; then
            echo "No volumes found in region: $region"
            echo "---------------------------------------"
            continue
            
        else
            for volume in "${vols[@]}"; do
                echo $volume

                volume_info=$(aws ec2 describe-volumes --volume-ids $volume)
                size=$(echo "$volume_info" | jq  ".Volumes[].Size")
                state=$(echo "$volume_info" | jq -r ".Volumes[].State")

            
                if [ "$state" == "in-use" ]; then

                    echo "$volume is attached to an instance. Skipping deletion."
                     echo "-------"
            
                elif [ "$size" -lt 5 ]; then
            
                    echo "$volume is less than 5GB. Skipping deletion."
                    echo "--------"
                else
            
                    echo "Deleting Volume $volume"
                    aws ec2 delete-volume --volume-id "$volume" --region "$region"
                    echo "--------"
            
                fi
        
            done 

        fi    
    done         
}
deletevolume

