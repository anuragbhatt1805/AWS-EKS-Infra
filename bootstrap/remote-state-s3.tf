resource "aws_s3_bucket" "remote_state" {
  bucket = "github-aws-eks-tofu-state"
}

resource "aws_s3_bucket_ownership_controls" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowGitHubInfraRole"
        Effect = "Allow"

        Principal = {
          AWS = aws_iam_role.github_infra_role.arn
        }

        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:DeleteObject"
        ]

        Resource = "${aws_s3_bucket.remote_state.arn}/*"
      },

      {
        Sid    = "AllowGitHubInfraRoleBucket"
        Effect = "Allow"

        Principal = {
          AWS = aws_iam_role.github_infra_role.arn
        }

        Action = [
          "s3:GetBucketVersioning",
          "s3:ListBucket"
        ]

        Resource = aws_s3_bucket.remote_state.arn
      }
    ]
  })
}