# permissions.tf
resource "aws_lambda_permission" "allow_sns_invocation" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.canoja_verify_etl.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = data.aws_sns_topic.etl_topic.arn
}

resource "aws_iam_policy" "lambda_sns_publish_policy" {
  name   = "LambdaSNSPublishPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Action: "sns:Publish",
        Resource: data.aws_sns_topic.etl_topic.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_sns_publish" {
  role       = data.aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_sns_publish_policy.arn
}