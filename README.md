# terraform_rds_project
Example project of an RDS service created using Terraform IaC.
I have included three example EC2 instances that have been connected to the RDS.

Pre-requisites / Requirements / Setup Info:

1) Utilised cmd terminal to interface with the project via a Windows OS.

2) Installed the following software / technologies:
- AWS CLI
- Git
- Terraform

3) Initialised Terraform and configured AWS account and access keys.
   
NOTE: Must run "terraform init" after pulling repo to reconstruct some terraform providers, as GitHub had a 100MB file size limit that wouldn't allow them to be pushed to the branch.

4) Defined AWS username and password set as environment variables.

5) In a more thorough solution I would consider implementing a key vault or similar to store the key pairs more securely.

6) Most values provided for allocated storage / etc. can be easily modified in the .tf files if required for scale. Values used in the solution are examples.

Research undertaken included the following sources:
- https://docs.aws.amazon.com/
- https://developer.hashicorp.com/
- https://spacelift.io/
