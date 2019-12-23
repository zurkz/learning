# Elastic Beanstalk

When creating a NodeJS application, by default AWS EBS creates:
- EC2 Instance configured to run a webapp
- Instance Security Group - allow inbound traffic on port 80. 
- Load Balancer - ELB configured to distribute requests to the instances running applications. 
- Load Balancer security group - EC2 sg configured to allow inbound traffic on port 80. 
- Auto Scaling group - ASG configured to replace an instance if it is terminated or becomes unavailable.
- S3 Bucket - storage location for source code, logs, and other artifcats(files, etc) created using EBS.
- CloudWatch Alarms - 2 cloudwatch alarms that monitor the instances. When an alarm is triggered, the ASG scales up or down in response.
- CloudFormation Stack - Creates a cloudformation template to launch resources in your environment and propagate config changes. 
- Domain Name - creates a domain name that routes to your app. This is if you use Route53 instead of

- **EBS manages all of the resources. When the env is terminated, EBS terminates all the resources inside of it (excluding the S3 bucket)**

