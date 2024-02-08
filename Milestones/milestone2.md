## Deploy the same application with a production grade design

#### Architecture Diagram
![loading...](/Milestones/MilestoneImages/Arch.png)


I tightened the security group rules and restricted the unnecessary traffic. I put my ec2 instance in private subnet by disable the public IP addresses. And I removed the Internet gateway route for the subnet. Then we can't able to access the instance in public network, then I created a VPC endpoint for connect my instance.

Following are some steps I did;

- Now, I try to create an Auto Scaling Group for my instance.
- If we create an ASG we need template for the instance. 
- So, I made an Image for my instance. 
- By using the AMI a template for the ASG is created.

![loading...](/Milestones/MilestoneImages/milestone2(i).jpg)

- Finally, creation of ASG is done.

![loading...](/Milestones/MilestoneImages/milestone2(ii).jpg)

- I set the ASG instance into the Target Group and an Application Load Balancer is created using the Target Group and I updated the ASG.

![loading...](/Milestones/MilestoneImages/milestone2(iii).jpg)

![loading...](/Milestones/MilestoneImages/milestone2(iv).jpg)

![loading...](/Milestones/MilestoneImages/milestone2(v).jpg)

- Then, I tested the application by ALB domain name and it worked. 
- After, the application was tested next day and it showed "type error". 
- Further I checked the code.

![loading...](/Milestones/MilestoneImages/image.png)

![loading...](/Milestones/MilestoneImages/image(1).png)

- I printed the exception in the Except block that was the problem and this was the false approach I did "print e". 
- So, I changed the code to return the exception and updated the version of template, "return e". 
- Then, I tested the application by ALB domain name and it worked. 
- After, the application was tested next day and again it showed the "type error". 
- I deleted the ALB, Target Group and ASG to redo once again as I was afraid of Cost. 
- Now, tried to find the error. 
- Then, I wrote "return str(e)" in the except block and created AMI, ASG, and ALB. 
- Further, I checked the application and it worked. 
- I tested the application next day it returns mysql connection timed out. 
- Then I established the connection in every methods and closed the connection in the same methods and updated the template. 
- After, It's worked well.

- As to conclude, I created a alarm in CloudWatch as it would send a notification to Email if the CPU utilization is greater than 80% in the ASG instances, through the SNS Notification.

![loading...](/Milestones/MilestoneImages/milestone2(vi).jpg)
