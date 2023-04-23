resource "aws_iam_role" "lambda-role" {
  name               = var.lambda-app-name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "lambda-role-policy" {
  name   = "${var.lambda-app-name}-policy"
  policy = data.aws_iam_policy_document.lambda-role-policy-document.json
}

data "aws_iam_policy_document" "lambda-role-policy-document" {
  statement {
    sid = "accesss3importobjs"
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:ListBucket"
    ]
    effect    = "Allow"
    resources = [
        "${data.aws_s3_bucket.lovecraft-deployment-bucket.arn}/*",
        data.aws_s3_bucket.lovecraft-deployment-bucket.arn
        ]
  }

  statement {
    sid = "secretspramsaccess"
    actions = [
          "secretsmanager:Get*",
          "secretsmanager:List*",
          "ssm:GetParameter"
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    sid = "cloudwatchputmetric"
    actions = [
      "cloudwatch:PutMetricData",
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    sid = "sesSend"
    actions = [
      "ses:SendEmail",
      "ses:SendRawEmail"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "lambda-role_lambda-role-policy_PolicyAttach" {
  policy_arn = aws_iam_policy.lambda-role-policy.arn
  role       = aws_iam_role.lambda-role.name
}

resource "aws_iam_role_policy_attachment" "lambda-role_AWSLambdaBasicExecutionRole_PolicyAttach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda-role.name
}

resource "aws_iam_role_policy_attachment" "lambda-role_AWSLambdaVPCAccessExecutionRole_PolicyAttach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  role       = aws_iam_role.lambda-role.name
}