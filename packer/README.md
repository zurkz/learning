# Things to do with Packer


#### Create the AMI

define a builder template to create the AMI

example builder template for AWS:

```
{
  "variables": {
    "aws_access_key": "LKAHJDG734AGE31G1337",
    "aws_secret_key": "asvdae3a3r3qka3329sd1337fa9q3df32gagoh"
  },
  "builders": [{
    "type": "amazon-ebs",
    "access_key": "{{user `aws_access_key`}}",
    "secret_key": "{{user `aws_secret_key`}}",
    "region": "us-east-1",
    "source_ami_filter": {
      "filters": {
        "virtualization-type": "hvm",
        "name": "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*",
        "root-device-type": "ebs"
      },
      "owners": ["099720109477"],
      "most_recent": true
    },
    "instance_type": "t2.micro",
    "ssh_username": "ubuntu",
    "ami_name": "packer-ubuntu-(ruby-builder-mongodb)"
  }]
}
```

validate the template

```
packer validate /path/to/buildertemplate.json
```
---

#### Define the provisioner 

this provisions a machine using shell scripts

example provisioner section:

```
"provisioners": [
      {
          "type": "shell",
          "script": "./scripts/configuration.sh",
          "execute_command": "sudo {{.Path}}"
      }
  ]
```

this assumes you have a bash script that installs and configures your packages located in ```./scripts/configuration.sh```

validate the template

```packer validate /path/to/buildertemplate.json```

---

#### Build the AMI

```packer build /path/to/buildertemplate.json```

output:

```





