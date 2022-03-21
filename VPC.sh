#!/bin/bash



# 1) Create VPC with CIDR ($VPCID)
tput setaf 2;read -p "Name of VPC:                       " VPCNAME
read -p "Cidr-Block (10.0.0.0/16) :         " CIDR
VPCID=$(aws ec2 create-vpc --cidr-block $CIDR --query Vpc.VpcId --output text --tag-specifications ResourceType=vpc,Tags="[{Key=Name,Value=$VPCNAME}]") 
echo -e "You have \"$VPCNAME\" VPC with \"$CIDR\" Cidr-Block created successful!"
sleep 1



# 2) Create two subnets, public subnet and private subnet with CIDR ($PRIVATES $PUBLICS)
read -p "Name of Private subnet:            " SUBNET1
read -p "$SUBNET1's subnet Cidr-Block:      " SUBNET1C
PRIVATES=$(aws ec2 create-subnet --vpc-id $VPCID --cidr-block $SUBNET1C --tag-specifications ResourceType=subnet,Tags="[{Key=Name,Value=$SUBNET1}]" --query Subnet.SubnetId --output text)
echo -e "You have \"$SUBNET1\" subnet created successful!"
sleep 1

read -p "Name of Public subnet:             " SUBNET2
read -p "$SUBNET2's subnet Cidr-Block:      " SUBNET2C
PUBLICS=$(aws ec2 create-subnet --vpc-id $VPCID --cidr-block $SUBNET2C --tag-specifications ResourceType=subnet,Tags="[{Key=Name,Value=$SUBNET2}]" --query Subnet.SubnetId --output text)
echo -e "You have \"$SUBNET2\" subnet created successful!"



# 3) Create Internet Gateway $GATEWAY
# -attach to VPC
read -p "Name of Internet Gateway:      " GATENAME
GATEWAY=$(aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --output text --tag-specifications ResourceType=internet-gateway,Tags="[{Key=Name,Value=$GATENAME}]")
aws ec2 attach-internet-gateway --vpc-id $VPCID --internet-gateway-id $GATEWAY
echo -e "You have \"$GATENAME\" gateway created and attached with \"$VPCNAME\" vpc successful!"
sleep 1



# 4) Public Route table and Private Route Table ($PRIVATER $PUBLICR)
#   -attach subnets to particular route tables
read -p "Name of Private  Route-Table:     " RTABLE1
PRIVATER=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$VPCID" "Name=association.main, Values=true" --query 'RouteTables[*].Associations[*].RouteTableId[]' --output text | awk '{print $1}')
aws ec2 create-tags --resources $PRIVATER --tags 'Key=Name, Value='$RTABLE1
echo "Added tag to the main Route Table"
sleep 2
read -p "Name of Public Route-Table:    " RTABLE2
PUBLICR=$(aws ec2 create-route-table --vpc-id $VPCID --tag-specifications ResourceType=route-table,Tags="[{Key=Name,Value=$RTABLE2}]" --query RouteTable.RouteTableId --output text)
echo -e "Created \"$RTABLE2\" route table successful!"

aws ec2 associate-route-table  --subnet-id $PRIVATES --route-table-id $PRIVATER > Private_RT.json
echo -e "\"$SUBNET1\" subnet associated with \"$RTABLE1\" successful!"
aws ec2 associate-route-table  --subnet-id $PUBLICS --route-table-id $PUBLICR > Public_RT.json
echo "\"$SUBNET2\" subnet associated with \"$RTABLE2\" successful!"
sleep 2
echo "TASK COMPLETED!!!"
