variable "trusted_account_id" {
  description = "ID of the trusted AWS account"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
