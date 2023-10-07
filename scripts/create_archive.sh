#!/bin/bash 

set -ueo pipefail

# DIR_TO_ZST=../../radiantbrink/balancer_v2
DIR_TO_ZST=balancer_v2_upstream

# copy this dir to pwd

rm -rf ./balancer_v2
rsync -a \
    --exclude .git \
    --exclude target \
    --exclude .cache \
    --exclude aws-lambda-cpp \
    --exclude aws-lambda-runtime-interface-emulator \
    $DIR_TO_ZST/ balancer_v2
rm -rf balancer_v2/.git
rm -rf balancer_v2/.gitignore

# create archive
tar cf - balancer_v2 | zstd -3 -T0 > balancer_v2.tar.zst

ls -lah balancer_v2.tar.zst

READ_ENV_URL=https://raw.githubusercontent.com/iamwrm/read_env/main/read_env.sh
# run read_env.sh without saving it
OPENSSL_ENC_KEY=$(bash <(curl -s $READ_ENV_URL) \
    .env OPENSSL_ENC_KEY)

# create encrypted archive
OPENSSL_PARAM="-aes-256-cbc -pbkdf2"

openssl enc $OPENSSL_PARAM \
    -in balancer_v2.tar.zst \
    -out balancer_v2.tar.zst.enc \
    -k $OPENSSL_ENC_KEY

ls -lah balancer_v2.tar.zst.enc

