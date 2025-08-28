# Bootstrap Terraform Module

This Terraform module creates the foundational infrastructure for managing Terraform state and execution roles

## Purpose

Creates IAM execution roles with administrative access for Terraform operations in AWS accounts

## Usage Example

```hcl
module "bootstrap" {
  source = "./terraform"

  project     = "test-arrise"
  component   = "bootstrap"
  environment = "dev"
}
```

## Terragrunt Usage

```bash
# Plan the bootstrap infrastructure
terragrunt plan

# Apply the bootstrap infrastructure
terragrunt apply

# Run tests (from terraform/ directory)
terraform init -backend=false
terraform test

# Destroy the bootstrap infrastructure
terragrunt destroy
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.terraform_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.terraform_execution_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| <a name="input_terraform_execution_role_name"></a> [terraform\_execution\_role\_name](#input\_terraform\_execution\_role\_name) | Name of the Terraform execution IAM role | `string` | `"TerraformExecutionRole"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_terraform_execution_role_arn"></a> [terraform\_execution\_role\_arn](#output\_terraform\_execution\_role\_arn) | ARN of the Terraform execution IAM role |
| <a name="output_terraform_execution_role_name"></a> [terraform\_execution\_role\_name](#output\_terraform\_execution\_role\_name) | Name of the Terraform execution IAM role |
<!-- END_TF_DOCS -->
