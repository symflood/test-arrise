include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../terraform/stage3"
}

dependencies {
  paths = ["../stage2"]
}

locals {
  env_cfg = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  stage_cfg = read_terragrunt_config("${get_terragrunt_dir()}/stage.hcl")
}

inputs = {
  trusted_account_id = local.stage_cfg.locals.trusted_account_id
}
