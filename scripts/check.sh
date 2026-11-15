#!/usr/bin/env bash
# Checks the tools and the local emulator needed for the labs.
set -uo pipefail

ok()   { echo "[ok]   $1"; }
fail() { echo "[FAIL] $1"; FAILED=1; }
FAILED=0

if command -v docker >/dev/null 2>&1; then
  ok "docker found"
  if docker info >/dev/null 2>&1; then
    ok "docker daemon is running"
  else
    fail "docker daemon is not running (start Docker Desktop or the Docker service)"
  fi
else
  fail "docker not installed"
fi

if docker compose version >/dev/null 2>&1; then
  ok "docker compose v2 found: $(docker compose version --short 2>/dev/null || true)"
else
  fail "docker compose v2 not available"
fi

if command -v aws >/dev/null 2>&1; then
  AWS_VERSION="$(aws --version 2>&1 || true)"
  case "$AWS_VERSION" in
    aws-cli/2.*) ok "aws cli v2 found: ${AWS_VERSION%% *}" ;;
    *) fail "AWS CLI v2 required, found: $AWS_VERSION" ;;
  esac
else
  fail "aws cli not installed"
fi

command -v curl >/dev/null 2>&1 && ok "curl found" || fail "curl not installed"

if curl -fsS --max-time 2 http://localhost:4566/_floci/init 2>/dev/null | grep -q '"ready":true'; then
  ok "floci is ready on http://localhost:4566"
  if AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test \
    AWS_SESSION_TOKEN='' AWS_SECURITY_TOKEN='' \
    aws --endpoint-url http://localhost:4566 s3 ls >/dev/null 2>&1; then
    ok "AWS CLI can reach floci"
  else
    fail "AWS CLI cannot reach floci (check the endpoint and credentials)"
  fi
else
  fail "floci is not ready. Run: docker compose up -d --wait"
fi

echo
if [ "$FAILED" -eq 0 ]; then
  echo "All checks passed."
else
  echo "Some checks failed. Fix the [FAIL] lines above and run this script again."
fi
exit "$FAILED"
