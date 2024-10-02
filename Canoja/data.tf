# data.tf
data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    "aws-cdk:subnet-type" = "Private"  # Adjust based on your tagging
  }
}

data "aws_subnet" "private_subnets" {
  count = length(data.aws_subnets.private_subnets.ids)
  id    = data.aws_subnets.private_subnets.ids[count.index]
}

data "aws_security_group" "lambda_sg" {
  id = var.security_group_id
}
# Extract the role name from the ARN
locals {
  lambda_role_name = element(split("/", var.lambda_role_arn), 1)
}

data "aws_iam_role" "lambda_role" {
  name = local.lambda_role_name
}

# Extract the SNS topic name from the ARN
locals {
  sns_topic_name = element(split(":", var.sns_topic_arn), 5)
}

data "aws_sns_topic" "etl_topic" {
  name = local.sns_topic_name
}

# Extract layer name and version from the ARN
locals {
  layer_arn_parts   = split(":", var.pandas_layer_arn)
  layer_name        = element(split("/", element(local.layer_arn_parts, 5)), 1)
  layer_version_str = element(local.layer_arn_parts, 7)
  layer_version     = tonumber(local.layer_version_str)
}

data "aws_lambda_layer_version" "aws_pandas_layer" {
  layer_name = local.layer_name
  version    = local.layer_version
}