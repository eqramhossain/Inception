#!/bin/bash

cd /etc/nginx/ && mkdir -p ssl && cd ssl

openssl req -x509 -newkey rsa:4096 -sha256 -noenc -keyout server.key -out server.crt -days 3650 -subj "/C=FR/ST=Paris/L=Paris/O=42paris/OU=Inception/CN=ehossain.42.fr"

exec nginx -g "daemon off;"
