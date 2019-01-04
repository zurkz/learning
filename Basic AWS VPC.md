# Create a basic VPC on AWS with a public and private subnet

### Create the VPC 
  ```	aws ec2 create-vpc --cidr-block 10.0.0.0/16```
```
{
  "Vpc": {
      "VpcId": "vpc-0ced319210e72e0a5",
      "InstanceTenancy": "default",
      "Tags": [],
      "CidrBlockAssociationSet": [
          {
              "AssociationId": "vpc-cidr-assoc-0e55c54d5d0dab483",
              "CidrBlock": "10.0.0.0/16",
              "CidrBlockState": {
                  "State": "associated"
              }
          }
      ],
      "Ipv6CidrBlockAssociationSet": [],
      "State": "pending",
      "DhcpOptionsId": "dopt-e618d29d",
      "OwnerId": "777907265175",
      "CidrBlock": "10.0.0.0/16",
      "IsDefault": false
  }
}
```
#### Tag the VPC 
  
Grab the VPC ID from the output of the previous command

```aws ec2 create-tags --resources vpc-0ced319210e72e0a5 --tags Key=Name,Value=CLI-VPC```

---
### Create subnets

  
* Private subnet

``` aws ec2 create-subnet --vpc-id vpc-0ced319210e72e0a5 --cidr-block 10.0.1.0/24```
```    
{
"Subnet": {
    "MapPublicIpOnLaunch": false,
    "AvailabilityZoneId": "use1-az4",
    "AvailableIpAddressCount": 251,
    "DefaultForAz": false,
    "SubnetArn": "arn:aws:ec2:us-east-1:777907265175:subnet/subnet-05671d9d9c5d401b2",
    "Ipv6CidrBlockAssociationSet": [],
    "VpcId": "vpc-0ced319210e72e0a5",
    "State": "pending
    "AvailabilityZone": "us-east-1d",
    "SubnetId": "subnet-05671d9d9c5d401b2",
    "OwnerId": "777907265175",
    "CidrBlock": "10.0.1.0/24",
    "AssignIpv6AddressOnCreation": false
  }
}
```  
* Public subnet

 ``` aws ec2 create-subnet --vpc-id vpc-0ced319210e72e0a5 --cidr-block 10.0.2.0/24```

    {
        "Subnet": {
            "MapPublicIpOnLaunch": false,
            "AvailabilityZoneId": "use1-az4",
            "AvailableIpAddressCount": 251,
            "DefaultForAz": false,
            "SubnetArn": "arn:aws:ec2:us-east-1:777907265175:subnet/subnet-0e6f68b3d240b59af",
            "Ipv6CidrBlockAssociationSet": [],
            "VpcId": "vpc-0ced319210e72e0a5",
            "State": "pending",
            "AvailabilityZone": "us-east-1d",
            "SubnetId": "subnet-0e6f68b3d240b59af",
            "OwnerId": "777907265175",
            "CidrBlock": "10.0.2.0/24",
            "AssignIpv6AddressOnCreation": false
        }
    }
  
#### Tag the subnets
  ``` aws ec2 create-tags --resources subnet-05671d9d9c5d401b2 --tags Key=Name,Value=CLI-VPC-Private```
  
  ``` aws ec2 create-tags --resources subnet-0e6f68b3d240b59af --tags Key=Name,Value=CLI-VPC-Public```

---

### Create the Internet Gateway (IGW)
  ``` aws ec2 create-internet-gateway```
  
    {
    "InternetGateway": {
        "Tags": [],
        "Attachments": [],
        "InternetGatewayId": "igw-0fd0bb6bffb7009dd"
      }
    }
    
#### Tag the IGW

``` aws ec2 create-tags --resources igw-0fd0bb6bffb7009dd --tags Key=Name,Value=CLI-VPC-IGW```
   
#### Attach the IGW to the VPC

   ``` aws ec2 attach-internet-gateway --internet-gateway-id igw-0fd0bb6bffb7009dd --vpc-id vpc-0ced319210e72e0a5```
   
---   
   
### Create the NAT Gateway

 First create an elastic IP (EIP)
 
 ``` aws ec2 allocate-address --domain vpc```

    {
    "PublicIp": "52.201.58.208",
    "Domain": "vpc",
    "AllocationId": "eipalloc-01ddefff2fe78a5af",
    "PublicIpv4Pool": "amazon"
    }

#### Create NAT Gateway

```aws ec2 create-nat-gateway --subnet-id subnet-05671d9d9c5d401b2 --allocation-id eipalloc-01ddefff2fe78a5af```

    {
    "NatGateway": {
        "NatGatewayAddresses": [
            {
                "AllocationId": "eipalloc-01ddefff2fe78a5af"
            }
        ],
        "VpcId": "vpc-0ced319210e72e0a5",
        "State": "pending",
        "NatGatewayId": "nat-047ebd208f6b5a245",
        "SubnetId": "subnet-05671d9d9c5d401b2",
        "CreateTime": "2019-01-02T23:54:32.000Z"
      }
    }

#### Tag the Nat Gateway

``` aws ec2 create-tags --resources nat-047ebd208f6b5a245 --tags Key=Name,Value=CLI-VPC-NATGW```

---

### Create the Route Tables

* Public Route Table

``` aws ec2 create-route-table --vpc-id vpc-0ced319210e72e0a5```

    {
    "RouteTable": {
        "Associations": [],
        "RouteTableId": "rtb-08ddde8b8bae72809",
        "VpcId": "vpc-0ced319210e72e0a5",
        "PropagatingVgws": [],
        "Tags": [],
        "Routes": [
            {
                "GatewayId": "local",
                "DestinationCidrBlock": "10.0.0.0/16",
                "State": "active",
                "Origin": "CreateRouteTable"
            }
        ],
        "OwnerId": "777907265175"
     }
    }
    
#### Tag the Route Table

``` aws ec2 create-tags --resources rtb-08ddde8b8bae72809 --tags Key=Name,Value=CLI-VPC-RTPUBLIC```

#### Tag the main route table

Grab the RouteTableID of the main rtb and create the tag

``` aws ec2 describe-route-tables```

```aws ec2 create-tags --resources rtb-0a36144552c74a223 --tags Key=Name,Value=CLI-VPC-MainRTB-PRIVATE```

#### Add route from Public rtb to the internet

```aws ec2 create-route --route-table-id rtb-08ddde8b8bae72809 --destination-cidr-block 0.0.0.0/0 --gateway-id igw-0fd0bb6bffb7009dd```

    {
      "Return": true
    }

#### Add route from Main Private rtb to the NAT Gateway

``` aws ec2 create-route --route-table-id rtb-0a36144552c74a223 --gateway-id nat-047ebd208f6b5a245 --destination-cidr-block 0.0.0.0/0```

    {
      "Return": true
    }
    
#### Associate public rtb with public subnet

``` aws ec2 associate-route-table --route-table-id rtb-08ddde8b8bae72809 --subnet-id subnet-0e6f68b3d240b59af```
  
    {
      "AssociationId": "rtbassoc-04456fbf5514a70c8"
    }
    
#### Associate private rtb with private subnet

``` aws ec2 associate-route-table --route-table-id rtb-0a36144552c74a223 --subnet-id subnet-05671d9d9c5d401b2```

    {
      "AssociationId": "rtbassoc-0041d1632745ba3ca"
    }

---

### Create security group to allow traffic 

```aws ec2 create-security-group --group-name CLI-VPN-WEBSG --description "SG created via CLI" --vpc-id vpc-0ced319210e72e0a5```

    {
      "GroupId": "sg-0b50276a141978363"
    }
  
#### Tag the security group

``` aws ec2 create-tags --resources sg-0b50276a141978363 --tags Key=Name,Value=CLI-VPC-WEBSG```

### Add rules to the security group

```aws ec2 authorize-security-group-ingress --group-id sg-0b50276a141978363 --protocol tcp --port 22 --cidr x.x.x.x/32```

```aws ec2 authorize-security-group-ingress --group-id sg-0b50276a141978363 --protocol tcp --port 80 --cidr 0.0.0.0/0```

---

### Create a key pair to ssh into EC2 instances 

``` aws ec2 create-key-pair --key-name CLI-VPN-keypair --query 'KeyMaterial' --output text > CLI-VPN-keypair```

### Create Web Server EC2 instance from Amazon Linux 2 AMI

``` aws ec2 run-instances --image-id ami-009d6802948d06e52 --count 1 --instance-type t2.micro --key-name CLI-VPN-keypair --security-group-ids sg-0b50276a141978363 --subnet-id subnet-0e6f68b3d240b59af --associate-public-ip-address```

    {
        "Instances": [
            {
                "Monitoring": {
                    "State": "disabled"
                },
                "PublicDnsName": "",
                "StateReason": {
                    "Message": "pending",
                    "Code": "pending"
                },
                "State": {
                    "Code": 0,
                    "Name": "pending"
                },
                "EbsOptimized": false,
                "LaunchTime": "2019-01-03T03:11:25.000Z",
                "PrivateIpAddress": "10.0.2.211",
                "ProductCodes": [],
                "VpcId": "vpc-0ced319210e72e0a5",
                "CpuOptions": {
                    "CoreCount": 1,
                    "ThreadsPerCore": 1
                },
                "StateTransitionReason": "",
                "InstanceId": "i-0b5d661fbf2ed7fd6",
                "ImageId": "ami-009d6802948d06e52",
                "PrivateDnsName": "ip-10-0-2-211.ec2.internal",
                "KeyName": "CLI-VPN-keypair",
                "SecurityGroups": [
                    {
                        "GroupName": "CLI-VPN-WEBSG",
                        "GroupId": "sg-0b50276a141978363"
                    }
                ],
                "ClientToken": "",
                "SubnetId": "subnet-0e6f68b3d240b59af",
                "InstanceType": "t2.micro",
                "NetworkInterfaces": [
                    {
                        "Status": "in-use",
                        "MacAddress": "0a:38:40:32:46:74",
                        "SourceDestCheck": true,
                        "VpcId": "vpc-0ced319210e72e0a5",
                        "Description": "",
                        "NetworkInterfaceId": "eni-0b39d873d203c4888",
                        "PrivateIpAddresses": [
                            {
                                "Primary": true,
                                "PrivateIpAddress": "10.0.2.211"
                            }
                        ],
                        "SubnetId": "subnet-0e6f68b3d240b59af",
                        "Attachment": {
                            "Status": "attaching",
                            "DeviceIndex": 0,
                            "DeleteOnTermination": true,
                            "AttachmentId": "eni-attach-0d98feab24094f5be",
                            "AttachTime": "2019-01-03T03:11:25.000Z"
                        },
                        "Groups": [
                            {
                                "GroupName": "CLI-VPN-WEBSG",
                                "GroupId": "sg-0b50276a141978363"
                            }
                        ],
                        "Ipv6Addresses": [],
                        "OwnerId": "777907265175",
                        "PrivateIpAddress": "10.0.2.211"
                    }
                ],
                "SourceDestCheck": true,
                "Placement": {
                    "Tenancy": "default",
                    "GroupName": "",
                    "AvailabilityZone": "us-east-1d"
                },
                "Hypervisor": "xen",
                "BlockDeviceMappings": [],
                "Architecture": "x86_64",
                "RootDeviceType": "ebs",
                "RootDeviceName": "/dev/xvda",
                "VirtualizationType": "hvm",
                "AmiLaunchIndex": 0
            }
        ],
        "ReservationId": "r-0e60badcc8fa5d680",
        "Groups": [],
        "OwnerId": "777907265175"
    }

#### Tag the instance

```aws ec2 create-tags --resources i-0b5d661fbf2ed7fd6 --tags Key=Name,Value=CLI-VPC-WebServer```

#### Wait for the instance to be created and then query the instance to find the public IP and SSH into the instance

```aws describe-instances --instance-id i-0b5d661fbf2ed7fd6```

``` chmod 400 CLI-VPN-keypair```

``` ssh ec2-user@x.x.x.x -i CLI-VPN-keypair ```


Install httpd and set up web server or whatever. Can create instances in the private subnet that can get out to the internet via the NAT Gateway

---

### Deleting Everything

#### Terminate the EC2 instance

``` aws ec2 terminate-instances --instance-id i-0b5d661fbf2ed7fd6```

    {
        "TerminatingInstances": [
            {
                "InstanceId": "i-0b5d661fbf2ed7fd6",
                "CurrentState": {
                    "Code": 32,
                    "Name": "shutting-down"
                },
                "PreviousState": {
                    "Code": 16,
                    "Name": "running"
                }
            }
        ]
    }
    
#### Delete the security group

``` aws ec2 delete-security-group --group-id sg-0b50276a141978363```

#### Delete the NAT Gateway

```aws ec2 delete-nat-gateway --nat-gateway-id nat-047ebd208f6b5a245```

    {
        "NatGatewayId": "nat-047ebd208f6b5a245"
    }

#### Delete the subnets

``` aws ec2 delete-subnet --subnet-id subnet-0e6f68b3d240b59af ```

``` aws ec2 delete-subnet --subnet-id subnet-05671d9d9c5d401b2```

#### Detach the IGW from the VPC

``` aws ec2 detach-internet-gateway --internet-gateway-id igw-0fd0bb6bffb7009dd --vpc-id vpc-0ced319210e72e0a5```

#### Delete the IGW

``` aws ec2 delete-internet-gateway --internet-gateway-id igw-0fd0bb6bffb7009dd```

#### Delete the public route table

``` aws ec2 delete-route-table --route-table-id rtb-08ddde8b8bae72809```

#### Delete the VPC which also deletes the main route table (private rtb)

```aws ec2 delete-vpc --vpc-id vpc-0ced319210e72e0a5```


