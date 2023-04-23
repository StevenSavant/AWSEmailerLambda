<!-- PROJECT SHIELDS -->
[![Python Version][python_version]]() [![Terraform Version][tf_version]]() [![Terragrunt Version][tg_version]]()


# AWSEmailerLambda
Simple Lambda Function for sending an SES Email create a url POST endpoint

This project creates a simple AWS Lambda Function with a url endpoint that will format and send an email using the Amazon SES Service.
The goal is to allow an S3 Bucket hosted front-end page to make and API call to send emails to website owners via a "Contact Us" form without the need to embede access keys into the Front-End files.


<!-- Markdown Variabls-->
[python_version]: https://img.shields.io/badge/python-v3.9-blue
[tf_version]: https://img.shields.io/badge/terraform-v1.2.3-purple
[tg_version]: https://img.shields.io/badge/terragrunt-v0.42.1-9cf