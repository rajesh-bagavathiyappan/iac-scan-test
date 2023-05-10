output "management_administrator" {
  value = aws_iam_user.this
}

output "management_administrator_arn" {
  value = aws_iam_user.this.arn
}
