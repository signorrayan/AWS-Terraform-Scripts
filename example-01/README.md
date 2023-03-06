## Example-01
In this example, I have the following set-up which I try to implement using Terraform:
1. There is a simple python script `app.py` inside `package/` directory which lists all files in the given S# bucket name.
2. This python script will be used in a Docker Image to run as a lambda function.
3. All processes during creating the image to creating lambda function, role, policies will be implemented in this Terraform script.

_____
## An overview of Terraform settings files:
### `backend.tf:`
- The AWS S3 has been used as terraform backend to store `terraform.tfstate` on S3.
- Two providers such as `docker` and `aws` has been used to implement our project.

### `data.tf:`
- In this file, `data "aws_ecr_authorization_token" "token" {}` is a data source block that retrieves the Amazon ECR authorization token. (We can use it to authenticate with an Amazon ECR registry.)
- This data source **does not** create or modify any resources. It simply reads data from the specified registry to provide the authorization token.
- The retrieved token can be used to authenticate Docker CLI to push/pull images to/from the ECR registry.

### `locals.tf:`
- In the real-world examples, it is possible that the `aws_ecr_url` is a fixed value that does not change frequently and is not expected to be overridden by different environments or deployment scenarios. In this case, defining it as a `local` is a convenient way to avoid creating a separate `*.tfvars` file and passing it as an input variable to the Terraform module.
- `aws_ecr_url` is a value that is specific to the Terraform module and not expected to be used by other modules or projects. In this case, defining it as a local is a way to keep the module self-contained and avoid leaking implementation details to other parts of the system.

### `providers.tf:`
- In this file, I defined the used providers such as `aws` and `docker`.
- The `docker` provider is consisting of three variables in `registry_auth`:
  - the `address` will assign the defined `aws_ecr_url` inside `locals.tf` file.
  - `username` and `password` will be received from `aws_ecr_authorization_token` (you need to configure AWS CLI on your machine).

### `variables.tf and terraform.tfvars:`
- In the `variables.tf` I defined the structure of used variables in terraform scripts.
- In the `terraform.tfvars` I defined value for each variable. (The main point is that if we don't define variable names in this file inside variables.tf, the Terraform will not understand it and gives some errors about the unknown variables.).

### `main.tf:`
- In this file I defined the main structure of Terraform script which:
  - Will create a Docker Image of `app.py` inside `package` directory.
  - Will create an AWS Elastic Container Registry (ECR) with defined name in `tfvars`.
  - Will create a lambda function with specified features.
  - Will create a role to be used in the lambda function.
  - Will create a policy to Allow the script to access the `GetObject`, `PutObject`, `ListBucket` actions on given S3 bucket.
  - Will attach the above policy to the defined role.
  - Will attach the policy `AWSLambdaBasicExecutionRole` to the defined role.
  - Will attach the policy `AmazonEC2ContainerRegistryReadOnly` to the defined role.

_____
## How to set-up to run on your environment and AWS:
1. Make sure you've configured AWS credentials on your machine. (You can use [this link](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html) to learn about it)
2. Update `aws_ecr_url` inside the file `locals.tf` to your AWS ECR url. 
3. Create a S3 bucket on AWS (pay attention to its region, because you need to update terraform variable). Then copy the bucket name and replace in `package/app.py` file inside `bucket_name` variable in line 8. 
4. Update `region_name` variable inside `terraform.tfvars` to your region. 
5. Make sure the `region` inside the `backend.tf` is the same as your account region (which used in the previous step).
6. Make sure the `bucket` inside the `backend.tf` is your own S3 bucket name to save `terraform.tfstate` file.
6. Update `s3_policy_resource` to your S3 bucket resource name. 
7. Run the following commands to initialize the terraform and push the settings to AWS:
   ```bash
   terraform init
   terraform validate
   terraform plan
   terraform apply
    ```
