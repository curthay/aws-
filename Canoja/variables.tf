# variables.tf
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for Lambda function"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID of the existing security group"
  type        = string
}

variable "lambda_role_arn" {
  description = "ARN of the existing IAM role for Lambda execution"
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN of the existing SNS Topic"
  type        = string
}

# Environment variables for Lambda
variable "mysql_db_endpoint" {
  description = "RDS endpoint"
  type        = string
}

variable "mysql_db_name" {
  description = "Database name"
  type        = string
}

variable "mysql_db_username" {
  description = "Database username"
  type        = string
}

variable "mysql_db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "mysql_db_port" {
  description = "Database port"
  type        = string
  default     = "3306"
}

variable "LOGURU_LEVEL" {
  description = "Logging level"
  type        = string
  default     = "INFO"
}

variable "teams_webhook_url" {
  description = "Microsoft Teams webhook URL"
  type        = string
}

variable "etl_environment" {
  description = "Environment identifier (e.g., DEV, QA, PROD)"
  type        = string
}

# Paths to Lambda function and layer code
variable "lambda_function_s3_bucket" {
  description = "S3 bucket name where Lambda function code is stored"
  type        = string
}

variable "lambda_function_s3_key" {
  description = "S3 key for the Lambda function code zip file"
  type        = string
}

variable "lambda_layer_s3_bucket" {
  description = "S3 bucket name where Lambda layer code is stored"
  type        = string
}

variable "lambda_layer_s3_key" {
  description = "S3 key for the Lambda layer code zip file"
  type        = string
}

variable "pandas_layer_arn" {
  description = "ARN of the AWS-managed Pandas Lambda Layer"
  type        = string
}