#!/usr/bin/env bash
set -euo pipefail

parameter_name="${1:?SSM parameter name is required}"
image_ref="$(aws ssm get-parameter --name "$parameter_name" --query Parameter.Value --output text)"

if [[ ! "$image_ref" =~ ^[0-9]{12}\.dkr\.ecr\.[a-z0-9-]+\.amazonaws\.com/[a-z0-9._/-]+@sha256:[a-f0-9]{64}$ ]]; then
  printf 'Invalid approved image reference\n' >&2
  exit 1
fi

printf '%s\n' "$image_ref"
