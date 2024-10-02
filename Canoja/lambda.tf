# lambda.tf
resource "aws_lambda_function" "canoja_verify_etl" {
  function_name = "CanojaVerify-ETL"
  description   = "A lambda function to process CanojaVerify ETL Updates."
  role          = data.aws_iam_role.lambda_role.arn
  handler       = "lambda_function.main"
  runtime       = "python3.9"
  timeout       = 300
  memory_size   = 128

  filename         = "lambda_function.zip"  # Path to your Lambda function zip file
  source_code_hash = filebase64sha256("lambda_function.zip")

  layers = [
    aws_lambda_layer_version.etl_layer.arn,
    data.aws_lambda_layer_version.aws_pandas_layer.arn
  ]

  environment {
    variables = {
      mysql_db_endpoint    = var.mysql_db_endpoint
      mysql_db_name        = var.mysql_db_name
      mysql_db_username    = var.mysql_db_username
      mysql_db_password    = var.mysql_db_password
      mysql_db_port        = var.mysql_db_port
      LOGURU_LEVEL         = var.LOGURU_LEVEL
      teams_webhook_url    = var.teams_webhook_url
      etl_environment      = var.etl_environment
    }
  }

  vpc_config {
    security_group_ids = [data.aws_security_group.lambda_sg.id]
    subnet_ids         = data.aws_subnets.private_subnets.ids
  }

  depends_on = [
    aws_lambda_layer_version.etl_layer
  ]
}