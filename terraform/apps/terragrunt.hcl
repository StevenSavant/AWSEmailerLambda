remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "awstarfire-remotestate"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
  }
}

terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars() 
  }
}