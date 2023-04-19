#!/bin/bash

# Find out account ID

echo "Retrieving account info"

ACCOUNT=$(aws sts get-caller-identity --query 'Account' --output text)

echo "Generating SSH key for account"

SSH_PATH=$(cd ~/.ssh; pwd -P)
KEY_PATH="$SSH_PATH/townsq"
PRIVATE_KEY="$KEY_PATH/$ACCOUNT"
PUBLIC_KEY="$PRIVATE_KEY.pub"

echo "Destination: $KEY_PATH"
mkdir -p $KEY_PATH

if [ -f "$PRIVATE_KEY" ]; then
    echo "$PRIVATE_KEY already setup"
else
    ssh-keygen -b 2048 -t rsa -f $PRIVATE_KEY -q -N ""
fi

echo "Retrieving bastion info"
INSTANCE=$(aws ec2 describe-instances --filters "Name=tag:BastionName,Values=CoreVpcBastion" "Name=instance-state-name,Values=running" --query 'Reservations[0].Instances[0].InstanceId' --output text)
BASTION_AZ=$(aws ec2 describe-instances --instance-ids $INSTANCE --query 'Reservations[0].Instances[0].Placement.AvailabilityZone' --output text)
BASTION_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)


echo "Sending public SSH key to bastion for temporary connection"

aws ec2-instance-connect send-ssh-public-key --instance-id $INSTANCE --availability-zone $BASTION_AZ --instance-os-user ec2-user --ssh-public-key file://${PUBLIC_KEY} && \
echo "Ready for connections:" && \
echo "- bastion host: $BASTION_IP" && \
echo "- bastion user: ec2-user" && \
echo "- private key: $PRIVATE_KEY"
