# outputs.tf
output "lambda_function_arn" {
  value = aws_lambda_function.canoja_verify_etl.arn
}

output "lambda_layer_arn" {
  value = aws_lambda_layer_version.etl_layer.arn
}