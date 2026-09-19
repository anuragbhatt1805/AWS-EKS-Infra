output "gitlab_infra_role_arn" {
  value = aws_iam_role.github_infra_role.arn
}

output "remote_state_bucket_arn" {
  value = aws_s3_bucket.remote_state.arn
}