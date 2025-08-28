# Task Infrastructure

Multi-stage IAM setup with cross-account role

## Stages

1. **[Stage 1](./terraform/stage1/README.md)** - Groups and Users
2. **[Stage 2](./terraform/stage2/README.md)** - Account Roles
3. **[Stage 3](./terraform/stage3/README.md)** - Cross-Account Role

## Usage

```bash
nx plan task    # All stages
nx deploy task

# Or specific stage
nx run task:plan:stage1:dev
```

## What Gets Created

- **Stage 1**: Groups (group1, group2) and users (service + human)
- **Stage 2**: roleA (admin access, no IAM) and roleB (cross-account)
- **Stage 3**: roleC (S3 access) in target account

## Flow

```
Users → roleB → roleC → S3 access
```
