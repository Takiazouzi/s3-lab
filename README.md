# AWS Security Fundamentals — S3 Labs

Hands-on labs for the AWS Security Fundamentals workshop (Securinets-Tekup). Everything
runs locally against [floci](https://floci.io/floci/) .
These labs are the S3 module: enumeration, bucket policies and a
public-bucket investigation.


## Prerequisites

- Docker Desktop, or Docker Engine with Docker Compose v2
- AWS CLI **v2** (`aws --version` should start with `aws-cli/2`)
- `curl` and `bash` (Linux, macOS, or WSL2 on Windows)

No AWS account, no real credentials, .

## Quick start

```bash
cd s3-lab                      # or wherever you cloned/downloaded the repository

docker compose up -d --wait   # start floci and wait for its healthcheck
scripts/check.sh              # verify Docker, AWS CLI v2, curl and floci
scripts/seed.sh               # create buckets, objects, IAM user and policies
source scripts/env.sh         # point the AWS CLI at floci and load lab credentials

aws sts get-caller-identity   # show the current IAM 
```


## Useful commands

```bash
docker compose up -d --wait   # start floci
scripts/check.sh              # environment check
scripts/seed.sh               # create or refresh the lab data
source scripts/env.sh         # load endpoint and credentials
scripts/submit.sh '<flag>'    # check a flag
scripts/reset.sh              # wipe floci, restart and reseed
docker compose down           # stop floci
```


if you have any problems then reset and check again:

```bash
scripts/reset.sh
source scripts/env.sh
scripts/check.sh
```

If everything is broken, run `scripts/reset.sh`. The environment is disposable.

## Safety

- This emulator is intentionally vulnerable. 
