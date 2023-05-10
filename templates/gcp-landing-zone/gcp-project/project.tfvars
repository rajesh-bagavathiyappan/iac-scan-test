org_id = ""
billing_account = ""
project_prefix = "cloudmatos"
//
//org_bucket = "cloudmatos-sys-int-eu-tfstates-1d37"
//org_prefix = "terraform/cloudmatos-gcp-org"

env_name = "stage"

project_iam_binding = {
       "roles/compute.networkAdmin" = [ "user:valentynk@cloudmatos.io"],
       "roles/appengine.appAdmin" = ["user:valentynk@cloudmatos.io"]
}

//project_quota = [
//    {
//        service        = "compute.googleapis.com"
//        metric         = "SimulateMaintenanceEventGroup"
//        limit          = "%2F100s%2Fproject"
//        value = "19"
//    },
//    {
//        service        = "servicemanagement.googleapis.com"
//        metric         = "servicemanagement.googleapis.com%2Fdefault_requests"
//        limit          = "%2Fmin%2Fproject"
//        value = "95"
//    }
//]

shared_vpc = false

cloud_nat = {
  "us-west1" = {
    region                   = "us-west1"
    router_name              = "my-router"
    ip_count                 = ["first", "second", "third"]
    },
  "us-west2" = {
    region                   = "us-west2"
    router_name              = "my-router2"
    ip_count                 = ["five", "six"]
    }
}

gke = {
  "us-west1" = {
    region                   = "us-west1"
    name                     = "gke-us-west1"
    subnetwork               = "us-west1"
    ip_range_pods            = "us-west1-secondary-pods"
    ip_range_services        = "us-west1-secondary-services"
    master_ipv4_cidr_block   = "10.100.0.0/28"
    enable_private_nodes     = true
    node_pools = [
    {
      name            = "main"
      machine_type    = "n1-standard-1"
      min_count       = 0
      max_count       = 5
      local_ssd_count = 0
      disk_size_gb    = 100
      disk_type       = "pd-standard"
      image_type      = "COS_CONTAINERD"
      auto_repair     = true
      auto_upgrade    = true
      preemptible        = false
      initial_node_count = 0
    },
    {
      name            = "secondary"
      machine_type    = "n1-standard-1"
      min_count       = 0
      max_count       = 5
      local_ssd_count = 0
      disk_size_gb    = 100
      disk_type       = "pd-standard"
      image_type      = "COS_CONTAINERD"
      auto_repair     = true
      auto_upgrade    = true
      preemptible        = true
      initial_node_count = 0
    },]}
  "us-west4" = {
    region                   = "us-west4"
    name                     = "gke-us-west4"
    subnetwork               = "us-west4"
    ip_range_pods            = "us-west4-secondary-pods"
    ip_range_services        = "us-west4-secondary-services"
    master_ipv4_cidr_block   = "10.100.1.0/28"
    enable_private_nodes     = false
    node_pools = [
    {
      name            = "third"
      machine_type    = "n1-standard-1"
      min_count       = 0
      max_count       = 5
      local_ssd_count = 0
      disk_size_gb    = 100
      disk_type       = "pd-standard"
      image_type      = "COS_CONTAINERD"
      auto_repair     = true
      auto_upgrade    = true
      preemptible        = false
      initial_node_count = 0
    },
    {
      name            = "forth"
      machine_type    = "n1-standard-1"
      min_count       = 0
      max_count       = 5
      local_ssd_count = 0
      disk_size_gb    = 100
      disk_type       = "pd-standard"
      image_type      = "COS_CONTAINERD"
      auto_repair     = true
      auto_upgrade    = true
      preemptible        = true
      initial_node_count = 0
    },]}
}

pgsql = {
  "us-west1" = {
    name                            = "test-pg-db-2-5"
    region                          = "us-west1"
    zone                            = "us-west1-c"
    database_version                = "POSTGRES_9_6"
    tier                            = "db-f1-micro"
    ip_configuration = {}
    backup_configuration = {}
  }
  "secondary" = {
    name                            = "test-pg-db-2-10"
    region                          = "us-west1"
    zone                            = "us-west1-c"
    database_version                = "POSTGRES_9_6"
    tier                            = "db-f1-micro"
    ip_configuration = {}
    backup_configuration = {}
  }
}

mysql = {
  "standalone" = {
    name                            = "mysqdb-1"
    region                          = "us-west1"
    zone                            = "us-west1-c"
    database_version                = "MYSQL_5_7"
    tier                            = "db-f1-micro"
    ip_configuration = {}
    backup_configuration = {}
  }
  "high-avalibility" = {
    name                            = "mysqldb-ha-1"
    region                          = "us-west1"
    zone                            = "us-west1-c"
    database_version                = "MYSQL_5_7"
    tier                            = "db-f1-micro"
    deletion_protection             = false
    ip_configuration = {
      ipv4_enabled       = true
      require_ssl        = true
      private_network    = null
      allocated_ip_range = null
      authorized_networks = [
        {
          name  = "sample-gcp-health-checkers-range"
          value = "130.211.0.0/28"
        },
      ]
    }

    backup_configuration = {
      enabled                        = true
      binary_log_enabled             = true
    }

    read_replica_name_suffix = "-test"
    read_replicas = [
      {
        name                = "0"
        zone                = "us-west1-a"
        tier                = "db-f1-micro"
        ip_configuration = {
          ipv4_enabled       = true
          require_ssl        = true
          private_network    = null
          allocated_ip_range = null
          authorized_networks = [
            {
              name  = "sample-gcp-health-checkers-range"
              value = "130.211.0.0/28"
            },
          ]
        }
        database_flags      = [{ name = "long_query_time", value = 1 }]
        disk_autoresize     = null
        disk_size           = 10
        disk_type           = "PD_HDD"
        user_labels         = { bar = "baz" }
        encryption_key_name = null
      },
      {
        name                = "1"
        zone                = "us-west1-b"
        tier                = "db-f1-micro"
        ip_configuration = {
          ipv4_enabled       = true
          require_ssl        = true
          private_network    = null
          allocated_ip_range = null
          authorized_networks = [
            {
              name  = "sample-gcp-health-checkers-range"
              value = "130.211.0.0/28"
            },
          ]
        }
        database_flags      = [{ name = "long_query_time", value = 1 }]
        disk_autoresize     = null
        disk_size           = 10
        disk_type           = "PD_HDD"
        user_labels         = { bar = "baz" }
        encryption_key_name = null
      },
      {
        name                = "2"
        zone                = "us-west1-c"
        tier                = "db-f1-micro"
        ip_configuration = {
          ipv4_enabled       = true
          require_ssl        = true
          private_network    = null
          allocated_ip_range = null
          authorized_networks = [
            {
              name  = "sample-gcp-health-checkers-range"
              value = "130.211.0.0/28"
            },
          ]
        }
        database_flags      = [{ name = "long_query_time", value = 1 }]
        disk_autoresize     = null
        disk_size           = 10
        disk_type           = "PD_HDD"
        user_labels         = { bar = "baz" }
        encryption_key_name = null
      }
    ],
  }
}

