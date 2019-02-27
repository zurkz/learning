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

IRL use https://ec2instances.info to spec what type of instance you may need.

