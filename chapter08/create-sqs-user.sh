#!/bin/bash

clear
echo "This script will create an IAM user and then assign the proper permissions following the Least Principle Model"
echo "Creating the SQS Admin User"
sleep 3 && clear

aws iam create-user --user-name sqs-user
credentials=$(aws iam create-access-key --user-name sqs-user \
   --query 'AccessKey.[AccessKeyId,SecretAccessKey]'  --output text)
access_key_id=$(echo $credentials | cut -d' ' -f 1)
secret_access_key=$(echo $credentials | cut -d' ' -f 2)
aws configure set profile.sqs-user.aws_access_key_id "$access_key_id"
aws configure set profile.sqs-user.aws_secret_access_key "$secret_access_key"

echo "SQS Admin User created"
sleep 3 && clear

echo "Attaching the AmazonSQSFullAccess IAM Policy"
aws iam attach-user-policy --user-name sqs-user --policy-arn arn:aws:iam::aws:policy/AmazonSQSFullAccess

echo "Policy Attached"

sleep 3 && clear
