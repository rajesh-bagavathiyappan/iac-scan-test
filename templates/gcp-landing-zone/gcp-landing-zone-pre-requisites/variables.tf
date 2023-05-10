variable "project_prefix" {
  description = "Name prefix to use for projects created."
  type    = string
  default = ""
}

variable "org_id" {
  description = "GCP Organization ID"
  type        = string
  default     = ""
}

variable "billing_account" {
  description = "The ID of the billing account to associate projects with."
  type        = string
  default     = ""
}

variable "region" {
  description = "Name of GCP region to bootstrap resources"
  type        = string
  default     = "us-west1"
}

variable "project_id" {
  description = "Custom project ID to use for project created. If not supplied, the default id is {project_prefix}-seed-{random suffix}."
  default     = ""
  type        = string
}

variable "org_iam_binding" {
  description = "IAM users permissions handler on Org level"
  type        = map(list(string))
  default     = {}
}

variable "activate_apis" {
  description = "List of APIs to enable in the new projects."
  type        = list(string)
  default = [
    "cloudkms.googleapis.com",
    "serviceusage.googleapis.com",
    "servicenetworking.googleapis.com",
    "compute.googleapis.com",
    "sqladmin.googleapis.com",
    "logging.googleapis.com",
    "bigquery.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "iam.googleapis.com",
    "admin.googleapis.com",
    "appengine.googleapis.com",
    "storage-api.googleapis.com",
    "monitoring.googleapis.com",
    "container.googleapis.com"
  ]
}

variable "svc-permissions" {
    type        = list(string)
    default = [
      "roles/billing.admin",
      "roles/assuredworkloads.admin",
      "roles/compute.xpnAdmin",
      "roles/resourcemanager.folderAdmin",
      "roles/resourcemanager.organizationAdmin",
      "roles/container.hostServiceAgentUser",
      "roles/orgpolicy.policyAdmin",
      "roles/iam.organizationRoleAdmin",
      "roles/resourcemanager.projectCreator",
      "roles/securitycenter.admin",
      "roles/billing.projectManager",
      "roles/storage.admin",
      "roles/storage.objectAdmin",
      "roles/compute.networkAdmin",
      "roles/iam.serviceAccountAdmin",
      "roles/resourcemanager.projectIamAdmin",
      "roles/iam.serviceAccountUser",
      "roles/container.clusterAdmin",
      "roles/compute.securityAdmin",
      "roles/compute.admin"
    ]
}

variable "domains_to_allow" {
  description = "The list of domains to allow users from"
  type        = list(string)
}

variable "subnets" {
  type        = list(map(string))
  description = "The list of subnets being created: US regions 10.0.0.0/14, EU regions 10.4.0.0/14, Asia regions 10.8.0.0/14, Australia regions 10.12.0.0/16, Southamerica regions 10.13.0.0/16, Northamerica regions 10.14.0.0/16"
  default     = [
      {
        subnet_name   = "us-central1"
        subnet_ip     = "10.0.0.0/20"
        subnet_region = "us-central1"
      },
      {
        subnet_name   = "us-west1"
        subnet_ip     = "10.0.16.0/20"
        subnet_region = "us-west1"
      },
      {
        subnet_name   = "us-west2"
        subnet_ip     = "10.0.32.0/20"
        subnet_region = "us-west2"
      },
      {
        subnet_name   = "us-west3"
        subnet_ip     = "10.0.48.0/20"
        subnet_region = "us-west3"
      },
      {
        subnet_name   = "us-west4"
        subnet_ip     = "10.0.64.0/20"
        subnet_region = "us-west4"
      },
      {
        subnet_name   = "us-east1"
        subnet_ip     = "10.0.80.0/20"
        subnet_region = "us-east1"
      },
      {
        subnet_name   = "us-east4"
        subnet_ip     = "10.0.96.0/20"
        subnet_region = "us-east4"
      },
      {
        subnet_name   = "europe-west1"
        subnet_ip     = "10.4.0.0/20"
        subnet_region = "europe-west1"
      },
      {
        subnet_name   = "europe-west2"
        subnet_ip     = "10.4.16.0/20"
        subnet_region = "europe-west2"
      },
      {
        subnet_name   = "europe-west3"
        subnet_ip     = "10.4.32.0/20"
        subnet_region = "europe-west3"
      },
      {
        subnet_name   = "europe-west4"
        subnet_ip     = "10.4.48.0/20"
        subnet_region = "europe-west4"
      },
      {
        subnet_name   = "europe-west6"
        subnet_ip     = "10.4.64.0/20"
        subnet_region = "europe-west6"
      },
      {
        subnet_name   = "europe-north1"
        subnet_ip     = "10.4.80.0/20"
        subnet_region = "europe-north1"
      },
      {
        subnet_name   = "europe-central2"
        subnet_ip     = "10.4.96.0/20"
        subnet_region = "europe-central2"
      },
      {
        subnet_name   = "asia-east1"
        subnet_ip     = "10.8.0.0/20"
        subnet_region = "asia-east1"
      },
      {
        subnet_name   = "asia-east2"
        subnet_ip     = "10.8.16.0/20"
        subnet_region = "asia-east2"
      },
      {
        subnet_name   = "asia-south1"
        subnet_ip     = "10.8.32.0/20"
        subnet_region = "asia-south1"
      },
      {
        subnet_name   = "asia-south2"
        subnet_ip     = "10.8.48.0/20"
        subnet_region = "asia-south2"
      },
      {
        subnet_name   = "asia-northeast1"
        subnet_ip     = "10.8.64.0/20"
        subnet_region = "asia-northeast1"
      },
      {
        subnet_name   = "asia-northeast2"
        subnet_ip     = "10.8.80.0/20"
        subnet_region = "asia-northeast2"
      },
      {
        subnet_name   = "asia-northeast3"
        subnet_ip     = "10.8.96.0/20"
        subnet_region = "asia-northeast3"
      },
      {
        subnet_name   = "asia-southeast1"
        subnet_ip     = "10.8.112.0/20"
        subnet_region = "asia-southeast1"
      },
      {
        subnet_name   = "asia-southeast2"
        subnet_ip     = "10.8.128.0/20"
        subnet_region = "asia-southeast2"
      },
      {
        subnet_name   = "australia-southeast1"
        subnet_ip     = "10.12.0.0/20"
        subnet_region = "australia-southeast1"
      },
      {
        subnet_name   = "australia-southeast2"
        subnet_ip     = "10.12.16.0/20"
        subnet_region = "australia-southeast2"
      },
      {
        subnet_name   = "southamerica-east1"
        subnet_ip     = "10.13.0.0/20"
        subnet_region = "southamerica-east1"
      },
      {
        subnet_name   = "southamerica-west1"
        subnet_ip     = "10.13.16.0/20"
        subnet_region = "southamerica-west1"
      },
      {
        subnet_name   = "northamerica-northeast1"
        subnet_ip     = "10.14.0.0/20"
        subnet_region = "northamerica-northeast1"
      },
      {
        subnet_name   = "northamerica-northeast2"
        subnet_ip     = "10.14.16.0/20"
        subnet_region = "northamerica-northeast2"
      }
  ]
}

variable "secondary_ranges" {
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  description = "Secondary ranges that will be used in some of the subnets. NOTE `172.17.0.0/16` can't used due GKE limmitation. Used by docker"
  default     = {
        us-central1 = [
            {
                range_name    = "us-central1-secondary-pods"
                ip_cidr_range = "172.16.0.0/18"
            },
            {
                range_name    = "us-central1-secondary-services"
                ip_cidr_range = "172.16.64.0/18"
            }
        ]
        us-west1 = [
            {
                range_name    = "us-west1-secondary-pods"
                ip_cidr_range = "172.16.128.0/18"
            },
            {
                range_name    = "us-west1-secondary-services"
                ip_cidr_range = "172.16.192.0/18"
            }
        ]
        us-west2 = [
            {
                range_name    = "us-west2-secondary-pods"
                ip_cidr_range = "172.30.128.0/18"
            },
            {
                range_name    = "us-west2-secondary-services"
                ip_cidr_range = "172.30.192.0/18"
            }
        ]
        us-west3 = [
            {
                range_name    = "us-west3-secondary-pods"
                ip_cidr_range = "172.31.0.0/18"
            },
            {
                range_name    = "us-west3-secondary-services"
                ip_cidr_range = "172.31.64.0/18"
            }
        ]
        us-west4 = [
            {
                range_name    = "us-west4-secondary-pods"
                ip_cidr_range = "172.18.0.0/18"
            },
            {
                range_name    = "us-west4-secondary-services"
                ip_cidr_range = "172.18.64.0/18"
            }
        ]
        us-east1 = [
            {
                range_name    = "us-east1-secondary-pods"
                ip_cidr_range = "172.18.128.0/18"
            },
            {
                range_name    = "us-east1-secondary-services"
                ip_cidr_range = "172.18.192.0/18"
            }
        ]
        us-east4 = [
            {
                range_name    = "us-east4-secondary-pods"
                ip_cidr_range = "172.19.0.0/18"
            },
            {
                range_name    = "us-east4-secondary-services"
                ip_cidr_range = "172.19.64.0/18"
            }
        ]
        europe-west1 = [
            {
                range_name    = "us-east1-secondary-pods"
                ip_cidr_range = "172.19.128.0/18"
            },
            {
                range_name    = "us-east1-secondary-services"
                ip_cidr_range = "172.19.192.0/18"
            }
        ]
        europe-west2 = [
            {
                range_name    = "europe-west2-secondary-pods"
                ip_cidr_range = "172.20.0.0/18"
            },
            {
                range_name    = "europe-west2-secondary-services"
                ip_cidr_range = "172.20.64.0/18"
            }
        ]
        europe-west3 = [
            {
                range_name    = "europe-west3-secondary-pods"
                ip_cidr_range = "172.20.128.0/18"
            },
            {
                range_name    = "europe-west3-secondary-services"
                ip_cidr_range = "172.20.192.0/18"
            }
        ]
        europe-west4 = [
            {
                range_name    = "europe-west4-secondary-pods"
                ip_cidr_range = "172.21.0.0/18"
            },
            {
                range_name    = "europe-west4-secondary-services"
                ip_cidr_range = "172.21.64.0/18"
            }
        ]
        europe-west6 = [
            {
                range_name    = "europe-west6-secondary-pods"
                ip_cidr_range = "172.21.128.0/18"
            },
            {
                range_name    = "europe-west6-secondary-services"
                ip_cidr_range = "172.21.192.0/18"
            }
        ]
        europe-north1 = [
            {
                range_name    = "europe-north1-secondary-pods"
                ip_cidr_range = "172.22.0.0/18"
            },
            {
                range_name    = "europe-north1-secondary-services"
                ip_cidr_range = "172.22.64.0/18"
            }
        ]
        europe-central2 = [
            {
                range_name    = "europe-central2-secondary-pods"
                ip_cidr_range = "172.22.128.0/18"
            },
            {
                range_name    = "europe-central2-secondary-services"
                ip_cidr_range = "172.22.192.0/18"
            }
        ]
        asia-east1 = [
            {
                range_name    = "asia-east1-secondary-pods"
                ip_cidr_range = "172.23.0.0/18"
            },
            {
                range_name    = "asia-east1-secondary-services"
                ip_cidr_range = "172.23.64.0/18"
            }
        ]
        asia-east2 = [
            {
                range_name    = "asia-east2-secondary-pods"
                ip_cidr_range = "172.23.128.0/18"
            },
            {
                range_name    = "asia-east2-secondary-services"
                ip_cidr_range = "172.23.192.0/18"
            }
        ]
        asia-south1 = [
            {
                range_name    = "asia-south1-secondary-pods"
                ip_cidr_range = "172.24.0.0/18"
            },
            {
                range_name    = "asia-south1-secondary-services"
                ip_cidr_range = "172.24.64.0/18"
            }
        ]
        asia-south2 = [
            {
                range_name    = "asia-south2-secondary-pods"
                ip_cidr_range = "172.24.128.0/18"
            },
            {
                range_name    = "asia-south2-secondary-services"
                ip_cidr_range = "172.24.192.0/18"
            }
        ]
        asia-northeast1 = [
            {
                range_name    = "asia-northeast1-secondary-pods"
                ip_cidr_range = "172.25.0.0/18"
            },
            {
                range_name    = "asia-northeast1-secondary-services"
                ip_cidr_range = "172.25.64.0/18"
            }
        ]
        asia-northeast2 = [
            {
                range_name    = "asia-northeast2-secondary-pods"
                ip_cidr_range = "172.25.128.0/18"
            },
            {
                range_name    = "asia-northeast2-secondary-services"
                ip_cidr_range = "172.25.192.0/18"
            }
        ]
        asia-northeast3 = [
            {
                range_name    = "asia-northeast3-secondary-pods"
                ip_cidr_range = "172.26.0.0/18"
            },
            {
                range_name    = "asia-northeast3-secondary-services"
                ip_cidr_range = "172.26.64.0/18"
            }
        ]
        asia-southeast1 = [
            {
                range_name    = "asia-southeast1-secondary-pods"
                ip_cidr_range = "172.26.128.0/18"
            },
            {
                range_name    = "asia-southeast1-secondary-services"
                ip_cidr_range = "172.26.192.0/18"
            }
        ]
        asia-southeast2 = [
            {
                range_name    = "asia-southeast2-secondary-pods"
                ip_cidr_range = "172.27.0.0/18"
            },
            {
                range_name    = "asia-southeast2-secondary-services"
                ip_cidr_range = "172.27.64.0/18"
            }
        ]
        australia-southeast1 = [
            {
                range_name    =  "australia-southeast1-secondary-pods"
                ip_cidr_range = "172.27.128.0/18"
            },
            {
                range_name    =  "australia-southeast1-secondary-services"
                ip_cidr_range = "172.27.192.0/18"
            }
        ]
        australia-southeast2 = [
            {
                range_name    = "australia-southeast2-secondary-pods"
                ip_cidr_range = "172.28.0.0/18"
            },
            {
                range_name    = "australia-southeast2-secondary-services"
                ip_cidr_range = "172.28.64.0/18"
            }
        ]
        southamerica-east1 = [
            {
                range_name    =  "southamerica-east1-secondary-pods"
                ip_cidr_range = "172.28.128.0/18"
            },
            {
                range_name    =  "southamerica-east1-secondary-services"
                ip_cidr_range = "172.28.192.0/18"
            }
        ]
        southamerica-west1 = [
            {
                range_name    = "southamerica-west1-secondary-pods"
                ip_cidr_range = "172.29.0.0/18"
            },
            {
                range_name    = "southamerica-west1-secondary-services"
                ip_cidr_range = "172.29.64.0/18"
            }
        ]
        northamerica-northeast1 = [
            {
                range_name    =  "northamerica-northeast1-secondary-pods"
                ip_cidr_range = "172.29.128.0/18"
            },
            {
                range_name    =  "northamerica-northeast1-secondary-services"
                ip_cidr_range = "172.29.192.0/18"
            }
        ]
        northamerica-northeast2 = [
            {
                range_name    = "northamerica-northeast2-secondary-pods"
                ip_cidr_range = "172.30.0.0/18"
            },
            {
                range_name    = "northamerica-northeast2-secondary-services"
                ip_cidr_range = "172.30.64.0/18"
            }
        ]
  }
}

variable "routes" {
  type        = list(map(string))
  description = "List of routes being created in this VPC"
  default     = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')"
}
