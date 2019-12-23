# AWS Certified SysOps Administrator study guide 

---

## EC2 for SysOps

#### Changing EC2 Instance Type
t2.micro ---> t2.medium
  - Changing the instance type only works for **EBS backed instances**

To Change the instance:
1. Stop the instance
2. Right click instance. Instance Settings --> Change Instance Type
3. Select the instance type that fits your needs. In this case I choose t2.medium
   1. When changing to a large instance type, you have the option for an EBS-optimized instance
4. The instance type changes immeditely and you can the start the instance.
5. The new instance uses the same EBS volume so you don't have to worry about losing data.

#### EC2 Placement Groups
- When you want control over how you want your instances placed, or the EC2 instance placement strategy.
- When creating a placement group, you can specifiy the placement group **strategy**:
    - Cluster --> cluster EC2 instances into a low-latency group in a single AZ
      - Instances are on the same hardware and rack. 
       - Use cases:
         - Big data job that needs to complete fast.
         - Application that needs extremely low latency and high network throughput

         | Pros | Cons
         ---|---
         Low latency, very fast network (10Gbps between instances) | If the rack fails, all instances fail at same time 

    - Spread --> spread EC2 instances across underlying hardware (max 7 instances per group per AZ)
      - All EC2 instances will be placed (spread) on different hardware
      - Span accross AZ's
      - Uses Cases:
        - Application that needs to maximize HA
        - Cassandra cluster, Kafka Cluster, Web App that needs to be distributed
         
        |Pros | Cons
        ---|---
        Can spread across AZ's | Limited to 7 instances per AZ per placement group
        Reduced risk of simultaneous failure | 
        EC2 instances are on different physical hardware |  

    - Can't use Placement Groups for t2 instance types

When launched an instance, at the "Configure Instance Details" add your instance to a placement group by clicking the box "Add instance to placement group." next to the "Placement Group" label. 

You then can add the instance to an existing placement group or create a new placement group right there and select the strategy. 

### EC2 Shutdown Behavior & Termination Protection

**Shutdown behavior:** How should the instance react when the instance is shut down from within the OS?
- Default = Shutdown
- Terminate is an option

Not relevant to the AWS console or AWS API

CLI Attribute = **InstanceInitiatedShutdownBehavior**

Termination Protection: If enabled, the instance(s) will be protected from accidental termination in the AWS conolse and AWS CLI. 
- The button to terminate the instance will be greyed out and you have to disable "Termination Protection" before you can terminate the instance(s).

Exam Tip:

If an instance has shutdown behavior = terminate and termination protection turned on, 


### EC2 Launch Troubleshooting

- InstanceLimitExceeded error: means you have reached your max limit of # of instances per region. To resolve, either launch the instance in a different region or request AWS to increase your limit.
- InsudfficientInstanceCapacity: AWS does not have the much On-Demand capacity in the particular AZ. To resolve, wait a few minutes before requesting again. If requesting multiple instances (say 5), break down the request say into single requests of 1. If urgent, submit a request for a different instance type now, which can be resized later.
- Instance Terminates Immediately (goes from pending to terminated): 
  - You've reached your EBS volume limit.
  - An EBS snapshot is corrupt
  - root EBS volume is encrupted and you do not have permissions to access the KMS key for decryption
  - The instance store-backed AMI that is used to launch the instance is missing a required part
    - Enable "state transition reason" and "state transition reason" columns to find more detail about why the instance goes from Pending --> Terminated

### Troubleshooting EC2 SSH Issues

- Make sure the pem file has correct permissions (400) or you will get an "Unprotected Private Key File error"

- Make sure the username for the OS is given correctly when logging in via SSH or you will get a "Host key not found" or "Permission Denied"
 
- Possible reasons for "connection timeout" error:
  - Security Groups are not configured correctly
  - Instance CPU load is too high

### EC2 Instance Launch Types

- On Demand Instances: short workload, predictable pricing
  - Pay for what you use (billing per second, after first minute)
  - Has the highest cost but no upfront payment
  - No long term commitment. Can stop and start the instance whenever you want.
  - Recommended for short-term and in-interrupted workloads, where you can't predict how the application will behave.
- Reserved Instances: long workloads (>= 1 year)
  - Up to 75% discount compared to On-Demand
  - Pay upfront for what you use with long term commitment
  - Reservation period can be 1 or 3 years.
  - Reserve a specific instance type
  - Recommended for steady state usage applications (databases)
- Convertible Reserved Instaces: long workloads with flexible instances. Not exactly sure what the instance will be doing, can convert between different instance types down the road.
  - can change the EC2 instance type
  - Only up to 54% discount
- Scheduled Reserved Instances: launch within time window you reserve. You know something is going to happen every week. Going to reserve some capacity but only for a small window.
  - launch within time window you reserve
  - (every sunday during football games, etc)
- Spot Instances: short workloads, for cheap, can lose instances. Bidding on instances.
  - Can get a discount of up to 90% compared to On-Demand
  - Have to bid a price and get hte instance as long as its under the price. If you get outbid you will lose the instance.
  - Prices vary based on offer and demand.
  - Reclaimed (terimated) with a 2 minute notification warning when the spot price goes above your bid.
  - Used for batch jobs that are very cheap, big data analysis, or workloads that are resilient to failures. Not great for citical jobs or databases.
- Dedicated Instances: no other customers will share underlying hardware.
  - Instances running on hardware thats dedicated to you.
  - Don't have full control of the hardware.
  - May share hardware with other instances **in the same account**.
  - No control over instance placement. (can move hardware after Stop / Start)
- Dedicated Hosts: book an entire physical server, control instance placement.
  - Physical dedicated EC2 server for your use
  - Full control of EC2 Instance placement
  - Visibility into the underlying sockets / physical cores of the hardware
  - Allocated for your account for a 3 year period reservation
  - More expensive
  - Useful for software that have complicated licensing model. (BYOL, billed on # of cores, etc)
    - Or for companies that have strong reulatory or compliance needs.

What host is right for me?

On Demand: coming and staying in a resort whenever we like and paying the full price.

Reserved: planning ahead and if you plan to stay for a long period of time, you might get a good discount.

Spot instances: the hotel has spare capacity and allows people to bid for the empty rooms and the highest bidder keeps the room and you have to bid again for the next night. You can get kicked out at any time.

Dedicated hosts: You book an enitre building or floor of the resort.

 
### EC2 Instance Types - Main ones

- R: RAM. applications that need a lot of RAM
- C: CPU. compute. applications that need lots of CPU. databases, Big Data
- M: Middle. Medium. applications that are balanced - general web app, etc
- I: I/O. applications that need good local I/O (instance storage) - databases
- G: GPU. video rendering / machine learning
- T T2/T3 burstable instances: (up to a capacity). good performance (burst) for a short while.
  - overall instance has OK CPU performance and when you need to process something enexpected ( a spike in load), it can burst and CPU load can increase. If the instance bursts, the instance uses "burst credits". When you run out of credits, the CPU load decreases significantly. When the instance stops bursting, the credits are accumulated over time.
  - These instances can be amazing to handle unexpected traffic and getting the insurance that it will be handled correctly.
  - If your instance consistently runs low on credit, you need to move to a different kind of non-burstable instance.
- T T2/T3 unlimited: unlimited burst
  - You pay extra money if you go over your credit balance, but you don't lose performance.
  - Kinda new (if you consider 2017 new..). so be careful as costs could go high if you're not monitoring the health and status of your instances.

IRL use https://ec2instances.info to spec what type of instance you may need.


### EC2 AMIs

base images

AMIs are custom images that can be used on instances. Linux/Windows

Using a custom built AMI can provide the following advantages:
- Pre-installed packages needed
- Faster boot time (no need for ec2 user data at boot time)
- Machine comes configured with monitoring / enterprise software
- Security concerns -  control over the machines in the network
- Control of maintenance of updates of AMIs over time (compliance)
- Active Directory Integration out of the box
- Installing your app ahead of time (for faster deploys when auto-scaling)
- Using someone lese's AMI that is optimised for runnning an app, DB, etc...
- AMIs are built for a specific region. **AMIs ARE NOT GLOBAL**
- Can pay (rent) someone else's AMI by the hour

Some AMIs may come with malware or not suitable for your enterprise SO DO YOU DUE DILIGENCE

- You AMIs take space and are stored in S3
- By default, your AMIs are private and locked for your account / region
- You can make them public to share with other people or sell on the marketplace.

AMI Pricing
- Since AMIs live in S3, you get charged for the actual space that an AMI takes up in S3. 
  - S3 Pricing in us-east-1:
    - First 50TB/month = $0.023/GB
    - Next 450TB/month = $0.022/GB
- Overall its quite inexpensive to store private AMIs
- Make sure to remove the AMIs you don't use

Cross Acount AMI Copy
- You can share an AMI with another AWS account.
- Sharing an AMI does not affect the ownership of the AMI.
- If you copy an AMI that has been shared with your account, you are the onwer of the target AMI in your account.
- To copy an AMI that has been shared with you from another account, the owner of the source AMI must grant you read permissions for the storage that backs the AMI, either the associated EBS snapshot (for an EBS-backed AMI) or an assoicated S3 bucket (for an instance store-backed AMI)

Limits
- You can't copy an encrupted AMI that was shared with you from another account. Instead, if the underlying snahpshot and encryption key were shared with you, you can copy the snapshot while re-cnerypting it with a key of your own. You own the coped snapshot and can register it as a new AMI.
- You can't copy an AMI with an assoicated billingProduct code that was shared with you from another account. This includes Windows AMIs and AMIs from the AWS Marketplace. To copy a shared AMI with a billingProduct code, launch an EC2 instance in your account using the shared AMI and then create an AMI from the instance. 

### Elastic IPs

- When you stop and then start an EC2 instance, it changes its public IP.
- If you need to have a fixed public IP, you need an Elastic IP
- An Elastic IP (EIP) is a public IPv4 IP you own as long as you don't delete it. 
- You can attach it to one instance at a time
- You can remap it across instances
- You pay for any EIP that is not attached to a server
- You don't pay for the EIP if it's attached to a server
- 5 EIP limit. Can request AWS to increase the limit.

Why use an EIP?
- You can mask the failure of an instance or software by rapidly remapping the address to another instance in your account.


- Overall, try to avoid using an EIP.
  - Always think if other alternatives are available to you.
  - You could use a random public IP and and register a DNS name to it using Route53
  - Use a Load Balancer with a static hostname that maps back to your instances

### CloudWatch Metrics for EC2

- AWS provides metrics for instances (AWS pushes them)
  - Basic monitoring (default): metrics are collected at a 5 min interval
  - Detailed Monitoring (paid): metrics are collected at a 1 minute interval
  - Includes: CPU, Network, Disk and Status Check Metrics
  - Custom metrics (yours to push) 
    - Basic Resolution: 1 minute resolution
    - High Resolution: all the way to 1 second resolution
    - Includes: RAM, application level metrics
    - Make sure the EC2 has an associated IAM role to push the metrics to CloudWatch

EC2 Included Metrics
- CPU: CPU utilization + t2/t3 burst credit usage & balance
- Network: Network In / Out
- Status Check:
  - Instance status = check the EC2 instance
  - System status = check the underlying hardware
- Disk: Read/Write for Ops/Bytes (only for instance store)
- **RAM IS NOT INCLUDED IN AWS EC2 METRICS**


### Custom CloudWatch Metrics for EC2

- RAM usage
- SWAP usage
  
  New way - use CloudWatch agent

  but you can use scripts, gotta download, install, and enable - find documentation on AWS to find the scripts for your distro. Also need to ensure scripts have the correct permissions, IAM roles. Create a new EC2 role with CloudWatch Full Access or more granular policy and attach it to the EC2 instance. Add scripts to crontab to run it

### CloudWatch Logs for EC2

CloudWatch agent runs on EC2 instance and pushes all the log files you want straight to CloudWatch.
- Make sure IAM permissions are correct.
- Can run agent on on-prem server to collect logs.

check documentation for more detailed instructions.

on instance run, ```sudo yum install -y awslogs```
- edit the conf file and the cli file to change the region

---

## Manage EC2 Instances at SCALE - SSM & Opswork

### Systems Manager Overview

- Helps you manage you EC2 and On-Prem systems at scale
- Get operational insights about the state of your infrastructure
- Easily detect problems
- Patching automation for enhanced compliance (common question on exam?!?)
- Free
- Integrated with CloudWatch metrics/dashboards & AWS Config

Features
- Resource Groups
- Insights
  - Insights Dashboard, Invetnory, Compliance
- Parameter Store

Actions
- Automation
- Run command
- Session Manager
- Patch Manager
- Maintenance Windows
- State Manager

How does SSM work?
- AWS Service
- Instances need to install the SSM Agent
- Agent is installed by default on AL2 and some Ubuntu AMI's
- SSM doesn't work out of the box, ensure proper IAM roles are enabled (AmazonEC2RoleforSSM)

### AWS Tags
- Key Value Pairs that attach to many AWS resources
- Common tags: Name, Environment, Team, Department, etc
- Used for: 
 - Resource Grouping
 - Automation
 - Cost Allocation
- Better to have to many tags than to few

AWS Systems Manager Resource Groups
- Create view or manage logical group of resources thanks to
- Create logical groups of resources in SSM such as:
  - Applications
  - Different layers of an application stack
  - Production versus development environments
- Regional Service (create different RGs if operation in different regions)
- Works with EC2, S3, DynamoDB, etc

### SSM Documents & SSM Run Command 

Documents
- JSON or YAML
- Define parameters
- Define Actions
- Many docs already exist in AWS

Run Command
- Run command across multiple instances (using resource groups)
- Execute a document (=script) or just run a command
- Rate Control/Error Control
- Integrated with IAM & CloudTrail
- No need for SSH 
- Results in the console


### SSM Inventory & Patches
- Invetory --> List software on an instance
- Inventory + Run Command --> Patch Software
- Patch Manager --> Gives you compliance
- Patch Manager + Maintenance Window --> Patch OS
- State Manager --> Ensure instances are in a consistent state (compliance)


### SSM Secure Shell
Session Manager allows you to start a secure shell on your VM
- Does not use SSH acces and bastion hosts
- Uses SSM Agent
- Only works for EC2 but On-Prem will be soon supported
- Log actions done through secure shells to S3 and CloudWatch Logs
- IAM permissions: access SSM + write to S3 + write to CloudWatch
- CloudTrail can intercept StartSession events
- AWS Secure Shell VS SSH:
  - No need to open 22
  - No need for bastion hosts
  - All commands are logged to S3 and CloudWatch (auditing)
  - Acces to Secure Shell is done through User IAM and not SSH Keys
- Can encrypt log data
In Systems Manager, go to Session Manager

### What if I lose my SSH Key for EC2

 Different measures depending on if your instance is EBS backed or instance-store backed

 If EBS-backed:
 - Stop the instance then detach the root volume
 - Attach root volume to another instance as a data volume
 - Modify the ~/.ssh/authorized_keys file with your new key
 - Move the volume back to the stopped instance
 - Start the instance and you can SSH into it again


 New Method for EBS-backed via SSM:
 - Run the AWSSupport-ResetAccess automation document in SSM


 Instance Store Backed EC2
 - Can't store the instance or you will lose all data.
 - AWS recommends to terminate the instance and create a new one.

 TIP: Use Session Manager to get a shell and edit the ~/.ssh/authorized_keys file directly

 ### SSM Parameter Store Overview

 - Secure storage for configuration and secrets
 - Optional Seamless Encryption using KMS
 - Serverless, scalable, durable, easy SDK, free
 - Version tracking of configurations/secrets
 - Configuration management using path & IAM
 - Notifications with CloudWatch Events
 - Integration with CloudFormation

 Application contacts SSM Parameter Store. Parameter Store checks IAM Permissions to check if it has the rights to use the Parameter. If so, it gets sent back to the application.

 #####Parameter Store Hierarchy

- /my-department/
  - my-app/
    - dev/
      - db-url
      - db-password
    - prod/
      - db-url
      - db-password
  - other-app/
- /other-department/

or however YoU wAnT. just define some kind of heirarchy.

Say you have dev-lambda function. To get parameters you would use the GetParameters or GetParamtersByPath API
 
CLI:

aws ssm get-parameters --names /my-app/dev/db-url my-app/dev/db-password (--with-decryption)

### AWS Opsworks Overview

- Chef & Puppet help you perform server configuration automatically, or repetitive actions
- They work great with EC2 & On-Prem VM
- AWS Opsworks = Managed Chef & Puppet
- An alternative to AWS SSM


IN THE EXAM: Any time you think you would need to use Chef or Puppet, the answer would be AWS Opswork


Chef/Puppet:
- Help with managing config as code
- Helps in having consistent deployments
- Works with Linux/Windows
- Can automate: user accounts, cron, ntp, packages, services...
- They leverage "Recipes" or "Manifests"
- Have a lot of similarities with SSM/Beanstalk/CloudFormation but they're open source and work cross-cloud 

---

## EC2 High Availability and Scalability

### Scalability 

Two kinds:
  - Vertical Scalability
    - increase the size of the instance
    - ex: application goes on t2.micro. scaling the application vertically means running it on a t2.large.
    - very common for non-distributed systems, such as a db
    - RDS, ElastiCache, etc
    - usually a hardware limit
  - Horizontal Scalability (=elasticty)
    - increase the # of instances/systems for your application
    - Horizontal scaling imples distributed systems.
    - Very common for web apps/modern apps
    - Easy to horizontally scale thanks to the cloud (EC2, GCloud), 1-click scaling


High Availability
- goes hand in hand with horizontal scaling
- Means running your application/system in at least 2 data centers (AZ's)
- Goal of HA is to survive a data center loss
- Can be passive (RDS Multi AZ for example)
- Can be active (for horizontal scaling)

FOR EC2:
- Vertical Scaling --> Increasing the instance size (scale up/down)
- Horizontal Scaling --> Increase the number of instances you have (scale out/in)
  - Auto scaling groups
  - Load Balancer
- High Availablility --> Run instances for the same applicatipon across multi AZ
  - Auto Scaling Group multi AZ
  - Load Balancer multi AZ

### Load Balancing Overview
- Load balancers are servers that forward internet traffic to multiple servers (EC2 Instances) downstream.

Users connect to Load Balancer and Load Balancer redirects that traffic to an EC2 instance. Users are not directed to the same instance. Load is being balanced.

Why use a load balancer?
- Spread load across multiple downstream instances
- Expose a single point of access (DNS) to your application
- Seamlessly handle failures of downstream instances
- Provide SSL termination (HTTPS) for your websites
- Enforce stickiness with cookies. Meaning user will talk to the same instance the whole time.
- HA across zones
- Separate public traffic from private traffic

#### ELB
- Managed load balancer
- AWS guarantees that it will be working
- AWS takes care of upgrades, maintenance, HA
- AWS provides only a few configuration knobs
- It costs less to setup your own load balancer but it will be a lot more effort on your end
- It is integrated with so many AWS Servers


AWS has 3 kinds of load balancers

1. Classic Load Balancer (v1 - old generation) - 2009
2. Application Load Balancer (v2 - new generation) - 2016
3. Network Load Balancer (v2 - new generation) - 2017

- Recommended to use the newer/v2 load balancers as they provide more features


You can setup an internal (private) or external (public) ELBs


##### Health Checks

Crucial for Load Balancers as they enable you to know if your instances are healthy. 
- They let load balancers know if the instances it forwards traffic to are available to reply to requests.


- The health check is done on a port and a route (/health is common)
- If the response is not 200 (OK), then the instance is unhealthy


