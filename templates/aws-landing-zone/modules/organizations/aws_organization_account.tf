#### WARNING DO NOT CREATE THIS UNTIL NEEDED ###### 
#### ONCE CREATED CANNOT BE DESTROYED VIA TERRAFORM DESTROY COMMAND ###
#### TERRAFORM DESTROY CAN ONLY REMOVE IT FROM ORGANIZATION. AND ACCOUNT WOULD BE DANGLING ##### 
#### Control this creation via local.accounts and account.create(boolean) property for each account objects in OUs ### 

resource "aws_organizations_account" "account" {
  count = length(local.accounts)

  name  = local.accounts[count.index].account_name
  email = "${local.email_segments[0]}+${local.accounts[count.index].account_name}@${local.email_segments[1]}"

  role_name = local.accounts[count.index].account_name
  parent_id = local.accounts[count.index].parent_ou_id

  # There is no AWS Organizations API for reading role_name
  lifecycle {
    ignore_changes = [role_name] # Federated Role name created in child account.
    # prevent_destroy = true
  }

  tags = merge({ AccountName = local.accounts[count.index].account_name }, local.accounts[count.index].tags)
}
