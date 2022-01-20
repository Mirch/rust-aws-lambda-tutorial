terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.48.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }

  required_version = "~> 1.0"
}

provider "aws" {
  region = var.aws_region
}

data "archive_file" "lambda_get_user_archive" {
  type = "zip"

  source_file = "${var.get_user_bin_path}"   
  output_path = "lambda.zip"
}

resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "lambda_execution_policy" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "get_user_lambda" {
  function_name = "GetUser"

  source_code_hash = data.archive_file.lambda_get_user_archive.output_base64sha256
  filename         = data.archive_file.lambda_get_user_archive.output_path

  handler = "bootstrap"
  runtime = "provided"

  role = aws_iam_role.lambda_execution_role.arn
}

resource "aws_apigatewayv2_api" "users_api" {
  name          = "API"
  description   = "Users API"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "get_user_integration" {
  api_id           = aws_apigatewayv2_api.users_api.id
  integration_type = "AWS_PROXY"

  connection_type    = "INTERNET"
  description        = "Get User"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.get_user_lambda.invoke_arn

  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "api_route" {
  api_id    = aws_apigatewayv2_api.users_api.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.get_user_integration.id}"
}

resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.users_api.id
  name        = "prod"
  auto_deploy = true
}

resource "aws_apigatewayv2_deployment" "api_deployment" {
  api_id      = aws_apigatewayv2_api.users_api.id
  description = "API deployment"

  triggers = {
    redeployment = sha1(join(",", [
      jsonencode(aws_apigatewayv2_integration.get_user_integration),
      jsonencode(aws_apigatewayv2_route.api_route)],
    ))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lambda_permission" "api_permission" {
  statement_id  = "allow_apigw_invoke"
  function_name = aws_lambda_function.get_user_lambda.function_name
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_stage.api_stage.execution_arn}/${aws_apigatewayv2_route.api_route.route_key}"
}