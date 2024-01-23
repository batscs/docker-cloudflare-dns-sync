#!/bin/bash
# A Script to automatically deploy a docker container with the cloudflare-dns-sync script running
# No Cronjobs are set by default
echo "Docker: Building Image batscs/cloudflage-dns-sync"
docker build -t batscs/cloudflare-dns-sync:1.0 https://raw.githubusercontent.com/batscs/cloudflare-dns-sync/main/Dockerfile

echo "Docker: Creating Container cf-sync with Image batscs/cloudflare-dns-sync"
docker run -dit --name cf-sync --restart unless-stopped batscs/cloudflare-dns-sync
