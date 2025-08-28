include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../terraform/stage1"
}

locals {
  env_cfg = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  stage_cfg = read_terragrunt_config("${get_terragrunt_dir()}/stage.hcl")
}

inputs = {
  groups = local.env_cfg.locals.groups
  service_users = local.env_cfg.locals.service_users
  human_users = local.env_cfg.locals.human_users
}
