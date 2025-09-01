locals {
  common_vars = {
    project = "test-arrise"
    component = "task"
  }

  env_cfg = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  stage_cfg = read_terragrunt_config("${get_terragrunt_dir()}/stage.hcl")

  environment = local.env_cfg.locals.environment
  aws_region = local.env_cfg.locals.aws_region
  account_name = local.stage_cfg.locals.account_name
  account_id = local.stage_cfg.locals.account_id

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
    bucket         = "${local.account_id}-${local.common_vars.project}-${local.environment}-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "${local.common_vars.project}-${local.environment}-terraform-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region  = "${local.aws_region}"
  profile = "${local.common_vars.project}.${local.environment}.${local.account_name}"

  assume_role {
    role_arn     = "arn:aws:iam::${local.account_id}:role/TerraformExecutionRole"
    session_name = "terragrunt-${local.common_vars.project}-${local.environment}"
  }
}
EOF
}

inputs = {
  tags = local.tags
}
