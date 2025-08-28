# test-arrise

Multi-account AWS infrastructure using Terraform and Terragrunt

## Components

- **[Bootstrap](./infra/bootstrap/README.md)** - State management setup
- **[Task](./infra/task/README.md)** - Multi-stage test task

## Prerequisites

- (Optional for nx) Node.js, pnpm
- Terraform, Terragrunt
- AWS CLI with configured profiles for two accounts

## Quick Start

### NX
```bash
pnpm install
nx deploy bootstrap
nx deploy task
```

### Terragrunt
```bash
cd infra/bootstrap && terragrunt run --all apply
cd ../task && terragrunt run --all apply
```

## Configuration

### 1. Update Account Names (Bootstrap)

**infra/bootstrap/environments/dev/ACCOUNT_NAME/account.hcl**:
```hcl
locals {
  account_name = "ACCOUNT_NAME"
}
```

### 2. Update Account Names and IDs (Task)

**infra/task/environments/dev/stageX/stage.hcl**:
```hcl
locals {
  account_name = "ACCOUNT_NAME"
  account_id   = "ACCOUNT_ID"
}
```

### 3. Update AWS SSO Profiles

In `~/.aws/config`:
```ini
[sso-session ORGANIZATION]
sso_start_url = https://ORGANIZATION.awsapps.com/start
sso_region = us-east-1

[profile test-arrise.dev.account0]
sso_session = ORGANIZATION
sso_account_id = ACCOUNT_ID
sso_role_name = AdministratorAccess
region = us-east-1

[profile test-arrise.dev.account1]
sso_session = ORGANIZATION
sso_account_id = ACCOUNT_ID
sso_role_name = AdministratorAccess
region = us-east-1
```

## Commands

### NX
```bash
nx plan|deploy|destroy bootstrap|task
nx fmt|lint|test|docs bootstrap|task
```

### Terragrunt
```bash
cd infra/bootstrap
terragrunt run --all plan|apply|destroy
terraform fmt -recursive terraform/
cd terraform && terraform test
tflint --chdir terraform/

cd infra/task
terragrunt run --all plan|apply|destroy
terraform fmt -recursive terraform/
tflint --chdir terraform/
```
