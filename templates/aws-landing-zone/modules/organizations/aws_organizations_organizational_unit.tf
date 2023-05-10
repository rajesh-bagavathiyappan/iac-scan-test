
resource "aws_organizations_organizational_unit" "core_ous" {
  for_each = { for ou in var.core_ous : ou.name => ou if ou.create }

  name      = each.value.name
  parent_id = aws_organizations_organization.this.roots[0].id
  tags = {
    OU = each.value.name
  }
}
# 
resource "aws_organizations_organizational_unit" "custom_ous" {
  for_each = { for ou in var.custom_ous : ou.name => ou if ou.create }

  name      = each.value.name
  parent_id = aws_organizations_organization.this.roots[0].id

  tags = {
    OU = each.value.name
  }
}

# This is needed for creating environment OUs whereever needed
resource "aws_organizations_organizational_unit" "environment_ous" {
  for_each = var.create_environment_ous ? local.core_ou_environments : {}

  parent_id = each.value.parent_id
  name      = each.value.name

  tags = {
    OU = each.value.name
  }
}
