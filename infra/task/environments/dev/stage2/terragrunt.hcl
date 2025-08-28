include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../terraform/stage2"
}

dependencies {
  paths = ["../stage1"]
}

locals {
  env_cfg = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  stage_cfg = read_terragrunt_config("${get_terragrunt_dir()}/stage.hcl")
}

inputs = {
  trusted_account_id = local.env_cfg.locals.trusted_account_id
}
