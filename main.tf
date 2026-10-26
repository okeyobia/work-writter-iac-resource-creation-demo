terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70"
    }
  }

  # Backend blocks cannot reference variables. Replace the bucket name with your
  # pre-existing state bucket (versioning enabled), or override at init time:
  #   terraform init -backend-config="bucket=<state-bucket>"
  # Credentials come from the standard AWS credential chain (env vars, SSO, profile).
  backend "s3" {
    bucket       = "my-org-terraform-state"
    key          = "infrastructure/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true # native S3 locking; no DynamoDB table required
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"

  name                 = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "s3_storage" {
  source = "./modules/s3"

  bucket_name   = var.bucket_name
  environment   = var.environment
  force_destroy = var.bucket_force_destroy
}

module "iam_app_role" {
  source = "./modules/iam"

  role_name     = "${var.project_name}-${var.environment}-app-role"
  environment   = var.environment
  s3_bucket_arn = module.s3_storage.bucket_arn
}
