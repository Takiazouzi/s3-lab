#!/usr/bin/env bash
# Wipes floci, starts it again and seeds the selected lab.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

LAB="${1:-all}"
case "$LAB" in
  1|2|all) ;;
  *)
    echo "Usage: scripts/reset.sh [1|2|all]" >&2
    exit 2
    ;;
esac

echo "Stopping floci and removing its state..."
docker compose down -v --remove-orphans

echo "Starting floci and waiting for its healthcheck..."
docker compose up -d --wait

echo "Seeding lab $LAB..."
scripts/seed.sh --lab "$LAB"

echo
echo "Reset complete. Load the environment with:"
echo "  source scripts/env.sh"
