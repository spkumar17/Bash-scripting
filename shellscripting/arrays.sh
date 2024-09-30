name='prasanna kumar'
echo ${name} # this displays the name
echo ${#name} # this display the length
echo ${name[@]:0:2} # this display the first to letters of the string


for i in {0..14};
do
    echo ${name[@]:0:$i}
done


prasanna kumar
14
pr

p
pr
pra
pras
prasa
prasan
prasann
prasanna
prasanna
prasanna k
prasanna ku
prasanna kum
prasanna kuma
prasanna kumar

#echo ${name[@]:0:$i}
#    :0      The starting index from where the substring extraction will begin
# $i: The length of the substring to extract 
#---------------------------------------------------
name='prasanna kumar'
echo ${name} # this displays the name
echo ${#name} # this display the length
echo ${name[@]:0:2} # this display the first to letters of the string


for i in {0..14};
do
    echo ${name[@]:$i:1}
done

prasanna kumar
14
pr
p
r
a
s
a
n
n
a

k
u
m
a
r


#------------------------------------------------------------------------------------------------------
#!/bin/bash 
aws_regions=(us-east-1 us-east-2 hyd-india-1 eu-north-1 ap-south-1 eu-west-3 eu-west-2 eu-west-1 ap-northeast-2)

echo "Running the function to list VPCs using the regions list"

for region in "${aws_regions[@]}"; do
    echo "Getting VPCs in $region .. "
    vpc_list=$(aws ec2 describe-vpcs --region "$region" | jq -r .Vpcs[].VpcId)
    vpc_arr=(${vpc_list[@]})

    if [ ${#vpc_arr[@]} -gt 0 ]; then
        for vpc in "${vpc_list[@]}"; do
            echo "The VPC-ID is: $vpc"
        done
        echo "##########"
    else
        echo "Invalid Region..!!"
        echo "#######"
        echo "# Breaking at $region #"
        echo "################"
        break
        #exit 99
        #continue
    fi
done