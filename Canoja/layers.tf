# layers.tf
resource "aws_lambda_layer_version" "etl_layer" {
  filename          = "lambda_layer.zip"  # Path to your Lambda layer zip file
  layer_name        = "CanojaVerify-ETL-Layer"
  compatible_runtimes = ["python3.9"]
  description       = "A layer to provide CanojaVerify-ETL-Layer library access."

  source_code_hash  = filebase64sha256("lambda_layer.zip")
}