# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

# This resource is the core take away of this example.
resource "aws_lambda_permission" "default" {
  statement_id  = "AllowExecutionFromAlexa"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.default.function_name}"
  principal     = "alexa-appkit.amazon.com"
}

resource "aws_lambda_function" "default" {
  filename         = "doctor-bot.zip"
  source_code_hash = "${base64sha256(file("doctor-bot.zip"))}"
  function_name    = "terraform_lambda_alexa_example"
  role             = "${aws_iam_role.default.arn}"
  handler          = "lambda_function.lambda_handler"
  runtime          = "nodejs8.10"
}

resource "aws_iam_role" "default" {
  name = "terraform_lambda_alexa_example"

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


resource "aws_iam_role_policy" "default" {
  name = "terraform_lambda_alexa_example"
  role = "${aws_iam_role.default.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
