output "group1_arn" {
  description = "ARN of group1"
  value       = module.iam_groups["group1"].arn
}

output "group2_arn" {
  description = "ARN of group2"
  value       = module.iam_groups["group2"].arn
}
