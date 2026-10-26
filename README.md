# AWS Modular Infrastructure (Terraform)

Modular Terraform codebase that provisions a VPC, a secure S3 bucket, and an EC2-trusted IAM role scoped to that bucket. Remote state lives in S3 and uses **native S3 state locking** (`use_lockfile = true`), so no DynamoDB table is needed.

## Requirements

| Tool | Version |
|------|---------|
| Terraform CLI | `>= 1.10.0` |
| AWS provider | `~> 5.70` |

AWS credentials are taken from the standard credential chain (environment variables, SSO, shared profile, or instance role). No credentials are stored in this repo.

## Layout

```
.
├── bootstrap/            # One-time stack: creates the versioned S3 state bucket (local state)
├── modules/
│   ├── vpc/              # VPC, public/private subnets, IGW, route tables
│   ├── s3/               # Versioned, encrypted, non-public S3 bucket
│   └── iam/              # EC2 role + least-privilege S3 policy + instance profile
├── main.tf               # Root module, providers, S3 backend
├── variables.tf          # Root variables
├── outputs.tf            # Root outputs
└── terraform.tfvars      # Default values
```

## Architecture

```
module.s3_storage.bucket_arn ──► module.iam_app_role (s3_bucket_arn)
```

- **vpc**: DNS hostnames and DNS support enabled; public subnets route `0.0.0.0/0` to the Internet Gateway; private subnets have a route table with no internet route (no NAT).
- **s3**: versioning enabled, AES256 default encryption, full public access block.
- **iam**: role trusted by `ec2.amazonaws.com`; policy allows `ListBucket`/`GetBucketLocation` on the bucket and `Get/Put/DeleteObject` (+ `GetObjectVersion`) on `bucket/*` only.

All resources carry an `Environment` tag.

## Usage

### 1. Bootstrap the state bucket (once)

```bash
cd bootstrap
# Edit terraform.tfvars: state_bucket_name must be globally unique
terraform init
terraform apply
```

The bootstrap stack uses local state (it creates the bucket that holds remote state). Keep its `terraform.tfstate` safe; the bucket has `prevent_destroy` enabled.

### 2. Deploy the infrastructure

Use the `backend_init_command` output from the bootstrap, or run:

```bash
cd ..
terraform init \
  -backend-config="bucket=<state-bucket-name>" \
  -backend-config="region=<region>"
terraform plan
terraform apply
```

Backend blocks cannot reference variables, so the bucket name in the `backend "s3"` block of [main.tf](./main.tf) is a placeholder (`my-org-terraform-state`); override it as above or edit it directly.

### 3. Destroy

```bash
terraform destroy
```

Set `bucket_force_destroy = true` first if the application bucket contains objects.

## Configuration

| Variable | Description | Default |
|----------|-------------|---------|
| `aws_region` | AWS region | `us-east-1` |
| `environment` | Value of the `Environment` tag | required |
| `project_name` | Name prefix for resources | required |
| `vpc_cidr` | VPC CIDR block | required |
| `public_subnet_cidrs` | Public subnet CIDRs | required |
| `private_subnet_cidrs` | Private subnet CIDRs | required |
| `bucket_name` | Globally unique app bucket name | required |
| `bucket_force_destroy` | Allow destroying a non-empty bucket | `false` |

## Outputs

`vpc_id`, `public_subnet_ids`, `private_subnet_ids`, `bucket_arn`, `app_role_arn`, `app_instance_profile_name`.

## Notes

- The S3 lock file is written alongside state as `<key>.tflock`. The identity running Terraform needs `s3:GetObject`, `s3:PutObject`, and `s3:DeleteObject` on the state key, plus `s3:ListBucket` on the bucket.
- State files are git-ignored; do not commit them.
