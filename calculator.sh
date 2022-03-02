#!/bin/bash




read -p "Enter first number: " FIRST
until [[ $FIRST =~ ^[+]?[0-9]+$ ]]
do
echo "Sorry integers only"
sleep 1
read -p "Try again, Please enter first number: " FIRST
done
sleep 2




read -p "Enter one of these (+)(-)(*)(/) " SYMBOL



read -p "Enter second number: " SECOND
until [[ $SECOND =~ ^[+]?[0-9]+$ ]]
do
echo "Sorry integers only"
sleep 1
read -p "Try again, Please enter second number: " SECOND
done
let SUM=$FIRST$SYMBOL$SECOND
echo "Result: $SUM "
