### AWS Assignment
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
