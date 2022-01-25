# GET USER
data "archive_file" "get_user_lambda_archive" {
  type = "zip"

  source_file = "${var.get_user_bin_path}"   
  output_path = "get_user_lambda.zip"
}

resource "aws_iam_role" "get_user_lambda_execution_role" {
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

resource "aws_iam_role_policy_attachment" "get_user_lambda_execution_policy" {
  role       = aws_iam_role.get_user_lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "get_user_lambda" {
  function_name = "GetUser"

  source_code_hash = data.archive_file.get_user_lambda_archive.output_base64sha256
  filename         = data.archive_file.get_user_lambda_archive.output_path

  handler = "func"
  runtime = "provided"

  role = aws_iam_role.get_user_lambda_execution_role.arn
}

# CREATE USER
data "archive_file" "create_user_lambda_archive" {
  type = "zip"

  source_file = "${var.create_user_bin_path}"   
  output_path = "create_user_lambda.zip"
}

resource "aws_iam_role" "create_user_lambda_execution_role" {
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

resource "aws_iam_role_policy_attachment" "create_user_lambda_execution_policy" {
  role       = aws_iam_role.create_user_lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "create_user_lambda" {
  function_name = "CreateUser"

  source_code_hash = data.archive_file.create_user_lambda_archive.output_base64sha256
  filename         = data.archive_file.create_user_lambda_archive.output_path

  handler = "func"
  runtime = "provided"

  role = aws_iam_role.create_user_lambda_execution_role.arn
}

# UPDATE USER
data "archive_file" "update_user_lambda_archive" {
  type = "zip"

  source_file = "${var.update_user_bin_path}"   
  output_path = "update_user_lambda.zip"
}

resource "aws_iam_role" "update_user_lambda_execution_role" {
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

resource "aws_iam_role_policy_attachment" "update_user_lambda_execution_policy" {
  role       = aws_iam_role.update_user_lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "update_user_lambda" {
  function_name = "UpdateUser"

  source_code_hash = data.archive_file.update_user_lambda_archive.output_base64sha256
  filename         = data.archive_file.update_user_lambda_archive.output_path

  handler = "func"
  runtime = "provided"

  role = aws_iam_role.update_user_lambda_execution_role.arn
}

# DELETE USER
data "archive_file" "delete_user_lambda_archive" {
  type = "zip"

  source_file = "${var.delete_user_bin_path}"   
  output_path = "delete_user_lambda.zip"
}

resource "aws_iam_role" "delete_user_lambda_execution_role" {
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

resource "aws_iam_role_policy_attachment" "delete_user_lambda_execution_policy" {
  role       = aws_iam_role.delete_user_lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "delete_user_lambda" {
  function_name = "DeleteUser"

  source_code_hash = data.archive_file.delete_user_lambda_archive.output_base64sha256
  filename         = data.archive_file.delete_user_lambda_archive.output_path

  handler = "func"
  runtime = "provided"

  role = aws_iam_role.delete_user_lambda_execution_role.arn
}