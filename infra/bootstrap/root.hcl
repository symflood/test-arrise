locals {
  common_vars = {
    project = "test-arrise"
    component = "bootstrap"
  }

  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  account_vars = try(
    read_terragrunt_config("${get_original_terragrunt_dir()}/account.hcl"),
    read_terragrunt_config(find_in_parent_folders("account.hcl"))
  )

  environment = local.environment_vars.locals.environment
  aws_region = local.environment_vars.locals.aws_region
  account_name = local.account_vars.locals.account_name

  tags = {
    Project     = local.common_vars.project
    Component   = local.common_vars.component
    Environment = local.environment
    ManagedBy   = "Terraform"
  }
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${get_aws_account_id()}-${local.common_vars.project}-${local.environment}-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "${local.common_vars.project}-${local.environment}-terraform-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Shared lock file will be generated after first init

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  profile = "${local.common_vars.project}.${local.environment}.${local.account_name}"
}
EOF
}

inputs = {
  tags = local.tags
}
