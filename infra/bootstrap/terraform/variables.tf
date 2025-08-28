variable "terraform_execution_role_name" {
  description = "Name of the Terraform execution IAM role"
  type        = string
  default     = "TerraformExecutionRole"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
