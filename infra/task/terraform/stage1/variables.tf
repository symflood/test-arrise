variable "groups" {
  description = "Groups to create"
  type = map(object({
    actions = list(string)
  }))
}

variable "service_users" {
  description = "Service users"
  type = map(object({
    group = string
  }))
}

variable "human_users" {
  description = "Human users"
  type = map(object({
    display_name = string
    group        = string
  }))
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
