
#################### organization variables #################
# Directory service can only be enabled from portal as of now - https://docs.aws.amazon.com/organizations/latest/userguide/services-that-can-integrate-directory-service.html

backend_bucket = "lbdroplab"

region = "us-east-1"


management_email = ""


create_environment_ous = false
create_accounts        = false

aws_service_access_principals = [
  "account.amazonaws.com",
  "cloudtrail.amazonaws.com",
  "config.amazonaws.com",
  "guardduty.amazonaws.com",
  "macie.amazonaws.com",
  "backup.amazonaws.com",
  "member.org.stacksets.cloudformation.amazonaws.com",
  "sso.amazonaws.com",
  "ssm.amazonaws.com", # Systems Manager
  "securityhub.amazonaws.com",
  "servicecatalog.amazonaws.com",
  "tagpolicies.tag.amazonaws.com",
  "fms.amazonaws.com", # Firewall Manager
  "reporting.trustedadvisor.amazonaws.com",
  "ram.amazonaws.com", # Resource Access Manager
  "license-manager.amazonaws.com"
]

enabled_policy_types = [
  "TAG_POLICY",
  "SERVICE_CONTROL_POLICY"
]

#💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥#
#                   CORE OUS                                    #
#💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥#

core_ous = [
  {
    create = true
    name   = "Security"
    accounts = [
      {
        create = false
        name   = "SecurityTooling"
      },
      {
        create = false
        name   = "Breakglass"
    }]
  },
  {
    create = true
    name   = "Infrastructure"
    accounts = [{
      create = false
      name   = "Networking"
    }]
}]

#💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥#
#                   ENVIRONMENT OUS                             #
#💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥#

# environment_ous = ["Prod", "Dev", "UAT"]
environment_ous = [{
  create = false
  name   = "Prod"
  accounts = [{
    create = false
    name   = "PROD1"
    }, {
    create = false
    name   = "PROD2"
  }]
  },
  {
    create = false
    name   = "Dev"
    accounts = [{
      create = false
      name   = "Dev1"
    }]
  },
  {
    create = false
    name   = "UAT"
    accounts = [{
      create = false
      name   = "UAT1"
    }]
}]

#💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥#
#                   NON CORE OUS                                #
#💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥#

custom_ous = [{
  create = true
  name   = "Workloads"
  accounts = [
    {
      create = false
      name   = "DEV"
    },
    {
      create = false
      name   = "PROD"
    },
    {
      create = false
      name   = "UAT"
    }
  ]
  },
  {
    create = true
    name   = "Sandbox"
    accounts = [{
      create = false
      name   = "Sandbox1"
    }]
  },
  {
    create = true
    name   = "Deployments"
    accounts = [{
      create = false
      name   = "Deployment"
    }]
  }
]

#################### organization variables #################
