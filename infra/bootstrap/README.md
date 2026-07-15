# Terraform State Bootstrap

This root configuration creates the S3 bucket used by the project's Terraform
backends.

## Security controls

- S3 public access is blocked.
- Object ownership is enforced by the bucket owner.
- Server-side encryption is enabled.
- Bucket versioning is enabled.
- Non-TLS requests are denied.
- Force deletion is configurable and enabled in the lab example for cleanup.

## Bootstrap sequence

1. Authenticate to the target AWS account.
2. Run `terraform init`, `terraform validate`, and `terraform plan`.
3. Apply the reviewed local plan.
4. Copy the bucket output into each live stack's local `backend.hcl`.
5. Initialize and apply the `shared`, `staging`, and `production` stacks.

The bootstrap stack keeps local state because it manages the S3 bucket used by
the live stacks. Preserve `terraform-lab.tfstate` until the bucket is destroyed.
