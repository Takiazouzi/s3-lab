.PHONY: help up check seed reset down

help:
	@echo "AWS Security Fundamentals - S3 Labs"
	@echo ""
	@echo "  make up      Start floci and wait for the healthcheck"
	@echo "  make check   Check Docker, AWS CLI v2, curl and floci"
	@echo "  make seed    Create or refresh the lab data"
	@echo "  make reset   Wipe floci, restart and reseed"
	@echo "  make down    Stop floci"
	@echo ""
	@echo "After seeding, load the environment in your shell:"
	@echo "  source scripts/env.sh"

up:
	docker compose up -d --wait

check:
	scripts/check.sh

seed:
	scripts/seed.sh

reset:
	scripts/reset.sh

down:
	docker compose down
