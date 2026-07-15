# Terraform State Bootstrap

This root configuration creates the S3 bucket used by the project's Terraform
backends.

## Security controls

- S3 public access is blocked.
- Object ownership is enforced by the bucket owner.
- Server-side encryption is enabled.
- Bucket versioning is enabled.
- Non-TLS requests are denied.
- Lifecycle protection prevents accidental destruction.

## Bootstrap sequence

1. Authenticate to the target AWS account.
2. Run `terraform init`, `terraform validate`, and `terraform plan`.
3. Apply the reviewed local plan.
4. Copy `backend.tf.example` to `backend.tf`.
5. Replace the placeholder bucket name with the Terraform output.
6. Run `terraform init -migrate-state`.
7. Verify that the bootstrap state exists in S3.

The bootstrap configuration starts with local state because an S3 backend cannot
use a bucket that does not exist yet.