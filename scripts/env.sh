#!/usr/bin/env bash
# Source this file from the repository root: source scripts/env.sh
# The lab uses emulator credentials; floci does not require real AWS keys.
# Loading this file overrides any real AWS credentials in the current shell.

# Refuse to run by execution: the exports would disappear with the subshell.
if [ -n "${BASH_VERSION:-}" ]; then
  if [ "${BASH_SOURCE[0]}" = "$0" ]; then
    echo "Source this file instead of running it: source scripts/env.sh" >&2
    exit 1
  fi
elif [ -n "${ZSH_VERSION:-}" ]; then
  case "${ZSH_EVAL_CONTEXT:-}" in
    *:file*) ;;
    *)
      echo "Source this file instead of running it: source scripts/env.sh" >&2
      return 1 2>/dev/null || exit 1
      ;;
  esac
else
  case "$0" in
    *env.sh)
      echo "Source this file instead of running it: source scripts/env.sh" >&2
      exit 1
      ;;
  esac
fi

if [ ! -f "scripts/env.sh" ]; then
  echo "Run this from the repository root: source scripts/env.sh" >&2
  return 1 2>/dev/null || exit 1
fi

LAB_ROOT="$(pwd)"
export LAB_ROOT

export AWS_ENDPOINT_URL="${AWS_ENDPOINT_URL:-http://localhost:4566}"
if ! printf '%s' "$AWS_ENDPOINT_URL" | grep -Eq '^http://(localhost|127\.0\.0\.1):[0-9]+/?$'; then
  echo "Refusing non-local endpoint: $AWS_ENDPOINT_URL" >&2
  echo "This lab must only talk to the local floci emulator." >&2
  return 1 2>/dev/null || exit 1
fi

export AWS_DEFAULT_REGION="us-east-1"
export AWS_REGION="us-east-1"
export AWS_PAGER=""
export AWS_EC2_METADATA_DISABLED="true"
unset AWS_SESSION_TOKEN AWS_SECURITY_TOKEN 2>/dev/null || true

if [ "${LAB_USE_ROOT:-0}" = "1" ]; then
  # Internal: seed and fix scripts use this to force the emulator root.
  export AWS_ACCESS_KEY_ID="test"
  export AWS_SECRET_ACCESS_KEY="test"
  if [ -z "${LAB_QUIET:-}" ]; then
    echo "Using emulator root credentials."
  fi
elif [ -f "$LAB_ROOT/build/lab-credentials.env" ]; then
  # shellcheck disable=SC1091
  . "$LAB_ROOT/build/lab-credentials.env"
  if [ -z "${LAB_QUIET:-}" ]; then
    echo "Loaded lab credentials for lab-analyst."
  fi
else
  export AWS_ACCESS_KEY_ID="test"
  export AWS_SECRET_ACCESS_KEY="test"
  if [ -z "${LAB_QUIET:-}" ]; then
    echo "No lab credentials found; using test/test (emulator root)."
    echo "Run scripts/seed.sh, then re-source this file to use lab-analyst."
  fi
fi

if [ -z "${AWS_ACCESS_KEY_ID:-}" ] || [ -z "${AWS_SECRET_ACCESS_KEY:-}" ]; then
  echo "Lab credentials are incomplete. Run scripts/seed.sh, then re-source this file." >&2
  return 1 2>/dev/null || exit 1
fi
