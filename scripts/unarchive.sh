#!/bin/bash

set -ueo pipefail

rm -rf balancer_v2.tar.zst
rm -rf ./balancer_v2

OPENSSL_PARAM="-aes-256-cbc -pbkdf2"

openssl enc -d $OPENSSL_PARAM \
    -in balancer_v2.tar.zst.enc \
    -out balancer_v2.tar.zst \
    -k $OPENSSL_ENC_KEY

ls -lah balancer_v2.tar.zst

tar xf balancer_v2.tar.zst

ls -lah balancer_v2
