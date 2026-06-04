#!/bin/bash

# Run from docker-env directory
docker compose run --rm certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials /etc/cloudflare/cloudflare.ini \
  --email joelai1988@gmail.com \
  --agree-tos \
  --no-eff-email \
  -d kawa.homes \
  -d "*.kawa.homes"
