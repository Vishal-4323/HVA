## Deploy the same application with a production grade design
I tightened the security group rules and restricted the unnecessary traffic. I put my ec2 instance in private subnet by disable the public IP addresses. And I removed the Internet gateway route for the subnet. Then we can't able to access the instance in public network.

Then I created a VPC endpoint for connect my instance.

After, I try to create an Auto Scaling Group for my instance. If we create an ASG we need template for the instance. So, I created an AMI for my instance. By using the AMI I created a template for the ASG.
