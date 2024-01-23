#!/bin/bash
# A Script to automatically deploy a docker container with the cloudflare-dns-sync script running
# No Cronjobs are set by default
echo "Docker: Building Image batscs/cloudflage-dns-sync"
docker build --no-cache -t batscs/cloudflare-dns-sync:latest https://raw.githubusercontent.com/batscs/cloudflare-dns-sync/main/Dockerfile

echo "Docker: Creating Container cf-sync with Image batscs/cloudflare-dns-sync"
docker run -dit --name cf-sync --restart unless-stopped batscs/cloudflare-dns-sync
