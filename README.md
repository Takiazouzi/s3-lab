# AWS Security Fundamentals — S3 Labs

Hands-on labs for the AWS Security Fundamentals workshop (Securinets-Tekup).
Everything runs locally against [floci](https://floci.io/floci/).
The labs cover S3 enumeration, bucket policies and a public website investigation.

## Prerequisites

- Docker Desktop, or Docker Engine with Docker Compose v2
- AWS CLI **v2** (`aws --version` should start with `aws-cli/2`)
- `curl`, `bash` and `make` (Linux, macOS, or WSL2 on Windows)

No AWS account or real credentials are needed.

## Quick start

```bash
cd s3-lab                      # or wherever you cloned the repository
make lab1                      # reset floci and seed Lab 01
source scripts/env.sh          # load endpoint and lab credentials
```

When Lab 01 is done:

```bash
make lab2                      # reset floci and seed Lab 02
source scripts/env.sh
```

## Useful commands

```bash
make lab1       # reset and seed Lab 01
make lab2       # reset and seed Lab 02
make reset      # reset and seed both labs (testing)
make up         # start floci
make check      # check tools and floci
make down       # stop floci
source scripts/env.sh          # load endpoint and credentials
scripts/submit.sh '<flag>'     # submit a flag
```

Run `source scripts/env.sh` after each lab target and in every new terminal.

If something breaks, rerun the lab target and load the environment again:

```bash
make lab1      # or: make lab2
source scripts/env.sh
```

