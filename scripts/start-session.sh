#!/bin/bash
# Start a SSM Session on a Windows or Linux EC2 instance.
# Ref.: https://docs.aws.amazon.com/cli/latest/reference/ssm/start-session.html

#Variables:
PROFILE=default
REGION=us-east-1

# Check parameters:
if [ $# -eq 0 ]
then
	echo "Please provide an instance ID. Example: './$(basename $0) -i-abcdef0987654321'"
	exit 1
fi

if [ $# -eq 1 ]
then
	#Start Session:
    aws ssm start-session --target "$1" --region $REGION --profile $PROFILE
	exit 0
fi
