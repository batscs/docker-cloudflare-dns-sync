# Base Image
FROM ubuntu:22.04

MAINTAINER dev@bats.li

RUN apt-get update
RUN apt-get install -y jq
RUN apt-get install -y curl
RUN apt-get install -y cron
RUN apt-get install -y nano

# Deploying installer for cloudflare-dns-sync on this system
RUN bash <(curl -s https://raw.githubusercontent.com/batscs/cloudflare-dns-sync/main/deploy-shell.sh)
