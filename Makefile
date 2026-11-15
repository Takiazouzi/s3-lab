.PHONY: help up check lab1 lab2 reset down

help:
	@echo "AWS Security Fundamentals - S3 Labs"
	@echo ""
	@echo "  make lab1    Reset and seed Lab 01"
	@echo "  make lab2    Reset and seed Lab 02"
	@echo "  make reset   Reset and seed both labs"
	@echo "  make up      Start floci and wait for the healthcheck"
	@echo "  make check   Check Docker, AWS CLI v2, curl and floci"
	@echo "  make down    Stop floci"
	@echo ""
	@echo "After seeding, load the environment in your shell:"
	@echo "  source scripts/env.sh"

up:
	docker compose up -d --wait

check:
	scripts/check.sh

lab1:
	scripts/reset.sh 1

lab2:
	scripts/reset.sh 2

reset:
	scripts/reset.sh

down:
	docker compose down
