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
>2. Create an AMI which upon launch will have tomcat installed and running on a particular port. Automate the AMI creation process 
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

>3. Launch two instances (with EBS volumes) one of which will upload a file to s3 and the other downloads the same file. Note: follow least privilege principle
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
<br><br>

>4. Automate the process of setting up passwordless between two AWS EC2 instances.
<br>Deliverable :- Steps for setting up passwordless SSH

**Steps**
- First, I created two instances in the aws server1 and server2.
- Then, I logged into the server1.
- And created a ssh key using "ssh-keygen" command.
- After, I copied the public key and logged into the server2.
- Then, I pasted into the following folder "/.ssh/authorized_keys"
- After I ssh to ther server2 by following command "ssh -i ~/.ssh/id_rsa private_ip_of_other_server2".
- By the same way I created the ssh key and sent to the server1 from server2. A
- After I accessed the server1 from the server2.

### S3
>1. Recursively copy a directory and its subfolders from your PC to Amazon S3 using a single command
<br>Deliverable: Command to use

```bash
aws s3 cp myDir s3://mybucket/ --recursive
```
![loading...](/AWS%20Assignment/Images/AWSassignment7.jpg)
<br><br>
>2. Create bucket MyBucket and folder MySecretFolder. Write a bucket policy which allows all users to retrieve any object in MyBucket except those in the MySecretFolder. It also grants put and delete permission to the root user of AWS account.
<br>Deliverable: Bucket policy

This question I solved by trial and error method each time I faced error when creating the policy I solved and understood the error by AWS Documentation.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::123456789044:user/Test"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::my-bucket-102/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::123456789044:root"
            },
            "Action": [
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::my-bucket-102/MySecretFolder/*"
        },
        {
            "Effect": "Deny",
            "Principal": {
                "AWS": "arn:aws:iam::123456789044:user/Test"
            },
            "Action": "*",
            "Resource": "arn:aws:s3:::my-bucket-102/MySecretFolder/*"
        }
    ]
}
```

![loading...](/AWS%20Assignment/Images/AWSassignment8.jpg)
<br><br>

>3. Write a python script that will list down all the files and folders in s3 and send this list to your mail id.
<br>Deliverable: Python script

I get the files and folders list from the bucket. Then stored that in a message and send that through the SNS notification.

```python
import boto3

s3 = boto3.resource('s3')
mybucket = s3.Bucket('my-bucket-104')

mysns = boto3.client('sns')
message = "Your S3 bucket files and folders list \n"

for mybucket_obj in mybucket.objects.all():
    message=message+mybucket_obj.key+'\n'

mysns.publish(
    TopicArn = "arn:aws:sns:ap-south-1:123456789044:MyTopic",
    Message = message,
    Subject = "Your S3 Bucket Report"
)
```

![loading...](/AWS%20Assignment/Images/AWSassignment9.jpg)

I used this article for send SNS notification.
https://medium.com/@vishvratnashegaonkar27/sending-notifications-with-aws-sns-using-python-and-boto3-4c48bb51710
<br><br>

>4. You have an application which stores all the generated logs at a particular location. These logs are analyzed on a monthly basis by your Data Analyst team and generate reports. Once analyzed these files will be of no use to the Data Analyst team but your manager asks you to store these logs for at least 1 year from the time of creation just for backup. Design an appropriate strategy.
<br>Deliverable: Description of strategy and implementation either through CLI or Python

**Strategy**
- First, I created a json file.
- That json file automatically transition the objects to the Standard Infrequent-Access storage classes after 30 days.
- And delete the object after 365 days.
   
```json
{
    "Rules": [
        {
            "Expiration": {
                "Days": 365
            },
            "ID": "MjA1ZmQ3ZDYtMDJmNS00ZjNlLWE1MWUtOTY5MTg1N2RhMDE0",
            "Filter": {
                "Prefix": "SubFolder/"
            },
            "Status": "Enabled",
            "Transitions": [
                {
                    "Days": 30,
                    "StorageClass": "STANDARD_IA"
                }
            ],
        },
        {
            "Expiration": {
                "ExpiredObjectDeleteMarker": true
            },
            "ID": "DeleteMarkers",
            "Filter": {
                "Prefix": "SubFolder/"
            },
            "Status": "Enabled"
        }
    ]
}
```
- Using the following command I set the lifecycle configuration for the s3 bucket.
```cmd
aws s3api put-bucket-lifecycle-configuration --bucket mybucket154 --lifecycle-configuration file://lifecycle.json
```

>5. Assuming you have a versioning enabled S3 bucket and multiple versions of the same object, Write a python script which takes the bucket name and object path as parameters and downloads the 2nd latest version of this object i.e the one prior to the latest version.
<br>Deliverable: Python script

```python
import boto3

client = boto3.client('s3')
response = client.list_object_versions(Bucket='mybucket15455', Prefix='welcome.txt')

li = []
for i in response.get('Versions'):
    li.append(i.get('LastModified'))

li.sort()
s = li[len(li)-2]

versionid = ""
for i in response.get('Versions'):
    if s==i.get('LastModified'):
        versionid = i.get('VersionId')

res = client.get_object(Bucket='mybucket15455', Key='welcome.txt', VersionId=versionid)
```

This is the script I used for get my object in the versioning enabled bucket.
