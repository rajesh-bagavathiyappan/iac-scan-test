# TOP MANAGEMENT ROOT USER HAS TO RESET PASSWORD MANUALLY FOR BELOW CREATED ADMINISTRATOR USER.
# TERRAFORM SHOULD NOT STORE ANYTHING RELATED TO USER SECRET.

resource "aws_iam_user" "this" {
  name = var.admin_user
  path = "/system/"

  tags = {
    Access = "Administrator"
  }

}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_iam_user_policy" "this" {
  name = "ManagementAdministratorPolicy"
  user = aws_iam_user.this.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}
