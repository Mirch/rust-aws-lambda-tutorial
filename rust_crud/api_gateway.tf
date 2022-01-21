resource "aws_apigatewayv2_api" "users_api" {
  name          = "API"
  description   = "Users API"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.users_api.id
  name        = "$default"
  auto_deploy = true
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

resource "aws_apigatewayv2_route" "get_user_route" {
  api_id    = aws_apigatewayv2_api.users_api.id
  route_key = "GET /users"
  target    = "integrations/${aws_apigatewayv2_integration.get_user_integration.id}"
}


resource "aws_apigatewayv2_deployment" "api_deployment" {
  api_id      = aws_apigatewayv2_api.users_api.id
  description = "API deployment"

  triggers = {
    redeployment = sha1(join(",", [
      jsonencode(aws_apigatewayv2_integration.get_user_integration),
      jsonencode(aws_apigatewayv2_route.get_user_route)],
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
  source_arn    = "${aws_apigatewayv2_api.users_api.execution_arn}/*/*/${split("/", aws_apigatewayv2_route.get_user_route.route_key)[1]}"
}