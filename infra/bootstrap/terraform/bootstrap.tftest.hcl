# Test: Basic bootstrap infrastructure validation
run "bootstrap_validation" {
  command = plan

  variables {
    project     = "test-project"
    component   = "bootstrap"
    environment = "dev"
  }

  # Validate IAM role is created with correct name
  assert {
    condition     = aws_iam_role.terraform_execution.name == "TerraformExecutionRole"
    error_message = "IAM role should be named 'TerraformExecutionRole'"
  }

  # Validate policy attachment exists
  assert {
    condition     = aws_iam_role_policy_attachment.terraform_execution_admin.policy_arn == "arn:aws:iam::aws:policy/AdministratorAccess"
    error_message = "IAM role should have AdministratorAccess policy attached"
  }

  # Validate policy attachment references correct role
  assert {
    condition     = aws_iam_role_policy_attachment.terraform_execution_admin.role == aws_iam_role.terraform_execution.name
    error_message = "Policy attachment should reference the terraform execution role"
  }
}

# Test: Custom role name
run "custom_role_name" {
  command = plan

  variables {
    project                       = "test-project"
    component                     = "bootstrap"
    environment                   = "dev"
    terraform_execution_role_name = "CustomTerraformRole"
  }

  # Validate custom role name is used
  assert {
    condition     = aws_iam_role.terraform_execution.name == "CustomTerraformRole"
    error_message = "IAM role should use custom name when provided"
  }
}

# Test: Tags validation
run "tags_validation" {
  command = plan

  variables {
    project     = "test-project"
    component   = "bootstrap"
    environment = "dev"
  }

  # Validate tags are applied via locals with correct values
  assert {
    condition     = local.common_tags.Project == "test-project"
    error_message = "Project tag should match input variable"
  }

  assert {
    condition     = local.common_tags.Component == "bootstrap"
    error_message = "Component tag should match input variable"
  }

  assert {
    condition     = local.common_tags.Environment == "dev"
    error_message = "Environment tag should match input variable"
  }
}

# Test: Environment validation success
run "environment_validation_success" {
  command = plan

  variables {
    project     = "test-project"
    component   = "bootstrap"
    environment = "dev" # Valid
  }

  # Should succeed with valid environment
  assert {
    condition     = var.environment == "dev"
    error_message = "Should accept valid environment 'dev'"
  }
}

# Test: Environment validation failure
run "environment_validation_failure" {
  command = plan

  variables {
    project     = "test-project"
    component   = "bootstrap"
    environment = "invalid" # Unsupported
  }

  # Should fail with invalid environment
  expect_failures = [
    var.environment
  ]
}
