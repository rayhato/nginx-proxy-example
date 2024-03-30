#!/bin/bash

mkdir website{1,2}
echo website1 > website1/index.html
echo website2 > website2/index.html

mkdir certs && cd certs
openssl genrsa -out website1.example.com.key 2048
openssl req -new -key website1.example.com.key -out website1.example.com.csr -subj "/CN=website1.example.com"
openssl x509 -req -days 365 -in website1.example.com.csr -signkey website1.example.com.key -out website1.example.com.crt

openssl genrsa -out website2.example.com.key 2048
openssl req -new -key website2.example.com.key -out website2.example.com.csr -subj "/CN=website2.example.com"
openssl x509 -req -days 365 -in website2.example.com.csr -signkey website2.example.com.key -out website2.example.com.crt

cd .. && docker compose up -d
