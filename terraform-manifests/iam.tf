resource "aws_iam_user" "lb" {
  name = "loadbalancer"
 
}

resource "aws_iam_group" "developers" {
  name = "developers"
}

resource "aws_iam_group_membership" "developersteam" {
  name  = "developers-membership"
  users = [aws_iam_user.lb.name]
  group = aws_iam_group.developers.name
}

resource "aws_iam_policy" "policy" {
  name        = "administrator_policy"
  description = "An administrator policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "*"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "developers_admin" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.policy.arn
}
