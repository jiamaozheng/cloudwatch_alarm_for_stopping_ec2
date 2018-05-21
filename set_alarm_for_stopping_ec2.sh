#!/bin/bash

# usages: bash set_alarm_for_ec2.sh <iam-user-name> <email-address> <ec2-instance_id> 

# Step one: 
# Create the topic using the create-topic command
sns_topic=$(aws sns create-topic --name $1 --output text)

# Step two: 
# Subscribe your email address to the topic using the subscribe command. 
# You will receive a confirmation email message if the subscription request succeeds. 
# Confirm that you intend to receive email from Amazon Simple Notification Service 
# by clicking the confirmation link in the body of the message to complete the subscription process. 
aws sns subscribe \
	--topic-arn $sns_topic \
	--protocol email \
	--notification-endpoint $2

# Step three: 
# create cloudwatch alarm
aws cloudwatch put-metric-alarm \
	--alarm-name $1-EC2StopAlarm \
	--alarm-description "Stop the instance when it is idle for one hour" \
	--namespace "AWS/EC2" \
	--dimensions Name=InstanceId,Value=$3 \
	--statistic Maximum \
	--metric-name CPUUtilization \
	--comparison-operator LessThanThreshold \
	--threshold 3 \
	--period 300 \
	--evaluation-periods 12 \
	--alarm-actions arn:aws:automate:us-east-1:ec2:stop $sns_topic  \
	--unit Percent
