#!/usr/bin/env bash
set -ex

KEY=$1

declare -A SECRETS
SECRETS[release/keystore.aes]=keystore.jks
SECRETS[release/localprops.aes]=local.properties

if [[ -n "$KEY" ]]; then
    for src in "${!SECRETS[@]}"; do
      openssl enc -aes-256-cbc -md sha256 -pbkdf2 -d -in "${src}" -out "${SECRETS[${src}]}" -k "${KEY}"
    done
else
    echo "Error"
fi

mv keystore.jks app/keystore.jks