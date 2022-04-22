#!/bin/bash
# Create a EC2 SSH Key Pair using AWS CLI
# Previous execution of "aws configure" is needed

#Variables:
KEY_NAME=CTesting
PROFILE=CTesting
REGION=us-east-1

#Create Key:
aws ec2 create-key-pair --key-name $KEY_NAME --query 'KeyMaterial' --output text > $KEY_NAME.pem --region $REGION --profile $PROFILE
#Set Permissions:
chmod 400 $KEY_NAME.pem
#Move key to .shh
mv $KEY_NAME.pem ~/.ssh/$KEY_NAME.pem