locals {
  environment_ou_names = [for ou in var.environment_ous : ou.name]
  core_ou_ids          = [for ou in aws_organizations_organizational_unit.core_ous : "${ou.id}.${ou.name}"]

  core_ou_environments = {
    for ou in setproduct(tolist(local.core_ou_ids), local.environment_ou_names) : "${ou[0]}/${ou[1]}" => {
      parent_id = ou[0]
      name      = ou[1]
    }
  }

  # custom_ous = { 
  #   for ou in setproduct(aws_organizations_organizational_unit.custom_ous, var.environment_ous) : "${ou[0].name}/${ou[1]}" => {
  #     parent_id = ou[0].id
  #     name  = ou[1]
  #   }
  # }

  email_segments = split("@", var.management_email)

  #💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥#
  # The intermediatory policies which are created based on inputs from both core and non core ous 
  # We need to flatten it and get only OU name and folder name. if the folder name exists under policies 
  # as same as ou name. Then we create the policies object with ou name itself and the policies json read
  # from the folder.
  #💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥#

  policies = flatten([
    for ou in toset(concat(var.core_ous, var.custom_ous)) : [
      for policyfile in fileset(path.module, "/policies/${upper(ou.name)}/*.json") : {
        ou   = ou.name
        file = policyfile
        # file = data.template_file.step_function.rendered
      } if try(ou.create, false) # create only if is true
    ]
  ])

  #💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥#
  # The intermediatory policy attachment created combining the core_ous and custom_ous resources 
  # properties (ouid , policy id and tags from ou)
  #💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥#

  # Combining core ou properties and non core ous. In future add environment ou policies.
  policy_attachments = flatten([
    for ou in concat(local.core_ou_properties, local.custom_ou_properties) : [
      for policy in aws_organizations_policy.this : {
        ouid     = ou.id
        policyid = policy.id
        tags = merge({
          policy = policy.name
        }, ou.tags)
      } if lower(ou.name) == lower(policy.tags["OU"]) # allow only if ou name matches with the policy tag
    ]
  ])


  core_ou_properties = [for ou in aws_organizations_organizational_unit.core_ous : {
    name = ou.name
    id   = ou.id
    tags = ou.tags
  }]

  custom_ou_properties = [for ou in aws_organizations_organizational_unit.custom_ous : {
    name = ou.name
    id   = ou.id
    tags = ou.tags
  }]

  accounts = flatten([
    for ou in concat(var.core_ous, var.custom_ous) : [
      for account in ou.accounts : [
        for ou_properties in concat(local.core_ou_properties, local.custom_ou_properties) : {
          create_account = account.create
          account_name   = account.name
          parent_ou_id   = ou_properties.id
          tags           = ou_properties.tags
        } if ou.name == ou_properties.name && account.create
      ]
  ]])

}
