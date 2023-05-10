# How to use:

#####1. create a backend.tf file with following code and correct values in place:

```
terraform {
  backend "s3" {
    bucket  = "#BAKCNED-BUCKET-NAME#"
    key     = "matos-terraform.tfstate"
    region  = "#BACKEND-REGION#"
    access_key = "#AWS-BACKEND-ACCESS-KEY#"
    secret_key = "#AWS-BACKEND-SECRET-KEY#"
  }
}
```

#####2. create a provider.tf file with following code and correct values in place:

```
provider "aws" {
  region     = "#PROVIDER-REGION#"
  access_key = #AWS-PROVIDER-ACCESS-KEY#
  secret_key = #AWS-PROVIDER-SECRET-KEY#
}
```

Note: we can not use "shared_credentials_file" argument in step 1 and 2 as there is an open bug in terrafrom for this. 
Bug Link - https://github.com/hashicorp/terraform/issues/25758

#####3. Add users config in users_groups.auto.tfvars.json by adding following block in "users" varable definition:

```
    <userName> = {
      create_iam_user_login_profile = bool(true or false)
      create_iam_access_key         = false(true or false)
    }
```

Do this for each user you want to add

#####4. Add user_group and corresponding users in users_groups.auto.tfvars.json file under "user_groups" variable definition:

```
        "<group_name>": {
          "policy_name": "<policy_name>",
          "user_list": ["<user 1>", "<user 2>", ...],
          "policy_ref": "<policy_reference>"
        },
```

#####5. Define any new policies(name should be same as given in "policy_ref" field above) with actions, effect and resource in "policy_permissions.auto.tfvars.json"

```
        "s3_viewer":{
            "Version" : "2012-10-17",
            "Statement" : [{
                "Action" : [
                    "s3:ListAllMyBuckets"
                             ],
                "Effect" : "Allow",
                "Resource" : "*"
                        }]
                    },
```
this is a simple example specified above for an object in variable actions in "policy_permissions.auto.tfvars.json".

#####6. run following commands to apply:

    1. terrafrom init
    2. terraform plan
    3. terraform apply --auto-approve



# TO DO:

## Essential Tasks:
1. use loops(count, for_each) to add users                   - DONE
2. Remote state [s3 or gcp bucket]                           - DONE
3. Multiple environment support                              - DONE
4. secure creds                                              - DONE
5. use loops on data block                                   - DONE
6. use json as input vars                                    - DONE
7. Import current users and current custom policies          - NOT STARTED

## Value adds:
1. Secure keys using vault
2. Remote modules
3. Pipeline config


