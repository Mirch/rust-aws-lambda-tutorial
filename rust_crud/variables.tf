# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "eu-west-1"
}

variable "get_user_bin_path" {
  description = "The binary path for the get_user lambda."

  type    = string
  default = "./users/get_user/bootstrap"
}

variable "create_user_bin_path" {
  description = "The binary path for the create_user lambda."

  type    = string
  default = "./lambda_functions/create_user/bootstrap"
}

variable "update_user_bin_path" {
  description = "The binary path for the update_user lambda."

  type    = string
  default = "./lambda_functions/update_user/bootstrap"
}

variable "delete_user_bin_path" {
  description = "The binary path for the delete_user lambda."

  type    = string
  default = "./lambda_functions/delete_user/bootstrap"
}