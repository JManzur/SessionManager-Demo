#!/bin/bash
# Start a SSM Session on a Windows or Linux EC2 instance.
# Ref.: https://docs.aws.amazon.com/cli/latest/reference/ssm/start-session.html

#Variables:
PROFILE=YourProfile
REGION=us-east-1

# Check if the necessary commands are installed
declare -A commands_array=(
    [session-manager-plugin]="https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html"
    [jq]="https://stedolan.github.io/jq/download/"
    [aws]="https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
)

for key in "${!commands_array[@]}"; 
do
    if command -v $key > /dev/null
        then
            echo "" > /dev/null
        else
            echo "[ERROR] $key not installed - Please install $key to continue"
            echo -e '\n'
            echo "Ref: ${commands_array[$key]}"
            echo -e '\n'
            exit 1
    fi
done

# Check parameters:
if [ $# -eq 0 ]
then
	echo "Please provide an instance ID. Example: './$(basename $0) i-abcdef0987654321'"
	exit 1
fi

if [ $# -eq 1 ]
then
	#Start Session:
    aws ssm start-session --target "$1" --region $REGION --profile $PROFILE
	exit 0
fi
