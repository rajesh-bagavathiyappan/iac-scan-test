resource "aws_organizations_policy_attachment" "this" {
  count = length(local.policy_attachments)

  policy_id = local.policy_attachments[count.index].policyid
  target_id = local.policy_attachments[count.index].ouid # This is the aws_organizations_organizational_unit id.

  depends_on = [
    aws_organizations_organization.this,
    aws_organizations_policy.this,
    aws_organizations_organizational_unit.core_ous,
    aws_organizations_organizational_unit.custom_ous
  ]

}

### CANT APPLY BECAUSE OF REASONS BELOW - 
### CHECK - https://stackoverflow.com/questions/63768921/the-for-each-value-depends-on-resource-attributes-that-cannot-be-determined-t
### CHECK - https://www.terraform.io/docs/language/meta-arguments/for_each.html#using-expressions-in-for_each
### IF resources are not known - Then cant do a for_each statement. 

# resource "aws_organizations_policy_attachment" "this" {
#   for_each = { for entry in local.policy_attachments : "${entry.policyid}.${entry.ouid}" => entry }

#   policy_id = each.value.policyid
#   target_id = each.value.ouid # This is the aws_organizations_organizational_unit id.

#   depends_on = [
#     aws_organizations_organization.this,
#     aws_organizations_policy.this,
#     aws_organizations_organizational_unit.core_ous,
#     aws_organizations_organizational_unit.custom_ous
#   ]
# }

