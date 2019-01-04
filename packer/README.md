# Creating an AWS AMI with Packer


#### Create the AMI

define a builder template to create the AMI

example builder template for AWS:

```
{
  "variables": {
    "region" : "us-east-1"
  },
  "builders": [{
    "type": "amazon-ebs",
    "region": "{{user `region`}}",
    "profile": "default",
    "source_ami" : "ami-009d6802948d06e52",
    "instance_type": "t2.micro",
    "ssh_username": "ec2-user",
    "ami_name": "packer-build01-docker",
    "ami_description": "amazon linux 2 with docker - created via packer",
    "run_tags": {
      "Name": "packer-builder-docker",
      "Author": "zurkz",
      "Builder": "Packer"
}
  }
],
  "provisioners": [
      {
          "type": "shell",
          "script": "./config.sh"
      }
  ]
}
```

---

#### Define the provisioner 

this provisions a machine using shell scripts or connect to ansible/chef/puppet/etc

example provisioner section:

```
  "provisioners": [
      {
          "type": "shell",
          "script": "./config.sh"
      }
  ]
```


validate the template

```packer validate /path/to/buildertemplate.json```

---

#### Build the AMI

```packer build /path/to/buildertemplate.json```

output:

```
amazon-ebs output will be in this color.

==> amazon-ebs: Prevalidating AMI Name: packer-build01-docker
    amazon-ebs: Found Image ID: ami-009d6802948d06e52
==> amazon-ebs: Creating temporary keypair: packer_5c2fba56-04af-3b47-9058-61a3b187bb07
==> amazon-ebs: Creating temporary security group for this instance: packer_5c2fba58-bfc2-f311-8d7a-569ce7e23662
==> amazon-ebs: Authorizing access to port 22 from 0.0.0.0/0 in the temporary security group...
==> amazon-ebs: Launching a source AWS instance...
==> amazon-ebs: Adding tags to source instance
    amazon-ebs: Adding tag: "Builder": "Packer"
    amazon-ebs: Adding tag: "Name": "packer-builder-docker"
    amazon-ebs: Adding tag: "Author": "zurkz"
    amazon-ebs: Instance ID: i-0da1c29eeb42224da
==> amazon-ebs: Waiting for instance (i-0da1c29eeb42224da) to become ready...
==> amazon-ebs: Using ssh communicator to connect: 3.86.199.22
==> amazon-ebs: Waiting for SSH to become available...
==> amazon-ebs: Connected to SSH!
==> amazon-ebs: Provisioning with shell script: ./config.sh
    amazon-ebs: Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
    amazon-ebs: Existing lock /var/run/yum.pid: another copy is running as pid 3278.
    amazon-ebs: Another app is currently holding the yum lock; waiting for it to exit...
    amazon-ebs:   The other application is: yum
    amazon-ebs:     Memory : 102 M RSS (393 MB VSZ)
    amazon-ebs:     Started: Fri Jan  4 19:56:44 2019 - 00:05 ago
    amazon-ebs:     State  : Running, pid: 3278
    amazon-ebs: Resolving Dependencies
    amazon-ebs: --> Running transaction check
        .......
    amazon-ebs: --> Finished Dependency Resolution
    amazon-ebs:
    amazon-ebs: Dependencies Resolved
    amazon-ebs:
    amazon-ebs: ================================================================================
    amazon-ebs:  Package                   Arch      Version                Repository     Size
    amazon-ebs: ================================================================================
    amazon-ebs: Installing:
    amazon-ebs:  kernel                    x86_64    4.14.88-88.73.amzn2    amzn2-core     19 M
    amazon-ebs: Updating:
    amazon-ebs:  amazon-ssm-agent          x86_64    2.3.274.0-1.amzn2      amzn2-core     15 M
        .......
    amazon-ebs:  wget                      x86_64    1.14-18.amzn2          amzn2-core    547 k
    amazon-ebs:
    amazon-ebs: Transaction Summary
    amazon-ebs: ================================================================================
    amazon-ebs: Install   1 Package
    amazon-ebs: Upgrade  15 Packages
    amazon-ebs:
    amazon-ebs: Total download size: 51 M
    amazon-ebs: Downloading packages:
    amazon-ebs: Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
    amazon-ebs: --------------------------------------------------------------------------------
    amazon-ebs: Total                                               31 MB/s |  51 MB  00:01
    amazon-ebs: Running transaction check
    amazon-ebs: Running transaction test
    amazon-ebs: Transaction test succeeded
    amazon-ebs: Running transaction
    amazon-ebs:   Updating   : glibc-common-2.26-30.amzn2.0.1.x86_64                       1/31
        .......
    amazon-ebs:   Verifying  : libcrypt-2.26-28.amzn2.0.1.x86_64                          31/31
    amazon-ebs:
    amazon-ebs: Installed:
    amazon-ebs:   kernel.x86_64 0:4.14.88-88.73.amzn2
    amazon-ebs:
    amazon-ebs: Updated:
        .......
    amazon-ebs: Complete!
    amazon-ebs: Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
    amazon-ebs: Cleaning repos: amzn2-core amzn2extra-docker
    amazon-ebs: 10 metadata files removed
    amazon-ebs: 4 sqlite files removed
    amazon-ebs: 0 metadata files removed
    amazon-ebs: Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
    amazon-ebs: Resolving Dependencies
    amazon-ebs: --> Running transaction check
    amazon-ebs: ---> Package docker.x86_64 0:18.06.1ce-5.amzn2 will be installed
    amazon-ebs: --> Processing Dependency: pigz for package: docker-18.06.1ce-5.amzn2.x86_64
    amazon-ebs: --> Processing Dependency: libcgroup for package: docker-18.06.1ce-5.amzn2.x86_64
    amazon-ebs: --> Processing Dependency: libltdl.so.7()(64bit) for package: docker-18.06.1ce-5.amzn2.x86_64
    amazon-ebs: --> Running transaction check
    amazon-ebs: ---> Package libcgroup.x86_64 0:0.41-15.amzn2 will be installed
    amazon-ebs: ---> Package libtool-ltdl.x86_64 0:2.4.2-22.2.amzn2.0.2 will be installed
    amazon-ebs: ---> Package pigz.x86_64 0:2.3.4-1.amzn2.0.1 will be installed
    amazon-ebs: --> Finished Dependency Resolution
    amazon-ebs:
    amazon-ebs: Dependencies Resolved
    amazon-ebs:
    amazon-ebs: ================================================================================
    amazon-ebs:  Package         Arch      Version                   Repository            Size
    amazon-ebs: ================================================================================
    amazon-ebs: Installing:
    amazon-ebs:  docker          x86_64    18.06.1ce-5.amzn2         amzn2extra-docker     37 M
    amazon-ebs: Installing for dependencies:
    amazon-ebs:  libcgroup       x86_64    0.41-15.amzn2             amzn2-core            65 k
    amazon-ebs:  libtool-ltdl    x86_64    2.4.2-22.2.amzn2.0.2      amzn2-core            49 k
    amazon-ebs:  pigz            x86_64    2.3.4-1.amzn2.0.1         amzn2-core            81 k
    amazon-ebs:
    amazon-ebs: Transaction Summary
    amazon-ebs: ================================================================================
    amazon-ebs: Install  1 Package (+3 Dependent packages)
    amazon-ebs:
    amazon-ebs: Total download size: 37 M
    amazon-ebs: Installed size: 151 M
    amazon-ebs: Downloading packages:
    amazon-ebs: --------------------------------------------------------------------------------
    amazon-ebs: Total                                               40 MB/s |  37 MB  00:00
    amazon-ebs: Running transaction check
    amazon-ebs: Running transaction test
    amazon-ebs: Transaction test succeeded
    amazon-ebs: Running transaction
        .......
    amazon-ebs: Installed:
    amazon-ebs:   docker.x86_64 0:18.06.1ce-5.amzn2
    amazon-ebs:
    amazon-ebs: Dependency Installed:
    amazon-ebs:   libcgroup.x86_64 0:0.41-15.amzn2  libtool-ltdl.x86_64 0:2.4.2-22.2.amzn2.0.2
    amazon-ebs:   pigz.x86_64 0:2.3.4-1.amzn2.0.1
    amazon-ebs:
    amazon-ebs: Complete!
    amazon-ebs: Installing docker
    amazon-ebs: Created symlink from /etc/systemd/system/multi-user.target.wants/docker.service to /usr/lib/systemd/system/docker.service.
==> amazon-ebs: Stopping the source instance...
    amazon-ebs: Stopping instance, attempt 1
==> amazon-ebs: Waiting for the instance to stop...
==> amazon-ebs: Creating unencrypted AMI packer-build01-docker from instance i-0da1c29eeb42224da
    amazon-ebs: AMI: ami-01a14a024cb55a23e
==> amazon-ebs: Waiting for AMI to become ready...
==> amazon-ebs: Modifying attributes on AMI (ami-01a14a024cb55a23e)...
    amazon-ebs: Modifying: description
==> amazon-ebs: Modifying attributes on snapshot (snap-0d3df24a04500daa5)...
==> amazon-ebs: Terminating the source AWS instance...
==> amazon-ebs: Cleaning up any extra volumes...
==> amazon-ebs: No volumes to clean up, skipping
==> amazon-ebs: Deleting temporary security group...
==> amazon-ebs: Deleting temporary keypair...
Build 'amazon-ebs' finished.

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:
us-east-1: ami-01a14a024cb55a23e
```
---

#### Create an instance based on the AMI

```
aws ec2 run-instances --image-id ami-01a14a024cb55a23e --count 1 --instance-type t2.micro --key-name KEY --security-group-ids SG_ID --region us-east-1 --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=packer-builder-docker}]'
```

#### Use the AMI 