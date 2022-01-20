# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "eu-west-1"
}

variable "get_user_bin_path" {
  description = "The binary path for the get_user lambda."

  type    = string
  default = "./lambda_functions/get_user/bootstrap"
}