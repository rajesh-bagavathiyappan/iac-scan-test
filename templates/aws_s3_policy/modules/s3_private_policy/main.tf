data "aws_s3_bucket" "selected" {
  bucket = var.bucket_name
}

resource "aws_s3_account_public_access_block" "block_account" {
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "block_bucket" {
  bucket = data.aws_s3_bucket.selected.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type = "AWS"
      identifiers = [
        aws_s3_account_public_access_block.block_account.id
      ]
    }
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      data.aws_s3_bucket.selected.arn,
      "${data.aws_s3_bucket.selected.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = data.aws_s3_bucket.selected.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

