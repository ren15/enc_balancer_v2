#!/bin/bash

set -ueo pipefail

READ_ENV_URL=https://raw.githubusercontent.com/iamwrm/read_env/main/read_env.sh
# run read_env.sh without saving it
export OPENSSL_ENC_KEY=$(bash <(curl -s $READ_ENV_URL) .env OPENSSL_ENC_KEY)

bash scripts/unarchive.sh
