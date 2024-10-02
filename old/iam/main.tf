provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "newUser" {
  name = "CSanders"
  
}

resource "aws_iam_policy" "customPolicy" {
  name = "semiCustomAdmin"
  description = "Give me full access to everything"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "policyBinding" {
  name = "semiCustomAdmin"
  users = [aws_iam_user.newUser.name]
  policy_arn = aws_iam_policy.customPolicy.arn
  
}