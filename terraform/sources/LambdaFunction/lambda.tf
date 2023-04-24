resource "aws_lambda_function_url" "lambda-app-url" {
  function_name      = aws_lambda_function.lambda-app-function.function_name
  authorization_type = "NONE"

  cors {
    allow_origins     = ["*"]
    allow_methods     = ["POST"]
    allow_headers     = ["date", "keep-alive", "accept", "accept-language", "content-type", "content-language"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 5
    allow_credentials = true
  }
}

resource "aws_lambda_function" "lambda-app-function" {
  s3_key           = data.aws_s3_object.lovecraft-deployment-object.key
  depends_on       = [data.aws_s3_object.lovecraft-deployment-object]
  source_code_hash = "always update"
  
  s3_bucket        = data.aws_s3_bucket.lovecraft-deployment-bucket.id
  function_name    = var.lambda-app-name
  handler          = var.handler_function
  role             = aws_iam_role.lambda-role.arn
  runtime          = var.python_version
  timeout          = 600
  memory_size      = 256
}

# Grant Invoke permission to the Event Bridge.
resource "aws_lambda_permission" "allow-eventsbridge-to-call-lambda" {
  statement_id  = "AllowExecutionFromEventsBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-app-function.arn
  principal     = "events.amazonaws.com"
}