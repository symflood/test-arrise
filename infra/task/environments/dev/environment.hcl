locals {
  environment = "dev"
  aws_region  = "us-east-1"

  trusted_account_id = "111111111111"

  groups = {
    "group1" = {
      actions = ["sts:AssumeRole", "sts:GetCallerIdentity"]
    }
    "group2" = {
      actions = [
        "sts:AssumeRole",
        "sts:GetCallerIdentity",
        "iam:GetUser",
        "iam:ListUsers",
        "iam:ChangePassword"
      ]
    }
  }

  service_users = {
    "engine" = { group = "group1" }
    "ci" = { group = "group1" }
  }

  human_users = {
    "denys.platon" = { display_name = "Denys Platon", group = "group2" }
    "ivan.petrenko" = { display_name = "Ivan Petrenko", group = "group2" }
  }
}
