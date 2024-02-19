# AWS Assignment
### IAM
>1. List users by ARN in your AWS account using a single command <br>Deliverable: Command to use

```bash
aws iam list-users
```
![loading...](/AWS%20Assignment/Images/AWSAssignment1.jpg)
<br><br>
>2. Your company has recently hired a group of 10 freelancers for a specific project for a short period of time. Your manager wants them to access the AWS account only when they are within the organization’s network. Design an IAM policy to achieve this following the best practices.<br>Deliverable: Description of your strategy and IAM policy

I will create a IAM user group and add the freelancers in the groups. By using IAM group I can easily manage the permissions of the IAM users. Then, I'll use the condition operators in IAM policy. There, I'll use the IP address condition operators for specify the company IP address range.

**IAM Policy**
```json
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": "iam:*AccessKey*",
    "Resource": "arn:aws:iam::account-id:user/*",
    "Condition": {"IpAddress": {"aws:SourceIp": "203.0.113.0/24"}}
  }
}
```
I used this documentation for learn about IP address condition operator. 
https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html#Conditions_IPAddress
<br><br>
### EC2
>1. List all of your  instances that are currently stopped and the reason for the stop using a simple one line command<br>
Deliverable: Command to use

I used describe-instances command and filter and query sub commands for this problem.

```bash
aws ec2 describe-instances --filter Name=instance-state-name,Values=stopped --query "Reservations[*].Instances[*].{Instance:InstanceId, InstanceReason:StateTransitionReason}"
```
![loading...](/AWS%20Assignment/Images/AWSassignment3.jpg)
I used this documentation to solve this problem. 
https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html
<br><br>
>2.Create an AMI which upon launch will have tomcat installed and running on a particular port. Automate the AMI creation process 
<br>Deliverable: AMI and Automation Script

First, I created an Instance. After I installed the apache tomcat and ran the server on a particular port by using this documentation. https://medium.com/@madhavarajas1997/installing-apache-tomcat-on-ubuntu-22-04-08c8eda52312

![loading...](/AWS%20Assignment/Images/AWSassignment4.jpg)

Then, I created the automation python code. By using the filters we can get the instance details and create image for that instance.

```python
import boto3

try:
    ec2 = boto3.resource('ec2', region_name='ap-south-1')
    image_ids = []
    instances = ec2.instances.filter(
        Filters=[
            {
                'Name': 'instance-state-name', 'Values': ['running']
            }
        ]
    )
    for instance in instances:
        print(instance.id)
        image = instance.create_image(Name='AMI Copy For '+instance.id)
        print(image)

except Exception as e:
    print(e)
```
I ran this code it's created the AMI for that instance.

![loading...](/AWS%20Assignment/Images/AWSassignment4(i).jpg)

Here, I used this documentation https://dheeraj3choudhary.com/automate-aws-ami-creation-for-ec2-and-copy-to-other-region-or-disaster-recovery
<br><br>

>3.Launch two instances (with EBS volumes) one of which will upload a file to s3 and the other downloads the same file. Note: follow least privilege principle
<br>Deliverable :- Required Steps and Scripts

**Steps**
- First, I created a S3 object in my instance.
- Then, I created a json policy to upload a file in S3.
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject"
      ],
      "Resource": ["arn:aws:s3:::test/*"]
    }
  ]
}
```
- And created a IAM role and attached this policy.
- Then, I attached this role to the instance by Modify IAM role.
- Again I created a json policy to download the same file in S3.
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": ["arn:aws:s3:::test/*"]
    }
  ]
}
```
- And created another IAM role and attached to this policy.
- Then, attached the IAM role to the instance by Modify IAM role.
