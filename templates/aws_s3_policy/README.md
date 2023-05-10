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

#####3. If you already have an bucket on AWS S3, enter the bucket name to apply policy as a variable.

```
bucket_name = "xxx-bucket"
```
Note: Make sure AWS S3 bucket exists in the region which is provided in the provider.tf

