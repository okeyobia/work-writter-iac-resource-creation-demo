aws_region   = "us-east-1"
environment  = "dev"
project_name = "workwriter"

vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]

bucket_name          = "workwriter-dev-app-storage-0001"
bucket_force_destroy = false
