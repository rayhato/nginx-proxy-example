#!/bin/bash

WEBSITE1_DOMAIN="website1.example.com"
WEBSITE2_DOMAIN="website2.example.com"
CERTS_DIR="certs"

generate_ssl_certificates() {
    local domain="$1"
    openssl genrsa -out "$domain.key" 2048
    openssl req -new -key "$domain.key" -out "$domain.csr" -subj "/CN=$domain"
    openssl x509 -req -days 365 -in "$domain.csr" -signkey "$domain.key" -out "$domain.crt"
}

mkdir -p website{1,2}
echo "website1" > website1/index.html
echo "website2" > website2/index.html

if [ ! -d $CERTS_DIR ]
then
  mkdir -p "$CERTS_DIR" && cd "$CERTS_DIR"
  generate_ssl_certificates "$WEBSITE1_DOMAIN"
  generate_ssl_certificates "$WEBSITE2_DOMAIN"
fi
