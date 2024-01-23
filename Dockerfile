# Base Image
FROM ubuntu:22.04

MAINTAINER dev@bats.li

RUN apt-get update
RUN apt-get install -y jq
RUN apt-get install -y curl
RUN apt-get install -y cron
RUN apt-get install -y nano

# Making Directory for Script
RUN mkdir -p ~/.cloudflare

# Deploying Script in ~/.cloudflare directory
RUN curl https://raw.githubusercontent.com/batscs/cloudflare-dns-sync/main/cloudflare-dns-sync.sh > ~/.cloudflare/cloudflare-dns-sync.sh
