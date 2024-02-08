## Deploy the same application with a production grade design

#### Architecture Diagram
![loading...](/Milestones/MilestoneImages/Arch.png)


I tightened the security group rules and restricted the unnecessary traffic. I put my ec2 instance in private subnet by disable the public IP addresses. And I removed the Internet gateway route for the subnet. Then we can't able to access the instance in public network.

Then I created a VPC endpoint for connect my instance.

After, I try to create an Auto Scaling Group for my instance. If we create an ASG we need template for the instance. So, I created an Image for my instance. By using the AMI I created a template for the ASG.

![loading...](/Milestones/MilestoneImages/milestone2(i).jpg)

Then I created the ASG.

![loading...](/Milestones/MilestoneImages/milestone2(ii).jpg)

Then, I gave the ASG instance into the Target Group. And I created an Application Load Balancer by using the Target Group.
And I updated the ASG.

![loading...](/Milestones/MilestoneImages/milestone2(iii).jpg)

![loading...](/Milestones/MilestoneImages/milestone2(iv).jpg)

![loading...](/Milestones/MilestoneImages/milestone2(v).jpg)
