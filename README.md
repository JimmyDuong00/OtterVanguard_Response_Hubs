# OtterVanguard_Response_Hubs

This GitHub is created for Project OtterVanguard's response hubs. 

When there is an oil spill or wildland fire, these response hubs are deployed to the nearest availiable AWS region. This will allow researchers to run simluations with the most accurate times, reducing latency. 

# Infrastructure
The hubs consist of:
VPC 
EC2 instances in each subnet
S3 bucket to store the data

All connected to a S3 Glacier for long term storage

# Adjusting variables
The purpose of this project is to be able to deploy resources in any AWS region that will allow it. Therefore, you can customize the region, zone, instance size in the variables.tf file. 

## Deploying the infrastructure
To run this Terraform script pull the repo:

``` git clone xxx ```

Initialize Terraform:

``` terraform init ```

Apply the infrastructure to AWS:

``` terraform apply ```

When you are done, destroy the infrastructure using:

``` terraform destroy ```
