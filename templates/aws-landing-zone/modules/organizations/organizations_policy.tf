resource "aws_organizations_policy" "this" {

  for_each = { for pol in local.policies : "${pol.ou}.${pol.file}" => pol }

  name        = "${upper(each.value.ou)}-${split(".", basename(each.value.file))[0]}"
  description = "This Policy denies all except the satisfied conditional ones"

  content = replace(file("${path.module}/${each.value.file}"), "<admin_user_arn>", var.admin_user_arn)

  depends_on = [
    aws_organizations_organization.this
  ]
  tags = {
    OU = each.value.ou
  }
}
