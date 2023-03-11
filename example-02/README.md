## Example-01
In this example, I will maintain two EC2 instances (Backend and Webserver), IAM roles, IAM policies, security groups, and key pair.
Each feature is implemented as a module inside `modules` directory.

_____
## Defined modules:
```text
1. backend_server
2. web_server
3. iam_roles
4. security_groups
5. key_pair
```

_____
## An overview of Terraform settings files:
### `backend.tf:`
- The AWS S3 has been used as terraform backend to store `terraform.tfstate` on S3. (You should change them to your bucket name and region).
- The aws provider has been used to implement our project.

### `providers.tf:`
- In this file, I defined the aws provider.

### `data.tf:`
- This file contains the OS distribution specifications (Ubuntu 22.04) defined in backend and webserver modules.

### `variables.tf and terraform.tfvars:`
- In the `variables.tf` I defined the structure of defined variables in terraform scripts.
- In the `terraform.tfvars` I defined value for each variable. (The main point is that if we don't define the variable that is in this file to variables.tf, the Terraform will not understand it and gives some errors about the unknown variables.).

### `main.tf:`
- In this file I defined the main structure of Terraform script which is using 4 modules, consisting:
	1. Webserver
	2. Backend server
	3. Security groups
	4. IAM roles + Policies


_____
## How to set-up to run on your environment and AWS:
1. Make sure you've configured AWS credentials on your machine. (You can use [this link](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html) to learn about it)
2. Create a S3 bucket on AWS for remote state file (pay attention to its region, because you need to update terraform variable). 
3. Update `region_name` variable inside `terraform.tfvars` to your region.
4. Make sure the `region` inside the `backend.tf` is the same as your account region (which used in the previous step).
5. Make sure the `bucket` and `region` inside the `backend.tf` is your own S3 bucket name.
6. Run the following commands to initialize the terraform and push the settings to AWS:
   ```bash
   terraform init
   terraform validate
   terraform plan
   terraform apply
    ```
