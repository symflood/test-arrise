locals {
  all_users = merge(var.service_users, var.human_users)
}

module "iam_groups" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group"
  version = "~> 6.2"

  for_each = var.groups
  name     = each.key
  users    = [for user, config in local.all_users : user if config.group == each.key]

  permissions = {
    GroupPermissions = {
      actions   = each.value.actions
      resources = ["*"]
    }
  }
}

module "service_users" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 6.2"

  for_each             = var.service_users
  name                 = each.key
  force_destroy        = true
  create_login_profile = false
  create_access_key    = true
}

module "human_users" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 6.2"

  for_each             = var.human_users
  name                 = each.key
  force_destroy        = true
  create_login_profile = true
  create_access_key    = true

  tags = merge(var.tags, {
    DisplayName = each.value.display_name
  })
}
