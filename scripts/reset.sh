#!/usr/bin/env bash
# Wipes floci, starts it again and reseeds all labs.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "Stopping floci and removing its state..."
docker compose down -v --remove-orphans

echo "Starting floci and waiting for its healthcheck..."
docker compose up -d --wait

echo "Seeding the labs..."
scripts/seed.sh

echo
echo "Reset complete. Load the environment with:"
echo "  source scripts/env.sh"
