## Milestone 4

### Set up Ci/CD for the application from scratch

- First, I installed Jenkins in my local system.
- Then, created a repository to access and stored the Insfrastructure code in the repository.
- https://github.com/Vishal-4323/Jenkins
- Furthormore, used the following documentation to create the Infrastructure Deployment pipeline.
- [https://spacelift.io/blog/terraform-jenkins](https://spacelift.io/blog/terraform-jenkins)

![loading...](/Milestones/MilestoneImages/tfjenkins.png)

- After, I tried to do CD for AMI.
- But, the EC2 instance in private subnet and I can't able to use the user data in the EC2 instance created by the AMI.
- So, I didn't use the aws modify instances command. Then, I planned to create an EC2 instance in public subnet by using the AMI of the private subnet EC2 instance.
- In the aws create instance command I use the public subnet and the AMI of private subnet instance.
- Then, created an repository for the API code and the myscript.txt for user data to change the api code in the EC2 instance.
- https://github.com/Vishal-4323/CD-for-AMI
- If we change anything in the code it will create a new instance with the changes.
- Furthermore, I created a pipeline for CD for AMI. It used the API code repository and create the EC2 instance with user data. 
- And we can use the EC2 instance id in the Infrastructure Deployment pipeline.

![loading...](/Milestones/MilestoneImages/instanceJenkins.png)