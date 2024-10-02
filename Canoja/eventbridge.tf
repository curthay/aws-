# eventbridge.tf
resource "aws_cloudwatch_event_rule" "etl_rule" {
  name        = "CanojaVerify-ETL-Rule"
  description = "Event Rule that kicks off the CanojaVerify ETL Updates"
  schedule_expression = "cron(0 6 * * ? *)"
}

resource "aws_cloudwatch_event_target" "etl_target" {
  rule      = aws_cloudwatch_event_rule.etl_rule.name
  target_id = "CanojaVerify-ETL-Target"
  arn       = aws_lambda_function.canoja_verify_etl.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.canoja_verify_etl.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.etl_rule.arn
}