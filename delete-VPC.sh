#!/bin/bash

aws ec2 --output text --query 'Vpcs[*].{VpcId:VpcId,Name:Tags[?Key==`Name`].Value|[0],CidrBlock:CidrBlock}' describe-vpcs

tput setaf 1;echo -e "\nWhich VPC you would like to delete? "
read -p "Please input Vpc-Id:               " VpcID

PRIVATESUBNET=$(aws ec2 describe-subnets --filters 'Name=vpc-id,Values='$VpcID --query 'Subnets[*].SubnetId[]' --output text | awk '{print $1}')
aws ec2 delete-subnet --subnet-id $PRIVATESUBNET
echo "Private Subnet has been deleted!"
sleep 2
PUBLICSUBNET=$(aws ec2 describe-subnets --filters 'Name=vpc-id,Values='$VpcID --query 'Subnets[*].SubnetId[]' --output text)
aws ec2 delete-subnet --subnet-id $PUBLICSUBNET
echo "Public Subnet has been deleted!"
sleep 2

PUBLICRT=$(aws ec2 describe-route-tables --filters 'Name=vpc-id,Values='$VpcID --query 'RouteTables[*].RouteTableId[]' --output text | awk '{print $2}')
aws ec2 delete-route-table --route-table-id $PUBLICRT
echo "Public Route Table has been deleted!"
sleep 2

IGW=$(aws ec2 describe-internet-gateways --filters 'Name=attachment.vpc-id,Values='$VpcID --query 'InternetGateways[*].InternetGatewayId[]' --output text)
aws ec2 detach-internet-gateway --internet-gateway-id $IGW --vpc-id $VpcID
echo "$IGW internet-gateway has been Detached!"
sleep 2

aws ec2 delete-internet-gateway --internet-gateway-id $IGW
echo " \"$IGW\" Internet Gateway has been deleted!"
sleep 2

aws ec2 delete-vpc --vpc-id $VpcID
echo "YOUR VPC HAS BEEN DELETED!"
sleep 2
