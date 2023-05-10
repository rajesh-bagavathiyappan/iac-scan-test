# AWS Auto Scaling Group

# How to use:

#####1. create a backend.tf file with following code and correct values in place:

```
terraform {
  backend "s3" {
    bucket  = "#BACKEND-BUCKET-NAME#"
    key     = "matos-awsasg-terraform.tfstate"
    region  = "#BAKCEND-REGION#"
    access_key = "#AWS-BACKEND-ACCESS-KEY#"
    secret_key = "#AWS-BACKEND-SECRET-KEY#"
  }
}
```

#####2. create a provider.tf file with following code and correct values in place:

```
provider "aws" {
  region     = "#PROVIDER-REGION#"
  access_key = "#AWS-PROVIDER-ACCESS-KEY#"
  secret_key = "#AWS-PROVIDER-SECRET-KEY#"
}
```

Note: we can not use "shared_credentials_file" argument in step 1 and 2 as there is an open bug in terrafrom for this.
Bug Link - https://github.com/hashicorp/terraform/issues/25758

#####3. If you already have an AMI, enter the AMI ID in main.tf of respective environment. If there is a need to create a new AMI ID from an instance, you would need to give the instance ID. while giving the instance_id, make sure "enable_new_ami_creation" is set to "true".

```
 module "webservers" {
  source = "./modules/webservers"
  cluster_name = "webservers-dev"
  image_id = "ami-xxxx"
  instance_type = "t2.nano"
  min_size      = 2
  max_size      = 5
  desired_capacity  = 2
  enable_new_ami_creation = false
  instance_id = "NA"
  availability_zone = ["us-east-2a","us-east-2b","us-east-2c"]
}    
```
Note: Make sure instance exists in the region which is provided in the provider.tf

#####4. Make sure availability_zone is updated properly in tfvars file as per the region mentioned in provider config.

