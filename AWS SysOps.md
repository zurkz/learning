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

