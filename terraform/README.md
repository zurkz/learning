# terraform

#### create terraform IAM user and give it programmatic access and proper roles


#### install terraform, create directory for terraform and create 


main.tf
```
provider "aws" {
  region                  = "us-west-1"
  shared_credentials_file = "/path/to/.aws/credentials"
  profile                 = "terraform-user"
