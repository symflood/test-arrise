# Bootstrap Infrastructure

Creates foundational infrastructure for Terraform state management and execution roles

## Purpose

- IAM execution roles with admin access
- S3 state buckets and DynamoDB locks
- Must be deployed first

## Usage

```bash
nx plan bootstrap
nx deploy bootstrap
nx test bootstrap  # Run Terraform native tests
```

## Resources Created

- IAM role `TerraformExecutionRole` with `AdministratorAccess`
- S3 bucket for state storage
- DynamoDB table for state locking

See [Terraform module documentation](./terraform/README.md) for details.
