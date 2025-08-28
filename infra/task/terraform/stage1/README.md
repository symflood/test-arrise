# Stage 1: Groups and Users

Creates IAM groups and users in the primary AWS account

## Purpose

- IAM groups with permissions
- Service users (CLI-only) and human users (console access)

## Usage

```bash
terragrunt plan --terragrunt-working-dir environments/dev/stage1
terragrunt apply --terragrunt-working-dir environments/dev/stage1
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.10 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_human_users"></a> [human\_users](#module\_human\_users) | terraform-aws-modules/iam/aws//modules/iam-user | ~> 6.2 |
| <a name="module_iam_groups"></a> [iam\_groups](#module\_iam\_groups) | terraform-aws-modules/iam/aws//modules/iam-group | ~> 6.2 |
| <a name="module_service_users"></a> [service\_users](#module\_service\_users) | terraform-aws-modules/iam/aws//modules/iam-user | ~> 6.2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_groups"></a> [groups](#input\_groups) | Groups to create | <pre>map(object({<br>    actions = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_human_users"></a> [human\_users](#input\_human\_users) | Human users | <pre>map(object({<br>    display_name = string<br>    group        = string<br>  }))</pre> | n/a | yes |
| <a name="input_service_users"></a> [service\_users](#input\_service\_users) | Service users | <pre>map(object({<br>    group = string<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group1_arn"></a> [group1\_arn](#output\_group1\_arn) | ARN of group1 |
| <a name="output_group2_arn"></a> [group2\_arn](#output\_group2\_arn) | ARN of group2 |
<!-- END_TF_DOCS -->
