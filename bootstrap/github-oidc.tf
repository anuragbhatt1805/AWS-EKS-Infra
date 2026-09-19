resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://${var.oidc_provider_url}"
  client_id_list = var.oidc_provider_audience
}

resource "aws_iam_role" "github_infra_role" {
  name = "aws_eks_infra_github_infra_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = {
      Effect = "Allow"
      Action = "sts:AssumeRoleWithWebIdentity"

      Principal = {
        Federated = aws_iam_openid_connect_provider.github.arn
      }

      Condition = {
        StringEquals = {
          "${var.oidc_provider_url}:aud" : var.oidc_provider_audience
          "${var.oidc_provider_url}:sub" : [
            "repo:${var.infra_repo}:ref:refs/heads/main",
            "repo:${var.infra_repo}:pull_request"
          ]
        }
      }
    }
  })
}

resource "aws_iam_role_policy" "github_infra_policy" {
  name = "${aws_iam_role.github_infra_role.name}_policy"
  role = aws_iam_role.github_infra_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid      = "AllowAllAWSActions"
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      },

      {
        Sid    = "DenySecretsManagerWrite"
        Effect = "Deny"

        Action = [
          "secretsmanager:CreateSecret",
          "secretsmanager:PutSecretValue",
          "secretsmanager:UpdateSecret",
          "secretsmanager:UpdateSecretVersionStage",
          "secretsmanager:DeleteSecret",
          "secretsmanager:RestoreSecret",
          "secretsmanager:RotateSecret",
          "secretsmanager:CancelRotateSecret",
          "secretsmanager:PutResourcePolicy",
          "secretsmanager:DeleteResourcePolicy",
          "secretsmanager:ReplicateSecretToRegions",
          "secretsmanager:RemoveRegionsFromReplication",
          "secretsmanager:TagResource",
          "secretsmanager:UntagResource"
        ]

        Resource = "*"
      }
    ]
  })
}