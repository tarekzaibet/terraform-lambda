# Deploy doctor-bot skill using terraform 
doctor-bot skill : https://github.com/tarekzaibet/doctor-bot 

- Creates an IAM role and role policy for your Lambda which enables logging.
- Creates the Amazon Skills Kit lambda
- Adds the Alexa permission to the lambda.

Once the lambda is created with Terraform you can head over to the [Amazon Developer Portal](https://developer.amazon.com) to register an Alexa Skill which will use the provided [Sample Interaction Model for the Color Expert Blueprint] and the ARN of the lambda (which is a Terraform output of this example).

## Run the example

From inside of this directory:

```bash
export AWS_ACCESS_KEY_ID=<this is a secret>
export AWS_SECRET_ACCESS_KEY=<this is a secret>
terraform init
terraform plan -out theplan
terraform apply theplan
```

## Remove the example

```bash
terraform destroy
```

Go to the console and remove the CloudWatch Log Group `/aws/lambda/terraform_lambda_alexa_example` which is created by AWS.
