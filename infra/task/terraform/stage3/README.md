# Stage 3: Cross-Account Target Role

Creates target IAM role in the resources AWS account

## Purpose

- roleC: S3 access role that can only be assumed by roleB from primary account

## Usage

```bash
terragrunt plan --terragrunt-working-dir environments/dev/stage3
terragrunt apply --terragrunt-working-dir environments/dev/stage3
```

## Access Flow

```
User → roleB (primary account) → roleC (target account) → S3 bucket
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
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.10 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.roleC_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.roleC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.roleC_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| <a name="input_trusted_account_id"></a> [trusted\_account\_id](#input\_trusted\_account\_id) | ID of the trusted AWS account | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
