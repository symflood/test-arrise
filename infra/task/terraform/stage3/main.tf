resource "aws_iam_role" "roleC" {
  name = "roleC"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.trusted_account_id}:role/roleB"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_policy" "roleC_policy" {
  name = "RoleCPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::aws-test-bucket",
          "arn:aws:s3:::aws-test-bucket/*"
        ]
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "roleC_attachment" {
  role       = aws_iam_role.roleC.name
  policy_arn = aws_iam_policy.roleC_policy.arn
}
