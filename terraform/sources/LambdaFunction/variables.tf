variable "aws_region" {
  default = "us-east-1"
}

variable "handler_function" {
  type = string
}

variable "lambda-app-name" {
  type = string
}

variable "python_version" {
  type = string
}

variable "deployment-bucket" {
  type = string
}

variable "deployment-object-name" {
  type = string
}
