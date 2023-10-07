#!/bin/bash

set -ueox pipefail

cat > message.txt <<EOF
a message
EOF

OPENSSL_PARAM="-aes-256-cbc -pbkdf2"

openssl enc $OPENSSL_PARAM \
    -in message.txt \
    -out message.enc \
    -k password

echo "encrypted message:"
cat message.enc 

echo -e "\ndecrepted message:"

cat message.enc | openssl enc -d $OPENSSL_PARAM -k $OPENSSL_ENC_KEY
