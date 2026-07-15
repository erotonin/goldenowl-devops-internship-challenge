locals {
  environments = var.enabled ? {
    staging = {
      branch     = "staging"
      push_image = true
    }
    production = {
      branch     = "master"
      push_image = false
    }
  } : {}

  pass_role_arns = distinct(compact([
    var.task_execution_role_arn,
    var.task_role_arn,
    "arn:aws:iam::${var.aws_account_id}:role/${var.project_name}-staging-ecs-execution",
    "arn:aws:iam::${var.aws_account_id}:role/${var.project_name}-production-ecs-execution",
  ]))
}

resource "aws_iam_openid_connect_provider" "github" {
  count = var.enabled ? 1 : 0

  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  tags = merge(var.tags, {
    Name = "github-actions"
  })
}

data "aws_iam_policy_document" "trust" {
  for_each = local.environments

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github[0].arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:${var.github_repository}:ref:refs/heads/${each.value.branch}",
        "repo:${var.github_repository}:environment:${each.key}",
      ]
    }
  }
}

resource "aws_iam_role" "deploy" {
  for_each = local.environments

  name               = "${var.project_name}-${each.key}-github-deploy"
  assume_role_policy = data.aws_iam_policy_document.trust[each.key].json

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${each.key}-github-deploy"
    Environment = each.key
  })
}

data "aws_iam_policy_document" "deploy" {
  for_each = local.environments

  statement {
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:GetDownloadUrlForLayer",
    ]
    resources = [var.ecr_repository_arn]
  }

  dynamic "statement" {
    for_each = each.value.push_image ? [1] : []

    content {
      actions = [
        "ecr:CompleteLayerUpload",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart",
      ]
      resources = [var.ecr_repository_arn]
    }
  }

  statement {
    actions = [
      "ecs:DescribeTaskDefinition",
      "ecs:RegisterTaskDefinition",
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "ecs:DescribeServices",
      "ecs:UpdateService",
    ]
    resources = [
      "arn:aws:ecs:${var.aws_region}:${var.aws_account_id}:service/${var.project_name}-${each.key}/${var.project_name}-${each.key}",
    ]
  }

  dynamic "statement" {
    for_each = length(local.pass_role_arns) > 0 ? [1] : []

    content {
      actions   = ["iam:PassRole"]
      resources = local.pass_role_arns
    }
  }

  statement {
    actions = each.key == "staging" ? [
      "ssm:GetParameter",
      "ssm:PutParameter",
      ] : [
      "ssm:GetParameter",
    ]
    resources = [
      "arn:aws:ssm:${var.aws_region}:${var.aws_account_id}:parameter${var.approved_image_parameter}",
    ]
  }
}

resource "aws_iam_role_policy" "deploy" {
  for_each = local.environments

  name   = "${var.project_name}-${each.key}-deployment"
  role   = aws_iam_role.deploy[each.key].id
  policy = data.aws_iam_policy_document.deploy[each.key].json
}
