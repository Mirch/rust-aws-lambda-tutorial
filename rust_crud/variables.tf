# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "eu-west-1"
}

variable "get_user_bin_path" {
  description = "The binary path for the get_user lambda."

  type    = string
  default = "./bin/get_user/bootstrap"
}

variable "create_user_bin_path" {
  description = "The binary path for the create_user lambda."

  type    = string
  default = "./bin/create_user/bootstrap"
}

variable "update_user_bin_path" {
  description = "The binary path for the update_user lambda."

  type    = string
  default = "./bin/update_user/bootstrap"
}

variable "delete_user_bin_path" {
  description = "The binary path for the delete_user lambda."

  type    = string
  default = "./bin/delete_user/bootstrap"
}