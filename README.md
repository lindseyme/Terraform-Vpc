# Creating a custom network using terraform
Creating a custom virtual private network(vpc) to deploy my simulations checkpoint.

## About the simulations checkpoint
The application is about a writing platform called AUTHORS HAVEN where different people express themselves through writing and also get an aundience for the written articles.
The frontend was written in react/redux and the backend in python/django.

## Steps taken
- Install terraform
To install terraform, use the link below

`https://learn.hashicorp.com/terraform/getting-started/install.html`

- Install packer and ansible

`brew install packer`

`brew install ansible`

- Clone the repository

`https://github.com/lindseyme/Terraform-Vpc.git`

- Open the terminal and change directory to the created folder.

- Create a file to store your AWS credentials as variables.

`terraform.tfvars`

- Initialize terraform using command

`terraform init`

- Run the terraform command to run the terraform scripts.

`terraform apply`

- To teardown the created vpc use command

`terraform destroy`
