output "terraform_execution_role_arn" {
  description = "ARN of the Terraform execution IAM role"
  value       = aws_iam_role.terraform_execution.arn
}

output "terraform_execution_role_name" {
  description = "Name of the Terraform execution IAM role"
  value       = aws_iam_role.terraform_execution.name
}