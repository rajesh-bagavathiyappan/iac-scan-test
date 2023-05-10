# GCP landing zone bootstrap script.

This terraform code bootstrap minimal needed environment to allow cloudmatos work futher. List created resources:
 - system project
 - GCS buckets for states in system project
 - IAM SVC account which will be used for cloudmatos landing zone code.

## Permissions

In order to run this script, user or svc account should have next permissions on **ORG level:**
 - `roles/billing.admin`
 - `roles/resourcemanager.organizationAdmin`
 - `roles/resourcemanager.projectCreator`
 - `roles/storage.objectAdmin`

## Usage

**NOTE:** this code works with GCP organisations only.
Before start make sure that you have GCP org account with payment account. Fullfill variable with values in [variables file](variables.tf):
- `project_prefix`
- `org_id`
- `billing_account`


```sh
### Boostrap
terraform init && terraform apply

### Destroy
terraform init && terraform destroy
```

## SVC account permissions

**NOTE:** During org initialisations, it will create terraform svc account in system project. Make sure that your account have enough permissions on org level to grant them.

Permissions:

```
    "roles/billing.admin"
    "roles/assuredworkloads.admin"
    "roles/compute.xpnAdmin"
    "roles/resourcemanager.folderAdmin"
    "roles/resourcemanager.organizationAdmin"
    "roles/container.hostServiceAgentUser"
    "roles/orgpolicy.policyAdmin"
    "roles/iam.organizationRoleAdmin"
    "roles/resourcemanager.projectCreator"
    "roles/securitycenter.admin"
    "roles/billing.projectManager"
    "roles/storage.admin"
    "roles/storage.objectAdmin"
    "roles/compute.networkAdmin"
    "roles/iam.serviceAccountAdmin"
    "roles/resourcemanager.projectIamAdmin"
    "roles/iam.serviceAccountUser"
    "roles/container.clusterAdmin"
    "roles/compute.securityAdmin"
    "roles/compute.admin"
```
