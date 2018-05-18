# set_alarm_for_stopping_ec2
This script is used to automatically stop the idle EC2 instance (its maxium CPU utilization is less than 3% over a hour period)

## Run 
```
bash set_alarm_for_stopping_ec2.sh <alarm_name> <email_address> <ec2_instance_id> 
```

## Confirm subscription
Confirm email subscription by clicking the confirmation link in the body of the message to complete the subscription process. 

## Outcome 
1) Generate a CloudWatch alarm 
2) Generate a SNS topic
3) Subscribed the SNS topic with your email 

## Notes
There are three scenarios for stopped instance’s CloudWatch alarm.

1) `No Data` alarm status. If you restart your instance, CloudWatch will work as expected.

2) `ALARM` alarm status #1. If you restart your instance AND do some work, CloudWatch will work as expected. You will notice that ALARM alarm status will disappear and OK will appear in a few minutes.

3) `ALARM` alarm status #2. If you restart your instance AND don't do any work, CloudWatch will NOT work as expected. The instance will not automatically stop because the instance alarm status is still ALARM, and CloudWatch alarm won't be triggered without any alarm status changes.

Please avoid last scenario. To solve this, please either do some work (like scenario 2) or stop your instance and wait for at least 1 hour.
