#!/usr/bin/env bash
set -euo pipefail

base_url="${1:?application URL is required}"
base_url="${base_url%/}"
expected='{"message":"Welcome warriors to Golden Owl!"}'

for _ in {1..12}; do
  if response="$(curl --fail --silent --show-error --max-time 10 "${base_url}/")" && [[ "$response" == "$expected" ]]; then
    printf '%s\n' "$response"
    exit 0
  fi
  sleep 5
done

printf 'Smoke test failed for %s\n' "$base_url" >&2
exit 1
